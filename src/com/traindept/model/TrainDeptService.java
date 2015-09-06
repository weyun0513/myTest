package com.traindept.model;

import java.util.List;

public class TrainDeptService {
	TrainDeptDAO dao=null;
	public TrainDeptService(){
		dao=new TrainDeptDAO();
	}
	
	public TrainDeptVO insertTrainDept(String deptName){
		TrainDeptVO trainDeptVO=new TrainDeptVO();
		trainDeptVO.setDeptName(deptName);
		dao.insert(trainDeptVO);
		return trainDeptVO;
	}
	public TrainDeptVO updateTrainDept(Integer deptID,String deptName) {
		TrainDeptVO trainDeptVO=new TrainDeptVO();
		trainDeptVO.setDeptID(deptID);
		trainDeptVO.setDeptName(deptName);
		dao.update(trainDeptVO);
		return trainDeptVO;	
	}
	public void deleteTrainDept(Integer deptID) {
		dao.delete(deptID);
	}
	public TrainDeptVO getOneTrainDept(Integer deptID) {
		return dao.findByPrimaryKey(deptID);
	}
	public List<TrainDeptVO> getAllTrainDept() {
		return dao.getAll();
	}
}
