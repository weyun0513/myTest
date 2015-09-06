package com.traindept.model;
/*
 * 訓練單位包含流水號deptID
 * */
public class TrainDeptVO{

	private Integer deptID;			//訓練單位代號
	private String 	deptName; 		//訓練單位名稱
	
	public Integer getDeptID() {
		return deptID;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptID(Integer deptID) {
		this.deptID = deptID;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

}
