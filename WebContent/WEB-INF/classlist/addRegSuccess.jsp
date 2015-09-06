<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.register.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css">
<link
	href="http://netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-2.1.1.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-ui-1.10.4.custom.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/jquery-ui-1.10.4.custom.min.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/mqtt.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/buttons.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout.css">
<script type="text/javascript">
	function sendEmail() {
		jQuery('#dialog')
				.empty()
				.append(
						'<form id="sendEMail" action="${pageContext.request.contextPath}/Email" method="post">'
								+ '<div><input type="text" name="email" value="">'
								+ '<input type="hidden" name="topic" value="${param.action!=goReg2?1:0}">'
								+ '<input type="hidden" name="action" value="${param.action}">'
								+ '<input type="hidden" name="regID" value="${registerVO.regID}">'
								+ '<input  type="button" value="寄送" size="10" onclick="doSendMail();"></div>'
								+ '<div id="loaderImg" style="vertical-align: middle;text-align:center;">處理中...<img src="${pageContext.request.contextPath}/css/images/ajax-loader.gif"></div>'
								+ '</form>').dialog({
					resizable : false,
					height : 300,
					modal : true
				}).find('#loaderImg').hide();
	}
	function doSendMail() {
		jQuery('#loaderImg').show();
		jQuery('#sendEMail').submit();
	}
</script>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/images/icon/icon.png"
	type="image/vnd.microsoft.icon">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/jquery-ui-1.10.4.custom.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:if test="${param.action!='goReg2'}">
	<title>報名成功</title>
</c:if>
<c:if test="${param.action=='goReg2'}">
	<title>變更訓練期別成功</title>
</c:if>
<style>
.unchanged {
	background-color: #FFEE99
}

.step {
	position: absolute;
	top: 150px;
	width: 220px;
	margin-left: 360px;
	padding: 5px 10px;
	text-align: center;
	border: 0;
	border-radius: 3px;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	background: #FFFFFF;
	-webkit-box-shadow: 0px 0px 38px 0px rgba(0, 0, 0, 0.75);
	-moz-box-shadow: 0px 0px 38px 0px rgba(0, 0, 0, 0.75);
	box-shadow: 0px 0px 38px 0px rgba(0, 0, 0, 0.75);
	font-family: "微軟正黑體";
	color: black
}

table {
	width: 320px;
	margin: 50%;
	margin-top: 8%;
	background-color: #FFF;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	-webkit-box-shadow: 0px 0px 38px 0px rgba(0, 0, 0, 0.75);
	-moz-box-shadow: 0px 0px 38px 0px rgba(0, 0, 0, 0.75);
	box-shadow: 0px 0px 38px 0px rgba(0, 0, 0, 0.75);
	font-family: "微軟正黑體";
}

tr {
	text-align: left;
	width: 150px;
	padding-left:50px;
	border-collapse: collapse;
	height: 30px;
	color: black
}

