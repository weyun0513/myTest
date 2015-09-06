<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>變更班級內容</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
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
	-webkit-box-shadow: 0px 0px 38px 0px rgba(0,0,0,0.75);
	-moz-box-shadow: 0px 0px 38px 0px rgba(0,0,0,0.75);
	box-shadow: 0px 0px 38px 0px rgba(0,0,0,0.75);
	font-family: "微軟正黑體";
}

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
	-webkit-box-shadow: 0px 0px 38px 0px rgba(0,0,0,0.75);
	-moz-box-shadow: 0px 0px 38px 0px rgba(0,0,0,0.75);
	box-shadow: 0px 0px 38px 0px rgba(0,0,0,0.75);
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
	font-family: "微軟正黑體";
}

input[type=text] {
	margin-top: 20px; 
	width: 200px;
	height: 5px;
	padding: 10px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	border: 1px solid #ccc;
}

td {
	width: 70%;
	text-align: left;
	font-family: "微軟正黑體";
}

p {
	color: #CC0000;
	font-family: "微軟正黑體";
}
</style>
<!--2014.07.31這裡 -->
<script type="text/javascript">
	function pauseAdd() {
		var classStatus = "${classListVO.classStatus}";
		var regNum = "${sessionScope.classListVO.regNum}";
		if (classStatus == "暫停報名" && regNum != 0) {
			jQuery("#pauseDialog").empty();
			jQuery("#pauseDialog").append(
					'<p>本班級已經暫停報名，且已有飛行員完成報名' + '是否要繼續進行班級的報名管理作業？</p>');
			jQuery("#pauseDialog").dialog("open");
		} else
			jQuery("#form1").submit();
	}
</script>
</head>
<body style="background:url(${pageContext.request.contextPath}/images/tweed.png);">
	<div><%@ include file="/WEB-INF/fragment/Top.jsp"%></div>
		<div class="step">
	<div style="font-size: 16px; padding-bottom:10px;font-family: Georgia;font-style: italic;">How To Use：</div>
		<div>
			<i class="fa fa-lightbulb-o fa-2x" style="color: #FFCC22;vertical-align: middle;"></i> <span>檢查資料是否正確</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div style="vertical-align: middle;">
		<span>確認後送出</span>
		</div>
		</div>
	<fieldset>
		<legend align="left">預覽編輯</legend>
		<form method="post" id='form1'
			action="${pageContext.request.contextPath}/classlist/Class.do">
			<table>
				<tr>
					<th>班級代號：</th>
					<td><input type="text" name="classID"
						value="${classListVO.classTypeVO.classID}" readonly
						class="unchanged"></td>
				</tr>
				<tr>
					<th>班級期別：</th>
					<td><input type="text" name="classNum"
						value="${classListVO.classNum}" readonly class="unchanged"></td>
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
					<td><input type="text" name="startDate"
						value="${classListVO.startDate}" readonly class="unchanged"></td>
				</tr>
				<tr>
					<th>結訓日期：</th>
					<td><input type="text" name="endDate"
						value="${classListVO.endDate}" readonly class="unchanged"></td>
				</tr>
				<tr>
					<th>開課人數：</th>
					<td><input type="text" name="maxNum"
						value="${classListVO.maxNum}" readonly class="unchanged"><br>
				</tr>
				<tr>
					<th>報名人數：</th>
					<td><input type="text" name="regNum"
						value="${sessionScope.classListVO.regNum}" readonly
						class="unchanged"><br>
				</tr>
				<tr>
					<th>上課時間：</th>
					<td><input type="text" name="classSchedule"
						value="${classListVO.classSchedule}" readonly class="unchanged"></td>
				</tr>
				<tr>
					<th>開課狀態：</th>
					<td><input type="text" name="classStatus"
						value="${classListVO.classStatus}" readonly class="unchanged"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" value="確定"
						onclick="pauseAdd()" style="width: 48%"> <input
						type="hidden" name="deptID"
						value="${classListVO.trainDeptVO.deptID}"> <input
						type="hidden" name="action" value="updateClass"> <!--轉交到updateClass -->
						<input type="button" value="繼續修改" onclick="history.back()"
						style="width: 46%"></td>
				</tr>
			</table>
		</form>
		<form id="form2" method="post"
			action="${pageContext.request.contextPath}/register/register.view">
			<input type="hidden" name="classID"
				value="${classListVO.classTypeVO.classID}"> <input
				type="hidden" name="classNum" value="${classListVO.classNum}">
			<input type="hidden" name="action" value="viewRegister">
		</form>
		<form id="form3" method="post"
			action="${pageContext.request.contextPath}/classlist/ClassView">
		</form>
	</fieldset>
	<script type="text/javascript">
		jQuery(function() {
			jQuery("#pauseDialog").dialog({
				autoOpen : false,
				draggable : false,
				resizable : false,
				height : 310,
				modal : true,
				title : "系統訊息",
				buttons : {
					"確定" : function() {
						jQuery(this).dialog("close");
						jQuery("#form2").submit();
					},
					"取消" : function() {
						jQuery(this).dialog("close");
						jQuery("#form3").submit();
					}
				}
			});
		});
	</script>
	<div id="pauseDialog"></div>

</body>
</html>