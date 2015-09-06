package com.classlist.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.classlist.model.ClassListService;
import com.classlist.model.ClassListVO;

@WebServlet("/MobileRegServlet")
public class MobileRegServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();		
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		
		if ("previewReg".equals(action)) {
		ClassListService classListSvc = new ClassListService();
		String classID = request.getParameter("classID");
		Integer classNum = new Integer(request.getParameter("classNum").trim());
		session.setAttribute("classID",classID);
		session.setAttribute("classNum",classNum);
		ClassListVO classListVO = classListSvc.getOneClass(classID,classNum);
		session.setAttribute("classListVO", classListVO);
		request.getRequestDispatcher("/WEB-INF/mobile/previewReg.jsp").forward(request, response);
		}
	}

}
