package com.pilot.model;


import org.hibernate.Transaction;
import org.hibernate.classic.Session;

import com.util.HibernateUtil;

public class PilotDAO implements PilotDAO_interface {
	Session session=HibernateUtil.getSessionFactory().getCurrentSession();
	Transaction tx =	null;
	
	@Override
	public PilotVO findbyID(String PilotID) {
		PilotVO pilotVO=null;
		try{
		tx = session.beginTransaction();
			pilotVO=(PilotVO)session.get(PilotVO.class, PilotID);
			tx.commit();
		} catch (RuntimeException ex) {
			tx.rollback();
			throw ex;
}
		return pilotVO;
}

	public static  void main(String[] args){
		PilotVO vo=new PilotVO() ;
		 PilotDAO dao=new   PilotDAO();
				vo=dao.findbyID("A100965089");
				System.out.println(vo.getPilotName());
	}
	
}
