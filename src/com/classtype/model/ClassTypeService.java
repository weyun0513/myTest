package com.classtype.model;

import java.util.List;
import java.util.Set;

import com.aircraft.model.AircraftVO;
import com.classlist.model.ClassListVO;

public class ClassTypeService {
	private ClassTypeDAO_interface dao;
	
	public ClassTypeService(){
		dao=new ClassTypeDAO();
	}
	public ClassTypeVO insertClassType(String classID,String className,Integer craftID){
		ClassTypeVO classTypeVO=new ClassTypeVO();
		AircraftVO aircraftVO=new AircraftVO();
		classTypeVO.setClassID(classID);
		classTypeVO.setClassName(className);
		aircraftVO.setCraftID(craftID);
		classTypeVO.setAircraftVO(aircraftVO);
		dao.insert(classTypeVO);
		return classTypeVO;
	}
	public ClassTypeVO updateClassType(String classID,String className,Integer craftID){
		ClassTypeVO classTypeVO=new ClassTypeVO();
		AircraftVO aircraftVO=new AircraftVO();
		classTypeVO.setClassID(classID);
		classTypeVO.setClassName(className);
		aircraftVO.setCraftID(craftID);
		classTypeVO.setAircraftVO(aircraftVO);
		dao.update(classTypeVO);
		return classTypeVO;
	}
	public void deleteClassType(String classID){
		dao.delete(classID);
	}
	public ClassTypeVO getOneClassType(String classID){
		return dao.findByPrimayKey(classID);
	}
	public List<ClassTypeVO> getAllClassType(){
		return dao.getAll();
	}
	public Set<ClassListVO> getClassListsByClassID(String classID){
		return dao.getClassListsByClassID(classID);
	}
}
