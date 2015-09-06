package com.classtype.model;

import java.util.List;
import java.util.Set;

import com.classlist.model.ClassListVO;

public interface ClassTypeDAO_interface {
	public void insert(ClassTypeVO classTypeVO);
	public void update(ClassTypeVO classTypeVO);
	public void delete(String classID);
	public ClassTypeVO findByPrimayKey(String classID);
	public List<ClassTypeVO> getAll();
	public Set<ClassListVO> getClassListsByClassID(String classID);
}
