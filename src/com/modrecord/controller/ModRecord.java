package com.modrecord.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.modrecord.model.ModRecordVO;
import com.modrecord.model.ModRecord_service;

/**
 * Servlet implementation class ModRecord
 */
@WebServlet("/ModRecord")
public class ModRecord extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModRecord() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
		if("search".equals(action)){
			ModRecordVO modRecordVO=new ModRecordVO();
			String regID=request.getParameter("regID");
			String pilotID=request.getParameter("pilotID");
	
			try {
				if (regID != null && regID.length() != 0)
					modRecordVO.setRegID(Integer.valueOf(regID));
			} catch (NumberFormatException e) {
				request.setAttribute("errMSG", "請輸入數字");
				request.getRequestDispatcher("/WEB-INF//modRecord/modRecord.jsp").forward(request, response);
				return;
			}
			
			if(pilotID!=null&&pilotID.length()!=0)
				modRecordVO.setPilotID(pilotID);
			ModRecord_service srv=new ModRecord_service();
			List<ModRecordVO> list=srv.getByRecord(modRecordVO);
			
			if(list.size()==0)
				request.setAttribute("noFind", "查無資料");
			else
				request.setAttribute("modList", list);
			
			request.getRequestDispatcher("/WEB-INF//modRecord/modRecord.jsp").forward(request, response);
			return;
		}
	}

}
