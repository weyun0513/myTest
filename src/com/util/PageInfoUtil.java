package com.util;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class PageInfoUtil {
	
	public static void setPageInfo(HttpServletRequest request,
				HttpServletResponse response){
		
		HttpSession session=request.getSession();
		Map<String,Object> pageInfo=new HashMap<String,Object>();
		
		int searchType;
		try {
			searchType = Integer.parseInt(request.getParameter("searchType"));
			if (searchType < 1 || searchType > 3)
				searchType = 1;
		} catch (NumberFormatException e) {
			searchType = 1;
		}

		int pageNum1 = 1;
		try {
			pageNum1 = Integer.parseInt(request.getParameter("pageNum1"));
		} catch (NumberFormatException e) {
			pageNum1 = 1;
		}
			
		int pageNum2 = 1;
		try {
			pageNum2 = Integer.parseInt(request.getParameter("pageNum2"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
			pageNum2 = 1;
		}
		
		int pageNum3 = 1;	
		try {
			pageNum3 = Integer.parseInt(request.getParameter("pageNum3"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
			pageNum3 = 1;
		}
		
		int rowNum = 10;
		try {
			rowNum = Integer.parseInt(request.getParameter("rowNum"));
		} catch (NumberFormatException e) {
			rowNum = 10;
			if (rowNum < 10)
				rowNum = 10;
			if (rowNum > 30)
				rowNum = 30;
		}
//		System.out.println("pageNum1="+pageNum1+"pageNum2="+pageNum2+"pageNum3="+pageNum3);	
		pageInfo.put("classID", request.getParameter("s_classID"));
		pageInfo.put("craftID", request.getParameter("s_craftID"));
		pageInfo.put("startDate1", request.getParameter("startDate1"));
		pageInfo.put("startDate2", request.getParameter("startDate2"));
		pageInfo.put("endDate1", request.getParameter("endDate1"));
		pageInfo.put("endDate2", request.getParameter("endDate2"));		
		pageInfo.put("searchType", searchType);
		pageInfo.put("pageNum1", pageNum1);
		pageInfo.put("pageNum2", pageNum2);
		pageInfo.put("pageNum3", pageNum3);
		pageInfo.put("rowNum", rowNum);	
		
		session.setAttribute("pageInfo", pageInfo);
	}
	
}
