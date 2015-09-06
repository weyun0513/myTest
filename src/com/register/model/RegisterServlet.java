package com.register.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
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
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.manager.model.ManagerVO;
import com.modrecord.model.ModRecordVO;
import com.util.PageInfoUtil;

public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain; charset=UTF-8");
		//System.out.println(request.getParameterMap());
		String action = request.getParameter("action");
		
		Map<String, String> errorMsgs = new HashMap<String, String>();
		request.setAttribute("errorMsgs", errorMsgs);
		// =============================================
		if (action.equals("select")) {
//			 Map<String,String> ModMessage=new LinkedHashMap<String,String> ();
		
			String tempregID =   request.getParameter("regID") ;
			if (tempregID == null || tempregID.trim().length() == 0) {
				errorMsgs.put("regID", "請輸入報名流水號");
			}
			if (errorMsgs != null && !errorMsgs.isEmpty()) {
				request.getRequestDispatcher("/WEB-INF/register/ModPayStatus.jsp").forward(
						request, response);
				return;
			}
		
			int regID=RegisterVO.convertInt(tempregID );
			RegisterService rs=new RegisterService();
			RegisterVO registerVO=new RegisterVO();
			registerVO=rs.findByPrimaryKey(regID);
				if(registerVO==null )	{ 
					errorMsgs.put("regID", "此流水號不存在");
		      			request.getRequestDispatcher(
		      					"/WEB-INF/register/ModPayStatus.jsp").forward(request, response);
		      			return;
		      		}  
				
				
//				if(Boolean.valueOf(registerVO.getPayStatus())){
//					ModMessage.put("payStatus","此次報名已繳費 不得更改 如要更改請變更訓練期別");}
//			   request.setAttribute("ModMessage", ModMessage);
				request.setAttribute("registerVO", registerVO);

				request.getRequestDispatcher(
     					"/WEB-INF/register/ModPayStatusresult.jsp").forward(request, response);
					}
		
		// ============================================

		
		if (action.equals("checkPay")) {
			 Map<String,String> ModMessage=new LinkedHashMap<String,String> ();
			String tempregID = request.getParameter("regID");
			int regID = RegisterVO.convertInt(tempregID);
			Date checkPayDate = new Date(System.currentTimeMillis());
			@SuppressWarnings("unchecked")
			String managerID = ((Map<String, String>) request.getSession()
					.getAttribute("LoginOK")).get("managerID");

			RegisterService rs2 = new RegisterService();
			RegisterVO registerVO2 = rs2.findByPrimaryKey(regID);
			ManagerVO managerVO = new ManagerVO();
			managerVO.setManagerID(Integer.parseInt(managerID));
			registerVO2.setManagerVO2(managerVO);

			registerVO2.setCheckPayDate(checkPayDate);
//			System.out.println(checkPayDate);
			registerVO2.setPayStatus("true");
			// ----------------------------稽核wayne修改------------------------------------------------------
			ModRecordVO modRecordVO = new ModRecordVO();
			modRecordVO.setRegID(regID);
			modRecordVO.setPilotID(request.getParameter("pilotID"));
			ManagerVO managerVO2 = new ManagerVO();
			managerVO2.setManagerID(Integer.valueOf(managerID));
			modRecordVO.setManagerVO(managerVO2);
			modRecordVO.setModDate(new Timestamp(System.currentTimeMillis()));
			modRecordVO.setModFunction("變更繳費");
			modRecordVO.setModIP(request.getRemoteAddr());
			modRecordVO.setModURL(request.getServletPath().toString()
					.replace("_", "-"));
//			System.out.println(modRecordVO.getPilotID()+modRecordVO.getRegID() + modRecordVO.getModURL()
//					+ new Timestamp(System.currentTimeMillis()));
			rs2.update(registerVO2, modRecordVO);
			// ----------------------------稽核wayne修改------------------------------------------------------
			ModMessage.put("payStatus","此次報名確認繳費");
		   request.setAttribute("ModMessage", ModMessage);
			request.setAttribute("registerVO", registerVO2);
			request.getRequestDispatcher("/WEB-INF/register/ModPayStatusresult.jsp").forward(request, response);
		}
		// ----------------------------更正為未繳費狀態-----------------------------------------
		if (action.equals("cancelPayStatus")) {
			 Map<String,String> ModMessage=new LinkedHashMap<String,String> ();
			String tempregID = request.getParameter("regID");
			int regID = RegisterVO.convertInt(tempregID);
			Date checkPayDate = new Date(System.currentTimeMillis());
			@SuppressWarnings("unchecked")
			String managerID = ((Map<String, String>) request.getSession()
					.getAttribute("LoginOK")).get("managerID");
//利用流水號查到報名者
			RegisterService rs2 = new RegisterService();
			RegisterVO registerVO2 = rs2.findByPrimaryKey(regID);
			//修改者要記錄帳號查到報名者			
			ManagerVO managerVO = new ManagerVO();
			managerVO.setManagerID(Integer.parseInt(managerID));
			registerVO2.setManagerVO2(managerVO);

			registerVO2.setCheckPayDate(checkPayDate);
			registerVO2.setPayStatus("false");
			// ----------------------------稽核wayne修改------------------------------------------------------
			ModRecordVO modRecordVO = new ModRecordVO();
			modRecordVO.setRegID(regID);
			modRecordVO.setPilotID(request.getParameter("pilotID"));
			ManagerVO managerVO2 = new ManagerVO();
			managerVO2.setManagerID(Integer.valueOf(managerID));
			modRecordVO.setManagerVO(managerVO2);
			modRecordVO.setModDate(new Timestamp(System.currentTimeMillis()));
			modRecordVO.setModFunction("變更繳費為未繳費");
			modRecordVO.setModIP(request.getRemoteAddr());
			modRecordVO.setModURL(request.getServletPath().toString()
					.replace("_", "-"));

			rs2.update(registerVO2, modRecordVO);
			// ----------------------------稽核wayne修改------------------------------------------------------
			ModMessage.put("payStatus","此次報名更正為未繳費");
		   request.setAttribute("ModMessage", ModMessage);
			request.setAttribute("registerVO", registerVO2);
			request.getRequestDispatcher("/WEB-INF/register/ModPayStatusresult.jsp").forward(request, response);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		// =============================================
		if (action.equals("viewRegister")) {
			PageInfoUtil.setPageInfo(request, response);

			String classID = request.getParameter("classID");
			String tempclassNum = request.getParameter("classNum");
			int classNum = Integer.parseInt(tempclassNum);

			RegisterService rs3 = new RegisterService();
			Set<RegisterVO> result = new LinkedHashSet<RegisterVO>();
			result = rs3.getRegisterByClass(classID, classNum);
			request.getSession().setAttribute("classID", classID);
			request.getSession().setAttribute("classNum",classNum);
			request.setAttribute("RegisterList", result);
			request.getRequestDispatcher("/WEB-INF/register/RegisterList.jsp")
					.forward(request, response);
		}
		// ===============================================
		if (action.equals("deleteReg")) {
			String tempregID = request.getParameter("regID");
			int regID = RegisterVO.convertInt(tempregID);
//			String regID1 = request.getParameter("regID");

			RegisterService rs = new RegisterService();
			RegisterVO registerVO = new RegisterVO();
			registerVO = rs.findByPrimaryKey(regID);
			if (registerVO == null) {

				request.getRequestDispatcher(
						"/WEB-INF/register/ModPayStatus.jsp").forward(request,
						response);
				return;
			} else if (registerVO != null) {
				request.setAttribute("registerVO", registerVO);
				request.getRequestDispatcher(
						"/WEB-INF/register/ModPayStatusresult.jsp").forward(
						request, response);
			}
		}
	}
}
