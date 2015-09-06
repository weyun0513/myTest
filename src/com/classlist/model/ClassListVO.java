package com.classlist.model;

import java.sql.Date;

import com.classtype.model.ClassTypeVO;
import com.manager.model.ManagerVO;
import com.traindept.model.TrainDeptVO;

public class ClassListVO implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	public ClassListVO(){}
	
	private ClassTypeVO classTypeVO;
	private Integer classNum;
	private String classStatus;
	private Date startDate;
	private Date endDate;
	private Integer maxNum;
	private Integer regNum;
	private Date createDate;
	private TrainDeptVO trainDeptVO;
	private ManagerVO managerVO;
	private String classSchedule;
	

	public Integer getClassNum() {
		return classNum;
	}
	public void setClassNum(Integer classNum) {
		this.classNum = classNum;
	}
	public String getClassStatus() {
		return classStatus;
	}
	public void setClassStatus(String classStatus) {
		this.classStatus = classStatus;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public Integer getMaxNum() {
		return maxNum;
	}
	public void setMaxNum(Integer maxNum) {
		this.maxNum = maxNum;
	}
	public Integer getRegNum() {
		return regNum;
	}
	public void setRegNum(Integer regNum) {
		this.regNum = regNum;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}	
	public ClassTypeVO getClassTypeVO() {
		return classTypeVO;
	}
	public void setClassTypeVO(ClassTypeVO classTypeVO) {
		this.classTypeVO = classTypeVO;
	}
	public TrainDeptVO getTrainDeptVO() {
		return trainDeptVO;
	}
	public void setTrainDeptVO(TrainDeptVO trainDeptVO) {
		this.trainDeptVO = trainDeptVO;
	}
	public ManagerVO getManagerVO() {
		return managerVO;
	}
	public void setManagerVO(ManagerVO managerVO) {
		this.managerVO = managerVO;
	}
	public String getClassSchedule() {
		return classSchedule;
	}
	public void setClassSchedule(String classSchedule) {
		this.classSchedule = classSchedule;
	}
}
