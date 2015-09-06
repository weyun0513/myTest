package com.classlist.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.classlist.model.ClassListDAO;
import com.classlist.model.ClassListVO;

@WebServlet("/PilotQueryServlet")
public class PilotQueryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		HttpSession session = request.getSession();
		if(session.getAttribute("message")!=null) {
			System.out.println(session.getAttribute("message").toString());
		}
		String startDate;
		String month = request.getParameter("month");
		if(month == null) {
			month = "";
			session.setAttribute("monthAfter", session.getAttribute("monthAfter"));
		} else {
			session.setAttribute("monthAfter", month);
		}
		
		if (month == "") {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date date = new java.util.Date();
			startDate = sdf.format(date);
		} else {
			startDate = month + "-01" ;
		}
		
		ClassListDAO dao = new ClassListDAO();
		List<ClassListVO> list = dao.getByStartDate(Date.valueOf(startDate));
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("/WEB-INF/mobile/list_pilot.jsp").forward(request,response);
	}

}
