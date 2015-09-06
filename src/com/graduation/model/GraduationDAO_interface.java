package com.graduation.model;

import java.util.*;

public interface GraduationDAO_interface {
          public void insert(GraduationVO graduationVO);
          public void update(GraduationVO graduationVO);
          public void delete(String pilotID, String classID, Integer classNum);
          public List<GraduationVO> findByPrimaryKey(String PilotID, String classID, Integer classNum);
          public List<GraduationVO> getByClassIDAndClassNum(String classID, Integer classNum);
          public List<GraduationVO> getAll();
}
