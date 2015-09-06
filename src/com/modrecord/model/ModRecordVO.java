package com.modrecord.model;

import java.io.Serializable;

import com.manager.model.ManagerVO;

public class ModRecordVO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer regID;
	private String pilotID;
	private java.sql.Timestamp modDate;
	private String modFunction;
	private String modURL;
	private ManagerVO managerVO;
	private String modIP;
	public Integer getRegID() {
		return regID;
	}
	public String getPilotID() {
		return pilotID;
	}
	public java.sql.Timestamp getModDate() {
		return modDate;
	}
	public String getModFunction() {
		return modFunction;
	}
	public String getModURL() {
		return modURL;
	}
	
	public String getModIP() {
		return modIP;
	}
	public void setRegID(Integer regID) {
		this.regID = regID;
	}
	public void setPilotID(String pilotID) {
		this.pilotID = pilotID;
	}
	public void setModDate(java.sql.Timestamp modDate) {
		this.modDate = modDate;
	}
	public void setModFunction(String modFunction) {
		this.modFunction = modFunction;
	}
	public void setModURL(String modURL) {
		this.modURL = modURL;
	}
	
	public void setModIP(String modIP) {
		this.modIP = modIP;
	}
	public ManagerVO getManagerVO() {
		return managerVO;
	}
	public void setManagerVO(ManagerVO managerVO) {
		this.managerVO = managerVO;
	}
	
	

}
