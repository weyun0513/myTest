package com.classlist.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;



import java.util.Map;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aircraft.model.AircraftService;
import com.classlist.model.ClassListService;
import com.classlist.model.ClassListVO;
import com.classtype.model.ClassTypeService;
import com.classtype.model.ClassTypeVO;
import com.manager.model.ManagerVO;
import com.traindept.model.TrainDeptService;
import com.util.CompositeQuery;
import com.util.PageInfoUtil;


public class ClassViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {		
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
				
		request.setCharacterEncoding("UTF-8");
//		response.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		String url;

		
		if ("searchList".equals(action)) {
			searchList(request, response);
			return;
		} else if ("searchOne".equals(action)) {
			searchOne(request, response);
			return;
		} else if ("previewAdd".equals(action)) {
			addPreview(request, response);
			return;
		} else if ("classPreview".equals(action) || "goReg".equals(action) || "goReg2".equals(action)) {
			PageInfoUtil.setPageInfo(request,response);
			regPreview(request, response);
			if ("classPreview".equals(action))
				url = "/WEB-INF/classlist/updateClass.jsp";
			else
				url = "/WEB-INF/classlist/addReg.jsp";
			request.getRequestDispatcher(url).forward(request, response);
			return;
		} else if ("goAddClass".equals(action)) {
//			PageInfoUtil.setPageInfo(request,response);
			goAddClass(request, response);
			url = "/WEB-INF/classlist/addClass.jsp";
			request.getRequestDispatcher(url).forward(request, response);
			return;
		} else if ("goUpdate".equals(action)) {
			goUpdate(request, response);
			return;
		}

