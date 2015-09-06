package com.pilot.model;

import java.sql.Date;

import com.aircraft.model.AircraftVO;

public class PilotVO  {
private String pilotID;
private String pilotName;
private Date birthday;
private String phone;
//private Integer craftID;
private Date lastTrainDate;
private String certificateID;
private String prohibit;//pilot is prohibit for fly
private String certificateExpired;//if certificate Expired
private String urgentContact;//緊急聯絡人
private String urgentPhone;//緊急聯絡人電話
private Date lastValidDate;
private Date nextValidDate;
private AircraftVO aircraftVO;

 
public String getPilotID() {
	return pilotID;
}
public void setPilotID(String pilotID) {
	this.pilotID = pilotID;
}
public String getPilotName() {
	return pilotName;
}
public void setPilotName(String pilotName) {
	this.pilotName = pilotName;
}
public Date getBirthday() {
	return birthday;
}
public void setBirthday(Date birthday) {
	this.birthday = birthday;
}
public String getPhone() {
	return phone;
}
public void setPhone(String phone) {
	this.phone = phone;
}

public Date getLastTrainDate() {
	return lastTrainDate;
}
public void setLastTrainDate(Date lastTrainDate) {
	this.lastTrainDate = lastTrainDate;
}
public String getCertificateID() {
	return certificateID;
}
public void setCertificateID(String certificateID) {
	this.certificateID = certificateID;
}

public String getProhibit() {
	return prohibit;
}
public void setProhibit(String prohibit) {
	this.prohibit = prohibit;
}
public String getCertificateExpired() {
	return certificateExpired;
}
public void setCertificateExpired(String certificateExpired) {
	this.certificateExpired = certificateExpired;
}
public String getUrgentContact() {
	return urgentContact;
}
public void setUrgentContact(String urgentContact) {
	this.urgentContact = urgentContact;
}
public String getUrgentPhone() {
	return urgentPhone;
}
public void setUrgentPhone(String urgentPhone) {
	this.urgentPhone = urgentPhone;
}
public Date getLastValidDate() {
	return lastValidDate;
}
public void setLastValidDate(Date lastValidDate) {
	this.lastValidDate = lastValidDate;
}
public Date getNextValidDate() {
	return nextValidDate;
}
public void setNextValidDate(Date nextValidDate) {
	this.nextValidDate = nextValidDate;
}
public AircraftVO getAircraftVO() {
	return aircraftVO;
}
public void setAircraftVO(AircraftVO aircraftVO) {
	this.aircraftVO = aircraftVO;
}

}
