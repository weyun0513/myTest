<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.classlist.model.ClassListService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增班級預覽</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
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

<style type="text/css">
.unchanged {
	background-color: #FFEE99
}
 
p, form{
 color:black;
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
	-webkit-box-shadow: 0px 0px 38px 0px rgba(0,0,0,0.75);
	-moz-box-shadow: 0px 0px 38px 0px rgba(0,0,0,0.75);
	box-shadow: 0px 0px 38px 0px rgba(0,0,0,0.75);
	font-family: "微軟正黑體";
	color:black
}

fieldset {
	width: 330px;
	text-align: left;
	border: 0;
	padding: 10px;
	padding-left:1px;
	margin: 40px 650px;
	border-radius: 8px;
	-moz-border-radius: 8px;
	-webkit-border-radius: 8px;
	background: #FFF;
	-webkit-box-shadow: 0px 0px 38px 0px rgba(0,0,0,0.75);
	-moz-box-shadow: 0px 0px 38px 0px rgba(0,0,0,0.75);
	box-shadow: 0px 0px 38px 0px rgba(0,0,0,0.75);
	font-family: "微軟正黑體";
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
	margin-left: 20px;
	top: -11px;
	font-family: "微軟正黑體";
}

tr {
	width: 100%;
	text-align: left;
}

th {
	text-align: right;
}

td {
	width: 55%;
	font-family: "微軟正黑體";
}
input[type=text]{
	margin-top: 10px; 
	margin-bottom: 5px;
	width: 180px;
	height: 20px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	border: 1px solid #ccc;
	padding: 5px;
}
</style>

</head>
<body style="background: url(${pageContext.request.contextPath}/images/tweed.png);">
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
		<div style="vertical-align: middle;">
			<span>確認後送出</span>
		</div>
	</div>
	<fieldset>
		<legend align="left">預覽新增</legend>
		<form method="post"
			action="${pageContext.request.contextPath}/classlist/Class.do">
			<table>
				<tr>
					<th>班級代號：</th>
					<td><input type="text" name="classID" value="${param.classID}"
						readonly class="unchanged"></td>
				</tr>
				<tr>
					<th>班級名稱：</th>
					<td><input type="text" name="className"
						value="${param.className}" readonly class="unchanged"></td>
				</tr>
				<tr>
					<th>班級期別：</th>
					<td><input type="text" name="classNum"
						value="${param.classNum}" readonly class="unchanged"></td>
				</tr>
				<tr>
					<th>機種代號：</th>
					<td><input type="text" name="craftID" value="${param.craftID}"
						readonly class="unchanged"></td>
				</tr>
				<tr>
					<th>機種類型：</th>
					<td><input type="text" name="craftType"
						value="${param.craftType}" readonly class="unchanged"></td>
				</tr>
				<tr>
					<th>訓練單位：</th>
					<td><input type="text" name="deptID" value="${param.deptID}"
						readonly style="width: 18px" id="deptID" class="unchanged">
						<input type="text" name="deptName" value="${param.deptName}"
						readonly style="width: 143px" class="unchanged"></td>
				</tr>
				<tr>
					<th>開訓日期：</th>
					<td><input type="text" name="startDate"
						value="${param.startDate}" readonly class="unchanged"></td>

				</tr>
				<tr>
					<th>結訓日期：</th>
					<td><input type="text" name="endDate" value="${param.endDate}"
						readonly class="unchanged"></td>
				</tr>
				<tr>
					<th>開課人數：</th>
					<td><input type="text" name="maxNum" value="${param.maxNum}"
						readonly class="unchanged"></td>
				</tr>
				<tr>
					<th>上課時間：</th>
					<td><input type="text" name="classSchedule"
						value="${classSchedule}" readonly class="unchanged"></td>
				</tr>
				<tr>
					<th style="width: 90px;">班級建立人員：</th>
					<td><input type="text" name="managerAccnt"
						value="${managerVO.managerAccnt}" readonly class="unchanged"></td>
				</tr>
				<tr>
					<th></th>
					<td colspan="2"><input type="submit" value="送出"
						style="width: 49%"><input type="button" value="取消"
						onclick="history.back()" style="width: 49%"></td>
				</tr>
			</table>
			<input type="hidden" name="action" value="addClass">
		</form>
	</fieldset>

</body>
</html>