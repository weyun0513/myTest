package com.util;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;


@WebServlet("/ClassListDataServlet")
public class ClassListDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private  static DataSource ds=null;
	
	static{
		try {
			Context ctx=new InitialContext();
			ds= (DataSource) ctx.lookup("java:comp/env/jdbc/ProjectDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String[] classID={"CECJ","EEIT","JSJQ","JSNH","MSIT","MSIQ",
								"PROL","PROK","SMQL","SMCS","WBUY","WBUI"};
		String[] schedule={"一","二","三","四","五","六","日"};

		Connection conn=null;
		PreparedStatement pstmt=null;
		
		ResultSet rs=null;	
		try {
			conn=ds.getConnection();
			conn.setAutoCommit(false);
			
			for(int i=0;i<2000;i++){
				String cID=classID[(int)(Math.random()*12)];
				//System.out.println(cID);
				String classNum=null;
				String start=null;
				int year;
				int month;
				int day;
				
				//取得最後一筆班級期別和開始日期
				pstmt=conn.prepareStatement("select classNum,startDate from air.classlist"
						+ " where classid=? order by classNum desc fetch FIRST 1 rows only");
				pstmt.setString(1,cID);
				rs=pstmt.executeQuery();
				while(rs.next()){
							classNum=rs.getString("classNum");
							start=rs.getString("startDate");
				}
				pstmt.close();
				
				//開始日期初始設定
				if(classNum==null){
					classNum="0";
					year=2008;	
					month=(int)(Math.random()*6)+1;
					day=(int)(Math.random()*((month==2)?28:30))+1;		
				}
				else{
					String[] tempdate=start.split("-");
					year=Integer.parseInt(tempdate[0]);
					month=Integer.parseInt(tempdate[1]);
					day=Integer.parseInt(tempdate[2])+((int)(Math.random()*10)+10);
					if(day>((month==2)?28:30)){
						day-=((month==2)?28:30);
						month++;
						if(month>12){
							month=1;
							year++;
						}
					}				
				}
				int classNo=Integer.parseInt(classNum)+1;
				int c_day=(day-((int)(Math.random()*5)+1));
				String create=year+"-"+month+"-"+(c_day<1?1:c_day);
				start=year+"-"+month+"-"+day;
				//System.out.println(start);
				if(month==12){
					month=0;
					year+=1;
				}
				if(month==1 && day>28)
					day=28;
				String end=year+"-"+(month+1)+"-"+day;
				int deptID=((int)(Math.random()*3)+1)*10;
				int creator=((int)(Math.random()*3)+1);
				List<Integer> list=new ArrayList<Integer>();
				int count=(int)(Math.random()*3)+2;
				
				for(int j=1;j<=count;j++){
				int temp=(int)(Math.random()*7);
				if(!list.contains(temp)){
					list.add(temp);
				} else
					j--;
				}
				
				Collections.sort(list);
				StringBuffer strbuff=new StringBuffer();
				
				for(Integer xx:list){
					strbuff.append(schedule[xx]+"、");
				}
				String scheduled=strbuff.substring(0,strbuff.length()-1);
				//System.out.println(scheduled);
				
				
				pstmt=conn.prepareStatement("insert into air.ClassList(classID,classNum,startDate,"
						+"endDate,maxNum,deptID,managerID,classSchedule,createDate) values(?,?,?,?,30,?,?,?,?)");
				pstmt.setString(1, cID);
				pstmt.setInt(2, classNo);
				pstmt.setString(3, start);
				pstmt.setString(4, end);
				pstmt.setInt(5, deptID);
				pstmt.setInt(6, creator);
				pstmt.setString(7, scheduled);
				pstmt.setString(8,create);
				pstmt.executeUpdate();
				pstmt.close();
			}	
			conn.commit();
			conn.setAutoCommit(true);
			System.out.println("ClassListData Add Successfully!!");
			
		} catch (SQLException e) {
			try {
				conn.rollback();
				conn.setAutoCommit(true);
				System.out.println("lassListData Add Error...");
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally{
			if(rs!=null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(pstmt!=null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}	
		}
					
	}

}
