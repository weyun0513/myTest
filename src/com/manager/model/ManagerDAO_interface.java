package com.manager.model;

import java.util.List;
public interface ManagerDAO_interface {
	public ManagerVO insert(ManagerVO managerVO) ;

	public ManagerVO update(ManagerVO managerVO);

	public ManagerVO delete(Integer managerID);

	public List<ManagerVO> getAll() ;

	public ManagerVO getByAccnt(String managerAccnt);
}
