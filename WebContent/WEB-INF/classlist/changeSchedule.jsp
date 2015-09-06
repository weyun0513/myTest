<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>變更排程器</title>
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
	href="${pageContext.request.contextPath}/css/box.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/buttons.css">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
<script>
	jQuery(function() {
		jQuery("#message").dialog({
			draggable : false,
			resizable : false,
			height : 250,
			modal : true,
			title : "系統訊息",
			buttons : {
				"確定" : function() {
					jQuery(this).dialog("close");
				}
			}
		});
	});
</script>

<style>
p, form{
 color:black;
}
</style>
</head>
<body
	style="background:url(${pageContext.request.contextPath}/images/tweed.png);">
	 <div class=sidebar style="z-index:2"> <%@ include file="/WEB-INF/fragment/sidebar.jsp"%></div>
	<div><%@ include file="/WEB-INF/fragment/Top.jsp"%></div>

	<div class="box">
		<div class="Bicon">
			<img alt=""
				src="${pageContext.request.contextPath}/images/overtime-128.png">
		</div>
		<p>${applicationScope.scheduleInfo}</p>
		<form method="post"
			action="${pageContext.request.contextPath}/Schedule">
			每日：<input type="text" name="hour" style="width: 60px">&nbsp;&nbsp;時：<input
				type="text" name="minute" style="width: 60px">&nbsp;&nbsp;分<input
				type="submit" value="更改"
				class="button button-rounded button-primary"  style="margin-top:20px"><input
				type="hidden" name="action" value="changeSchedule">
		</form>

		<c:if test="${ not empty message}">
			<div id="message">
				<p>${message}</p>
				<c:remove var="message" scope="session" />
			</div>
		</c:if>
	</div>
</body>
</html>