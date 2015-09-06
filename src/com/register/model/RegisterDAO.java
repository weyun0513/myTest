package com.register.model;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.aircraft.model.AircraftVO;
import com.classlist.model.ClassListVO;
import com.classtype.model.ClassTypeVO;
import com.modrecord.model.ModRecordDAO;
import com.modrecord.model.ModRecordVO;
import com.pilot.model.PilotVO;
import com.util.HibernateUtil;

public class RegisterDAO implements RegisterInterface {
	@Override
	public RegisterVO getReg(String pilotID, String classID, Integer classNum) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = null;
		RegisterVO result = null;
		try {
			tx = session.beginTransaction();
			Query query = session.createQuery("from RegisterVO where pilotID='"
					+ pilotID + "' and classID='" + classID + "' and classNum="
					+ classNum);
			result = (RegisterVO) query.list().get(0);
			tx.commit();
		} catch (Exception ex) {
			tx.rollback();
			result = null;
		}

		return result;

	}

	@Override
	public void insert(RegisterVO registerVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			session.saveOrUpdate(registerVO);
			tx.commit();
		} catch (RuntimeException ex) {
			tx.rollback();
			throw ex;
		}
	}

	// =================================================

	@Override
	public void update(RegisterVO registerVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			session.saveOrUpdate(registerVO);
			tx.commit();
		} catch (RuntimeException ex) {
			tx.rollback();
			throw ex;
		}
	}

	@Override
	public void update(RegisterVO registerVO, ModRecordVO modRecordVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		ModRecordDAO dao = new ModRecordDAO();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			dao.insert(modRecordVO, session)// 稽核
					.saveOrUpdate(registerVO); // 變更繳費狀態
			tx.commit();
		} catch (RuntimeException ex) {
			tx.rollback();
			throw ex;
		}
	}

	// =======================================================
	@Override
	public void delete(Integer regID) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			RegisterVO registerVO = (RegisterVO) session.get(RegisterVO.class,
					regID);
			session.delete(registerVO);
			tx.commit();
		} catch (RuntimeException ex) {
			tx.rollback();
			throw ex;
		}
	}

	// =================================================
	@Override
	public RegisterVO findByPrimaryKey(Integer regID) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = null;
		RegisterVO registerVO = null;
		try {
			tx = session.beginTransaction();
			registerVO = (RegisterVO) session.get(RegisterVO.class, regID);
			tx.commit();
		} catch (RuntimeException ex) {
			tx.rollback();
			throw ex;
		}
		return registerVO;
	}

	// =================================================
	@Override
	public Set<RegisterVO> getRegisterByClass(String classID, Integer classNum) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = null;
		Set<RegisterVO> result = null;
		try {
			tx = session.beginTransaction();
			Query query = session
					.createQuery("from RegisterVO where classID=? and classNum=? order by regDate ");
			query.setParameter(0, classID);
			query.setParameter(1, classNum);
			result = new LinkedHashSet<RegisterVO>(query.list());
			tx.commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return result;
	}

	// 以classID和classNum查出所有pilotID
	@Override
	public List<RegisterVO> getByClassIDAndClassNum(String classID,
			Integer classNum) {
		List<RegisterVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session
					.createQuery("from RegisterVO where classID=? and classNum=? order by pilotID ");
			query.setParameter(0, classID);
			query.setParameter(1, classNum);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

	@Override
	public List<RegisterVO> getByNotes(String classID, Integer classNum,
			String notes) {
		List<RegisterVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session
					.createQuery("from RegisterVO where classID=? and classNum=? and notes=? order by pilotID ");
			query.setParameter(0, classID);
			query.setParameter(1, classNum);
			query.setParameter(2, notes);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

	@Override
	public List<RegisterVO> getGraduation() {
		List<RegisterVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Criteria query = session.createCriteria(RegisterVO.class);
			query.addOrder(Order.asc("regID"));
			query.add(Restrictions.isNull("notes"));
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

	@Override
	public List<RegisterVO> getByPilotID(String pilotID) {
		List<RegisterVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session
					.createQuery("from RegisterVO where pilotID=? order by regID ");
			query.setParameter(0, pilotID);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

	@Override
	public RegisterVO getByDoubleReg(PilotVO pilotVO, String classID,
			Integer classNum) {
		RegisterVO registerVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session
					.createQuery("from RegisterVO where pilotID=? and classID=? and classNum=?");
			query.setParameter(0, pilotVO.getPilotID());
			query.setParameter(1, classID);
			query.setParameter(2, classNum);
			registerVO = (RegisterVO) query.list().get(0);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			return registerVO;
		}
		return registerVO;
	}

	public RegisterVO changeClassID(String pilotID,String classIDNew,String classNumNew,String classID_classNum,ModRecordVO modRecordVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		ModRecordDAO dao = new ModRecordDAO();
		RegisterVO registerVO;
		Transaction tx = null;
		String classIDOld=classID_classNum.substring(0,4);
		String classNumOld=classID_classNum.substring(4);
		try {
			tx = session.beginTransaction();
		//用舊的取的報名VO	
			System.out.println(pilotID+" "+classIDOld+" "+classNumOld);
			Query query = session
					.createQuery("from RegisterVO where pilotID=? and classID=? and classNum=?");
			query.setParameter(0, pilotID);
			query.setParameter(1, classIDOld);
			query.setParameter(2, classNumOld);
			registerVO = (RegisterVO) query.list().get(0);
		//放入流水號
			modRecordVO.setRegID(registerVO.getRegID());
		//更新期別	
			ClassListVO classListVO=new ClassListVO();
			classListVO.setClassNum(Integer.valueOf(classNumNew));
			ClassTypeVO classTypeVO=new ClassTypeVO();
			AircraftVO aircraftVO =new AircraftVO();
			aircraftVO.setCraftType(registerVO.getClassListVO().getClassTypeVO().getAircraftVO().getCraftType());
			classTypeVO.setAircraftVO(aircraftVO);
					
			classTypeVO.setClassID(classIDNew);
			classListVO.setClassTypeVO(classTypeVO);
			registerVO.setClassListVO(classListVO);
			dao.insert(modRecordVO, session)// 稽核
					.update(registerVO); // 變更訓練期別
			//session.update(registerVO);
		//更改報名人數
			session=changeNum(classIDNew,classNumNew,true,session);
			session=changeNum(classIDOld,classNumOld,false,session);
			tx.commit();
		} catch (RuntimeException ex) {
			tx.rollback();
			throw ex;
		}
		return registerVO;
	}
	public Session changeNum(String classID,String classNum,boolean isPlus,Session session){
		ClassListVO classListVO=null;
		try {
//			System.out.println(classID+" "+classNum+" "+isPlus);
			Query query = session
					.createQuery("from ClassListVO where classID=? and classNum=?");
			query.setParameter(0, classID);
			query.setParameter(1, Integer.valueOf(classNum));
			classListVO = (ClassListVO) query.list().get(0);
			int num=0;
			if(isPlus)num=classListVO.getRegNum()+1;
			else num=classListVO.getRegNum()-1;
			classListVO.setRegNum(num);
			session.update(classListVO);
		} catch (RuntimeException ex) {
			throw ex;
		}
		return session;
	}
	
	@Override
	public void cancelRegister(RegisterVO registerVO, ClassListVO classListVO){
		
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx =null;
		try{
			tx =session.beginTransaction();
		session.update(registerVO);
		session.update(classListVO);
		tx.commit();
	} catch (RuntimeException ex) {
		tx.rollback();
		throw ex;
	}
		
		
		
	}
	
	
	// =================================================
//	public static void main(String[] args) {
//		RegisterDAO dao = new RegisterDAO();
		//System.out.println(list.getPilotVO().getPilotID());
		// for(RegisterVO vo:list){
		// System.out.println(vo.getPilotVO().getLastTrainDate());
		// }
		// RegisterVO VO=dao.findByPrimaryKey(1000);
		// if(VO==null){
		// System.out.println("not found");
		// }
		// else
		// +++++++++++++�啣�鞈�
		// RegisterVO VO=new RegisterVO();
		// PilotVO pilotvo=new PilotVO();
		// pilotvo.setPilotID("A121707694");
		// VO.setPilotvo(pilotvo);
		// classlistVO classlistvo=new classlistVO();
		// classlistvo.setClassID("CECJ");
		// classlistvo.setClassNum(2);
		// VO.setClasslistvo(classlistvo);
		//
		// VO.setPayStatus(false);
		// VO.setRegDate(new Timestamp(System.currentTimeMillis()));;
		// VO.setRegIP("129.16.07.0");
		// VO.setRegStatus("�勗�");
		// dao.insert(VO);
		// ===========================
		// String classID="CECJ";
		// int classNum=1;
		// Set<RegisterVO> result=new LinkedHashSet<RegisterVO>();
		// result=dao.getRegisterByClass(classID, classNum);
		// for(RegisterVO r:result)
		// {System.out.println(r.getPilotVO().getPilotID());
		// ==================
		// RegisterVO VO=new RegisterVO();
		// VO=dao.findByPrimaryKey(1000);
		// System.out.println(VO.getRegIP());

		// ============================
		// List<RegisterVO> list = dao.getByClassIDAndClassNum("CECJ",1);
		// for (RegisterVO vo : list) {
		// System.out.println(vo.getPilotVO().getPilotID());
		// }
		// List<RegisterVO> list = dao.getByNotes("CECJ",1,"有報名沒結訓");
		// for (RegisterVO vo : list) {
		// System.out.println(vo.getPilotVO().getPilotID());
		// System.out.println(vo.getNotes());
		//
		//
		// }
		// List<RegisterVO> list = dao.getGraduation();
		// for (RegisterVO vo : list) {
		// System.out.println(vo.getPilotVO().getPilotID());
		// System.out.println(vo.getNotes());
		// }

//	}
}
