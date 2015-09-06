package com.util;


import java.io.IOException;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.TimeZone;
import java.util.Timer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class ScheduleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Timer timer=null;
	Schedule schedule=null;
	
	@Override
	public void init(){
		timer=new Timer();
		schedule=new Schedule();
		Calendar rightNow = Calendar.getInstance(TimeZone.getTimeZone("GMT+8"),Locale.TAIWAN);
		int year=rightNow.get(Calendar.YEAR);
		int month=rightNow.get(Calendar.MONTH);
		int date=rightNow.get(Calendar.DATE);
		int hour=rightNow.get(Calendar.HOUR_OF_DAY);
		int minute=rightNow.get(Calendar.MINUTE);
//		int second=rightNow.get(Calendar.SECOND);
		System.out.print("Schedule Start..");
		System.out.println(year+"-"+(month+1)+"-"+date+" "+hour+":"+minute);
		GregorianCalendar gCalendar=new GregorianCalendar(year, month, date+1, hour, minute);
		gCalendar.setTimeZone(TimeZone.getTimeZone("GMT+8"));
//		System.out.println(gCalendar.getTime());
		getServletContext().setAttribute("scheduleInfo", "排程器啟動時間為每日 "+
									(hour>9?hour:"0"+hour)+":"+(minute>9?minute:"0"+minute));
		timer.scheduleAtFixedRate(schedule, gCalendar.getTime(), 24*60*60*1000);
	
	}
	
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException{
		doPost(request,response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException{

		HttpSession session = request.getSession();
		String action=request.getParameter("action");
		if("changeSchedule".equals(action)){
			int hour=0;
			int minute=0;
			
			try {
				hour = Integer.valueOf(request.getParameter("hour"));
				minute = Integer.valueOf(request.getParameter("minute"));
				if(hour<0 || hour>24 || minute<0 || minute>60){
					session.setAttribute("message", "請輸入正確時間！");		
					response.sendRedirect(request.getContextPath()+"/Schedule");
					return;
				}
				if(hour==24)
					hour=0;
				if(minute==60)
					minute=0;

			} catch (NumberFormatException e) {
				session.setAttribute("message", "請輸入正確時間！");
				response.sendRedirect(request.getContextPath()+"/Schedule");
				return;
			}

			timer.cancel();
			timer=new Timer();
			schedule=new Schedule();
			Calendar rightNow = Calendar.getInstance(TimeZone.getTimeZone("GMT+8"),Locale.TAIWAN);
			int year=rightNow.get(Calendar.YEAR);
			int month=rightNow.get(Calendar.MONTH);
			int date=rightNow.get(Calendar.DATE);
			
			System.out.print("Schedule Changed..");
			System.out.println(year+"-"+(month+1)+"-"+date+" "+hour+":"+minute);
			GregorianCalendar gCalendar=new GregorianCalendar(year, month, date, hour, minute);
			gCalendar.setTimeZone(TimeZone.getTimeZone("GMT+8"));
			timer.schedule(schedule, gCalendar.getTime(), 24*60*60*1000);
			request.getSession().setAttribute("message","排程器修改成功！"
					+ "<br>啟動時間為每日 "+(hour>9?hour:"0"+hour)+":"+(minute>9?minute:"0"+minute));
			request.getServletContext().setAttribute("scheduleInfo", "排程器啟動時間為每日 "+
									(hour>9?hour:"0"+hour)+":"+(minute>9?minute:"0"+minute));
			response.sendRedirect(request.getContextPath()+"/Schedule");
			return;
		}
			request.getRequestDispatcher("/WEB-INF/classlist/changeSchedule.jsp").forward(request, response);
			
	}

	@Override
	public void destroy(){
		timer.cancel();
		System.out.println("Schedule Over..");
	}

}
