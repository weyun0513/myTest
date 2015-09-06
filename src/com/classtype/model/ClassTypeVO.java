package com.classtype.model;

import java.util.HashSet;
import java.util.Set;

import com.aircraft.model.AircraftVO;
import com.classlist.model.ClassListVO;

public class ClassTypeVO implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	public ClassTypeVO(){}
	
	private String classID;
	private String className;
	private AircraftVO aircraftVO;
	private Set<ClassListVO> classLists=new HashSet<ClassListVO>();
	

	public String getClassID() {
		return classID;
	}
	public void setClassID(String classID) {
		this.classID = classID;
	}
	
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	
	public AircraftVO getAircraftVO() {
		return aircraftVO;
	}
	public void setAircraftVO(AircraftVO aircraftVO) {
		this.aircraftVO = aircraftVO;
	}
	
	public Set<ClassListVO> getClassLists() {
		return classLists;
	}
	public void setClassLists(Set<ClassListVO> classList) {
		this.classLists = classList;
	}
}
