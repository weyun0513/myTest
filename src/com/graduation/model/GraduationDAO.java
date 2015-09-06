package com.graduation.model;

/*
 Hibernate is providing a factory.getCurrentSession() method for retrieving the current session. A
 new session is opened for the first time of calling this method, and closed when the transaction is
 finished, no matter commit or rollback. But what does it mean by the ��current session��? We need to
 tell Hibernate that it should be the session bound with the current thread.

 <hibernate-configuration>
 <session-factory>
 ...
 <property name="current_session_context_class">thread</property>
 ...
 </session-factory>
 </hibernate-configuration>

 */

import org.hibernate.*;

import com.classlist.model.ClassListVO;
import com.classtype.model.ClassTypeVO;
import com.graduation.model.GraduationVO;
import com.pilot.model.PilotVO;




import com.util.HibernateUtil;

import java.util.*;

public class GraduationDAO implements GraduationDAO_interface {

	private static final String GET_ALL_STMT = "from GraduationVO order by pilotID";

	@Override
	public void insert(GraduationVO graduationVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(graduationVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}

	@Override
	public void update(GraduationVO graduationVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(graduationVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}

	@Override
	public void delete(String pilotID, String classID, Integer classNum) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();

//        �i���ɦh��(�y)�i�ĥ�HQL�R���j
//			Query query = session.createQuery("delete EmpVO where empno=?");
//			query.setParameter(0, empno);
//			System.out.println("�R��������=" + query.executeUpdate());

//        �i�Φ��ɦh��(�])�i�ĥΥh�����p���Y��A�A�R�����覡�j
			GraduationVO graduationVO = new GraduationVO();
			graduationVO.getPilotVO().setPilotID(pilotID);
			graduationVO.getClassListVO().getClassTypeVO().setClassID(classID);
			graduationVO.getClassListVO().setClassNum(classNum);
			session.delete(graduationVO);

//        �i���ɦh�褣�i(���y)�ĥ�cascade�p�ŧR���j
//        �i�h��emp2.hbm.xml�p�G�]�� cascade="all"�� cascade="delete"�N�|�R���Ҧ��������-�]�A���ݳ���P�P����䥦��u�N�|�@�ֳQ�R���j
//			EmpVO empVO = (EmpVO) session.get(EmpVO.class, empno);
//			session.0delete(empVO);

			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GraduationVO> findByPrimaryKey(String pilotID, String classID, Integer classNum) {
		List<GraduationVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from GraduationVO where pilotID=? classID=? and classNum=? order by pilotID ");
			query.setParameter(0, pilotID);
			query.setParameter(1, classID);
			query.setParameter(2, classNum);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GraduationVO> getByClassIDAndClassNum(String classID, Integer classNum) {
		List<GraduationVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from GraduationVO where classID=? and classNum=? order by pilotID ");
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
	
	@SuppressWarnings("unchecked")
	@Override
	public List<GraduationVO> getAll() {
		List<GraduationVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ALL_STMT);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

	public static void main(String[] args) {

		GraduationDAO dao = new GraduationDAO();

		//�� �s�W

		GraduationVO graduationVO = new GraduationVO();
		PilotVO pilotVO=new PilotVO();
		pilotVO.setPilotID("A121707694");
		graduationVO.setPilotVO(pilotVO);
		graduationVO.setBirthday(java.sql.Date.valueOf("1970-11-19"));
		graduationVO.setTrainDate(java.sql.Date.valueOf("2013-07-22"));
		graduationVO.setValidDate(java.sql.Date.valueOf("2018-07-02"));
		graduationVO.setDeptName("�_�ϰV�m����");
		ClassListVO classListVO = new ClassListVO();
		ClassTypeVO classTypeVO = new ClassTypeVO();
		classTypeVO.setClassID("CECJ");
		classListVO.setClassTypeVO(classTypeVO);
		classListVO.setClassNum(1);
		graduationVO.setClassListVO(classListVO);
		
		dao.insert(graduationVO);

		
		//�� �ק�
//		EmpVO empVO2 = new EmpVO();
//		empVO2.setEmpno(7001);
//		empVO2.setEname("�d�ç�2");
//		empVO2.setJob("MANAGER2");
//		empVO2.setHiredate(java.sql.Date.valueOf("2002-01-01"));
//		empVO2.setSal(new Double(20000));
//		empVO2.setComm(new Double(200));
//		empVO2.setDeptVO(deptVO);
//		dao.update(empVO2);



		//�� �R��(�p��cascade - �h��emp2.hbm.xml�p�G�]�� cascade="all"��
		// cascade="delete"�N�|�R���Ҧ��������-�]�A���ݳ���P�P����䥦��u�N�|�@�ֳQ�R��)
		// �ҥH�ثe�b�W��65��67��A�ĥΥh�����p���Y��A�A�R�����覡�A�o�O���w�����覡
//		dao.delete(7014);



		//�� �d��-findByPrimaryKey (�h��emp2.hbm.xml�����]��lazy="false")(�u!)
//		EmpVO empVO3 = dao.findByPrimaryKey(7001);
//		System.out.print(empVO3.getEmpno() + ",");
//		System.out.print(empVO3.getEname() + ",");
//		System.out.print(empVO3.getJob() + ",");
//		System.out.print(empVO3.getHiredate() + ",");
//		System.out.print(empVO3.getSal() + ",");
//		System.out.print(empVO3.getComm() + ",");
//		// �`�N�H�U�T�檺�g�k (�u!)
//		System.out.print(empVO3.getDeptVO().getDeptno() + ",");
//		System.out.print(empVO3.getDeptVO().getDname() + ",");
//		System.out.print(empVO3.getDeptVO().getLoc());
//		System.out.println("\n---------------------");

		
//		List<GraduationVO> list = dao.findByPrimaryKey("A100965089","CECJ",1);
//		for (GraduationVO grad : list) {
//			System.out.println(grad.getPilotID());
//		}
		
//		List<GraduationVO> list = dao.getByClassIDAndClassNum("CECJ",1);
//		for (GraduationVO grad : list) {
//			System.out.println(grad.getPilotVO().getPilotID());
//		}

		
		
		//�� �d��-getAll (�h��emp2.hbm.xml�����]��lazy="false")(�u!)
//		List<EmpVO> list = dao.getAll();
//		for (EmpVO aEmp : list) {
//			System.out.print(aEmp.getEmpno() + ",");
//			System.out.print(aEmp.getEname() + ",");
//			System.out.print(aEmp.getJob() + ",");
//			System.out.print(aEmp.getHiredate() + ",");
//			System.out.print(aEmp.getSal() + ",");
//			System.out.print(aEmp.getComm() + ",");
//			// �`�N�H�U�T�檺�g�k (�u!)
//			System.out.print(aEmp.getDeptVO().getDeptno() + ",");
//			System.out.print(aEmp.getDeptVO().getDname() + ",");
//			System.out.print(aEmp.getDeptVO().getLoc());
//			System.out.println();
//		}
	}
}
