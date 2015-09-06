package com.aircraft.model;

import java.util.HashSet;
import java.util.Set;

import com.classtype.model.ClassTypeVO;

public class AircraftVO implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	public AircraftVO(){}
	
	private Integer craftID;
	private String craftType;
	private Set<ClassTypeVO> classTypes=new HashSet<ClassTypeVO>();
	
	public Integer getCraftID() {
		return craftID;
	}
	public void setCraftID(Integer craftID) {
		this.craftID = craftID;
	}
	public String getCraftType() {
		return craftType;
	}
	public void setCraftType(String craftType) {
		this.craftType = craftType;
	}
	public Set<ClassTypeVO> getClassTypes() {
		return classTypes;
	}
	public void setClassTypes(Set<ClassTypeVO> classTypes) {
		this.classTypes = classTypes;
	}
	
	
}
