<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>變更繳費狀態</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/ajax2.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/jquery-ui-1.10.4.custom.min.css" />
<script
	src="${pageContext.request.contextPath}/js/jquery-ui-1.10.4.custom.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/mqtt.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/box.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/buttons.css">

<style>
p{
 color:black;
}
.error {
	color: #FF0000;
	padding-bottom:10px;
}
</style>	
<script type="text/javascript">
	var context = "${pageContext.request.contextPath}";
	jQuery(document).ready(function() {

		jQuery("input[name='regID']").blur(function() {
			var path = context + "/register/change.view";
			var data = jQuery("input[name='regID']").val();
			sendjQueryRequest(path, data);
		});

		jQuery("#ModMessage").dialog({
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
</head>
<body style="background: url(${pageContext.request.contextPath}/images/tweed.png);">
    <div class=sidebar style="z-index:2"> <%@ include file="/WEB-INF/fragment/sidebar.jsp"%></div>
	<div><%@ include file="/WEB-INF/fragment/Top.jsp"%></div>

	<div class="box">
	<div class="Bicon"><img alt="" src="${pageContext.request.contextPath}/images/banknotes-128.png"></div>
	<P>請輸入報名流水號:
	<P>
	<form
		action="${pageContext.request.contextPath}/register/ModPayStatus.do"
		method="post">
		<input type="text" name="regID" value="${param.regID}"><p
			id="message" class="error">${errorMsgs.regID}</p>
		<input
			type="submit" class="button button-rounded button-primary" value="查詢">
			<input type="hidden" value="select" name="action">
	</form>
</div>



	<!-- 	//=================	 -->
	<c:if test="${not empty ModMessage}">
		<div id="ModMessage" class=error>
			<p style="color: red">${ModMessage.payStatus}</p>

			<c:remove var="ModMessage" scope="request" />
		</div>
	</c:if>


</body>
</html>