		url = "/WEB-INF/classlist/classList.jsp";
		request.getRequestDispatcher(url).forward(request, response);
					
	}
	
	
	
	private void searchList(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		ClassListService classListSvc = new ClassListService();
		String whereCondition = CompositeQuery.get_WhereCondition(request
				.getParameterMap());

		int count;
		try {
			count = classListSvc.getCount(whereCondition);
		} catch (Exception e1) {
			count = 0;
		}
		// System.out.println("count="+count);
		
		int rowNum;
		try {
			rowNum = Integer.parseInt(request.getParameter("rowNum"));
		} catch (NumberFormatException e) {
			rowNum = 10;
			if (rowNum < 10)
				rowNum = 10;
			if (rowNum > 30)
				rowNum = 30;
		}
		// System.out.println("rowNum="+rowNum);
		
		int totalPage = count / rowNum + ((count % rowNum == 0) ? 0 : 1);
		// System.out.println("totalPage="+totalPage);

		int searchType;
		try {
			searchType = Integer.parseInt(request.getParameter("searchType"));
			if (searchType < 1 || searchType > 3)
				searchType = 1;
		} catch (NumberFormatException e) {
			searchType = 1;
		}

		int pageNum1 = 1;
		int pageNum2 = 1;
		int pageNum3 = 1;
		int pageNum = 1;

		try {
			pageNum1 = Integer.parseInt(request.getParameter("pageNum1"));
			pageNum2 = Integer.parseInt(request.getParameter("pageNum2"));
			pageNum3 = Integer.parseInt(request.getParameter("pageNum3"));

			if (searchType == 3) {
				pageNum = pageNum3;
			} else {
				pageNum = (searchType == 2) ? pageNum2 : pageNum1;
			}
			if (pageNum < 1)
				pageNum = 1;
			if (pageNum > totalPage)
				pageNum = totalPage;

		} catch (NumberFormatException e) {
			// e.printStackTrace();
			pageNum = 1;
		}

		if (searchType == 3) {
			pageNum3 = pageNum;
		} else if (searchType == 2) {
			pageNum2 = pageNum;
		} else {
			pageNum1 = pageNum;
		}
		// System.out.println("searchType="+searchType+" pageNum="+pageNum+
		// 				" pageNum1="+pageNum1+" pageNum2="+pageNum2);

		String rowCondition = " WHERE row BETWEEN "
				+ ((pageNum - 1) * rowNum + 1) + " AND " + (pageNum * rowNum);
		// System.out.println(whereCondition+rowCondition);

		List<ClassListVO> list = classListSvc.searchClass(whereCondition + rowCondition);

		try {
			JsonArrayBuilder builder = Json.createArrayBuilder();
			JsonObject obj1 = Json.createObjectBuilder()
					.add("hasMoreData", true).build();
			builder.add(obj1);
			JsonObject obj2 = Json.createObjectBuilder()
					.add("sysTime", System.currentTimeMillis())
					.add("searchType", searchType).add("pageNum1", pageNum1)
					.add("pageNum2", pageNum2).add("pageNum3", pageNum3)
					.add("count", count).add("rowNum", rowNum)
					.add("totalPage", totalPage).build();
			builder.add(obj2);
			for (ClassListVO classListVO : list) {
				JsonObject obj = Json
						.createObjectBuilder()
						.add("classID",
								classListVO.getClassTypeVO().getClassID())
						.add("classNum", classListVO.getClassNum())
						.add("classStatus", classListVO.getClassStatus())
						.add("startDate", classListVO.getStartDate().toString())
						.add("endDate", classListVO.getEndDate().toString())
						.add("maxNum", classListVO.getMaxNum())
						.add("regNum", classListVO.getRegNum())
						.add("classSchedule", classListVO.getClassSchedule())
						.build();
				builder.add(obj);
			}
			out.write(builder.build().toString());
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	private void searchOne(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		String temp = request.getParameter("classID");
		ClassTypeService classTypeSvc = new ClassTypeService();
		ClassTypeVO classTypeVO = classTypeSvc.getOneClassType(temp);
		ClassListService classListSvc = new ClassListService();

		String classID;
		try {
			classID = classTypeVO.getClassID();
			int craftID = classTypeVO.getAircraftVO().getCraftID();
			int classNum = classListSvc.getClassNum(classID);
			int deptID = classListSvc.getOneClass(classID, classNum).getTrainDeptVO().getDeptID();

			AircraftService aircraftSvc = new AircraftService();
			TrainDeptService trainDeptSvc = new TrainDeptService();
			String deptName = trainDeptSvc.getOneTrainDept(deptID).getDeptName();
			
			
			JsonArrayBuilder builder = Json.createArrayBuilder();
			JsonObject obj1 = Json.createObjectBuilder()
					.add("hasMoreData", true).build();
			builder.add(obj1);
			JsonObject obj2 = Json
					.createObjectBuilder()
					.add("classID", classID)
					.add("className", classTypeVO.getClassName())
					.add("craftID", craftID)
					.add("classNum", classNum)
					.add("craftType", aircraftSvc.getOneAircraft(craftID).getCraftType())
					.add("deptID", deptID)
					.add("deptName", deptName)					
					.build();
			builder.add(obj2);
			out.write(builder.build().toString());
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	// 2014.08.01改這裡
		private void regPreview(HttpServletRequest request,
				HttpServletResponse response) {
			HttpSession session=request.getSession();
			ClassListService classListSvc = new ClassListService();
			String classID = request.getParameter("classID");
			Integer classNum = new Integer(request.getParameter("classNum").trim());
			ClassListVO classListVO = classListSvc.getOneClass(classID, classNum);
			// 把從jsp接到的字串用頓號分隔開來存成字串陣列
			String[] classSchedule = classListVO.getClassSchedule().split("、");
			// 存進request，給下一支取值
			session.setAttribute("classSchedule", classSchedule);
			// 設定weeks的內容準備比對
			String[] weeks = { "一", "二", "三", "四", "五", "六", "日" };
			// 存進requestt，給下一支取值
			session.setAttribute("weeks", weeks);
			session.setAttribute("classListVO", classListVO);
		}

		// 2014.08.01改這裡
		private void goUpdate(HttpServletRequest request,
				HttpServletResponse response) throws ServletException, IOException {
			HttpSession session=request.getSession();
			ClassListVO classListVO = (ClassListVO) session.getAttribute("classListVO");
			String url;
			Map<String, String> msg = new HashMap<>();

	//將JSP的資料接住並串成字串
			String classSchedule = "";
			try {
				for (String str : request.getParameterValues("classSchedule")) {
					if(str.trim()!="")
					classSchedule += ("、" + str);
					
				}
				classSchedule = classSchedule.substring(1);
			} catch (Exception e1) {
				classSchedule = "";
			}		
			
			if(classSchedule.length()==0 || classSchedule.trim()=="")
				msg.put("classSchedule", "請選擇上課日期");
	//將字串第一個頓號去掉
			
			
			Date startDate = null;
			Date endDate = null;
			Integer maxNum;
			try {
				startDate = Date.valueOf(request.getParameter("startDate"));

			} catch (Exception e) {
				msg.put("startDate", "開訓日期不得空白");
			}
			try {
				endDate = Date.valueOf(request.getParameter("endDate"));
			} catch (Exception e) {
				msg.put("endDate", "結訓日期不得空白");

			}
			if (startDate != null && endDate != null) {
				if (startDate.getTime() >= endDate.getTime()) {
					msg.put("lessDate", "開訓日期需小於結訓日期");
				}
			}
			if (classSchedule == null || classSchedule.trim().length() == 0) {
				msg.put("weeks", "請選擇日期");
			}

			try {
				maxNum = Integer.valueOf(request.getParameter("maxNum"));
			} catch (Exception e) {
				maxNum = 0;
				msg.put("notNum", "請輸入數字");
			}
			// 直接用VO去取
			if (maxNum < classListVO.getRegNum()) {
				msg.put("lessNum", "開課人數不得小於已報名人數");
			}

			if (!msg.isEmpty()) {
				request.setAttribute("msg", msg);
				url = "/WEB-INF/classlist/updateClass.jsp";
				request.getRequestDispatcher(url).forward(request, response);
				return;
			}
			// 有需要用到的才重新設定
			classListVO.setStartDate(startDate);
			classListVO.setEndDate(endDate);
			classListVO.setMaxNum(maxNum);
			classListVO.setClassSchedule(classSchedule);
			// checkbox的轉型，打鉤（not null）用request.getParameter("classStatus")取得當前參數
			// 沒打鉤（null）取得存入session的參數。之後沒用到要記得remove

			if (request.getParameter("classStatus") != null)
				classListVO.setClassStatus("暫停報名");
			else
				classListVO.setClassStatus("開放報名");
			// 包裝成classListVO傳送出去
			session.setAttribute("classListVO", classListVO);

			url = "/WEB-INF/classlist/classUpdatePreview.jsp";
			request.getRequestDispatcher(url).forward(request, response);
		}
	
	
	private void goAddClass(HttpServletRequest request,HttpServletResponse response){
//			System.out.println("goaddclass do nothing");
	}

	
	private void addPreview(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String url = "";
		String className = request.getParameter("className");
		String[] classSchedules = request.getParameterValues("classSchedule");
		String classSchedule = "";
		Map<String, String> msg = new HashMap<>();
		Date startDate = null;
		Date endDate = null;
		Integer maxNum = 0;
		try {
			startDate = Date.valueOf(request.getParameter("startDate"));

		} catch (Exception e) {
			msg.put("startDate", "開訓日期不得空白");
		}
		try {
			endDate = Date.valueOf(request.getParameter("endDate"));
		} catch (Exception e) {
			msg.put("endDate", "結訓日期不得空白");
		}

		if (className == null || className.trim().length() == 0) {
			msg.put("className", "請選擇班級");
		}
		if (startDate != null && endDate != null) {
			if (startDate.getTime() >= endDate.getTime()) {
				msg.put("lessDate", "開訓日期需小於結訓日期");
			}
		}
		try {
			maxNum = Integer.parseInt(request.getParameter("maxNum"));
		} catch (Exception e) {
			msg.put("notNum", "請輸入數字");
		}
		if (classSchedules == null) {
			msg.put("weeks", "請選擇日期");
		}
		if (!msg.isEmpty()) {
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("/WEB-INF/classlist/addClass.jsp")
					.forward(request, response);
			return;
		}
		for (String str : classSchedules) {
			classSchedule += ("、" + str);
		}
		classSchedule = classSchedule.substring(1);
		ManagerVO managerVO = new ManagerVO();
		@SuppressWarnings("unchecked")
		Map<String, String> map = (Map<String, String>) request.getSession().getAttribute("LoginOK");
		managerVO.setManagerID(Integer.valueOf(map.get("managerID")));
		managerVO.setManagerAccnt(map.get("managerAccnt"));
		request.setAttribute("classSchedule", classSchedule);
		request.setAttribute("managerVO", managerVO);
		url = "/WEB-INF/classlist/addClassPreview.jsp";
		request.getRequestDispatcher(url).forward(request, response);
	}
	

}
