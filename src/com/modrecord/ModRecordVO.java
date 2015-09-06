package com.modrecord;

import java.sql.Date;

public class ModRecordVO implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	public ModRecordVO(){}
	
	private Date modDate;
	private String modFunction;
	private String modURL;
	private String managerID;
	private String modIP;
	
	public Date getModDate() {
		return modDate;
	}
	public void setModDate(Date modDate) {
		this.modDate = modDate;
	}
	public String getModFunction() {
		return modFunction;
	}
	public void setModFunction(String modFunction) {
		this.modFunction = modFunction;
	}
	public String getModURL() {
		return modURL;
	}
	public void setModURL(String modURL) {
		this.modURL = modURL;
	}
	public String getManagerID() {
		return managerID;
	}
	public void setManagerID(String managerID) {
		this.managerID = managerID;
	}
	public String getModIP() {
		return modIP;
	}
	public void setModIP(String modIP) {
		this.modIP = modIP;
	}
	
	
}
