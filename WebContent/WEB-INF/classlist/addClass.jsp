<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.classlist.model.ClassListService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增班級</title>
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
.step {
	position: absolute;
	top: 85px;
	width: 220px;
	margin-left: 25%;
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
	width: 300px;
	text-align: left;
	border: 0;
	padding: 10px;
	margin: 40px 50%;
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
	left: 10px;
	top: -11px;
	font-family: "微軟正黑體";
}

tr {
	width: 100%;
	text-align: left;
	font-family: "微軟正黑體";
}

th {
	width: 100px;
}

td {
	font-family: "微軟正黑體";
}

input[type=checkbox] {
	width: 20px;
	height: 15px;
	font-family: "微軟正黑體";
	margin-top: 10px; 
	margin-bottom: 5px;
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

 
 form{
 color:black;
}
 
</style>
<script>
	function backClass() {
		jQuery("#back").submit();
	}

	function changed(x) {
		var path = "${pageContext.request.contextPath}/classlist/ClassView";
		var classID = x.value;
		sendPostRequest(path, classID);
	}

	var xmlhttp = null;
	function sendPostRequest(path, classID) {
		xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange = callback;
		xmlhttp.open("POST", path);
		xmlhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		xmlhttp.send("classID=" + classID + "&action=searchOne");
	}

	function callback() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				processJSON(xmlhttp.responseText);
			}
		}
	}

	function processJSON(text) {
		var array = eval(text);
		if (array[0].hasMoreData) {
			document.getElementsByName("className")[0].value = array[1].className;
			document.getElementsByName("classNum")[0].value = array[1].classNum + 1;
			document.getElementsByName("craftID")[0].value = array[1].craftID;
			document.getElementsByName("craftType")[0].value = array[1].craftType;
			document.getElementsByName("deptID")[0].value = array[1].deptID;
			document.getElementsByName("deptName")[0].value = array[1].deptName;
		}
	}
	function clearMsg() {
		$("#spanID").empty();
	}
	function resetSearch() {
		jQuery(
				'select[name="classID"],[name="className"],[name="classNum"]'
						+ ',[name="craftID"],[name="craftType"],[name="deptID"],'
						+ '[name="deptName"],[name="startDate"],[name="endDate"],'
						+ '[name="maxNum"]').val(null);
		jQuery("input[name=classSchedule]").prop("checked", false);

		jQuery("#spanID,#spanID1,#spanID2,#spanID3,#spanID4").empty();
	}
	function clearme() {
		$("#spanID3").empty();
	}
</script>

</head>
<body style="background: url(${pageContext.request.contextPath}/images/tweed.png);">
    <div class=sidebar style="z-index:2"> <%@ include file="/WEB-INF/fragment/sidebar.jsp"%></div>
	<div><%@ include file="/WEB-INF/fragment/Top.jsp"%></div>

	<div class="step">
	<div style="font-size: 16px; padding-bottom:10px;font-family: Georgia;font-style: italic;"><span>How To Use：</span></div>
		<div>
			<i class="fa fa-code-fork fa-2x" style="color: #5599FF;vertical-align: middle;"></i> <span>選擇欲新增的班級代號</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div style="vertical-align: middle;">
			<i class="fa fa-calendar-o fa-2x" style="color: #5599FF;vertical-align: middle;"></i> <span>選擇開訓日期</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
				<div style="vertical-align: middle;">
			<i class="fa fa-calendar-o fa-2x" style="color: #5599FF;vertical-align: middle;"></i> <span>選擇結訓日期</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div>
			<i class="fa fa-users fa-2x" style="color: #5599FF;vertical-align: middle;"></i> <span>輸入開課上限人數</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div>
			<i class="fa fa-check-square-o fa-2x" style="color: #5599FF;vertical-align: middle;"></i> <span>選擇開課日期</span>
		</div>
	</div>
	<fieldset>
		<legend align="left">新增班級</legend>
		<form method="post" class="classview"
			action="${pageContext.request.contextPath}/classlist/ClassView">
			<table>
				<jsp:useBean id="classTypeSvc"
					class="com.classtype.model.ClassTypeService" />
				<tr>
					<th>班級代號：</th>
					<td><select name="classID" onchange="changed(this)"
						onclick="clearMsg()">
							<option value="">請選擇</option>
							<c:forEach var="classTypeVO" items="${classTypeSvc.allClassType}">
								<option ${param.classID==classTypeVO.classID?'selected':""}
									value="${classTypeVO.classID}">${classTypeVO.classID}</option>
							</c:forEach>
					</select><span id="spanID" style="color: red">${msg.className}</span></td>
				</tr>
				<tr>
					<th>班級名稱：</th>
					<td><input type="text" name="className"
						value="${param.className}" readonly></td>
				</tr>
				<tr>
					<th>班級期別：</th>
					<td><input type="text" name="classNum"
						value="${param.classNum}" readonly></td>
				</tr>
				<tr>
					<th>機種代號：</th>
					<td><input type="text" name="craftID" value="${param.craftID}"
						readonly></td>
				</tr>
				<tr>
					<th>機種類型：</th>
					<td><input type="text" name="craftType"
						value="${param.craftType}" readonly></td>
				</tr>
				<tr>
					<th>訓練單位：</th>
					<td><input type="text" name="deptID" value="${param.deptID}"
						readonly style="width: 20px" id="deptID"> <input
						type="text" name="deptName" value="${param.deptName}" readonly
						style="width: 143px"></td>
				</tr>
				<tr>
					<th>開訓日期：</th>
					<td><input type="text" name="startDate"
						value="${param.startDate}" class="dtp" readonly placeholder="選擇日期"><span
						id="spanID1" style="color: red"><br>${msg.startDate}</span></td>

				</tr>
				<tr>
					<th>結訓日期：</th>
					<td><input type="text" name="endDate" value="${param.endDate}"
						class="dtp" readonly placeholder="選擇日期"><span id="spanID2"
						style="color: red"><br>${msg.endDate}${msg.lessDate}</span></td>
				</tr>
				<tr>
					<th>開課人數：</th>
					<td><input type="text" name="maxNum" value="${param.maxNum}"
						onfocus="clearme()"><span id="spanID3" style="color: red"><br>${msg.notNum}</span></td>
				</tr>
				<tr>
					<th>上課時間：</th>
					<td><input type="checkbox" name="classSchedule" value="一">一
						<input type="checkbox" name="classSchedule" value="二">二 <input
						type="checkbox" name="classSchedule" value="三">三 <input
						type="checkbox" name="classSchedule" value="四">四 <input
						type="checkbox" name="classSchedule" value="五">五 <input
						type="checkbox" name="classSchedule" value="六">六 <input
						type="checkbox" name="classSchedule" value="日">日<span
						id="spanID4" style="color: red"><br>${msg.weeks}</span></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="送出"
						style="width: 33%"><input type="button" value="重新填寫"
						style="width: 34%" onclick="resetSearch()"><input
						type="button" value="取消" onclick="backClass()" style="width: 33%"></td>
				</tr>
			</table>
			<input type="hidden" name="action" value="previewAdd">
		</form>
	</fieldset>
	<script>
		jQuery(".dtp").datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : "yy-mm-dd",
			minDate : '+7d'
		});
	</script>
	<script>
		jQuery('.dtp').click(function() {
			$("#spanID1,#spanID2").empty();
		});
		jQuery('[name="classSchedule"]').click(function() {
			$("#spanID4").empty();
		});
	</script>
	<form method="post" id="back"
		action="${pageContext.request.contextPath}/classlist/ClassView">
	</form>
</body>
</html>