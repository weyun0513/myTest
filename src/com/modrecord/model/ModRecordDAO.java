package com.modrecord.model;

import com.util.HibernateUtil;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

public class ModRecordDAO implements ModRecordDAO_interface{
	@Override
	public Session insert(ModRecordVO modRecordVO,Session session) {
		try {
			session.save(modRecordVO);
			return session;
		} catch (RuntimeException ex) {
			throw ex;
		}
	}
	@Override
	public Session update(ModRecordVO modRecordVO,Session session) {
		try {
			session.update(modRecordVO);
			return session;
		} catch (RuntimeException ex) {
			throw ex;
		}
	}
	@Override
	public Session delete(Integer regID,Session session) {
		try {
			ModRecordVO modRecordVO = (ModRecordVO) session.get(ModRecordVO.class,
					regID);
			session.delete(modRecordVO);
			return session;
		} catch (RuntimeException ex) {
			throw ex;
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ModRecordVO> getAll() {
		List<ModRecordVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from ModRecordVO");
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
	 */
	@Override
	public List<ModRecordVO> getByRecord(ModRecordVO modRecordVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		String condition="";
		List<ModRecordVO> list = null;
		if(modRecordVO.getRegID()!=null)
			condition=condition+" and regID ='" +modRecordVO.getRegID()+"'";
		if(modRecordVO.getPilotID()!=null)
			condition=condition+" and pilotID ='" +modRecordVO.getPilotID()+"'";
		try {
			session.beginTransaction();
			Query query = session.createQuery("from ModRecordVO where 1=1 "+condition);
			
			
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			return null;
		}
		return list;
	}
	
	
}