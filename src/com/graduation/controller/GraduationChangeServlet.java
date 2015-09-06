package com.graduation.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.register.model.RegisterDAO;
import com.register.model.RegisterVO;

@WebServlet("/GraduationChangeServlet")
public class GraduationChangeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		Integer regID = Integer.valueOf(request.getParameter("regID"));
//		System.out.println(regID);
		RegisterDAO dao=new RegisterDAO();
		RegisterVO registerVO = dao.findByPrimaryKey(regID);
		request.setAttribute("registerVO", registerVO);
		request.setAttribute("craftID", registerVO.getClassListVO().getClassTypeVO().getAircraftVO().getCraftID());
		String classID = registerVO.getClassListVO().getClassTypeVO().getClassID();
		String classNum = registerVO.getClassListVO().getClassNum().toString();
		String OldclassIDclassNum = classID+classNum;
		request.setAttribute("OldclassIDclassNum",OldclassIDclassNum);
		request.getRequestDispatcher("/WEB-INF/graduation/graduationChange.jsp").forward(request,response);
	}

}
