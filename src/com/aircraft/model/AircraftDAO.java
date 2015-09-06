package com.aircraft.model;

import java.util.*;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import com.classtype.model.ClassTypeVO;
import com.util.HibernateUtil;

public class AircraftDAO implements AircraftDAO_interface {
	
	private static final String DELETE="DELETE from AircraftVO WHERE craftID=?";
	private static final String GET_ALL="FROM AircraftVO";
	
	@Override
	public void insert(AircraftVO aircraftVO) {		
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();	
		try {
			session.beginTransaction();
			session.save(aircraftVO);
			session.getTransaction().commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}
	}

	@Override
	public void update(AircraftVO aircraftVO) {
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();		
		try {
			session.beginTransaction();
			session.update(aircraftVO);
			session.getTransaction().commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}
	}
	
	@Override
	public void delete(Integer craftID){
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query=session.createQuery(DELETE);
			query.setParameter(0, craftID);
			query.executeUpdate();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}
	}

	@Override
	public AircraftVO findByPrimaryKey(Integer craftID) {
		AircraftVO aircraftVO=null;
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();		
		try {
			session.beginTransaction();
			aircraftVO=(AircraftVO) session.get(AircraftVO.class, craftID);
			session.getTransaction().commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}	
		return aircraftVO;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<AircraftVO> getAll() {
		List<AircraftVO> list=new ArrayList<AircraftVO>();		
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
	public Set<ClassTypeVO> getClassTypesByCraftID(Integer craftID) {
		Set<ClassTypeVO> set=findByPrimaryKey(craftID).getClassTypes();
		return set;
	}
	
	
	public static void main(String args[]){
		AircraftDAO dao=new AircraftDAO();
//		List<AircraftVO> list=dao.getAll();
//		for(AircraftVO vo:list){
//			System.out.print(vo.getCraftID()+",");
//			System.out.println(vo.getCraftType());
//			System.out.println("--------------");
//		}
		
//		AircraftVO vo=new AircraftVO();
//		vo.setCraftType("民航WTF");
//		dao.insert(vo);
		
//		vo.setCraftID(40);
//		vo.setCraftType("民航YY");
//		dao.update(vo);	
		
//		dao.delete(80);
		
//		vo=dao.findByPrimaryKey(10);
//		System.out.print(vo.getCraftID()+",");
//		System.out.println(vo.getCraftType());
//		System.out.println("--------------");
	
		Set<ClassTypeVO> set=dao.getClassTypesByCraftID(20);
		for(ClassTypeVO cvo:set){
			System.out.print(cvo.getClassID());
			System.out.print(cvo.getClassName());
			System.out.println(cvo.getAircraftVO().getCraftID());
			System.out.println("--------------");
		}
		
	}
	
}
