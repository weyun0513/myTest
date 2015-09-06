package com.register.model;

import java.sql.Timestamp;
import java.util.Set;

import com.classlist.model.ClassListVO;
import com.classtype.model.ClassTypeVO;
import com.modrecord.model.ModRecordVO;
import com.pilot.model.PilotVO;

public class RegisterService {
	private RegisterInterface dao;

	public RegisterService(){
		dao = new RegisterDAO();
		
	}
	public RegisterVO getByDoubleReg(PilotVO pilotVO,String classID,Integer classNum) {
		return dao.getByDoubleReg(pilotVO,classID,classNum);
	}
	public  void insert(RegisterVO registerVO){
		dao.insert(registerVO);}
	public  void update(RegisterVO registerVO){ 
		dao.update(registerVO);}
	public  void update(RegisterVO registerVO	,ModRecordVO modRecordVO){ 
		dao.update(registerVO,modRecordVO);}
	
	public  void delete(Integer regID) {
		dao.delete(regID);
	}	
	public RegisterVO findByPrimaryKey(Integer regID){
	return dao.findByPrimaryKey(regID);
	}
	public RegisterVO getReg(String pilotID, String classID, Integer classNum){
		return dao.getReg(pilotID,classID,classNum);
	}
	public Set<RegisterVO> getRegisterByClass(String classID,Integer classNum){
	return dao.getRegisterByClass(classID, classNum);
	}
	public RegisterVO changeClassID(String pilotID,String classID,String classNum,String classID_classNum,ModRecordVO modRecordVO) {
		return dao.changeClassID(pilotID,classID,classNum,classID_classNum, modRecordVO);
	}
	public void cancelRegister(RegisterVO registerVO, ClassListVO classListVO){
		dao.cancelRegister(registerVO, classListVO);
	}
	
	
	
//	public static  void main(String[] args){
//
//		RegisterService dao=new RegisterService();
//		
//		//+++++++++++++新增資料
//				RegisterVO registerVO=new RegisterVO();
//				
//				
//				PilotVO pilotVO=new PilotVO();
//				pilotVO.setPilotID("A116913859");
//				registerVO.setPilotVO(pilotVO);
//				
//				ClassListVO classListvo=new ClassListVO();
//				ClassTypeVO classTypeVO=new ClassTypeVO();
//				classTypeVO.setClassID("CECJ");
//			    classListvo.setClassTypeVO(classTypeVO);
//			    
//				classListvo.setClassNum(3);
//				registerVO.setClassListVO(classListvo);
//				
//				registerVO.setPayStatus("false");
//				registerVO.setRegDate(new Timestamp(System.currentTimeMillis()));;
//				registerVO.setRegIP("119.16.07.0");
//				registerVO.setRegStatus("報名");
//				 dao.insert(registerVO);
//		//===========================
////		String classID="CECJ";
////		int classNum=2;
////		Set<RegisterVO> result=new TreeSet<RegisterVO>();
////		result=dao.getRegisterByClass(classID, classNum);
////		for(RegisterVO r:result)
////		{System.out.println(r.getPilotvo().getPilotID());
////			//==================	 
////					RegisterVO VO=new RegisterVO();			
////					 VO=dao.findByPrimaryKey(1000);
////					 System.out.println(VO.getRegIP());
//		}
		
	}

