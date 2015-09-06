package com.modrecord.model;

import com.util.HibernateUtil;

import java.util.List;

import org.hibernate.Session;

public class ModRecord_service {
	ModRecordDAO_interface dao=new ModRecordDAO();
	/*
	 * 需要跨table交易時用
	 * 失敗丟回Null 成功回傳VO
	 * dao回傳session
	 * */
	public ModRecordVO insert(ModRecordVO modRecordVO) {
		if(modRecordVO==null){
			return null;
		}
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
				session.beginTransaction();
				dao.insert(modRecordVO, session)
				   .getTransaction()
				   .commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
			modRecordVO=null;
		}
		return modRecordVO;
	}

	public ModRecordVO update(ModRecordVO modRecordVO){
		if(modRecordVO==null){
			return null;
		}
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
				session.beginTransaction();
				dao.update(modRecordVO, session)
				   .getTransaction()
				   .commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
			modRecordVO=null;
		}
		return modRecordVO;
	}

	public Integer delete(Integer regID){
		if(regID==null){
			return null;
		}
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
				session.beginTransaction();
				dao.delete(regID, session)
				   .getTransaction()
				   .commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
			regID=null;
		}
		return regID;
	}

	public List<ModRecordVO> getAll(){
		return dao.getAll();
	}

	public List<ModRecordVO> getByRecord(ModRecordVO modRecordVO)  {
		return dao.getByRecord(modRecordVO);
	}
	
	
	public static void main(String[] args) {
		ModRecord_service ser=new ModRecord_service();
		
		for(ModRecordVO vo:ser.getAll())
			System.out.println(vo.getPilotID());;
	}
}
