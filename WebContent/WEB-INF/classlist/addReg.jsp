<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	href="${pageContext.request.contextPath}/css/layout.css">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
<c:if test="${param.action=='goReg2'}"><title>變更訓練期別</title></c:if>
<c:if test="${param.action!='goReg2'}"><title>班級報名</title></c:if>

<style type="text/css">
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
	color:black
	 
}

 th{color:black}

fieldset {
	width: 300px;
	text-align: center;
	font-family: "微軟正黑體";
	border: 0;
	padding: 10px;
	margin: 25px 650px;
	border-radius: 8px;
	-moz-border-radius: 8px;
	-webkit-border-radius: 8px;
	background: #FFFFFF;
	-webkit-box-shadow: 0px 0px 38px 0px rgba(0, 0, 0, 0.75);
	-moz-box-shadow: 0px 0px 38px 0px rgba(0, 0, 0, 0.75);
	box-shadow: 0px 0px 38px 0px rgba(0, 0, 0, 0.75);
}

legend {
	padding: 5px 10px;
	background-color: #4F709F;
	color: #FFF;
	border-radius: 3px;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	box-shadow: 2px 2px 4px #666;
	-moz-box-shadow: 2px 2px 4px #666;
	-webkit-box-shadow: 2px 2px 4px #666;
	left: 10px;
	top: -11px;
}

tr {
	text-align: left;
	font-family: "微軟正黑體";
}
input[type=text] {
	margin-top: 8px; 
	width: 180px;
	height: 5px;
	padding: 10px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	border: 1px solid #ccc;
}

</style>
<script>
	jQuery(function() {
		jQuery(".cal").datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : "yy-mm-dd",
			defaultDate : -18 * 365,
			yearRange : '1967:1996'
		});
	});

	function ChangeCheckCode() {
		var images = document.getElementById("img");
		images.src = document.getElementById("img").src + '?';
	}

	function goBack() {
		jQuery('#back').submit();
	}
</script>
</head>
<body
	style="background:url(${pageContext.request.contextPath}/images/tweed.png);">
	<div class=sidebar style="z-index:2"> <%@ include file="/WEB-INF/fragment/sidebar.jsp"%></div>
	<div><%@ include file="/WEB-INF/fragment/Top.jsp"%></div>
	<c:if test="${param.action=='goReg2'}">
	<div class="step">
		<div
			style="font-size: 16px; padding-bottom: 10px; font-family: Georgia; font-style: italic;">How
			To Use：</div>
		<div>
			<i class="fa fa-university fa-2x"
				style="color: #5599FF; vertical-align: middle;"></i> <span>確認欲變更的班級</span>
		</div>	
	</div>
	</c:if>
	<c:if test="${param.action!='goReg2'}">
	<div class="step">
		<div
			style="font-size: 16px; padding-bottom: 10px; font-family: Georgia; font-style: italic;">How
			To Use：</div>
		<div>
			<i class="fa fa-university fa-2x"
				style="color: #5599FF; vertical-align: middle;"></i> <span>確認欲報名的班級</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div style="vertical-align: middle;">
			<i class="fa fa-child fa-2x"
				style="color: #5599FF; vertical-align: middle;"></i> <span>輸入身分證號碼</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div style="vertical-align: middle;">
			<i class="fa fa-calendar-o fa-2x"
				style="color: #5599FF; vertical-align: middle;"></i> <span>選擇生日</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div>
			<i class="fa fa-info-circle fa-2x"
				style="color: #5599FF; vertical-align: middle;"></i> <span>輸入圖形驗證碼</span>
		</div>
	</div>
</c:if>
	<fieldset>
		<legend align="left">班級資訊</legend>
		<form method="post"
			action="${pageContext.request.contextPath}/classlist/Class.do">
			<table>
				<tr>
					<th>代號/期別：</th>
					<td><input type="text"
						value="${classListVO.classTypeVO.classID}${classListVO.classNum}"
						readonly class="unchanged"></td>
				</tr>
				<tr>
					<th>班級名稱：</th>
					<td><input type="text"
						value="${classListVO.classTypeVO.className}" readonly
						class="unchanged"></td>
				</tr>
				<tr>
					<th>機種類型：</th>
					<td><input type="text"
						value="${classListVO.classTypeVO.aircraftVO.craftType}" readonly
						class="unchanged"></td>
				</tr>
				<tr>
					<th>訓練單位：</th>
					<td><input type="text"
						value="${classListVO.trainDeptVO.deptName}" readonly
						class="unchanged"></td>
				</tr>
				<tr>
					<th>開訓日期：</th>
					<td><input type="text"
						value="<fmt:formatDate pattern="yyyy/MM/dd"  value="${classListVO.startDate}" />"
						readonly class="unchanged"></td>
				</tr>
				<tr>
					<th>結訓日期：</th>
					<td><input type="text"
						value="<fmt:formatDate pattern="yyyy/MM/dd"  value="${classListVO.endDate}" />"
						readonly class="unchanged"></td>
				</tr>
				<tr>
					<th>開課人數：</th>
					<td><input type="text" value="${classListVO.maxNum}" readonly
						class="unchanged"></td>
				</tr>
				<tr>
					<th>報名人數：</th>
					<td><input type="text" value="${classListVO.regNum}" readonly
						class="unchanged">
					<td>
				</tr>
				<tr>
					<th>上課時間：</th>
					<td><input type="text" value="${classListVO.classSchedule}"
						readonly class="unchanged"></td>
				</tr>
				<c:if test="${param.action!='goReg2'}">
					<tr>
						<th colspan="2"><h4  style="text-align: center; margin-top: 20px;">請輸入個人資料</h4></th>
					</tr>
					<tr>
						<td colspan="2">
							<table>
								<tr>
									<th style="width: 80%;">身份證號碼：</th>
									<td><input type="text" name="pilotID"
										value="${param.pilotID}"><br> <span
										style="color: red">${msg.message1}</span></td>
								</tr>
								<tr>
									<th style="width: 100%;">生日：</th>
									<td><input type="text" name="birthday" class="cal"
										placeholder="選擇日期" value="${param.birthday}"><br>
										<span style="color: red">${msg.message2}</span></td>
								</tr>
								<tr>
									<th style="width: 100%;">圖形驗證碼：</th>
									<td><input type="text" name="checkCode" value=""
										placeholder="請輸入驗證碼"><br><span
										style="color: red">${msg.message3}</span><img id="img"
										style="height: 40px ;"
										src="${pageContext.request.contextPath }/CheckCode" /><br>
										<a href="javascript:ChangeCheckCode();" style="color:blue">更新驗證碼</a></td>
								</tr>
							</table> <input type="hidden" name="action" value="addReg">
					<tr>
						<td colspan="2"><input type="submit" value="報名"
							style="width: 33%">
				</c:if>
				<c:if test="${param.action=='goReg2'}">
					<input type="hidden" name="action" value="goReg2">
					<input type="hidden" name="pilotID" value="${param.pilotID}">
					<input type="hidden" name="classID_classNum"
						value="${param.classID_classNum}">
					<tr>
						<td colspan="2"><input type="submit" value="變更"
							style="width: 34%">
				</c:if>
				<input type="hidden" name="classID"
					value="${classListVO.classTypeVO.classID}">
				<input type="hidden" name="classNum" value="${classListVO.classNum}">
				<input type="button" value="取消" onclick="javascript:history.back();"
					style="width: 33%">
				</td>
				</tr>
			</table>
		</form>
	</fieldset>
</body>
</html>

