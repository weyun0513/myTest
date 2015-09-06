<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>稽核紀錄</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.dataTables.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/ajax2.js"></script>
<script
	src="${pageContext.request.contextPath}/js/jquery-ui-1.10.4.custom.min.js"></script>
<link
	href="${pageContext.request.contextPath}/css/jquery.dataTables.min.css"
	rel="stylesheet">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/mqtt.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/box.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/buttons.css">
</head>
<style>
td{
color: white;
}
.box {
	margin-top: 2%;
}
form{
   font-family: "Helvetica Neue", Helvetica, Arial, "微軟正黑體", sans-serif;
color:black
}


.box input[type=text] {
	height: 10px;
}
</style>
<body
	style="background: url(${pageContext.request.contextPath}/images/tweed.png);">
	<div class=sidebar style="z-index:2"> <%@ include file="/WEB-INF/fragment/sidebar.jsp"%></div>
	<%@ include file="/WEB-INF/fragment/Top.jsp"%>


	<div class="box">
		<div class="Bicon">
			<img alt=""
				src="${pageContext.request.contextPath}/images/check_book-128.png">
		</div>
		<form action="${pageContext.request.contextPath}/ModRecord"
			method="POST" style="text-align: left;">
			<div>
				報名流水號：&nbsp;&nbsp;&nbsp;<input type="text" value="${param.regID}" name="regID"
					style="width: 165px;"> <font color="red">${errMSG}</font>
			</div>
			<div>
				飛行員身分證：<input type="text" value="${param.pilotID}" name="pilotID"
					style="width: 165px;">
			</div>
			<input type="hidden" value="search" name="action"><input
				type="submit" value="查詢"
				class="button button-rounded button-primary"
				style="margin-top: 20px;" />
		</form>
	</div>
	<table id="myTable" style="text-align:center;">
		<c:if test="${not empty noFind}">
			<tr>
				<td>查無資料</td>
			</tr>
		</c:if>
		<c:if test="${not empty modList}">
			<thead>
				<tr>
					<th>報名流水號</th>
					<th>飛行員身分證</th>
					<th>修改日期</th>
					<th>修改方法</th>
					<th>修改網址</th>
					<th>修改管理員</th>
					<th>修改IP</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="modData" items="${modList}">
					<tr>
						<td>${modData.regID}</td>
						<td>${modData.pilotID}</td>
						<td>${modData.modDate}</td>
						<td>${modData.modFunction}</td>
						<td>${modData.modURL}</td>
						<td>${modData.managerVO.managerAccnt=='0'?'飛行員':modData.managerVO.managerAccnt}</td>
						<td>${modData.modIP}</td>
					</tr>
				</c:forEach>
			</tbody>
		</c:if>
	</table>
	<c:remove var="modList" />
	<script type="text/javascript">
	jQuery("tr").not(':first').hover(function() {
		$(this).css("background-color", "rgba(227,228,229, 0.1)");
	}, function() {
		$(this).css("background", "");
	});
</script>
	<script type="text/javascript">
		$('#myTable').dataTable();
	</script>
</body>
</html>