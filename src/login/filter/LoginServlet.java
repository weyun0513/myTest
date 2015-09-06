package login.filter;


import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.manager.model.ManagerVO;
import com.manager.model.ManagerDAO;
import com.manager.model.Manager_Service;

@WebServlet(urlPatterns = { "/LoginServlet" })
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}
	
	protected void doGet(HttpServletRequest request
			,HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request,response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
//		String path=request.getServletPath().toString();
		HttpSession session = request.getSession();
		String path="/index.jsp?isError=yes";
	//	System.out.println(path);
		if(action!=null&&action.equals("logout")){
			session.removeAttribute("LoginOK");
			request.getRequestDispatcher("/index.jsp")
			   .forward(request, response);
		return;
		}
		System.out.println(path);
		// 接收資料
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		//String path = request.getContextPath();
		Map<String,String> errorMSG=new HashMap<>();
		request.setAttribute("errorMSG", errorMSG);
		// 驗證資料
		if (username == null || username.trim().length() == 0) {
			errorMSG.put("username", "請輸入帳號");
		}
		if (password == null || password.trim().length() == 0) {
			errorMSG.put("password", "請輸入密碼");
		}

		if (!errorMSG.isEmpty()) {
			request.getRequestDispatcher(path)
				   .forward(request, response);
			return;
		}	
		Manager_Service dao = new Manager_Service();	
		ManagerVO managerVO = dao.getByAccnt(username);
		if (managerVO != null) {	
			String PWDDatabase=new String(managerVO.getManagerPWD());
			if (!(password.equals(PWDDatabase))) {
				errorMSG.put("password", "密碼錯誤");	
			} else {
				// 登入成功
				// 放入帳號使用者資訊之後還會再加
				Map<String, String> map = new LinkedHashMap<>();
				map.put("username", username);
				map.put("trainDept", managerVO.getTrainDeptVO().getDeptName());
				map.put("managerID", managerVO.getManagerID().toString());
				map.put("managerAccnt", managerVO.getManagerAccnt());
				session.setAttribute("LoginOK", map);
				//有勾加入cookie 沒勾刪除
				Cookie cookieUser = null;
				Cookie cookiePassword = null;
				Cookie cookieRememberMe = null;
				if(request.getParameter("remember")!=null){	
						cookieUser = new Cookie("username", username);
						cookieUser.setMaxAge(30*24*60*60);
						cookieUser.setPath(request.getContextPath());
//						String encodePassword = Base64.encode(password.getBytes());
						cookiePassword = new Cookie("password", password);
						cookiePassword.setMaxAge(30*24*60*60);
						cookiePassword.setPath(request.getContextPath());
						cookieRememberMe = new Cookie("remember", "true");
						cookieRememberMe.setMaxAge(30*24*60*60);
						cookieRememberMe.setPath(request.getContextPath());
					} else {
						cookieUser = new Cookie("username", username);
						cookieUser.setMaxAge(0);
						cookieUser.setPath(request.getContextPath());
						//cookiePassword = new Cookie("password", password);
//						String encodePassword = Base64.encode(password.getBytes());
						cookiePassword = new Cookie("password", password);
						cookiePassword.setMaxAge(0);
						cookiePassword.setPath(request.getContextPath());
						cookieRememberMe = new Cookie("remember", "false");
						cookieRememberMe.setMaxAge(0);
						cookieRememberMe.setPath(request.getContextPath());
					}
					response.addCookie(cookieUser);
					response.addCookie(cookiePassword);
					response.addCookie(cookieRememberMe);
					
					
					request.getRequestDispatcher("/WEB-INF/index_manager.jsp")
					   .forward(request, response);
					return;
				
			}
		}else{
			errorMSG.put("username", "帳號錯誤");
		}
		if(!errorMSG.isEmpty()){
			request.getRequestDispatcher(path)
			   .forward(request, response);
			return;
		}
	}
	
}
