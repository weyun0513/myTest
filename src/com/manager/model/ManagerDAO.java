package com.manager.model;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.util.HibernateUtil;

public class ManagerDAO implements ManagerDAO_interface{
	@Override
	public ManagerVO insert(ManagerVO managerVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.save(managerVO);
			session.getTransaction().commit();
			return managerVO;
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			return null;
		}
	}

	@Override
	public ManagerVO update(ManagerVO managerVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.update(managerVO);
			session.getTransaction().commit();
			return managerVO;
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			return null;
		}
	}

	@Override
	public ManagerVO delete(Integer managerID) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			ManagerVO managerVO = (ManagerVO) session.get(ManagerVO.class, managerID);
			session.delete(managerVO);
			session.getTransaction().commit();
			return managerVO;
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			return null;
		}
		
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ManagerVO> getAll() {
		List<ManagerVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from ManagerVO");
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			return null;
		}
		return list;
	}
	
	/*
	 * 有資料回傳VO沒有就回傳null
	 * */
	@Override
	public ManagerVO getByAccnt(String managerAccnt){
		ManagerVO managerBean=null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query=session.createQuery("from ManagerVO where managerAccnt='"+managerAccnt+"'");
			@SuppressWarnings({ "unchecked"})
			List<ManagerVO> list=query.list();
			
			if(!list.isEmpty()){
				managerBean=list.get(0);
			}
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return managerBean;
	}
	
	
	public static void main(String[] args) {
		ManagerDAO dao=new ManagerDAO();
		ManagerVO m=dao.getByAccnt("111");
		System.out.println(m.getTrainDeptVO().getDeptName());
		for(ManagerVO v:dao.getAll())System.out.println(v.getManagerAccnt());
		
	}
}
