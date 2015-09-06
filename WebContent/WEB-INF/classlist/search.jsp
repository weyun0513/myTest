<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
table {
	width: 90%;
	table-layout: fixed;
	margin: auto;
}

td {
	vertical-align: middle;
	text-align: center;
	border-collapse: collapse;
	font-size: medium;
	font-family: "微軟正黑體";
	font-weight: bold;
	border-collapse: collapse;
}

p {
	color: #CC0000;
}

th {
	font-size: large;
	height: 50px;
	vertical-align: middle;
}

.tab {
	background-color: rgba(255, 255, 255, 0.7);
}

body {
	background:
		url("${pageContext.request.contextPath}/images/photography.png")
		repeat;
}

tr:hover {
	background-color: rgba(20, 20, 20, 0.1)
}

.step {
	position: absolute;
	width: 300px;
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
	color: black;
}
</style>
<script>
	function changed(x) {
		var path = "${pageContext.request.contextPath}/classlist/ClassView";
		var classID = x.value;
		sendPostRequest(path, classID);
	}
	var xmlhttp = null;
	function sendPostRequest(path, classID) {
		xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange = myCraft;
		xmlhttp.open("POST", path);
		xmlhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		xmlhttp.send("classID=" + classID + "&action=searchOne");
	}

	function myCraft() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				processJSON1(xmlhttp.responseText);
			}
		}
	}
	function processJSON1(text) {
		var array = eval(text);
		if (array[0].hasMoreData)
			document.getElementsByName("craftID")[0].value = array[1].craftID;
	}
	function resetCraftID() {
		jQuery('#classID').val(null);
	}
</script>
<div class="step" style="display:none; margin: 10% 28%;">
	<div
		style="font-size: 16px; padding-bottom: 10px; font-family: Georgia; font-style: italic;">
		<span>How To Use：</span>
	</div>
	<div>
		<i class="fa fa-code-fork fa-2x"
			style="color: #5599FF; vertical-align: middle;"></i><span>直接搜尋</span>&nbsp;&nbsp;&nbsp;&nbsp;or
	</div>
	<div>
		<i class="fa fa-code-fork fa-2x"
			style="color: #5599FF; vertical-align: middle;"></i> <span>選擇班級代號或機種類型</span>
	</div>
	<div>
		<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
	</div>

	<div style="vertical-align: middle;">
		<i class="fa fa-calendar-o fa-2x"
			style="color: #5599FF; vertical-align: middle;"></i> <span>選擇開訓或結訓日期搜尋班級</span>
	</div>
	<div>
		<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
	</div>
	<div style="vertical-align: middle;">
		<i class="fa fa-pencil-square-o fa-2x"
			style="color: #5599FF; vertical-align: middle;"></i><span>進行班級異動流程</span>
	</div>
</div>
<div class="step" style="display:none; margin: 30% 28% 0 28%;">
	<div>
		<i class="fa fa-code-fork fa-2x"
			style="color: #5599FF; vertical-align: middle;"></i> <span>選擇『未開訓』區，進行班級異動</span>
	</div>
	<div>
		<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
	</div>

	<div style="vertical-align: middle;">
		<span>選擇&nbsp;&nbsp;<img style="vertical-align: middle;" src="${pageContext.request.contextPath}/images/edit_property-26.png">&nbsp;&nbsp;按鈕，進行編輯</span>
	</div>
	or<br>
	<div>
		<span>選擇&nbsp;&nbsp;<img style="vertical-align: middle;" src="${pageContext.request.contextPath}/images/delete-26.png">&nbsp;&nbsp;按鈕，刪除該班級</span>
	</div>
	or<br>
	<div>
		<span>選擇&nbsp;&nbsp;<img style="vertical-align: middle;" src="${pageContext.request.contextPath}/images/icon/reg_on.png">&nbsp;&nbsp;按鈕，報名該班級</span>
	</div>
	or<br>
	<div>
		<span>選擇&nbsp;&nbsp;<img style="vertical-align: middle;" src="${pageContext.request.contextPath}/images/show_property-26.png">&nbsp;&nbsp;按鈕，檢視該班級資訊</span>
	</div>
	or<br>
	<div>
		<span>選擇&nbsp;&nbsp;<img style="vertical-align: middle;" src="${pageContext.request.contextPath}/images/excel_logo-26.png">&nbsp;&nbsp;按鈕，將報名表匯出</span>
	</div>
	or<br>
	<div style="vertical-align: middle;">
		<i class="fa fa-pencil-square-o fa-2x"
			style="color: #5599FF; vertical-align: middle;"></i><span>選擇『已開訓』區</span>
	</div>
