package com.traindept.model;

import java.util.List;

public interface TrainDeptDAO_interface {
	
	public TrainDeptVO insert(TrainDeptVO trainDeptVO);
		
	public TrainDeptVO update(TrainDeptVO trainDeptVO) ;
	
	public TrainDeptVO delete(Integer deptID) ;

	public TrainDeptVO findByPrimaryKey(Integer deptID);
	
	public List<TrainDeptVO> getAll() ;
}
