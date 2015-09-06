package com.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 專門用來轉交的
 */
@WebServlet("/Referred")
public class Referred extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Referred() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
		if(action==null){
			response.setContentType("text/plain; charset=utf-8");
			PrintWriter out=response.getWriter();
			out.print("這是非法入侵");
			out.print("清重新來過");
			return;
		}
		if(action.equals("groupRegistration")){
			request.getRequestDispatcher("/WEB-INF/groupRegistration/groupRegistration.jsp").forward(request, response);;
			return ;
		}
		if(action.equals("modRecord")){
			request.getRequestDispatcher("/WEB-INF/modRecord/modRecord.jsp").forward(request, response);;
			return ;
		}
		if(action.equals("modPayStatus")){
			request.getRequestDispatcher("/WEB-INF/register/ModPayStatus.jsp").forward(request, response);;
			return ;
		}
		if(action.equals("customerServiceMobile")){
			request.getRequestDispatcher("/WEB-INF/mobile/customerServiceMobile.jsp").forward(request, response);;
			return ;
		}
		if(action.equals("air")){
			if(request.getSession().getAttribute("LoginOK")!=null)
				request.getSession().removeAttribute("LoginOK");
			request.getRequestDispatcher("/WEB-INF/index_air.jsp").forward(request, response);;
			return ;
		}
	}

}
