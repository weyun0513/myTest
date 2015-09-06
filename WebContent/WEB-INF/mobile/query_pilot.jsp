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
	<title>查詢班級列表</title>
	
	
</head>
<body>
	<div data-role="page" id="page_main" >
        <div data-role="header" >
        	<a data-role="button" href="${pageContext.request.contextPath}/index_mobile.jsp" 
        	   data-icon="back" data-iconpos="left" data-inlne="true">
               Back
            </a>
        	<h3>Soaring High</h3>
        	<a data-role="button" href="${pageContext.request.contextPath}/index_mobile.jsp" 
        	   data-icon="home" data-iconpos="left" data-inlne="true">
               Home
            </a>
        </div>
        
        <div data-role="main" class="ui-content">
        	<h3>班級列表查詢</h3>
            <form method="post" action='<c:url value="/PilotQueryServlet"/>'>
            <div>
            	<label for="trainDate">開訓日期</label>
            	<input type="month" name="month" value="" style="background:#ffffff; color:#000000"/>
            </div>
            <div>
                <input type="submit" id="submit" value="查詢"/>
            </div>	
        </div>
    </div>
</body>
</html>