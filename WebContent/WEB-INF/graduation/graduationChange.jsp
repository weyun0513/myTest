<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>變更訓練期別</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/mqtt.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout.css">
<style>
table {
	background-color: rgba(163,167,171, 0.4);
	width: 90%;
	margin: auto;
	margin-top: 20px;
}

th {
	padding: 6px;
	color: white;
}

table,td {

	font-family: "微軟正黑體";
	color: white;
	text-align: center;
	vertical-align: middle;
	padding: 7px;
	border-collapse: collapse;
	font-size: medium;
}

td {
	height: 30px;
}

tr:hover
{ 
background-color:rgba(227,228,229, 0.1);
}

.tabs {
	background-color: rgba(66, 125, 164, 0.9);
}
</style>
<div class=sidebar style="z-index:2"> <%@ include file="/WEB-INF/fragment/sidebar.jsp"%></div>
<div><%@ include file="/WEB-INF/fragment/Top.jsp"%></div>
<script>
	function showDialog(ID, Num) {
		$(function() {
			//		alert(ID);
			//		alert(Num);
			$("#dialog-confirm").text(
					"將把${registerVO.pilotVO.pilotID}/${registerVO.pilotVO.pilotName}報名資訊自"
							+ classID_classNum + "變更至" + ID + Num + "。是否確定？");
			$("#dialog-confirm")
					.dialog(
							{
								modal : true,
								draggable : false,
								resizable : false,
								buttons : {
									是 : function() {
										$('#myForm')
												.append(
														'<input type="hidden" name="pilotID" value="${registerVO.pilotVO.pilotID}">'
																+ '<input type="hidden" name="classID_classNum" value="'+classID_classNum+'">'
																+ '<input type="hidden" name="classID" value="'+ID+'">'
																+ '<input type="hidden" name="classNum" value="'+Num+'">'
																+ '<input type="hidden" name="action" value="goReg2">');
										$('#myForm').submit();
									},
									否 : function() {
										$(this).dialog("close");
									}
								}
							});
		});
	}
	var sysTime;
	function getSysTime() {
		var now = new Date(sysTime);
		sysTime += 50;
		var year = now.getFullYear();
		var month = now.getMonth() + 1;
		var date = now.getDate();
		var hour = now.getHours();
		var minute = now.getMinutes();
		var second = now.getSeconds();

		function changeType(type) {
			return (type < 10) ? "0" + type : "" + type;
		}

		jQuery('#time').text(
				'系統時間：' + changeType(year) + '-' + changeType(month) + '-'
						+ changeType(date) + ' ' + changeType(hour) + ':'
						+ changeType(minute) + ':' + changeType(second));
	}

	jQuery(document).ready(function() {
		var data1 = '${craftID}';
		var data2 = '${OldclassIDclassNum}';
		if (data1 != '' && data2 != '') {
<%request.removeAttribute("craftID");%>
	
<%request.removeAttribute("OldclassIDclassNum");%>
	goSearchType(1, 10, data1, data2);
		}
	});

	function changeRowNum(value, craftID, classID_classNum) {
		var index;
		//			alert(value);
		index = (pageNum1 - 1) * rowNum + 1;
		pageNum1 = Math.ceil(index / value);
		rowNum = value;
		goSearchType(pageNum1, rowNum, craftID, classID_classNum);
	}
	//		var craftType;
	var xmlhttp = null;

	var classID_classNum;

	function goSearchType(pageNum1, rowNum, craftID, OldclassIDclassNum) {
		//			alert(rowNum);
		var path = "${pageContext.request.contextPath}/ChangeClassServlet";
		xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange = callback;
		xmlhttp.open("POST", path);
		xmlhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		//			alert(pageNum1);		 
		//			alert(craftID);
		classID_classNum = OldclassIDclassNum;
		//			alert(classID_classNum);
		var query = "craftID=" + craftID + "&pageNum1=" + pageNum1 + "&rowNum="
				+ rowNum;
		//			alert(query);
		xmlhttp.send(query);
	}

	function callback() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				processJSON(xmlhttp.responseText);
			}
		}
	}

	var pageNum1;
	var rowNum;
	var intervalID;
	var craftID;
	function processJSON(text) {
		var array = eval(text);

		if (array[0].hasMoreData) {
			clearInterval(intervalID);
			sysTime = array[1].sysTime;
			intervalID = setInterval("getSysTime()", 50);
			pageNum1 = array[1].pageNum1;

			rowNum = array[1].rowNum;
			var content = "";
			var count = array[1].count;
			var totalPage = array[1].totalPage;

			jQuery('#tabs').empty();
			document.getElementById("tabs").style.display = "block";

			content += '<table class="tabs"><tr><th>班級代號/期別</th><th>名稱</th><th>班級狀態</th><th>開訓日期</th>'
					+ '<th>結訓日期</th><th>開課人數</th><th>報名人數</th><th>上課時間</th></tr>';
			for (var i = 2; i < array.length; i++) {
				craftID = array[i].craftID;
				var craftType = array[i].craftType;
				var classID = array[i].classID;
				var classNum = array[i].classNum;
				var classStatus = array[i].classStatus;
				var startDate = array[i].startDate;
				var endDate = array[i].endDate;
				var maxNum = array[i].maxNum;
				var regNum = array[i].regNum;
				var classSchedule = array[i].classSchedule;

				content += '<td>' + classID + classNum + '</td><td>'
						+ craftType + '</td><td>' + classStatus + '</td><td>'
						+ startDate + '</td><td>' + endDate + '</td><td>'
						+ maxNum + '</td>';

				if (maxNum > regNum && classStatus == ("開放報名")) {
					content += '<td>'
							+ regNum
							+ ' '
							+ '<input type="image" src="${pageContext.request.contextPath}/images/icon/reg_on.png" value="報名"  align="right" '
							+ ' onclick="showDialog(\''
							+ classID
							+ '\','
							+ classNum
							+ ');"><input type="hidden" name="classID" value='+classID+'>'
							+ '<input type="hidden" name="classNum" value='+classNum+'>'
							+ '<input type="hidden" name="action" value="goReg">';
				} else {
					content += '<td><form>'
							+ regNum
							+ ' <img src="${pageContext.request.contextPath}/images/icon/reg_off.png"  align="right">';
				}

				content += '</td><td>' + classSchedule + '</td></tr>';
			}//end for

			var pageNum = pageNum1;

			content += '<tr style="height: 50px"><td><font color="red">'
					+ count
					+ '</font>個搜尋結果</td>'
					+ '<td>第<font color="red">'
					+ pageNum
					+ '</font>頁/共'
					+ totalPage
					+ '頁</td>'
					+ '<td><img src="${pageContext.request.contextPath}/images/icon/first.png" value="第一頁" onclick="goSearchType(';

			var pageType1 = 1;

			content += pageType1
					+ ','
					+ rowNum
					+ ','
					+ craftID
					+ ',\''
					+ classID_classNum
					+ '\')"></td><td>'
					+ '<img src="${pageContext.request.contextPath}/images/icon/previous.png" value="上一頁" onclick="goSearchType(';

			pageType1 = pageNum1 - 1;
			content += pageType1 + ',' + rowNum + ',' + craftID + ',\''
					+ classID_classNum + '\')"></td><td>';

			var begin = ((pageNum - 3) > 1 ? (totalPage - pageNum) > 3 ? pageNum - 3
					: totalPage - 6
					: 1);
			var end = pageNum + 3 < totalPage ? ((pageNum - 3) > 1 ? pageNum + 3
					: 7)
					: totalPage;

			for (var page = begin; page <= end; page++) {
				pageType1 = page;

				content += ' <a href="javascript:goSearchType(' + pageType1
						+ ',' + rowNum + ',' + craftID + ',\''
						+ classID_classNum + '\')">' + page + '</a>';
			}

			content += '</td><td><img src="${pageContext.request.contextPath}/images/icon/next.png" value="下一頁" onclick="goSearchType(';

			pageType1 = pageNum1 + 1;

			content += pageType1
					+ ','
					+ rowNum
					+ ','
					+ craftID
					+ ',\''
					+ classID_classNum
					+ '\')"></td><td>'
					+ '<img src="${pageContext.request.contextPath}/images/icon/last.png" value="最末頁" onclick="goSearchType(';

			pageType1 = totalPage;

			content += pageType1 + ',' + rowNum + ',' + craftID + ',\''
					+ classID_classNum
					+ '\')"></td><td>每頁顯示&nbsp;<select name="rowNum"'
					+ ' onchange="changeRowNum(this.value,craftID,\''
					+ classID_classNum
					+ '\')"><option value="10" >10</option><option value="20" ';
			var selected = (rowNum == 20) ? "selected" : "";

			content += selected + '>20</option><option value="30" ';

			selected = (rowNum == 30) ? "selected" : "";
			content += selected
					+ '>30</option></select>&nbsp;筆</td></tr></table>';

			jQuery('#tabs').append(content);
		}
	}

	jQuery(function() {
		jQuery("#tabs").tabs();

	});
