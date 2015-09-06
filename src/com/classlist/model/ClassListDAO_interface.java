package com.classlist.model;


import java.sql.Date;
import java.util.List;

import com.modrecord.model.ModRecordVO;
import com.register.model.RegisterVO;


public interface ClassListDAO_interface {
	public void insert(ClassListVO classListVO);
	public void update(ClassListVO classListVO);
	public void delete(String classID,Integer classNum);
	public ClassListVO findByPrimayKey(String classID,Integer classNum);
	public List<ClassListVO> getAll();
	public List<ClassListVO> goSearch(String condition);
	public Integer getCount(String whereCondition);
	public Integer getClassNum(String classID);
	public Integer changeClassStatus(String afterStatus,String date,String beforeStatus);
	public RegisterVO addOneReg(RegisterVO registerVO, ModRecordVO modRecordVO);
	public List<ClassListVO> getByStartDate(Date startDate); //mobile用
}
