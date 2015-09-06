package com.classlist.model;

import java.sql.Date;
import java.util.List;

import com.classtype.model.ClassTypeVO;
import com.modrecord.model.ModRecordVO;
import com.register.model.RegisterVO;
import com.traindept.model.TrainDeptVO;

public class ClassListService {
	private ClassListDAO_interface dao;
	
	public ClassListService(){
		dao=new ClassListDAO();
	}
	
	public ClassListVO insertClass(String classID,Integer classNum,Date startDate,
			Date endDate,Integer maxNum,Integer deptID,String classSchedule) {
		ClassListVO classListVO=new ClassListVO();
		ClassTypeVO classTypeVO=new ClassTypeVO();
		TrainDeptVO trainDeptVO=new TrainDeptVO();
		classTypeVO.setClassID(classID);
		classListVO.setClassTypeVO(classTypeVO);
		classListVO.setClassNum(classNum);
		classListVO.setStartDate(startDate);
		classListVO.setEndDate(endDate);
		classListVO.setMaxNum(maxNum);
		trainDeptVO.setDeptID(deptID);
		classListVO.setTrainDeptVO(trainDeptVO);
		classListVO.setClassSchedule(classSchedule);
		dao.insert(classListVO);
		return classListVO;
	}
	
	public ClassListVO updateClass(String classID,Integer classNum,String classStatus,
			Date startDate,Date endDate,Integer maxNum,Integer deptID,String classSchedule) {
		ClassListVO classListVO=new ClassListVO();
		ClassTypeVO classTypeVO=new ClassTypeVO();
		TrainDeptVO trainDeptVO=new TrainDeptVO();

		classTypeVO.setClassID(classID);
		classListVO.setClassTypeVO(classTypeVO);
		classListVO.setClassNum(classNum);
		classListVO.setClassStatus(classStatus);
		classListVO.setStartDate(startDate);
		classListVO.setEndDate(endDate);
		classListVO.setMaxNum(maxNum);

		trainDeptVO.setDeptID(deptID);

		classListVO.setTrainDeptVO(trainDeptVO);
		classListVO.setClassSchedule(classSchedule);
		dao.update(classListVO);	
		return classListVO;
	}
	
	public void deleteClass(String classID, Integer classNum) {
		dao.delete(classID, classNum);
	}
	
	public ClassListVO getOneClass(String classID, Integer classNum) {
		return dao.findByPrimayKey(classID, classNum);
	}
	
	public List<ClassListVO> getAllClass() {
		return dao.getAll();
	}
	
	public RegisterVO addOneReg(RegisterVO registerVO,ModRecordVO modRecordVO){
		return dao.addOneReg(registerVO,modRecordVO);
	}
	
	public List<ClassListVO> searchClass(String condition){
		return dao.goSearch(condition);
	}
	
	public Integer getCount(String whereCondition){
		return dao.getCount(whereCondition);
	}
	
	public Integer getClassNum(String classID){
		return dao.getClassNum(classID);
	}
	
	public Integer changeClassStatus(String afterStatus,String date,String beforeStatus){
		return dao.changeClassStatus(afterStatus, date, beforeStatus);
	}
	
}
