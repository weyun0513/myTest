package com.classlist.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pilot.model.PilotDAO;
import com.pilot.model.PilotVO;
import com.register.model.RegisterDAO;
import com.register.model.RegisterVO;

@WebServlet("/CheckPilotServlet")
public class CheckPilotServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CheckPilotServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String ID = request.getParameter("pilotID");
		String BD = request.getParameter("birthday");
		String code = request.getParameter("code");
		
		HttpSession session = request.getSession();
		Map<String, String> msg = new HashMap<>();
		
		if (ID == null || ID.trim().length() == 0) {
			msg.put("ID", "請輸入身分證");
		}
		if (BD == null || BD.trim().length() == 0) {
			msg.put("BD", "請輸入生日");
		}
		if (code == null || code.trim().length() == 0) {
			msg.put("code", "請輸入驗證碼");
		}
		
		if (!msg.isEmpty()) {	// 有格式錯誤
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("/WEB-INF/register/regStatus.jsp").forward(request, response);
			return;
		} else {
			PilotVO pilotVO = null;
			// 驗證碼沒過直接掰/
			String checkCode = (String) session.getAttribute("check_code");

			if (code.equals(checkCode)) {
				pilotVO = new PilotDAO().findbyID(ID);
				if (pilotVO != null) {
					String dataBirthday = String.valueOf(pilotVO.getBirthday());// 資料庫的生日
					if (dataBirthday.equals(BD)) {
						session.removeAttribute("check_code");// 成功後刪除驗證碼
					} else {
						msg.put("inputID", ID);
						msg.put("BD", "出生日期錯誤");
					}
				} else {
					msg.put("inputBD", BD);
					msg.put("ID", "查無此身分證字號");
				}
			} else {
				msg.put("inputID", ID);
				msg.put("inputBD", BD);
				msg.put("code", "驗證碼不合");
			}
			
			if (msg.isEmpty()) {// 沒錯誤
				RegisterDAO dao=new RegisterDAO();
				List<RegisterVO> list = dao.getByPilotID(ID);
				for(RegisterVO vo : list) {
					session.setAttribute("pilotID", vo.getPilotVO().getPilotID());
					session.setAttribute("pilotName", vo.getPilotVO().getPilotName());
				}
				
				request.setAttribute("registerList", list);
				request.getRequestDispatcher("/WEB-INF/register/register_info.jsp").forward(request,response);
				return;
			} else {
				request.setAttribute("msg", msg);
				request.getRequestDispatcher("/WEB-INF/register/regStatus.jsp").forward(request, response);
				return;
			}
		}
	}
}
