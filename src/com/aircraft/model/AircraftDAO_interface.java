package com.aircraft.model;

import java.util.List;
import java.util.Set;

import com.classtype.model.ClassTypeVO;

public interface AircraftDAO_interface {
	public void insert(AircraftVO aircraftVO);
	public void update(AircraftVO aircraftVO);
	public void delete(Integer craftID);
	public AircraftVO findByPrimaryKey(Integer craftID);
	public List<AircraftVO> getAll();
	public Set<ClassTypeVO> getClassTypesByCraftID(Integer craftID);	
}
