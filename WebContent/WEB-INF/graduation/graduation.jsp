<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.graduation.model.*"%>
<%@ page import="com.register.model.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	String classID = request.getParameter("classID");
	Integer classNum = Integer
			.valueOf(request.getParameter("classNum"));
%>
<%
	GraduationService graduationSvc = new GraduationService();
	List<GraduationVO> gradList = graduationSvc
			.getByClassIDAndClassNum(classID, classNum);
	pageContext.setAttribute("gradList", gradList);
%>
<%
	RegisterDAO registerDAO = new RegisterDAO();
	List<RegisterVO> regList = registerDAO.getByNotes(classID,
			classNum, "有報名沒結訓");
	pageContext.setAttribute("regList", regList);
%>
<%
	registerDAO = new RegisterDAO();
	List<RegisterVO> allList = registerDAO.getGraduation();
	pageContext.setAttribute("allList", allList);
%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-2.1.1.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-ui-1.10.4.custom.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/jquery-ui-1.10.4.custom.min.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/mqtt.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout.css">
<style>
table {
	color: white;
	width: 100%;
	margin: auto;
	margin-top: 2%;
	table-layout: fixed;
	background-color: rgba(163, 167, 171, 0.4);
}

th {
	font-family: "微軟正黑體";
	font-weight: bold;
	text-align: center;
	height: 40px;
	vertical-align: middle;
}

table,td {
	text-align: center;
	border-collapse: collapse;
	font-size: medium;
}

td {
	height: 30px;
	font-family: "微軟正黑體";
	vertical-align: middle;
	padding: 10px;
}
</style>

<title>結訓表</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
</head>
<body
	style="background:url(${pageContext.request.contextPath}/images/tweed.png);">
	 <div class=sidebar style="z-index:2"> <%@ include file="/WEB-INF/fragment/sidebar.jsp"%></div>	
	<div><%@ include file="/WEB-INF/fragment/Top.jsp"%></div>
	<table border='1' cellspacing='0'>
		<tr>
			<th>變更訓練期別</th>
			<th>報名流水號</th>
			<th>身份證號碼</th>
			<th>姓名</th>
			<th>可駕駛機種</th>
			<th>訓練日期</th>
			<th>訓練有效日期</th>
			<th>訓練單位名稱</th>
			<th>班級期別</th>
			<th>報名日期</th>
			<th>訓練建立人員</th>
			<th style="width: 5%;">備註</th>
		</tr>
		<c:forEach var="allVO" items="${allList}">
			<c:forEach var="graduationVO" items="${gradList}">
				<c:if
					test="${graduationVO.pilotVO.pilotID==allVO.pilotVO.pilotID && graduationVO.classListVO.classTypeVO.classID==allVO.classListVO.classTypeVO.classID && graduationVO.classListVO.classNum==allVO.classListVO.classNum}">
					<tr align='center' valign='middle'>
						<td><img
							src="${pageContext.request.contextPath}/images/icon/change_reg_off.png"></td>
						<td>${allVO.regID}</td>
						<td>${graduationVO.pilotVO.pilotID}</td>
						<td>${graduationVO.pilotVO.pilotName}</td>
						<td>${graduationVO.classListVO.classTypeVO.aircraftVO.craftType}</td>
						<td><fmt:formatDate value="${graduationVO.trainDate}"
								pattern="yyyy/MM/dd" /></td>
						<td><fmt:formatDate value="${graduationVO.validDate}"
								pattern="yyyy/MM/dd" /></td>
						<td>${graduationVO.deptName}</td>
						<td>${graduationVO.classListVO.classTypeVO.classID}${graduationVO.classListVO.classNum}</td>
						<td><fmt:formatDate value="${allVO.regDate}"
								pattern="yyyy/MM/dd HH:mm:ss" /></td>
						<td>${graduationVO.classListVO.managerVO.managerID}</td>
						<td style="width: 5%;">${graduationVO.notes}</td>
					</tr>
				</c:if>
			</c:forEach>
		</c:forEach>

		<c:forEach var="graduationVO" items="${gradList}">
			<c:if test="${graduationVO.notes != ''}">
				<tr align='center' valign='middle'>
					<td><img
						src="${pageContext.request.contextPath}/images/icon/change_reg_off.png"></td>
					<td></td>
					<td>${graduationVO.pilotVO.pilotID}</td>
					<td>${graduationVO.pilotVO.pilotName}</td>
					<td>${graduationVO.classListVO.classTypeVO.aircraftVO.craftType}</td>
					<td><fmt:formatDate value="${graduationVO.trainDate}"
							pattern="yyyy/MM/dd" /></td>
					<td><fmt:formatDate value="${graduationVO.validDate}"
							pattern="yyyy/MM/dd" /></td>
					<td>${graduationVO.deptName}</td>
					<td>${graduationVO.classListVO.classTypeVO.classID}${graduationVO.classListVO.classNum}</td>
					<td>沒報名</td>
					<td>${graduationVO.classListVO.managerVO.managerID}</td>
					<td>${graduationVO.notes}</td>
				</tr>
			</c:if>
		</c:forEach>


		<c:forEach var="registerVO" items="${regList}">
			<tr align='center' valign='middle'>
				<td><form name="myForm"
						action="${pageContext.request.contextPath}/GraduationChangeServlet"
						method="post">
						<input type="image"
							src="${pageContext.request.contextPath}/images/icon/change_reg_on.png"
							onclick="document.myForm.submit()"> <input type="hidden"
							name="regID" value="${registerVO.regID}">
					</form></td>
				<td>${registerVO.regID}</td>
				<td>${registerVO.pilotVO.pilotID}</td>
				<td>${registerVO.pilotVO.pilotName}</td>
				<td>${registerVO.classListVO.classTypeVO.aircraftVO.craftType}</td>
				<td>沒上課</td>
				<td>沒上課</td>
				<td>${registerVO.classListVO.trainDeptVO.deptName}</td>
				<td>${registerVO.classListVO.classTypeVO.classID}${registerVO.classListVO.classNum}</td>
				<td><fmt:formatDate value="${registerVO.regDate}"
						pattern="yyyy/MM/dd HH:mm:ss" /></td>
				<td>${registerVO.classListVO.managerVO.managerID}</td>
				<td>${registerVO.notes}</td>
			</tr>
		</c:forEach>
	</table>
<script type="text/javascript">
	jQuery("tr").not(':first').hover(function() {
		$(this).css("background-color", "rgba(227,228,229, 0.1)");
	}, function() {
		$(this).css("background", "");
	});
</script>
</body>
</html>