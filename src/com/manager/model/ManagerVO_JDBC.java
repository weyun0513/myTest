package com.manager.model;

public class ManagerVO_JDBC implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	public ManagerVO_JDBC(){}
	
	private Integer managerID;
	private String	managerAccnt;
	private byte[]	managerPWD;
	private String	deptID;
	
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
	public String getDeptID() {
		return deptID;
	}
	public void setDeptID(String deptID) {
		this.deptID = deptID;
	}
}
