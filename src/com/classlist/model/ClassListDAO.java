package com.classlist.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.aircraft.model.AircraftVO;
import com.classtype.model.ClassTypeVO;
import com.manager.model.ManagerVO;
import com.modrecord.model.ModRecordVO;
import com.register.model.RegisterVO;
import com.traindept.model.TrainDeptVO;
import com.util.HibernateUtil;

public class ClassListDAO implements ClassListDAO_interface {

	private static DataSource ds=null;
	static{
		try {
			Context context=new InitialContext();
			ds=(DataSource)context.lookup("java:comp/env/jdbc/ProjectDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}		
	}
	
//	 String driver="com.microsoft.sqlserver.jdbc.SQLServerDriver";
//	 String url="jdbc:sqlserver://localhost:1433;DataBaseName=ProjectAir";
//	 String user="sa";
//	 String password="P@ssw0rd";
	
	private static final String UPDATE="UPDATE FROM ClassListVO SET classStatus=?,startDate=?,endDate=?,maxNum=?,"
			+"deptID=?,classSchedule=? WHERE classID=? AND classNum=?";
	private static final String DELETE="DELETE FROM ClassListVO WHERE classID=? AND classNum=?";
	private static final String GET_ONE="FROM ClassListVO WHERE classID=? AND classNum=?";
	private static final String GET_ALL="SELECT * FROM (SELECT *,ROW_NUMBER() OVER(ORDER BY startDate) AS row FROM ClassList) AS temp";
//	private static final String ADD_REG="UPDATE ClassList SET regNum=(SELECT regNum FROM ClassList WHERE classID=? AND classNum=?)+1"
//								+ "WHERE classID=? AND classNum=?";
	private static final String SEARCH="SELECT * FROM (SELECT *,ROW_NUMBER() OVER(ORDER BY startDate) AS row FROM ClassView";
	private static final String COUNT="SELECT COUNT(*) AS count FROM (SELECT *,ROW_NUMBER() OVER(ORDER BY startDate) AS row FROM ClassView";
	private static final String GET_CLASSNUM="SELECT TOP 1 classNum FROM Classlist WHERE classID=? ORDER BY classNum DESC";
//	private static final String CHANGE_STATUS="UPDATE FROM ClassListVO SET classStatus=? WHERE ? <= getDate() AND classStatus=?";
	
	
	@Override
	public void insert(ClassListVO classListVO) {
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();
			try {
				session.beginTransaction();
				session.save(classListVO);
				session.getTransaction().commit();
			} catch (HibernateException e) {
				e.printStackTrace();
				session.getTransaction().rollback();
			}
	}

	@Override
	public void update(ClassListVO classListVO) {
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query=session.createQuery(UPDATE);
			query.setParameter(0, classListVO.getClassStatus());
			query.setParameter(1, classListVO.getStartDate());
			query.setParameter(2, classListVO.getEndDate());
			query.setParameter(3, classListVO.getMaxNum());
			query.setParameter(4, classListVO.getTrainDeptVO().getDeptID());
			query.setParameter(5, classListVO.getClassSchedule());
			query.setParameter(6, classListVO.getClassTypeVO().getClassID());
			query.setParameter(7, classListVO.getClassNum());		
			query.executeUpdate();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}		
		
	}

	@Override
	public void delete(String classID, Integer classNum) {
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();
			try {
				session.beginTransaction();
				Query query=session.createQuery(DELETE);
				query.setParameter(0, classID);
				query.setParameter(1, classNum);
				query.executeUpdate();
				session.getTransaction().commit();
			} catch (HibernateException e) {
				e.printStackTrace();
				session.getTransaction().rollback();
			}
	}

	@Override
	public ClassListVO findByPrimayKey(String classID, Integer classNum) {
		ClassListVO classListVO=null;
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query=session.createQuery(GET_ONE);
			query.setParameter(0, classID);
			query.setParameter(1, classNum);
			@SuppressWarnings("unchecked")
			List<ClassListVO> list=query.list();
			System.out.println(classID+classNum);
			classListVO=list.get(0);
			session.getTransaction().commit();
			//System.out.println(list.size());
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		return classListVO;
	}

	@Override
	public List<ClassListVO> getAll() {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ClassListVO> list=new ArrayList<ClassListVO>();
		ClassListVO classListVO=null;
		ClassTypeVO classTypeVO=null;
		ManagerVO managerVO=null;
		
		try {

//			Class.forName(driver);
//			conn=DriverManager.getConnection(url, user, password);
			conn=ds.getConnection();
			pstmt=conn.prepareCall(GET_ALL);
			rs=pstmt.executeQuery();
			while(rs.next()){
				classListVO=new ClassListVO();
				classTypeVO=new ClassTypeVO();
				managerVO=new ManagerVO();
				classTypeVO.setClassID(rs.getString("classID"));
				classListVO.setClassTypeVO(classTypeVO);
				classListVO.setClassNum(rs.getInt("classNum"));
				classListVO.setClassStatus(rs.getNString("classStatus"));
				classListVO.setStartDate(rs.getDate("startDate"));
				classListVO.setEndDate(rs.getDate("endDate"));
				classListVO.setMaxNum(rs.getInt("maxNum"));
				classListVO.setRegNum(rs.getInt("regNum"));
				classListVO.setCreateDate(rs.getDate("createDate"));
				managerVO.setManagerID(rs.getInt("managerID"));
				classListVO.setManagerVO(managerVO);
				classListVO.setClassSchedule(rs.getNString("classSchedule"));
				list.add(classListVO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(pstmt!=null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
	
		return list;
	}

	@Override
	public RegisterVO addOneReg(RegisterVO registerVO,ModRecordVO modRecordVO) {
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx =	null;
		RegisterVO result=null;
		try{ 
			int regNum=registerVO.getClassListVO().getRegNum();
			int classNum=registerVO.getClassListVO().getClassNum();
			String classID=registerVO.getClassListVO().getClassTypeVO().getClassID();
			String pilotID=registerVO.getPilotVO().getPilotID();
			tx = session.beginTransaction();
			
			Query query = session.createQuery("update ClassListVO set regNum="+(regNum+1)
												+" where classNum="+classNum+" and classID='"
												+classID+"'"
												);
			query.executeUpdate();
			session.saveOrUpdate(registerVO);
			session.flush();
			query = session.createQuery("from RegisterVO where pilotID='"+pilotID +"' and classID='"+classID+"' and classNum="+classNum);
			result=(RegisterVO) query.list().get(0);
			//System.out.println(result.getPilotVO().getPilotName());
			modRecordVO.setRegID(result.getRegID());
			session.saveOrUpdate(modRecordVO);
			tx.commit();
		} catch (Exception ex) {
			tx.rollback();
			ex.printStackTrace();
			result=null;
		}
		
		return result;
		
	}
	
	
	@Override
	public List<ClassListVO> goSearch(String condition) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ClassListVO> list=new ArrayList<ClassListVO>();
		ClassListVO classlistVO=null;
		ClassTypeVO classTypeVO=null;
		TrainDeptVO trainDeptVO=null;
		ManagerVO managerVO=null;
		AircraftVO aircraftVO=null;
		
		try {
//			Class.forName(driver);
//			conn=DriverManager.getConnection(url, user, password);
			conn=ds.getConnection();
			pstmt=conn.prepareCall(SEARCH+condition);
			rs=pstmt.executeQuery();
			while(rs.next()){
				classlistVO=new ClassListVO();
				classTypeVO=new ClassTypeVO();
				trainDeptVO=new TrainDeptVO();
				managerVO=new ManagerVO();
				aircraftVO=new AircraftVO();
				aircraftVO.setCraftType(rs.getString("craftType"));
				aircraftVO.setCraftID(rs.getInt("craftID"));
				classTypeVO.setClassID(rs.getString("classID"));			
				classlistVO.setClassTypeVO(classTypeVO);
				classlistVO.getClassTypeVO().setAircraftVO(aircraftVO);
				classlistVO.setClassNum(rs.getInt("classNum"));
				classlistVO.setClassStatus(rs.getNString("classStatus"));
				classlistVO.setStartDate(rs.getDate("startDate"));
				classlistVO.setEndDate(rs.getDate("endDate"));
				classlistVO.setMaxNum(rs.getInt("maxNum"));
				classlistVO.setRegNum(rs.getInt("regNum"));
				classlistVO.setCreateDate(rs.getDate("createDate"));			
				trainDeptVO.setDeptID(rs.getInt("deptID"));
				classlistVO.setTrainDeptVO(trainDeptVO);
				managerVO.setManagerID(rs.getInt("managerID"));
				classlistVO.setManagerVO(managerVO);
				classlistVO.setClassSchedule(rs.getNString("classSchedule"));
				list.add(classlistVO);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if(pstmt!=null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		return list;
	}

	@Override
	public Integer getCount(String whereCondition) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Integer count=null;
		
		try {
//			Class.forName(driver);
//			conn=DriverManager.getConnection(url, user, password);
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(COUNT+whereCondition);
			rs=pstmt.executeQuery();
			while(rs.next()){
				count=rs.getInt("count");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			if(rs!=null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(pstmt!=null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		
		return count;
	}

	@Override
	public Integer getClassNum(String classID) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Integer classNum=null;
		
		try {
//			Class.forName(driver);
//			conn=DriverManager.getConnection(url, user, password);
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(GET_CLASSNUM);
			pstmt.setString(1, classID);
			rs=pstmt.executeQuery();
			while(rs.next()){
				classNum=rs.getInt("classNum");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			if(rs!=null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(pstmt!=null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		
		return classNum;
	}
	
	@Override
	public Integer changeClassStatus(String afterStatus,String date,String beforeStatus) {
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();
		int count=0;
		try {
			session.beginTransaction();
			Query query=session.createQuery("UPDATE FROM ClassListVO SET classStatus=? WHERE "+date+" <= getDate() AND classStatus=?");
			query.setParameter(0, afterStatus);
			query.setParameter(1, beforeStatus);
			count=query.executeUpdate();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		return count;
		
	}

	
	@SuppressWarnings("unchecked")
	@Override
	public List<ClassListVO> getByStartDate(Date startDate) {
		List<ClassListVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			//今天日期+7天
			Calendar c = Calendar.getInstance();
            c.setTime(new java.util.Date());
            c.add(Calendar.DATE,7);
            String date = Integer.toString(c.get(Calendar.YEAR))
            +"-"
            +Integer.toString(c.get(Calendar.MONTH)+1)
            +"-"
            +Integer.toString(c.get(Calendar.DATE));
			
          //startDate加一個月
            Calendar c2 = Calendar.getInstance();
            c2.setTime(new java.util.Date(startDate.getTime()));
            c2.add(Calendar.MONTH,3);
            String startDate2 = Integer.toString(c2.get(Calendar.YEAR))
            +"-"
            +Integer.toString(c2.get(Calendar.MONTH)+1)
            +"-"
            +Integer.toString(c2.get(Calendar.DATE));
            
			session.beginTransaction();
			Criteria query = session.createCriteria(ClassListVO.class);
			query.addOrder(Order.asc("startDate"));
			query.add(Restrictions.ge("startDate", startDate));
			query.add(Restrictions.le("startDate", Date.valueOf(startDate2)));
			query.add(Restrictions.ge("startDate", Date.valueOf(date)));
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

	
	
//	public static void main(String args[]){
//		ClassListDAO dao=new ClassListDAO();
//		ClassListVO vo=new ClassListVO();
//		System.out.println(dao.getClassNum("cecj"));
//		ClassTypeVO classTypeVO=new ClassTypeVO();
//		classTypeVO.setClassID("CECJ");
//		ManagerVO managerVO=new ManagerVO();
//		managerVO.setManagerID(2);
//		TrainDeptVO trainDeptVO=new TrainDeptVO();
//		trainDeptVO.setDeptID(10);
		
//		vo.setClassTypeVO(classTypeVO);
//		vo.setClassNum(1301);
//		vo.setStartDate(java.sql.Date.valueOf("2014-08-08"));
//		vo.setEndDate(java.sql.Date.valueOf("2014-08-30"));
//		vo.setMaxNum(20);
//		vo.setRegNum(2);
//		vo.setTrainDeptVO(trainDeptVO);
//		vo.setManagerVO(managerVO);
//		vo.setClassSchedule("一、二、三");
//		dao.insert(vo);
//		
//		vo.setClassStatus("暫停報名");
//		vo.setCreateDate(java.sql.Date.valueOf("2014-09-09"));

		
//		dao.delete("CECJ", 1300);
//		vo=dao.findByPrimayKey("CECJ", 1);
//		System.out.print(vo.getClassTypeVO().getClassID()+",");
//		System.out.print(vo.getClassNum()+",");
//		System.out.print(vo.getClassStatus()+",");
//		System.out.print(vo.getStartDate()+",");
//		System.out.print(vo.getEndDate()+",");
//		System.out.print(vo.getMaxNum()+",");
//		System.out.print(vo.getRegNum()+",");
//		System.out.print(vo.getCreateDate()+",");
//		System.out.print(vo.getManagerVO().getManagerID()+",");
//		System.out.println(vo.getClassSchedule());
//		System.out.println("---------------");
		
//		List<ClassListVO> list=dao.getAll();
//		for(ClassListVO cvo:list){
//			System.out.print(cvo.getClassTypeVO().getClassID()+",");
//			System.out.print(cvo.getClassNum()+",");
//			System.out.print(cvo.getClassStatus()+",");
//			System.out.print(cvo.getStartDate()+",");
//			System.out.print(cvo.getEndDate()+",");
//			System.out.print(cvo.getMaxNum()+",");
//			System.out.print(cvo.getRegNum()+",");
//			System.out.print(cvo.getCreateDate()+",");
//			System.out.print(cvo.getManagerVO().getManagerID()+",");
//			System.out.println(cvo.getClassSchedule());
//			System.out.println("---------------");
//		}
		
//		dao.addOneReg("CECJ", 1);
		
//		List<ClassListVO> list=dao.goSearch(")as temp");
//		for(ClassListVO cvo:list){
//			System.out.print(cvo.getClassTypeVO().getClassID()+",");
//			System.out.print(cvo.getClassNum()+",");
//			System.out.print(cvo.getClassStatus()+",");
//			System.out.print(cvo.getStartDate()+",");
//			System.out.print(cvo.getEndDate()+",");
//			System.out.print(cvo.getMaxNum()+",");
//			System.out.print(cvo.getRegNum()+",");
//			System.out.print(cvo.getCreateDate()+",");
//			System.out.print(cvo.getManagerVO().getManagerID()+",");
//			System.out.println(cvo.getClassSchedule());
//			System.out.println("---------------");
//		}
		
//		System.out.println(dao.getCount(")as temp"));
		
//		System.out.println(dao.getClassNum("CECJ"));
		
//		System.out.println(dao.changeClassStatus("已開訓","startDate", "開放報名"));
//
//	}


}
