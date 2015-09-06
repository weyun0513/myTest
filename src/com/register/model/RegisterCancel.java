package com.register.model;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.classlist.model.ClassListDAO;
import com.classlist.model.ClassListVO;


@WebServlet("/register/cancelRegister.do")
public class RegisterCancel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
		Map<String,String> cancelMessage = new LinkedHashMap<String,String>();
		
		request.setAttribute("errorMsgs", errorMsgs);
		request.setAttribute("cancelMessage", cancelMessage);
		String tempregID =   request.getParameter("regID") ;
		int regID=RegisterVO.convertInt(tempregID );
		String classID =   request.getParameter("classID") ;
		
		String tempclassNum =   request.getParameter("classNum") ;
		int classNum=RegisterVO.convertInt(tempclassNum );
		
		
		RegisterService rs=new RegisterService();
		RegisterVO registerVO=new RegisterVO();
		registerVO=rs.findByPrimaryKey(regID);
		System.out.println(tempregID+","+classID+","+tempclassNum);
		System.out.println(registerVO.getRegStatus().toString());
		
		
		if(Boolean.valueOf(registerVO.getPayStatus())){
			 errorMsgs.put("payStatus","此飛行員已完成繳費不得取消");
			 System.out.println("此飛行員已完成繳費不得取消");
			}
		if("取消報名".equals(registerVO.getRegStatus().toString())){
			 errorMsgs.put("regStatus","此飛行員已經取消過報名");
			 System.out.println("此飛行員紀錄已為取消報名 取消失敗");
			}
		
		ClassListDAO classListDao=new ClassListDAO();
		ClassListVO classListVO= classListDao.findByPrimayKey(registerVO.getClassListVO().getClassTypeVO().getClassID(), registerVO.getClassListVO().getClassNum());
		if(classListVO.getRegNum()==0){
			errorMsgs.put("regNum","報名人數請確認");}
	
		String action = request.getParameter("action");
		System.out.println(action);
		if(action.equals("reg")) {
			if( errorMsgs!=null && ! errorMsgs.isEmpty()) {
				RegisterDAO dao=new RegisterDAO();
				List<RegisterVO> list = dao.getByPilotID(request.getSession().getAttribute("pilotID").toString());
				request.setAttribute("registerList", list);
				request.getRequestDispatcher("/WEB-INF/register/register_info.jsp").forward(request,response);
				return;
			}
		} else {		
			if( errorMsgs!=null && ! errorMsgs.isEmpty()) {
				Set<RegisterVO> result=new LinkedHashSet<RegisterVO>();
				result=rs.getRegisterByClass(classID, classNum);	
				request.setAttribute("RegisterList", result);
				request.getRequestDispatcher(
						"/WEB-INF/register/RegisterList.jsp").forward(request, response);
				return;
			}
		}
		registerVO.setRegStatus("取消報名");
	
		int currentRegNum= classListVO.getRegNum();
		currentRegNum=currentRegNum-1;
		classListVO.setRegNum(currentRegNum);
		System.out.println(currentRegNum);
		rs.cancelRegister(registerVO, classListVO);
		cancelMessage.put("cancelMessage", "成功將此飛行員取消報名");
		
		if(action.equals("reg")) { 
			RegisterDAO dao=new RegisterDAO();
			List<RegisterVO> list = dao.getByPilotID(request.getSession().getAttribute("pilotID").toString());
			request.setAttribute("registerList", list);
			request.getRequestDispatcher("/WEB-INF/register/register_info.jsp").forward(request,response);
		} else {
			Set<RegisterVO> result=new LinkedHashSet<RegisterVO>();
			result=rs.getRegisterByClass(classID, classNum);
			request.setAttribute("RegisterList", result);
			request.getRequestDispatcher(
					"/WEB-INF/register/RegisterList.jsp").forward(request, response);
		}
	}

}
