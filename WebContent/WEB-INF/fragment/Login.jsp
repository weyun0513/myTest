<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
<style type="text/css">
	#container{
	border-radius: 20px;
	border-color: #d0e5f5;
	border-width: 2px;
	}
</style>

</head>
<body>
<jsp:include page="Top.jsp"/>
<%//讀取客戶端 餅乾
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	String name = "";
	for (Cookie cookie : cookies) {
		name = cookie.getName();
		if (name.equals("username")) {
			session.setAttribute("username", cookie.getValue());
		}
		if (name.equals("password")) {
			session.setAttribute("password", cookie.getValue());
		}
		if (name.equals("remember")) {
			session.setAttribute("remember", true);
		}
	}
}
//登入成功後(LoginServlet會刪除)
%>
	<div id="container">
		
		<form action="${pageContext.request.contextPath}/LoginServlet" method="POST">
		
		<label for="name">帳號:</label>
		
		<span style="color: #FF3333;float: right;font-size: 11px;margin-right: 20px;margin-top: 15px">${errorMSG.username}</span>
		
		<input type="name" name="username" value="${username}">	
		
		<label for="username">密碼:</label>
		
		<span style="color: #FF3333;float: right;font-size: 11px;margin-right: 20px;margin-top: 15px">${errorMSG.password}</span>	
		
		<input type="password" name="password" value="${password}">
			
		<div id="lower">
		
		<input type="checkbox" name="remember" value="true"
			   <c:if test="${remember==true}">
                  checked='checked'
               </c:if> ><label class="check" for="checkbox">記住密碼</label>
		<%
		if(session.getAttribute("errorMSG")!=null){
			session.removeAttribute("errorMSG");
		}
		//為了登入畫面用send 所以msg放session 
		%>
		<input type="submit" value="Login">
<!-- 	<input type="submit" value="登入"> -->
		</div>
		
		</form>
		
	</div>
</body>
</html>