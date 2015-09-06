package com.util;



import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;


@WebServlet("/PilotDataServlet")
public class PilotDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	private static DataSource ds=null;
	private static Map<String,Integer> area=null;
	static {
		try {
			Context ctx=new InitialContext();
			ds= (DataSource) ctx.lookup("java:comp/env/jdbc/ProjectDB");
					
			area=new TreeMap<String,Integer>();
			area.put("A", 10); area.put("J", 18); area.put("S", 26); area.put("I", 34);
			area.put("B", 11); area.put("K", 19); area.put("T", 27); area.put("O", 35);
			area.put("C", 12); area.put("L", 20); area.put("U", 28);
			area.put("D", 13); area.put("M", 21); area.put("V", 29);
			area.put("E", 14); area.put("N", 22); area.put("X", 30);
			area.put("F", 15); area.put("P", 23); area.put("Y", 31);
			area.put("G", 16); area.put("Q", 24); area.put("W", 32);
			area.put("H", 17); area.put("R", 25); area.put("Z", 33);
			
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		String[] lastname={"林","李","張","劉","曾","沈","王","吳","陳","詹","許","楊","周","彭","尤",
				"吳","馬","徐","侯","朱","韓","游","毛","柳","袁","崔","任","郭","柯","邱"};
		String[] firstname={"釣竿","拉麵","麥克","鼻子","鬍子","大哥","罐頭","光頭","長毛","烏龜","咖啡","麵包",
				"椪柑","山雞","雪芙","大叔","德雞","牛丸","天線","咖啡","成功","丹丹","漢堡","香蕉",
				"銅鑼","堡王","當勞","城武","保羅","馬力","努比","香包","電車","德華","黑板","瑞凡",
				"志傑","仁甫","協志","邵偉","孟哲","嘟嘟","鉛筆","水壺","稻草","玉米","蘋果","柳丁",
				"靈芝","史蓋","通尼","白嵐","腿堡","皇上","小夫","胖虎","大雄","八方","金剛","蛋塔",
				"鐵頭","饅頭","大象","尾熊","猿猴","電燈","好帥","全家","種花","神燈","鬚張","榕樹",
				"波哥","年香","百品","肉羹","晶美","摩斯","福全","美樂","茅廬","不能","便當","滿足",
				"吉吉","木蘭","一休","田一","聞西","黑熊","金銀","肥雪","有為","來福","洋蔥","波爾",
				"傑克","山姆","菜包","檸檬","鳳梨","西瓜","甘蔗","剪刀","毛巾","蜜蜂","薯條","雞塊",};
		String[] phone={"0963","0971","0912","0952","0930","0933","0928","0915","0910","0911","0913",
							"0921","0916","0918","0919","0920","0922","0923","0924","0931","0933","0936",
							"0972","0973","0963","0961","0981","0982","0929","0937","0975","0988","0939"};


		
		Connection conn=null;
		PreparedStatement pstmt=null;
		List<String> list=new ArrayList<String>();
		

		try {		
			
			conn=ds.getConnection();
			conn.setAutoCommit(false);
			List<StringBuffer> idList=new ArrayList<StringBuffer>();
			
			//產生飛行員資料
			for(int i=0;i<6000;i++){				
				StringBuffer id=generateID();
				while(true){
					if(!idList.contains(id)){
						idList.add(id);
						break;
					}
				}
								
				String last=lastname[(int)(Math.random()*(lastname.length))];
				String pname=last+firstname[(int)(Math.random()*(firstname.length))];
				String uname=last+firstname[(int)(Math.random()*(firstname.length))];
				
				
				//產生電話號碼 
				StringBuffer pphone=new StringBuffer();
				StringBuffer uphone=new StringBuffer();
				pphone.append(phone[(int)(Math.random()*(phone.length))]);
				uphone.append(phone[(int)(Math.random()*(phone.length))]);
				for(int j=0;j<6;j++){
					pphone.append((int)(Math.random()*10));
					uphone.append((int)(Math.random()*10));
				}

				
				int craftID;
				String certifyID;
				while(true){
				craftID=((int)(Math.random()*6)+1)*10;
				//飛行員證號範圍
				certifyID="CID"+(int)((Math.random()*9000)+1000);			
					if(!list.contains(certifyID)){
						list.add(certifyID);
						break;
					}
				}
				
				//生日範圍
				int year=(int)(Math.random()*20)+1967;
				int month=(int)(Math.random()*12)+1;
				int day=(int)(Math.random()*28)+1;
				String birthday=year+"-"+month+"-"+day;

				
				//有效日期
				year=(int)(Math.random()*4)+2009;
				month=(int)(Math.random()*12)+1;
				day=(int)(Math.random()*28)+1;
				String lasttrain=year+"-"+month+"-"+day;
				day+=((int)(Math.random()*4)+1);
				String lastvalid=(year+2)+"-"+month+"-"+(day>28?28:day);
				day-=((int)(Math.random()*4)+1);
				String nextvalid=(year+5)+"-"+(month<8?8+((int)(Math.random()*2)):month)+"-"+(day<1?1:(day>28?28:day));
//				System.out.println("last"+lastvalid+" ,nextvalid="+nextvalid);
				pstmt=conn.prepareStatement("insert into air.Pilot values(?,?,?,?,?,?,'false','false',?,?,?,?,?)");
				pstmt.setString(1, id.toString());
				pstmt.setString(2, pname);
				pstmt.setString(3, birthday);
				pstmt.setString(4, pphone.toString());
				pstmt.setString(5,certifyID);
				pstmt.setInt(6, craftID);
				pstmt.setString(7, lasttrain);
				pstmt.setString(8, lastvalid);
				pstmt.setString(9, nextvalid);
				pstmt.setString(10, uname);
				pstmt.setString(11, uphone.toString());
				pstmt.executeUpdate();
				pstmt.close();
			}
			conn.commit();
			conn.setAutoCommit(true);
			System.out.println("PilotData Add Successfully!!");
		} catch (SQLException e) {
			try {
				System.out.println("PilotData Add Error...");
				conn.rollback();
				conn.setAutoCommit(true);
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally{
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
	
	

	private StringBuffer generateID(){
		StringBuffer id;
		while(true){
			id=null;
			id=new StringBuffer();
			id.append(String.valueOf((char)((int)(Math.random()*26+65)))
									+String.valueOf((int)(Math.random()*2+1)));
			for(int i=0;i<8;i++){
				id.append(String.valueOf((int)(Math.random()*10)));
			}
			if(check(id)){
				//System.out.println(id);
				break;
			}
		}
		return id;
	}

	private boolean check(StringBuffer id){
		int num;
		int checkCode=Integer.parseInt(id.substring(9));
		int areaNum=area.get(id.substring(0,1));
		num=areaNum/10+areaNum%10*9;
		for(int i=1;i<9;i++){
			num+=Integer.valueOf(id.substring(i,i+1))*(9-i);
		}
		if((10-num%10)==checkCode){
			return true;
		}else{
			return false;
		}
	}	

}
