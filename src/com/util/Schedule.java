package com.util;


import java.util.TimerTask;

import com.classlist.model.ClassListService;

public class Schedule extends TimerTask {
	private ClassListService classListSvc;
	
	public Schedule(){
		classListSvc=new ClassListService();
	}
	
	@Override
	public void run() {
		System.out.println("HIHI Timer:"+new java.util.Date());
		int count;
		count=classListSvc.changeClassStatus("已開訓", "startDate", "開放報名");
		//System.out.println(count);
		count=classListSvc.changeClassStatus("已結訓", "endDate", "已開訓");
		//System.out.println(count);
	}

}
