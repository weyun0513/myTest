<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewpoint" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link rel="stylesheet" type="text/css" href="themes/bluemix.min.css">
	<link rel="stylesheet" type="text/css" href="themes/jquery.mobile.icons.min.css">
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.3/jquery.mobile.structure-1.4.3.min.css" />
	<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.3/jquery.mobile-1.4.3.min.js"></script>
<title>報名失敗</title>


</head>
<body>
	<div data-role="page" id="page_main" >
    	<div data-role="header">
        	<a data-role="button" onclick="document.myForm.submit()" 
        	   data-icon="back" data-iconpos="left">
               Back
            </a>
            <h3>Soaring High</h3>
            <a data-role="button" href="${pageContext.request.contextPath}/index_mobile.jsp" 
        	   data-icon="home" data-iconpos="left" data-inlne="true">
               Home
            </a>
        </div>
        	
        	<div data-role="main" class="ui-content">
        		<ul data-role="listview">
                    <li>
        			<c:if test="${not empty message}">
	  					<p style="color:#DB8580;font-size:20px">${message}</p>
	  					<c:remove var="message" scope="session"/>
					</c:if>
					</li>
				</ul>	
				<form action="${pageContext.request.contextPath}/QueryPilotMobileServlet" method="post">
					<div>
						<input type="submit" value="返回">
					</div>
				</form>
        	</div>
        	
        	
    </div>
	
	<form name="myForm" action="${pageContext.request.contextPath}/PilotQueryServlet" method="post" style="display:inline">
    	<input type="hidden" name="month" value="${sessionScope.monthAfter}" style="display:inline">
    </form>
</body>
</html>