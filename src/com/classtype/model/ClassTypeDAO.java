package com.classtype.model;

import java.util.*;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import com.classlist.model.ClassListVO;
import com.util.HibernateUtil;

public class ClassTypeDAO implements ClassTypeDAO_interface {

	private static final String DELETE="DELETE FROM ClassTypeVO WHERE classID=?";
//	private static final String DELETE_CLASSES="DELETE FROM ClassList WHERE classID=?";
	private static final String GET_ALL="FROM ClassTypeVO";

	@Override
	public void insert(ClassTypeVO classTypeVO) {
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();	
		try {
			session.beginTransaction();
			session.save(classTypeVO);
			session.getTransaction().commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}
	}

	@Override
	public void update(ClassTypeVO classTypeVO) {
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.update(classTypeVO);
			session.getTransaction().commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}
	}

	@Override
	public void delete(String classID) {
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query=session.createQuery(DELETE);
			query.setParameter(0, classID);
			query.executeUpdate();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}
	}

	@Override
	public ClassTypeVO findByPrimayKey(String classID) {
		ClassTypeVO classTypeVO=null;
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			classTypeVO=(ClassTypeVO) session.get(ClassTypeVO.class, classID);
			session.getTransaction().commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}		
		return classTypeVO;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ClassTypeVO> getAll() {
		List<ClassTypeVO> list=new ArrayList<ClassTypeVO>();
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query=session.createQuery(GET_ALL);
			list=query.list();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}	
		return list;
	}

	@Override
	public Set<ClassListVO> getClassListsByClassID(String classID) {
		Set<ClassListVO> set=findByPrimayKey(classID).getClassLists();	
		return set;
	}

	
	public static void main(String args[]){
		ClassTypeDAO dao=new ClassTypeDAO();
//		ClassTypeVO vo=new ClassTypeVO();
//		AircraftVO aircraftVO=new AircraftVO();
		
//		aircraftVO.setCraftID(20);
//		vo.setClassID("CECC");
//		vo.setClassName("CCCC");
//		vo.setAircraftVO(aircraftVO);
//		dao.insert(vo);
//		dao.update(vo);
//		dao.delete("CECC");
		
//		vo=dao.findByPrimayKey("CECJ");
//			System.out.print(vo.getClassID()+",");
//			System.out.print(vo.getClassName()+",");
//			System.out.println(vo.getAircraftVO().getCraftID());
//			System.out.println("----------------");
			
//		List<ClassTypeVO> list=dao.getAll();
//		for(ClassTypeVO cvo:list){
//			System.out.print(cvo.getClassID()+",");
//			System.out.print(cvo.getClassName()+",");
//			System.out.println(cvo.getAircraftVO().getCraftID()+",");
//			System.out.println("------------");		
//		}
		
		Set<ClassListVO> set=dao.getClassListsByClassID("CECJ");
		for(ClassListVO cvo:set){
			System.out.print(cvo.getClassTypeVO().getClassID()+",");
			System.out.print(cvo.getClassStatus()+",");
			System.out.print(cvo.getStartDate()+",");
			System.out.print(cvo.getEndDate()+",");
			System.out.print(cvo.getMaxNum()+",");
			System.out.print(cvo.getRegNum()+",");
			System.out.print(cvo.getCreateDate()+",");
			System.out.print(cvo.getManagerVO().getManagerID()+",");
			System.out.println(cvo.getClassSchedule());
			System.out.println("------------");	
		}

	}
}
