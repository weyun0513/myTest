package com.classlist.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aircraft.model.AircraftVO;
import com.classlist.model.ClassListDAO;
import com.classlist.model.ClassListService;
import com.classlist.model.ClassListVO;
import com.classtype.model.ClassTypeVO;
import com.manager.model.ManagerVO;
import com.modrecord.model.ModRecordVO;
import com.pilot.model.PilotService;
import com.pilot.model.PilotVO;
import com.register.model.RegisterService;
import com.register.model.RegisterVO;
import com.traindept.model.TrainDeptVO;
import com.util.PageInfoUtil;

public class ClassUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	ClassListService classListSvc;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
//		System.err.println("Session Id Change ClassUpdateServlet: "+request.getSession().getId());	
		request.setCharacterEncoding("UTF-8");
		request.getSession().removeAttribute("message");
		String action = request.getParameter("action");	
			
		
		if ("addClass".equals(action)) {
			addClass(request,response);
			return;
		} else if ("updateClass".equals(action)) {
			updateClass(request,response);
		} else if ("deleteClass".equals(action)) {
			deleteClass(request,response);
		} else if ("addReg".equals(action) || "addReg2".equals(action)) {
			addReg(request,response);
			return;
		} else if("goReg2".equals(action)){
			goReg2(request,response);
			return;
		}
		
		String url = request.getContextPath() + "/classlist/ClassView";
		response.sendRedirect(url);	
	}
	
	
	
	private void addClass(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException{	

		HttpSession session=request.getSession();
		String className = request.getParameter("className");
		String[] classSchedules = request.getParameterValues("classSchedule");
//		System.out.println(classSchedules);
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
		if(classSchedules==null){
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
		// 將取得到的資料存入VO。ClassTypeVO、TrainDeptVO、ManagerVO因參考到別支VO需額外設定
		ClassTypeVO classTypeVO = new ClassTypeVO();
		ClassListVO classListVO = new ClassListVO();
		AircraftVO aircraftVO = new AircraftVO();
		TrainDeptVO trainDeptVO = new TrainDeptVO();
		ManagerVO managerVO = new ManagerVO();
		classTypeVO.setClassID(request.getParameter("classID"));
		classTypeVO.setClassName(className);
		aircraftVO.setCraftID(Integer.parseInt(request.getParameter("craftID")));
		aircraftVO.setCraftType(request.getParameter("craftType"));
		classTypeVO.setAircraftVO(aircraftVO);
		classListVO.setClassTypeVO(classTypeVO);
		classListVO.setClassNum(Integer.parseInt(request
				.getParameter("classNum")));
		classListVO.setStartDate(startDate);
		classListVO.setEndDate(endDate);
		trainDeptVO.setDeptID(Integer.parseInt(request.getParameter("deptID")));
		trainDeptVO.setDeptName(request.getParameter("deptName"));
		classListVO.setTrainDeptVO(trainDeptVO);

		@SuppressWarnings("unchecked")
		Map<String, String> map = (Map<String, String>) session.getAttribute("LoginOK");
		managerVO.setManagerID(Integer.valueOf(map.get("managerID")));
		// managerVO.setManagerID(1);
		classListVO.setManagerVO(managerVO);
		classListVO.setMaxNum(maxNum);
		classListVO.setClassSchedule(classSchedule);
		ClassListDAO classListDAO = new ClassListDAO();
		classListDAO.insert(classListVO);
		session.setAttribute("message", "新增班級成功");
		String url = request.getContextPath() + "/classlist/ClassView";
		response.sendRedirect(url);

	}

	
	
	private void updateClass(HttpServletRequest request,HttpServletResponse response) throws IOException{	
		
		HttpSession session=request.getSession();
		session.removeAttribute("classSchedule");
		session.removeAttribute("weeks");
		session.removeAttribute("classListVO");
		ClassListVO classListVO = (ClassListVO) request.getAttribute("classListVO");
		classListSvc = new ClassListService();
		String classStatus = request.getParameter("classStatus");
		Date startDate = Date.valueOf(request.getParameter("startDate"));
		Date endDate = Date.valueOf(request.getParameter("endDate"));
		Integer maxNum = Integer.parseInt(request.getParameter("maxNum"));
		String classSchedule = request.getParameter("classSchedule");
		String classID = request.getParameter("classID");
		Integer classNum = Integer.parseInt(request.getParameter("classNum"));
		
		synchronized (this) {
			classListVO = (this).classListSvc.getOneClass(classID, classNum);
			Integer deptID=classListVO.getTrainDeptVO().getDeptID();
			
	
			(this).classListSvc.updateClass(classID, classNum, classStatus,
						startDate, endDate, maxNum, deptID, classSchedule);
			session.setAttribute("message", "修改成功！");		
		}
		
	}

	
	
	private void deleteClass(HttpServletRequest request,HttpServletResponse response) throws IOException{	
		PageInfoUtil.setPageInfo(request,response);
		classListSvc = new ClassListService();
		String classID = request.getParameter("classID");
		Integer classNum = Integer.parseInt(request.getParameter("classNum"));

		synchronized (this) {
			(this).classListSvc.deleteClass(classID, classNum);
		}
	}

	
	
	private void addReg(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException{	
//		java.util.Map<String, String[]> map=request.getParameterMap();
//		for(String str:map.keySet()){
//			String [] strs=map.get(str);
//			System.out.println(strs[0]);
//		}
//		
		String action = request.getParameter("action");
		String pilotID=request.getParameter("pilotID");
		String birthday=request.getParameter("birthday");
		String checkCode=request.getParameter("checkCode");
		String classID = request.getParameter("classID");
		Integer classNum = new Integer(request.getParameter("classNum").trim());
		
		Map<String, String> msg = new HashMap<>();
		request.setAttribute("msg", msg);
		if(pilotID==null||pilotID.trim().length()==0
			||(birthday==null||birthday.trim().length()==0)	
			||(checkCode==null||checkCode.trim().length()==0)
			){
			if("addReg".equals(action)) {
			msg.put("message1", "請輸入資料");
			request.getRequestDispatcher("/WEB-INF/classlist/addReg.jsp").forward(request, response);
			return;
			} else {
				msg.put("message1", "請輸入資料");
				request.getRequestDispatcher("/WEB-INF/mobile/previewReg.jsp").forward(request, response);
				return;
			}
		}
		
		HttpSession session=request.getSession();
		//--------驗證-------------
//		System.out.println(checkCode+"  "+((String)(session.getAttribute("check_code"))));
		String check_code=(String)(session.getAttribute("check_code"));
		if(checkCode.equals(check_code)){
			PilotService serv=new PilotService();
			PilotVO pilotVO=serv.findbyID(pilotID);
			if(pilotVO==null){
				msg.put("message1", "查無此人");
			}else if(pilotVO.getBirthday().toString().equals(birthday)){
				ClassListVO classListVO=(ClassListVO)session.getAttribute("classListVO");
				if((int)pilotVO.getAircraftVO().getCraftID()!=(int)classListVO.getClassTypeVO().getAircraftVO().getCraftID()){
					msg.put("message1", "飛行員機種不同");
				}else if(new RegisterService().getByDoubleReg(pilotVO, classID, classNum)!=null){
					msg.put("message1", "已報名");
				}else if(Boolean.valueOf(pilotVO.getCertificateExpired())|| Boolean.valueOf(pilotVO.getProhibit())){
					msg.put("message1", "停飛狀態");
				}//else就合格了
				classListVO=null;
				}else{
					msg.put("message2", "生日錯誤");
			}
		}else{
			msg.put("message3", "驗證碼錯誤");
		}
		if(!msg.isEmpty()){
			if("addReg".equals(action)) {
			request.getRequestDispatcher("/WEB-INF/classlist/addReg.jsp").forward(request, response);
			return;
			} else {
				request.getRequestDispatcher("/WEB-INF/mobile/previewReg.jsp").forward(request, response);
				return;
			}
		}
		//------永續存取----------
		ClassListVO classListVO = null;
		classListSvc = new ClassListService();
		
		RegisterVO registerVO=new RegisterVO();
		PilotVO pilotVO=new PilotVO();
		pilotVO.setPilotID(pilotID);
		registerVO.setPilotVO(pilotVO);
		classListVO=new ClassListVO();
		ClassTypeVO classTypeVO=new ClassTypeVO();
		classTypeVO.setClassID(classID);
		classListVO.setClassTypeVO(classTypeVO);
		classListVO.setClassNum(classNum);
		
		@SuppressWarnings("unchecked")
		Map<String, String> map = ((Map<String, String>) session
				.getAttribute("LoginOK"));
		String managerID="";
		if(map==null)
			managerID="-100";
		else 
			managerID=map.get("managerID");
		ManagerVO managerVO =new ManagerVO();
		managerVO.setManagerID(Integer.valueOf(managerID));
		registerVO.setManagerVO(managerVO);
		registerVO.setRegIP(request.getRemoteAddr());
		registerVO.setRegStatus("報名");
		Timestamp time=new Timestamp(System.currentTimeMillis());
		registerVO.setRegDate(time);
		
	//--------稽核紀錄-----------------------
		ModRecordVO modRecordVO = new ModRecordVO();
		//regID新增後才取得
		modRecordVO.setPilotID(request.getParameter("pilotID"));
		ManagerVO managerVO2 = new ManagerVO();
		managerVO2.setManagerID(Integer.valueOf(managerID));
		modRecordVO.setManagerVO(managerVO2);
		modRecordVO.setModDate(time);
		modRecordVO.setModFunction("報名");
		modRecordVO.setModIP(request.getRemoteAddr());
		modRecordVO.setModURL(request.getServletPath().toString()
				.replace("_", "-"));
	//--------稽核紀錄-----------------------
		synchronized (this) {
			classListVO = (this).classListSvc.getOneClass(classID, classNum);
			int number=classListVO.getRegNum();
			classListVO.setRegNum(number);
			registerVO.setClassListVO(classListVO);
			if (number >= classListVO.getMaxNum()) {
				session.setAttribute("message", "報名失敗！<br>請重新確認開課與報名人數。");
			} else {
				//System.out.println("1");
				registerVO=classListSvc.addOneReg(registerVO,modRecordVO);
				
				if(registerVO==null)
					session.setAttribute("message", "報名失敗！<br>原因不明。");
				else{
					RegisterService dao=new RegisterService();
					RegisterVO registerVO2= dao.getReg(pilotID, classID, classNum);
					session.setAttribute("message", "報名成功！");
					request.setAttribute("registerVO", registerVO2);
					if("addReg".equals(action)) {
					request.getRequestDispatcher("/WEB-INF/classlist/addRegSuccess.jsp").forward(request, response);
					return;
					} else {
						request.getRequestDispatcher("/WEB-INF/mobile/successReg.jsp").forward(request, response);
						return;
					}
				}
					
			}
			if("addReg".equals(action)) {
			String url = request.getContextPath() + "/classlist/ClassView";
			response.sendRedirect(url);
			} else {
				request.getRequestDispatcher("/WEB-INF/mobile/failReg.jsp").forward(request, response);
				return;
			}
		}	
	}
	
	
	private void goReg2(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException{
		String pilotID=request.getParameter("pilotID");
		String classID=request.getParameter("classID");
		String classNum=request.getParameter("classNum");
		String classID_classNum=request.getParameter("classID_classNum");
		Timestamp time=new Timestamp(System.currentTimeMillis());
	//--------稽核紀錄-----------------------
		@SuppressWarnings("unchecked")
		Map<String, String> map = ((Map<String, String>) request.getSession()
				.getAttribute("LoginOK"));
		String managerID="";
		if(map==null)
			managerID="-100";
		else 
			managerID=map.get("managerID");
		ModRecordVO modRecordVO=new ModRecordVO();
		modRecordVO.setPilotID(request.getParameter("pilotID"));
		ManagerVO managerVO2 = new ManagerVO();
		managerVO2.setManagerID(Integer.valueOf(managerID));
		modRecordVO.setManagerVO(managerVO2);
		modRecordVO.setModDate(time);
		modRecordVO.setModFunction("變更訓練期別");
		modRecordVO.setModIP(request.getRemoteAddr());
		modRecordVO.setModURL(request.getServletPath().toString()
				.replace("_", "-"));
	//--------稽核紀錄-----------------------
		RegisterService serv=new RegisterService();
		RegisterVO registerVO= serv.changeClassID(pilotID,classID,classNum,classID_classNum, modRecordVO);
		request.getSession().setAttribute("message", "變更成功！");
		request.setAttribute("registerVO", registerVO);
		request.getRequestDispatcher("/WEB-INF/classlist/addRegSuccess.jsp").forward(request, response);
		return;
	}
	

}
