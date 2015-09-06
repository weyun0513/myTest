package com.register.model;


import java.sql.Date;
import java.sql.Timestamp;

import com.classlist.model.ClassListVO;
import com.manager.model.ManagerVO;
import com.pilot.model.PilotVO;

public class RegisterVO {
private Integer regID;
private java.sql.Timestamp regDate;
private String payStatus;
private String regIP;
private String regStatus;
private String notes;
private Date checkPayDate;

private ClassListVO classListVO;
private PilotVO pilotVO;
private ManagerVO managerVO;
private ManagerVO managerVO2;

public static int convertInt(String data) {
	int result = 0;
	try {
		result = Integer.parseInt(data);
	} catch (NumberFormatException e) {
		e.printStackTrace();
		result = -1000;
	}
	return result;
}


public PilotVO getPilotVO() {
	return pilotVO;
}
public void setPilotVO(PilotVO pilotVO) {
	this.pilotVO = pilotVO;
}



public Integer getRegID() {
	return regID;
}
public void setRegID(Integer regID) {
	this.regID = regID;
}


public Timestamp getRegDate() {
	return regDate;
}
public void setRegDate(Timestamp regDate) {
	this.regDate = regDate;
}


public String getPayStatus() {
	return payStatus;
}


public void setPayStatus(String payStatus) {
	this.payStatus = payStatus;
}


public String getRegIP() {
	return regIP;
}
public void setRegIP(String regIP) {
	this.regIP = regIP;
}
public String getRegStatus() {
	return regStatus;
}
public void setRegStatus(String regStatus) {
	this.regStatus = regStatus;
}
public String getNotes() {
	return notes;
}
public void setNotes(String notes) {
	this.notes = notes;
}

public Date getCheckPayDate() {
	return checkPayDate;
}


public void setCheckPayDate(Date checkPayDate) {
	this.checkPayDate = checkPayDate;
}


public ManagerVO getManagerVO() {
	return managerVO;
}


public void setManagerVO(ManagerVO managerVO) {
	this.managerVO = managerVO;
}


public ManagerVO getManagerVO2() {
	return managerVO2;
}


public void setManagerVO2(ManagerVO managerVO2) {
	this.managerVO2 = managerVO2;
}


public ClassListVO getClassListVO() {
	return classListVO;
}


public void setClassListVO(ClassListVO classListVO) {
	this.classListVO = classListVO;
}

}
