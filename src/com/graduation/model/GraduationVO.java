package com.graduation.model;

import java.sql.Date;

import com.classlist.model.ClassListVO;
import com.pilot.model.PilotVO;
public class GraduationVO implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	
	private ClassListVO classListVO;
	private PilotVO pilotVO;
	private Date 	birthday;
	private Date trainDate;
	private Date validDate;
	private String deptName;
	private String notes;
	public ClassListVO getClassListVO() {
		return classListVO;
	}
	public void setClassListVO(ClassListVO classListVO) {
		this.classListVO = classListVO;
	}
	public PilotVO getPilotVO() {
		return pilotVO;
	}
	public void setPilotVO(PilotVO pilotVO) {
		this.pilotVO = pilotVO;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public Date getTrainDate() {
		return trainDate;
	}
	public void setTrainDate(Date trainDate) {
		this.trainDate = trainDate;
	}
	public Date getValidDate() {
		return validDate;
	}
	public void setValidDate(Date validDate) {
		this.validDate = validDate;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	
}
