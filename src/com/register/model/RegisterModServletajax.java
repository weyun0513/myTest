package com.register.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

@WebServlet
(
		urlPatterns={"/register/change.view"}
)
public class RegisterModServletajax extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter printwout = response.getWriter();

		String tempregID =   request.getParameter("regID") ;
		int regID=RegisterVO.convertInt(tempregID );

      
              if (tempregID== null||tempregID.trim().length()==0 ){
          	        JSONObject  obj = new JSONObject();
      				JSONArray jsonarray=new JSONArray();
      				try {
						obj.put("text", "請輸入報名流水號");
      				obj.put("hasMoreData", false);
    			    jsonarray.put(obj);
              printwout.write(jsonarray.toString());
              return;
              
              
              } catch (JSONException e) {		
						e.printStackTrace();
					} 
             finally{
            	 printwout.close();}           
             }
           
			RegisterService rs=new RegisterService();
			RegisterVO registerVO=new RegisterVO();
			registerVO=rs.findByPrimaryKey(regID);
			
			JSONObject  obj = new JSONObject();
	      	 JSONArray jsonarray=new JSONArray();
			try {
				if(registerVO==null ){	 
					
	      			obj.put("text", "此流水號不存在");
				    obj.put("hasMoreData", false);}
				else
					
					{obj.put("text", "流水號存在");
				   obj.put("hasMoreData", true);}
				  jsonarray.put(obj);
	              printwout.write(jsonarray.toString());
	              return;
	             
			} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				
			 finally{
            	 printwout.close();}           
              
				
		}
				
	}


