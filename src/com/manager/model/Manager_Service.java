package com.manager.model;

import java.util.List;

public class Manager_Service {
	ManagerDAO_interface dao=new ManagerDAO();

	public ManagerVO insert(ManagerVO managerVO) {
		if(managerVO!=null)
			return dao.insert(managerVO);
		else
			return managerVO;
	}

	public ManagerVO update(ManagerVO managerVO){
		if(managerVO!=null)
			return dao.update(managerVO);
		else
			return managerVO;
	}

	public ManagerVO delete(Integer managerID){
		if(managerID!=null)
			return dao.delete(managerID);
		else
			return null;
	}

	public List<ManagerVO> getAll(){
		return dao.getAll();
	}

	public ManagerVO getByAccnt(String managerAccnt){
		return dao.getByAccnt(managerAccnt);
	}
}
