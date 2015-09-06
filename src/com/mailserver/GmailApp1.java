package com.mailserver;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class GmailApp1 { 
	
	
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
	  
//	        System.out.println("Done");  
	  
	        } catch (MessagingException e) {  
	            throw new RuntimeException(e);  
	        }  
	}
//    public static void main(String args[]) {  
//    	new GmailApp1().sendEmail("cecj04t2@gmail.com"
//    			,"yhk4cjo4", "wayne2956@hotmail.com"
//    			, "報名完成","<table style=\"border:2px solid;\"><tr><td>中文</td><td>test</td></tr><tr><td>test</td><td>test</td></tr></table>" );
//    }//
    
}