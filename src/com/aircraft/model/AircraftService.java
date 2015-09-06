package com.aircraft.model;

import java.util.List;
import java.util.Set;

import com.classtype.model.ClassTypeVO;

public class AircraftService {
	private AircraftDAO_interface dao;
	
	public AircraftService(){
		dao=new AircraftDAO();
	}
	
	public AircraftVO addAircraft(String craftType){
		AircraftVO aircraftVO=new AircraftVO();
		aircraftVO.setCraftType(craftType);
		dao.insert(aircraftVO);
		return aircraftVO;	
	}
	
	public AircraftVO updateAircraft(Integer craftID,String craftType) {
		AircraftVO aircraftVO=new AircraftVO();
		aircraftVO.setCraftID(craftID);
		aircraftVO.setCraftType(craftType);		
		dao.update(aircraftVO);
		return aircraftVO;
	}
	
	public void deleteAircraft(Integer craftID){
		dao.delete(craftID);
	}
	
	public AircraftVO getOneAircraft(Integer craftID) {
		return dao.findByPrimaryKey(craftID);
	}
	
	public List<AircraftVO> getAllAircraft() {
		return dao.getAll();
	}
	
	public Set<ClassTypeVO> getClassTypesByCraftID(Integer craftID) {
		return dao.getClassTypesByCraftID(craftID);
	}

}


