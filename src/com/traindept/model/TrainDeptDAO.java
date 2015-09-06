package com.traindept.model;

import com.util.HibernateUtil;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
/*
 * 基本新刪修查詢
 * 目前只用到getAll
 * */
public class TrainDeptDAO implements TrainDeptDAO_interface{
	
	public TrainDeptVO insert(TrainDeptVO trainDeptVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.save(trainDeptVO);
			session.getTransaction().commit();
			return trainDeptVO;
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			return null;
		}
	}

	
	public TrainDeptVO update(TrainDeptVO trainDeptVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.update(trainDeptVO);
			session.getTransaction().commit();
			return trainDeptVO;
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			return null;
		}
	}

	
	public TrainDeptVO delete(Integer deptID) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			TrainDeptVO trainDeptVO = (TrainDeptVO) session.get(TrainDeptVO.class, deptID);
			session.delete(trainDeptVO);
			session.getTransaction().commit();
			return trainDeptVO;
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			return null;
		}
	}

	public TrainDeptVO findByPrimaryKey(Integer deptID) {
		TrainDeptVO deptVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			deptVO = (TrainDeptVO) session.get(TrainDeptVO.class, deptID);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return deptVO;
	}
	
	public List<TrainDeptVO> getAll() {
		List<TrainDeptVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from TrainDeptVO");
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}
	public static void main(String[] args) {
		TrainDeptDAO dao=new TrainDeptDAO();
		for(TrainDeptVO vo:dao.getAll())
			System.out.println(vo.getDeptName());
	}
}
