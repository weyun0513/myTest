package com.register.model;

import java.util.List;
import java.util.Set;

import com.classlist.model.ClassListVO;
import com.modrecord.model.ModRecordVO;
import com.pilot.model.PilotVO;
//07參考
public interface RegisterInterface {

    public  void insert(RegisterVO registerVO);
   // public  void update(RegisterVO registerVO);
    public  void delete(Integer regID);
    public RegisterVO findByPrimaryKey(Integer regID);
    //查詢某班級的學生(一對多)(回傳 Set)
    public Set<RegisterVO> getRegisterByClass(String classID,Integer classNum);
    public List<RegisterVO> getByClassIDAndClassNum(String classID,Integer classNum);
    public List<RegisterVO> getByNotes(String classID,Integer classNum, String notes);
    public List<RegisterVO> getGraduation();
    public List<RegisterVO> getByPilotID(String pilotID);
	public void update(RegisterVO registerVO, ModRecordVO modRecordVO);
	public void update(RegisterVO registerVO);
	public RegisterVO getByDoubleReg(PilotVO pilotVO,String classID,Integer classNum);
	RegisterVO getReg(String pilotID, String classID, Integer classNum);
	public RegisterVO changeClassID(String pilotID, String classID,
			String classNum, String classID_classNum, ModRecordVO modRecordVO);
	public void cancelRegister(RegisterVO registerVO, ClassListVO classListVO);
}