.button-primary {
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	width: 250px;
	margin-bottom: 5px;
	padding-top: 5px;
}

}
.button {
	font-size: 16px;
	font-family: "微軟正黑體";
	letter-spacing: 10px;
}
</style>
</head>
<body
	style="background: url(${pageContext.request.contextPath}/images/tweed.png);">
	<div class=sidebar style="z-index: 2">
		<%@ include file="/WEB-INF/fragment/sidebar.jsp"%></div>
	<div><%@ include file="/WEB-INF/fragment/Top.jsp"%></div>
	<div class="step">
		<div
			style="font-size: 16px; padding-bottom: 10px; font-family: Georgia; font-style: italic;">How
			To Use：</div>
		<div>
			<i class="fa fa-lightbulb-o fa-2x"
				style="color: #FFCC22; vertical-align: middle;"></i> <span>檢查資料是否正確</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div>
			<i class="fa fa-envelope-square fa-2x"
				style="color: #5599FF; vertical-align: middle;"></i> <span>選擇是否寄送E-mail通知</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div style="vertical-align: middle;">
			<span>離開</span>
		</div>
	</div>
	<div id="send">
		<table>
			<c:if test="${param.action!='goReg2'}">
				<tr>
					<td colspan="2">報名成功</td>
				</tr>
			</c:if>
			<c:if test="${param.action=='goReg2'}">
				<tr>
					<td colspan="2">變更訓練期別成功</td>
				</tr>
			</c:if>
			<tr>
				<td>報名流水號：</td><td>${registerVO.regID}</td>
			</tr>
			<tr>
				<td>身分證號：</td>
				<td>${registerVO.pilotVO.pilotID}</td>
				
			
			</tr>
			<tr>
				<td>姓名：</td>
				<td>${registerVO.pilotVO.pilotName}</td>
				
			
			</tr>
			<tr>
				<td>連絡電話：</td>
				<td>${registerVO.pilotVO.phone}</td>
				
			
			</tr>
			<tr>
				<td>可駕駛機種：</td>
				<td>${registerVO.classListVO.classTypeVO.aircraftVO.craftType}</td>
				
			
			</tr>
			<tr>
				<td>上次訓練日期：</td>
				<td><fmt:formatDate pattern="yyyy/MM/dd"
					value="${registerVO.pilotVO.lastTrainDate}" />
				</td>
				
			
			</tr>
			<tr>
				<td>上次訓練有效日期：</td>
				<td><fmt:formatDate pattern="yyyy/MM/dd"
					value="${registerVO.pilotVO.lastValidDate}" />
				</td>
				
			
			</tr>
			<tr>
				<td>下次審驗日期：</td>
				<td><fmt:formatDate pattern="yyyy/MM/dd"
					value="${registerVO.pilotVO.nextValidDate}" />
				</td>
				
			
			</tr>
			<tr>
				<td>下次訓練有效日期：</td>
				<td><fmt:formatDate pattern="yyyy/MM/dd"
					value="${registerVO.pilotVO.nextValidDate}" />
				</td>
				
			
			</tr>
			<tr>
				<td>緊急聯絡人：</td>
				<td>${registerVO.pilotVO.urgentContact}</td>
				
			
			</tr>
			<tr>
				<td>緊急聯絡人電話：</td>
				<td>${registerVO.pilotVO.urgentPhone}</td>
				
			
			</tr>
			<tr>
				<td>班級期別：</td>
				<td>${registerVO.classListVO.classTypeVO.classID}${registerVO.classListVO.classNum}</td>
				
			
			</tr>
			<tr>
				<td>報名日期：</td>
				<td><fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss"
					value="${registerVO.regDate}" />
				</td>
				
			
			</tr>
			<c:if test="${param.action!='goReg2'}">
				<tr>
					<td>訓練建立人員：</td>
					<td>${registerVO.managerVO.managerAccnt=='0'?'飛行員':registerVO.managerVO.managerAccnt}</td>
					
				
				</tr>
			</c:if>
			<c:if test="${param.action=='goReg2'}">
				<tr>
					<td>報名進度：</td>
					<td>${registerVO.regStatus}</td>
					
				
				</tr>
				<tr>
					<td>繳費狀態：</td>
					<td>${registerVO.payStatus?'已繳費':'未繳費'}</td>
					
				
				</tr>
			</c:if>
			<c:if test="${not empty LoginOK}">
				<tr style="text-align:center;">
					<td colspan="2"><input type="button"
						class="button button-rounded button-primary"
						onclick="sendEmail();" value="寄送E-mail">

						<form
							action="${pageContext.request.contextPath}/classlist/ClassView"
							method="POST">
							<input type="submit" class="button button-rounded button-primary"
								value="離開">
						</form></td>
				</tr>
			</c:if>
			<c:if test="${empty LoginOK}">
				<tr style="text-align:center;">
					<td colspan="2"><input type="button"
						class="button button-rounded button-primary"
						onclick="sendEmail();" value="寄送E-mail">
						<form action="${pageContext.request.contextPath}/Referred"
							method="POST">
						<input type="hidden" name="action" value="air">
							<input type="submit" class="button button-rounded button-primary"
								value="離開">
						</form></td>
				</tr>
			</c:if>
			<c:set var="message" scope="session">
					<c:if test="${param.action=='goReg2'}">變更訓練期別成功</c:if>
					<c:if test="${param.action!='goReg2'}">報名成功</c:if>
				</c:set>
		</table>
	</div>
	<div id="dialog" title="填寫E-Mail"></div>
</body>
</html>