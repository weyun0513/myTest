package com.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.CloseReason;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/Customer")
public class CustomerServlet {
	/*
	 * http://docs.oracle.com/javaee/7/tutorial/doc/websocket003.htm
	 */

	@OnOpen
	public void open(Session session, EndpointConfig conf) {
//		System.out.println(session.getId());
		if (session.getQueryString() != null) {
			session.getUserProperties().put("role", "service");
		}
	}

	@OnMessage
	public void message(Session session, String msg) {
		//System.out.println(msg);
		String[] array = msg.split(",");
		
		if (array[0].equals("service")) {
			try {
				boolean control=true;
				for (Session sess : session.getOpenSessions()) {
					String role=(String) sess.getUserProperties().get("role");
					if (sess.isOpen()&&(role!=null)&&role.equals("service")){
						sess.getBasicRemote().sendText(session.getId()+"," + array[1]);
						control=false;
					}
				}
				if(control)session.getBasicRemote().sendText(session.getId()+"," + "抱歉客服還未上線");
			} catch (IOException e) {
			}
		}else{
			try {
				for (Session sess : session.getOpenSessions()) {
					if (sess.isOpen()&&sess.getId().equals(array[0]))
						sess.getBasicRemote().sendText(session.getId()+"," + array[1]);
				}
			} catch (IOException e) {
			}
		}
		
	}

	@OnError
	public void error(Session session, Throwable error) {
	}

	@OnClose
	public void close(Session session, CloseReason reason) {
//		try {
//			session.getBasicRemote().sendText("disconnect,"+session.getId());
//			
//		} catch (IOException e) {
//		}
	}

}
