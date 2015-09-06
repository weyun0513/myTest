package com.util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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


@WebServlet("/RegisterDataServlet")
public class RegisterDataServlet extends HttpServlet {
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
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Integer> list=null;
		
		
		try {
			long start=System.currentTimeMillis();
			conn=ds.getConnection();
			conn.setAutoCommit(false);
			pstmt=conn.prepareStatement("select * from air.classview where"
					+ " startdate <= current date +10 days order by startdate");
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				PreparedStatement pstmt_inner=null;
				ResultSet rs_inner=null;

				String classID=rs.getString("classID");
				String craftID=rs.getString("craftID");
				Date startDate=rs.getDate("startDate");
				int classNum=rs.getInt("classNum");
				int deptID=rs.getInt("deptID");
				int maxNum=rs.getInt("maxNum");	
				int count_pilot=0;
				int count_manager=0;
				int regNum=0;
				
				//隨機變動報名人數 -0~3
				if((int)(Math.random()*4)==0)
					regNum=maxNum-((int)(Math.random()*3+1));
				else
					regNum=maxNum;
				
				//得到crftid=?時的pilot人數
				pstmt_inner=conn.prepareStatement("SELECT COUNT(*) as count FROM air.pilot WHERE CRAFTID=?");
				pstmt_inner.setString(1, craftID);
				rs_inner=pstmt_inner.executeQuery();
				while(rs_inner.next()){
					count_pilot=rs_inner.getInt("count");
				}
				pstmt_inner.close();
				
				//得到deptid=?時的manager人數
				pstmt_inner=conn.prepareStatement("SELECT COUNT(*) as count FROM air.manager WHERE deptID=?");
				pstmt_inner.setInt(1, deptID);
				rs_inner=pstmt_inner.executeQuery();
				while(rs_inner.next()){
					count_manager=rs_inner.getInt("count");
				}
				pstmt_inner.close();
				
				
				list=new ArrayList<Integer>();
				for(int i=1;i<=regNum;i++){		
					//隨機得到一個pilot和manager
					int row_pilot=(int)(Math.random()*count_pilot+1);
					int row_manager=(int)(Math.random()*count_manager+1);
					
					//random get pilotID
					if(list.contains(row_pilot)){
						i--;
						continue;
					} else{
						String pilotID = null;
						list.add(row_pilot);
						pstmt_inner=conn.prepareStatement("select pilotID from (select pilotid ,ROW_NUMBER()over("
								+ "order by pilotid) as row from air.pilot where craftid=?) as temp where row=?");
						pstmt_inner.setString(1, craftID);
						pstmt_inner.setInt(2, row_pilot);
						rs_inner=pstmt_inner.executeQuery();
						while(rs_inner.next()){
							pilotID=rs_inner.getString("pilotID");
						}
						int managerID=0;
						pstmt_inner.close();
						
						
						//random get managerID 1/15
						if((int)(Math.random()*15)==0){
							pstmt_inner=conn.prepareStatement("select managerID from (select managerID ,ROW_NUMBER()over("
									+ "order by managerID) as row from air.manager where deptID=?) as temp where row=?");
							pstmt_inner.setInt(1, deptID);
							pstmt_inner.setInt(2, row_manager);
							rs_inner=pstmt_inner.executeQuery();
							while(rs_inner.next()){
								managerID=rs_inner.getInt("managerID");
							}
						} else{
							managerID=-100;
						}
						pstmt_inner.close();
						
						
						Date regDate=new Date(startDate.getTime()-((int)(Math.random()*14+3))*24*60*60*1000);
						String regIP="192.168."+((int)(Math.random()*256))+"."+((int)(Math.random()*256));
						Date checkPayDate=new Date(regDate.getTime()+((int)(Math.random()*9+2))*24*60*60*1000);
						
						int checkMangerID = 0;
						// get checkMangerID
						row_manager=(int)(Math.random()*count_manager+1);
						pstmt_inner=conn.prepareStatement("select managerID from (select managerID ,ROW_NUMBER()over("
								+ "order by managerID) as row from air.manager where deptID=?) as temp where row=?");
						pstmt_inner.setInt(1, deptID);
						pstmt_inner.setInt(2, row_manager);
						rs_inner=pstmt_inner.executeQuery();
						while(rs_inner.next()){
							checkMangerID=rs_inner.getInt("managerID");
						}
						pstmt_inner.close();
						
						
						pstmt_inner=conn.prepareStatement("insert into air.register(pilotID,classID,classNum,regDate,managerID,"
										+ "regIP,checkPayDate,checkManagerID,payStatus) values(?,?,?,?,?,?,?,?,'true')");
						pstmt_inner.setString(1, pilotID);
						pstmt_inner.setString(2, classID);
						pstmt_inner.setInt(3, classNum);
						pstmt_inner.setDate(4, regDate);
						pstmt_inner.setInt(5, managerID);
						pstmt_inner.setString(6, regIP);
						pstmt_inner.setDate(7, checkPayDate);
						pstmt_inner.setInt(8, checkMangerID);
						pstmt_inner.executeUpdate();	
						pstmt_inner.close();
						
						
						pstmt_inner=conn.prepareStatement("select regNum from air.classlist where"
										+ " classID=? and classNum=?");
						pstmt_inner.setString(1, classID);
						pstmt_inner.setInt(2, classNum);
						rs_inner=pstmt_inner.executeQuery();
						while(rs_inner.next()){
							pstmt_inner=conn.prepareStatement("update air.classlist set regNum=? "
										+ "where classID=? and classNum=?");
							pstmt_inner.setInt(1, rs_inner.getInt("regNum")+1);
							pstmt_inner.setString(2, classID);
							pstmt_inner.setInt(3, classNum);
							pstmt_inner.executeUpdate();
							pstmt_inner.close();
						}
						rs_inner.close();
					}				
				}
	
			}
			conn.commit();
			long time=System.currentTimeMillis()-start;
			System.out.println("RegisterData Add Successfully!! Runtime:"+time/1000+"s");
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally{
			if(pstmt!=null)
				try {
					pstmt.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			if(rs!=null)
				try {
					rs.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
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
