package com.mailserver;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.register.model.RegisterService;
import com.register.model.RegisterVO;


@WebServlet("/Email")
public class Email extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public Email() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String email=request.getParameter("email");
		String regID=request.getParameter("regID");
		String topic=request.getParameter("topic");
		
		System.out.println(email+"  "+regID);
		RegisterService registerService=new RegisterService();
		RegisterVO registerVO= registerService.findByPrimaryKey(Integer.valueOf(regID));
		StringBuffer table=new StringBuffer();
		table.append("<table style=\"border:2px solid ;\"><tr><td colspan=\"2\" style=\"text:align\">"+(topic=="1"?"報名成功":"變更報名成功")+"</td></tr>");
		table.append("<tr><td>報名流水號</td><td>"+registerVO.getRegID()+"</td></tr>");
		table.append("<tr><td>姓名</td><td>"+registerVO.getPilotVO().getPilotName()+"</td></tr>");
		table.append("<tr><td>連絡電話</td><td>"+registerVO.getPilotVO().getPhone()+"</td></tr>");
		table.append("<tr><td>可駕駛機種</td><td>"+registerVO.getClassListVO().getClassTypeVO().getAircraftVO().getCraftType()+"</td></tr>");
		table.append("<tr><td>下次訓練有效日期</td><td>"+registerVO.getPilotVO().getNextValidDate()+"</td></tr>");
		table.append("<tr><td>班級期別</td><td>"+registerVO.getClassListVO().getClassTypeVO().getClassID()+registerVO.getClassListVO().getClassNum()+"</td></tr>");
		table.append("<tr><td>報名日期</td><td>"+registerVO.getRegDate()+"</td></tr>");
		table.append("<tr><td>報名進度</td><td>"+registerVO.getRegStatus()+"</td></tr>");
		table.append("<tr><td>繳費狀態</td><td>未繳費</td></tr>");
		table.append("</table>");
		//System.out.println(table.toString());
		this.sendEmail("cecj04t2@gmail.com"
    				  ,"yhk4cjo4"
    				  ,email
    				  ,(topic=="1"?"Register Success":"Modify Success")
    				  ,table.toString()
    				  );
		if(topic.equals("報名成功"))
			request.getSession().setAttribute("message", "報名成功 信件已送出");
		else
			request.getSession().setAttribute("message", "變更成功  信件已送出");
		String url="";
		if(request.getSession().getAttribute("LoginOK")==null){
			request.getRequestDispatcher("/Referred?action=air").forward(request, response);
		}else{
			url = request.getContextPath() + "/classlist/ClassView";
			response.sendRedirect(url);	
		}
	}
	public void sendEmail(final String sendFrom,final String password
			,String sendTo,String sendSubject,String sendContent){
		 String host = "smtp.gmail.com";  
	        int port = 587;  
	       
	        Properties props = new Properties();  
	        props.put("mail.smtp.host", host);  
	        props.put("mail.smtp.auth", "true");  
	        props.put("mail.smtp.starttls.enable", "true");  
	        props.put("mail.smtp.port", port);  
	          
	        Session session = Session.getInstance(props,new Authenticator(){  
	              protected PasswordAuthentication getPasswordAuthentication() {  
	                  return new PasswordAuthentication(sendFrom, password);  
	              }} );  
	           
	        try {  
	  
	        Message message = new MimeMessage(session);  
	        message.setFrom(new InternetAddress(sendFrom));  
	        message.setRecipients(Message.RecipientType.TO,   
	                        InternetAddress.parse(sendTo));  
	        message.setSubject(sendSubject);  
	        message.setContent(sendContent, "text/html; charset=UTF-8");       
	  
	        Transport transport = session.getTransport("smtp");  
	        transport.connect(host, port, sendFrom, password);  
	  
	        Transport.send(message);  
	  
	        
	  
	        } catch (MessagingException e) {  
	            throw new RuntimeException(e);  
	        }  
	}

}
