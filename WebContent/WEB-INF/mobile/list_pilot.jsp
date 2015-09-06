<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Date" %>
<%@ page import="com.classlist.model.*"%>
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

	<title>班級列表</title>
	
<script>
    $(function () {
        //避免 disabled 的 hyperlink 被觸發， chrome,firefox 需要這段處理
        $("a").click(function () {
            if ($(this).attr("disabled") == "disabled") {
                event.preventDefault();
            }
        });
    });
    
    
</script>


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
        	<h3>班級列表</h3>
	        	<form class="ui-filterable" >
                    <input id="filter-input" data-type="search" style="background:#ffffff; color:#000000">
                </form>
                <c:forEach var="classListVO" items="${list}" varStatus="count">
                <form name="myForm${count.index}" method="post" action="${pageContext.request.contextPath}/MobileRegServlet" data-ajax="false">
                <ul data-role="listview" data-filter="true" data-input="#filter-input" data-inset="true">
                
                <c:if test="${classListVO.maxNum-classListVO.regNum > 0}">
                    <li>
                        <a data-role="button" onclick="document.myForm${count.index}.submit()">
                        <p>日期:${classListVO.startDate}&nbsp;&nbsp;&nbsp;&nbsp;每週${classListVO.classSchedule}</p>
                        <p>機種類型:${classListVO.classTypeVO.aircraftVO.craftType}</p>
                        <p>訓練地點:${classListVO.trainDeptVO.deptName}</p>
                        <span class="ui-li-count">餘額:${classListVO.maxNum-classListVO.regNum}</span>
                        <input type="hidden" name="classID" value="${classListVO.classTypeVO.classID}">
                        <input type="hidden" name="classNum" value="${classListVO.classNum}">
                        <input type="hidden" name="action" value="previewReg">
<!--                    <input type="hidden" name="className" value="${classListVO.classTypeVO.className}">
                        <input type="hidden" name="craftType" value="${classListVO.classTypeVO.aircraftVO.craftType}">
                        <input type="hidden" name="startDate" value="${classListVO.startDate}">
                        <input type="hidden" name="deptName" value="${classListVO.trainDeptVO.deptName}">
-->                     </a>
                    </li>
                </c:if>
                <c:if test="${classListVO.maxNum-classListVO.regNum == 0}">
                    <li>
                    	<a data-role="button" class="ui-disabled">
                        <p>日期:${classListVO.startDate}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;每週${classListVO.classSchedule}</p>
                        <p>訓練項目:${classListVO.classTypeVO.className}</p>
                        <p>訓練地點:${classListVO.trainDeptVO.deptName}</p>
                        <span class="ui-li-count">餘額:${classListVO.maxNum-classListVO.regNum}</span>
                        </a>
                    </li>
                </c:if>    
                
                </ul>
                </form>
                </c:forEach> 
		</div>
		<div data-role="footer">
        		
        </div>
    </div>
    
    <form name="myForm" action="${pageContext.request.contextPath}/QueryPilotMobileServlet" method="post" style="display:inline">
    </form>    
</body>
</html>