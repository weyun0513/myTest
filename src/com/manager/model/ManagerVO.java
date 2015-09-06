package com.manager.model;

import java.io.Serializable;

import com.traindept.model.TrainDeptVO;

public class ManagerVO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private Integer managerID;
	private String managerAccnt;
	private byte[] managerPWD;
	private TrainDeptVO trainDeptVO;
	
	
	public Integer getManagerID() {
		return managerID;
	}
	public void setManagerID(Integer managerID) {
		this.managerID = managerID;
	}
	public String getManagerAccnt() {
		return managerAccnt;
	}
	public void setManagerAccnt(String managerAccnt) {
		this.managerAccnt = managerAccnt;
	}
	public byte[] getManagerPWD() {
		return managerPWD;
	}
	public void setManagerPWD(byte[] managerPWD) {
		this.managerPWD = managerPWD;
	}
	public TrainDeptVO getTrainDeptVO() {
		return trainDeptVO;
	}
	public void setTrainDeptVO(TrainDeptVO trainDeptVO) {
		this.trainDeptVO = trainDeptVO;
	}
	
	

}
