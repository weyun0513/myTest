package com.graduation.model;

import java.sql.Date;
import java.util.List;

public class GraduationService {

	private GraduationDAO_interface dao;

	public GraduationService() {
		dao = new GraduationDAO();
	}

	public GraduationVO addGraduation(String pilotID, Date birthday, Date trainDate, 
			Date validDate, String deptName, String classID, Integer classNum) {

		GraduationVO graduationVO = new GraduationVO();

		graduationVO.getPilotVO().setPilotID(pilotID);
		graduationVO.setBirthday(birthday);
		graduationVO.setTrainDate(trainDate);
		graduationVO.setValidDate(validDate);
		graduationVO.setDeptName(deptName);
		graduationVO.getClassListVO().getClassTypeVO().setClassID(classID);
		graduationVO.getClassListVO().setClassNum(classNum);
		dao.insert(graduationVO);

		return graduationVO;
	}

	//預留給 Struts 2 用的
	public void addGraduation(GraduationVO graduationVO) {
		dao.insert(graduationVO);
	}
	
	public List<GraduationVO> updateGraduation(String pilotID, Date birthday, Date trainDate, 
			Date validDate, String deptName, String classID, Integer classNum, String notes) {

		GraduationVO graduationVO = new GraduationVO();

		graduationVO.getPilotVO().setPilotID(pilotID);
		graduationVO.setBirthday(birthday);
		graduationVO.setTrainDate(trainDate);
		graduationVO.setValidDate(validDate);
		graduationVO.setDeptName(deptName);
		graduationVO.getClassListVO().getClassTypeVO().setClassID(classID);
		graduationVO.getClassListVO().setClassNum(classNum);
		graduationVO.setNotes(notes);
		dao.update(graduationVO);

		return dao.findByPrimaryKey(pilotID, classID, classNum);
	}
	
	//預留給 Struts 2 用的
	public void updateGraduation(GraduationVO graduationVO) {
		dao.update(graduationVO);
	}

	public void deleteGraduation(String pilotID, String classID, Integer classNum) {
		dao.delete(pilotID, classID, classNum);
	}

	public List<GraduationVO> getOnePilot(String pilotID, String classID, Integer classNum) {
		return dao.findByPrimaryKey(pilotID, classID, classNum);
	}

	public List<GraduationVO> getByClassIDAndClassNum(String classID, Integer classNum) {
		return dao.getByClassIDAndClassNum(classID, classNum);
	}	
	
	public List<GraduationVO> getAll() {
		return dao.getAll();
	}
}
