<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<title>報名資訊</title>

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
        	<form action="${pageContext.request.contextPath}/QueryPilotMobileServlet" method="post" data-ajax="false">
        		<h3 style="color:#F6D375">報名成功</h3>
        		<ul data-role="listview">
                    <li>                        
                        <h5 style="color:#000000">報名流水號</h5>
                        <h5>${registerVO.regID}</h5>
                        <h5 style="color:#000000">身分證字號</h5>
                        <h5>${registerVO.pilotVO.pilotID}</h5>
                        <h5 style="color:#000000">姓名</h5>
                        <h5>${registerVO.pilotVO.pilotName}</h5>
                        <h5 style="color:#000000">連絡電話</h5>
                        <h5>${registerVO.pilotVO.phone}</h5>
                        <h5 style="color:#000000">班級期別</h5>
                        <h5>${registerVO.classListVO.classTypeVO.classID}${registerVO.classListVO.classNum}</h5>
                        <h5 style="color:#000000">班級名稱</h5>
                        <h5>${registerVO.classListVO.classTypeVO.className}</h5>
                        <h5 style="color:#000000">訓練地點</h5>
                        <h5>${registerVO.classListVO.trainDeptVO.deptName}</h5>
                        <h5 style="color:#000000">報名日期</h5>
                        <h5><fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss"  value="${registerVO.regDate}" /></h5>                        
                    </li>
             	</ul>
             	<input type="submit" value="返回">
             </form>	
        </div>
        
    </div>
    
    <form name="myForm" action="${pageContext.request.contextPath}/PilotQueryServlet" method="post" style="display:inline">
    	<input type="hidden" name="month" value="${sessionScope.monthAfter}" style="display:inline">
    </form>
</body>
</html>