</div>
<div class="step" style="display:none; margin: 10% 0% 0 55%;">
	<div>
		<span>選擇&nbsp;&nbsp;<img style="vertical-align: middle;" src="${pageContext.request.contextPath}/images/show_property-26.png">&nbsp;&nbsp;按鈕，檢視該班級資訊</span>
	</div>
	or<br>
	<div>
		<span>選擇&nbsp;&nbsp;<img style="vertical-align: middle;" src="${pageContext.request.contextPath}/images/excel_logo-26.png">&nbsp;&nbsp;按鈕，將報名表匯出</span>
	</div>
	or<br>
	<div style="vertical-align: middle;">
		<i class="fa fa-pencil-square-o fa-2x"
			style="color: #5599FF; vertical-align: middle;"></i><span>選擇『已結訓』區</span>
	</div>
</div>
<div class="step" style="display:none; margin: 25% 0% 0 55%;">
	<div>
		<span>選擇&nbsp;&nbsp;<img style="vertical-align: middle;" src="${pageContext.request.contextPath}/images/show_property-26.png">&nbsp;&nbsp;按鈕，檢視該班級資訊</span>
	</div>
	or<br>
	<div>
		<span>選擇&nbsp;&nbsp;<img style="vertical-align: middle;" src="${pageContext.request.contextPath}/images/excel_logo-26.png">&nbsp;&nbsp;按鈕，將報名表匯出</span>
	</div>
		or<br>
	<div>
		<span>選擇&nbsp;&nbsp;<img style="vertical-align: middle;" src="${pageContext.request.contextPath}/images/excel_logo2-26.png">&nbsp;&nbsp;按鈕，將結訓表匯入</span>
	</div>
</div>
<form id="search"
	action="<%=request.getContextPath()%>/classlist/ClassView"
	method="post">
	<jsp:useBean id="classTypeSvc"
		class="com.classtype.model.ClassTypeService" />
	<table style="width: 100%">
		<tr>
			<td colspan="2">班級代號：<select name="classID" id="classID"
				onchange="changed(this)" style="width: 35%">
					<option value="">請選擇</option>
					<c:forEach var="classTypeVO" items="${classTypeSvc.allClassType}">
						<option value="${classTypeVO.classID}"
							${sessionScope.pageInfo.classID==classTypeVO.classID?"selected":""}>
							${classTypeVO.classID}</option>
					</c:forEach>
			</select></td>
			<jsp:useBean id="aircraftSvc"
				class="com.aircraft.model.AircraftService" />
			<td colspan="2">機種類型：<select name="craftID"
				onchange="resetCraftID()" style="width: 62%">
					<option value="">請選擇</option>
					<c:forEach var="aircraftVO" items="${aircraftSvc.allAircraft}">
						<option value="${aircraftVO.craftID}"
							${pageInfo.craftID==aircraftVO.craftID?"selected":""}>
							${aircraftVO.craftType}</option>
					</c:forEach>
			</select>
			</td>
			<td colspan="3">開訓日期：<input type="text" name="startDate1"
				size=8 style="width: 25%" class="cal" value="${pageInfo.startDate1}"
				readonly placeholder="請選擇日期"> ～&nbsp;&nbsp;<input
				type="text" name="startDate2" size=8 style="width: 25%" class="cal"
				value="${pageInfo.startDate2}" readonly placeholder="請選擇日期"></td>
			<td colspan="3">結訓日期：<input type="text" name="endDate1" size=8
				style="width: 25%" class="cal" value="${pageInfo.endDate1}" readonly
				placeholder="請選擇日期"> ～&nbsp;&nbsp;<input type="text"
				name="endDate2" size=8 style="width: 25%" class="cal"
				value="${pageInfo.endDate2}" readonly placeholder="請選擇日期"></td>
			<td colspan="2"><input type="button" value="查詢"
				style="width: 40%" onclick="goSearch()"> <input
				type="button" id="reset" value="清除" style="width: 40%"
				onclick="resetSearch()"></td>
		</tr>
	</table>
</form>
