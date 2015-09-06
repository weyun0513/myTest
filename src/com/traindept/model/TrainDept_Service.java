package com.traindept.model;

import java.util.List;

public class TrainDept_Service {
	TrainDeptDAO_interface dao=new TrainDeptDAO();
	
	public TrainDeptVO insert(TrainDeptVO trainDeptVO){
		if(trainDeptVO==null)return null;
		return dao.insert(trainDeptVO);
	}
	
	public TrainDeptVO update(TrainDeptVO trainDeptVO) {
		if(trainDeptVO==null)return null;
		return dao.update(trainDeptVO);
	}
	
	public TrainDeptVO delete(Integer deptID) {
		if(deptID==null)return null;
		return dao.delete(deptID);
	}

	public TrainDeptVO findByPrimaryKey(Integer deptID){
		return dao.findByPrimaryKey(deptID);
	}
	
	public List<TrainDeptVO> getAll() {
		return dao.getAll();
	}
}
