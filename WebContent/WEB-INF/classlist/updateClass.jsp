<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css">
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
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
<style type="text/css">
.unchanged {
	background-color: #FFEE99
}

.step {
	position: absolute;
	top: 80px;
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

.div {
	margin: 0 auto;
	text-align: center;
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
	font-family: "微軟正黑體";
	top: -11px;
}
span , tr{color:black}
th {
	width: 100px;
}

td {
	text-align: left;
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

input[type=checkbox] {
	width: 20px;
	height: 15px;
	font-family: "微軟正黑體";
	margin-top: 10px; 
	margin-bottom: 5px;
}
</style>
<script>
	jQuery(function() {
		jQuery(".cal").datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : "yy-mm-dd",
			minDate : '+7d'
		});

	});
	function resetSearch() {
		jQuery('[name="startDate"],[name="endDate"],[name="maxNum"]').val(null);

		jQuery("#spanID,#spanID1,#spanID2,#spanID3,#spanID4").empty();
		jQuery("input[name=classSchedule]").prop("checked", false);
	}
	function clearme() {
		$("#spanID2,#spanID3").empty();
	}

	function goBack() {
		jQuery('#back').submit();
	}
</script>
</head>
<body style="background: url(${pageContext.request.contextPath}/images/tweed.png);">
 <div class=sidebar style="z-index:2"> <%@ include file="/WEB-INF/fragment/sidebar.jsp"%></div>
	<div><%@ include file="/WEB-INF/fragment/Top.jsp"%></div>
	<div class="step">
		<div
			style="font-size: 16px; padding-bottom: 10px; font-family: Georgia; font-style: italic;"><span>How
			To Use：</span></div>
		<div>
			<i class="fa fa-pencil-square-o fa-2x"
				style="color: #5599FF; vertical-align: middle;"></i> <span>確認欲修改的班級</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div style="vertical-align: middle;">
			<i class="fa fa-calendar-o fa-2x"
				style="color: #5599FF; vertical-align: middle;"></i> <span>選擇開訓日期</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div style="vertical-align: middle;">
			<i class="fa fa-calendar-o fa-2x"
				style="color: #5599FF; vertical-align: middle;"></i> <span>選擇結訓日期</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div>
			<i class="fa fa-users fa-2x"
				style="color: #5599FF; vertical-align: middle;"></i> <span>輸入開課上限人數</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div>
			<i class="fa fa-hand-o-right fa-2x"
				style="color: #5599FF; vertical-align: middle;"></i> <span>確認已報名人數</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div>
			<i class="fa fa-check-square-o fa-2x"
				style="color: #5599FF; vertical-align: middle;"></i> <span>選擇開課日期</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div>
			<i class="fa fa-gavel fa-2x"
				style="color: #5599FF; vertical-align: middle;"></i> <span>選擇是否暫停報名</span>
		</div>
	</div>

	<div class="div">
		<fieldset>
			<legend align="left">班級異動</legend>
			<!-- 執行ClassViewServlet action 的方法--regPreview從資料庫撈出資料 -->
			<form method="post"
				action="${pageContext.request.contextPath}/classlist/ClassView">
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
						<td colspan="2"><input type="text" name="className"
							value="${classListVO.classTypeVO.className}" readonly
							class="unchanged"></td>
					</tr>
					<tr>
						<th>機種類型：</th>
						<td><input type="text" name="craftType"
							value="${classListVO.classTypeVO.aircraftVO.craftType}" readonly
							class="unchanged"></td>
					</tr>
					<tr>
						<th>訓練單位：</th>
						<td><input type="text" name="deptName"
							value="${classListVO.trainDeptVO.deptName}" readonly
							class="unchanged"></td>
					</tr>
					<tr>
						<th>開訓日期：</th>
						<td><input type="text" name="startDate" placeholder="選擇日期"
							readonly value="${classListVO.startDate}" class="cal"><br>
							<span id="spanID" style="color: red">${msg.startDate}${msg.lessDate}</span></td>
					</tr>
					<tr>
						<th>結訓日期：</th>
						<td><input type="text" name="endDate" placeholder="選擇日期"
							readonly value="${classListVO.endDate}" class="cal"><br>
							<span id="spanID1" style="color: red">${msg.endDate}</span></td>
					</tr>
					<tr>
						<th>開課人數：</th>
						<td><input type="text" name="maxNum" placeholder="請輸入數字"
							onfocus="clearme()" value="${classListVO.maxNum}"><span
							id="spanID2" style="color: red"><br>${msg.notNum}</span></td>
					</tr>
					<tr>
						<th>報名人數：</th>
						<td><input type="text"
							value="${sessionScope.classListVO.regNum}" readonly
							class="unchanged"><span id="spanID3" style="color: red">${msg.lessNum}</span></td>
					</tr>
					<tr>
						<!-- 2014.08.01改這裡 -->
						<th>上課時間：</th>
						<!--用增強迴圈取出weeks的值 -->
						<td><c:forEach var="x" items="${weeks}">
								<!--用增強迴圈取出classSchedule的值 -->
								<c:forEach var="y" items="${classSchedule}">
									<!--進行判斷，如果值相等的設定為1 -->
									<c:if test="${x==y}">
										<c:set var="z" value="1" />
									</c:if>
								</c:forEach>
								<!--將判斷後的結果輸出，用EL方式判斷是否checked，並動態加入值-->
								<input type="checkbox" name="classSchedule" ${z==1?'checked':''}
									value="${x}">${x}
<!--將z還原成0準備下次比對 -->
								<c:set var="z" value="0" />
							</c:forEach><span id="spanID4" style="color: red"><br>${msg.classSchedule}</span></td>

					</tr>
					<tr>
						<th colspan="2" align="left">暫停報名：<input type="checkbox"
							name="classStatus" value="暫停報名"
							${classListVO.classStatus=='暫停報名'?'checked':''}
							style="width: 50%"></th>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="確認修改"
							style="width: 32%"> <input type="hidden" name="action"
							value="goUpdate"> <!--導向ClassViewServlet的goUpdate方法 --> <input
							type="button" value="重新填寫" style="width: 32%"
							onclick="resetSearch()"> <input type="button" value="取消"
							onclick="goBack()" style="width: 32%"></td>
					</tr>
				</table>
			</form>
		</fieldset>
		<form method="post" id="back"
			action="${pageContext.request.contextPath}/classlist/ClassView">
		</form>
	</div>
	<script>
		jQuery(function() {
			jQuery('[class="ui-datepicker-trigger"]').click(function() {
				$("#spanID,#spanID1").empty();
			});
			jQuery('[name="classSchedule"]').click(function() {
				$("#spanID4").empty();
			});
		});
	</script>
</body>
</html>