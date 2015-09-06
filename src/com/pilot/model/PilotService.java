package com.pilot.model;

import java.util.Set;

public class PilotService {
	private PilotDAO_interface dao;

	public PilotService(){
		dao = new PilotDAO();
		
	}
	public PilotVO findbyID(String PilotID){
		return dao.findbyID(PilotID);
	}		
	}