</script>



</head>
<body
	style="background:url(${pageContext.request.contextPath}/images/tweed.png);">
	<table border='1' cellspacing='0' >
		<tr>
			<!-- 			<th>變更訓練期別</th> -->
			<th>報名流水號</th>
			<th>身份證號碼</th>
			<th>姓名</th>
			<th>可駕駛機種</th>
			<th>訓練日期</th>
			<th>訓練有效日期</th>
			<th>訓練單位名稱</th>
			<th>班級期別</th>
			<th>報名日期</th>
			<th>訓練建立人員</th>
			<th>備註</th>
		</tr>

		<tr align='center' valign='middle'>
			<!-- 			<td> -->
			<%-- 			<input type="button" value="變更訓練期別" onclick="goSearchType(1,10,${registerVO.classListVO.classTypeVO.aircraftVO.craftID},'${registerVO.classListVO.classTypeVO.classID}${registerVO.classListVO.classNum}')"> --%>
			<!-- 			</td> -->
			<td>${registerVO.regID}</td>
			<td>${registerVO.pilotVO.pilotID}</td>
			<td>${registerVO.pilotVO.pilotName}</td>
			<td>${registerVO.classListVO.classTypeVO.aircraftVO.craftType}</td>
			<td>未上課</td>
			<td>未上課</td>
			<td>${registerVO.classListVO.trainDeptVO.deptName}</td>
			<td>${registerVO.classListVO.classTypeVO.classID}${registerVO.classListVO.classNum}</td>
			<td><fmt:formatDate value="${registerVO.regDate}"
					pattern="yyyy/MM/dd HH:mm:ss" /></td>
			<td>${registerVO.classListVO.managerVO.managerAccnt}</td>
			<td>${registerVO.notes}</td>
		</tr>

	</table>

	<h3 id="time" align="center" style="color: white; padding: 10px;"></h3>
	<div id="tabs" style="display: none; background: rgba(0, 0, 0, 0); border:0px; margin-top:-20px;"></div>

	<div id="dialog-confirm" title="變更期別確認"></div>

	<form action="${pageContext.request.contextPath}/classlist/ClassView"
		method="post" id="myForm"></form>

</body>
</html>