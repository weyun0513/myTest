<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/buttons.css">
<title>報名進度查詢</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
<style type="text/css">
.box{
margin-top: 3%;
}

p{
color:black;
}

 
</style>
<script>
	$(function() {
		$("#birthday").datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : "yy-mm-dd",
			defaultDate : -365 * 18,
			yearRange : "1967:1996"
		});
	});

	window.onload = function() {
		document.getElementById("ID").onblur = IDCheck;
		//    document.getElementById("birthday").onblur = birthdayCheck;
		document.getElementById("code").onblur = codeCheck;
		document.getElementById("ID").onfocus = IDInput;
		document.getElementById("birthday").onfocus = birthdayInput;
		document.getElementById("code").onfocus = codeInput;
	}

	function IDCheck() {
		if (ID.value == "") { //檢查身分證字號空白
			$("#spanID").html("必填");
		}
	}

	function codeCheck() {
		if (code.value == "") { //檢查圖形驗證碼空白
			$("#spanCode").html("必填");
		}
	}

	function IDInput() {
		$("#spanID").empty();
	}

	function birthdayInput() {
		$("#spanBirthday").empty();
	}

	function codeInput() {
		$("#spanCode").empty();
	}

	function ChangeCheckCode() {
		var images = document.getElementById("img");
		images.src = document.getElementById("img").src + '?';
	}
</script>
</head>

<body style="background: url(${pageContext.request.contextPath}/images/tweed.png);">
		
    <div class=sidebar style="z-index:2"> <%@ include file="/WEB-INF/fragment/sidebar.jsp"%></div>	
	<div><%@ include file="/WEB-INF/fragment/Top.jsp"%></div>
	
	<div class="box">
	<div class="Bicon"><img alt="" src="${pageContext.request.contextPath}/images/register.png"></div>
	<form action="${pageContext.request.contextPath }/CheckPilotServlet"
		method="post">
		<table>
			<tr>
				<td><p for="ID" >身分證字號</p><input type="text"
					name="pilotID" id="ID" value="${msg.inputID}"/><span
					id="spanID" style="color: red">${msg.ID}</span></td>
			</tr>
			<tr>
				<td><p for="birthday">出生日期</p>
					<input type="text" name="birthday" id="birthday" placeholder="請選擇日期"
					value="${msg.inputBD}"/><span id="spanBirthday"
					style="color: red">${msg.BD}</span></td>
			</tr>
			<tr>
				<td><p for="code">圖形驗證碼</p><span id="checkcode"></span>
					<input type="text" name="code" id="code" style="width: 60px"/><img
					id="img" style="height: 40px; margin-bottom: -15px;" src="${pageContext.request.contextPath}/CheckCode"/>
				<a href="javascript:ChangeCheckCode();" style="color:blue">更新驗證碼</a><br><span id="spanCode" style="color: red">${msg.code}</span></td>
			</tr>
			<tr>
				<td><input type="submit" id="submit" value="確認"  class="button button-rounded button-primary" style="margin-top:20px"/></td>
			</tr>
		</table>
	</form>
</div>
</body>

</html>