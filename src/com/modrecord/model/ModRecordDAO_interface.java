package com.modrecord.model;

import java.util.List;

import org.hibernate.Session;

public interface ModRecordDAO_interface {

	Session insert(ModRecordVO modRecordVO, Session session);

	Session update(ModRecordVO modRecordVO, Session session);

	List<ModRecordVO> getAll();

	

	Session delete(Integer regID, Session session);



	List<ModRecordVO> getByRecord(ModRecordVO modRecordVO);


}
