<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/jquery-ui-1.10.4.custom.min.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-2.1.1.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-ui-1.10.4.custom.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout.css">
<title>查詢班級列表</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
<style>
table {
	width: 90%;
	table-layout: fixed;
	margin: auto;
	 color:white;
}
th {
	padding: 6px;
}


td {
	vertical-align: middle;
	text-align: center;
}

.tab {
	border-collapse: collapse;
	font-size: medium;
	font-family: "微軟正黑體";
	font-weight: bold;
	width:100%;
	line-height: 68px;
background-color: rgba(0,20,0, 0.7);
}

tr:hover {
	background-color: rgba(227,228,229, 0.1);
}
.sidebar a.menu-icon

{
margin-top:-20px
}

.step {
	position: absolute;
	width: 350px;
	margin:150px 520px;
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
.menu

</style>


<script>
	$(function() {
		$(".cal").datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : "yy-mm-dd",
			yearRange : "2014:2024"
		});
	});
	$(function() {
		$("#startDate2").datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : "yy-mm-dd",
			yearRange : "2014:2024"
		});
	});

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

	//	var startDate1 = $("#startDate1").val();

	function changeRowNum(value) {
		var index;
		//		alert(value);
		index = (pageNum1 - 1) * rowNum + 1;
		pageNum1 = Math.ceil(index / value);
		rowNum = value;
		goSearchType(pageNum1, rowNum);
	}
	//	var craftType;
	var xmlhttp = null;

	function goSearchType(pageNum1, rowNum) {

		//		alert(rowNum);
		var path = "${pageContext.request.contextPath}/ChangeClassServlet";
		xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange = callback;
		xmlhttp.open("POST", path);
		xmlhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		//		alert(pageNum1);		 
		//		alert(startDate1);
		var query = "startDate1=" + $("#startDate1").val() + "&startDate2="
				+ $("#startDate2").val() + "&pageNum1=" + pageNum1 + "&rowNum="
				+ rowNum;
		//		alert(query);
		xmlhttp.send(query);
		
		jQuery('.step').hide();
	}

	function callback() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				processJSON(xmlhttp.responseText);
			}
		}
	}

	function resetSearch() {
		jQuery('#startDate1,#startDate2').val(null);
	}

	var pageNum1;
	var rowNum;
	var intervalID;
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

			content += '<table class="tab"><tr ><th>班級代號/期別</th><th>名稱</th><th>班級狀態</th><th>開訓日期</th>'
					+ '<th>結訓日期</th><th>開課人數</th><th>報名人數</th><th>上課時間</th></tr>';
			for (var i = 2; i < array.length; i++) {
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
					content += '<td><form action="${pageContext.request.contextPath }/classlist/ClassView" method="get">'
							+ regNum
							+ ' '
							+ '<input type="image" src="${pageContext.request.contextPath}/images/icon/reg_on.png" value="報名" align="right">'
							+ '<input type="hidden" name="classID" value='+classID+'>'
							+ '<input type="hidden" name="classNum" value='+classNum+'>'
							+ '<input type="hidden" name="action" value="goReg"></form>';
				} else {
					content += '<td><form>'
							+ regNum
							+ ' <img src="${pageContext.request.contextPath}/images/icon/reg_off.png" align="right"></form>';
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
					+ ')"></td><td><img'
					+ ' src="${pageContext.request.contextPath}/images/icon/previous.png" value="上一頁" onclick="goSearchType(';

			pageType1 = pageNum1 - 1;
			content += pageType1 + ',' + rowNum + ')"></td><td>';

			var begin = ((pageNum - 3) > 1 ? (totalPage - pageNum) > 3 ? pageNum - 3
					: totalPage - 6
					: 1);
			var end = pageNum + 3 < totalPage ? ((pageNum - 3) > 1 ? pageNum + 3
					: 7)
					: totalPage;
			if(begin<=1)begin=1;
			if(end>totalPage) end=totalPage;
			for (var page = begin; page <= end; page++) {
				pageType1 = page;

				content += ' <a href="javascript:goSearchType(' + pageType1
						+ ',' + rowNum + ')">' + page + '</a>';
			}

			content += '</td><td><img src="${pageContext.request.contextPath}/images/icon/next.png" value="下一頁" onclick="goSearchType(';

			pageType1 = pageNum1 + 1;

			content += pageType1
					+ ','
					+ rowNum
					+ ')"></td><td><img src="${pageContext.request.contextPath}/images/icon/last.png"'
					+ ' value="最末頁" onclick="goSearchType(';

			pageType1 = totalPage;

			content += pageType1
					+ ','
					+ rowNum
					+ ')"></td><td>每頁顯示<select name="rowNum"'
					+ ' onchange="changeRowNum(this.value)"><option value="10" >10</option><option value="20" ';
			var selected = (rowNum == 20) ? "selected" : "";

			content += selected + '>20</option><option value="30" ';

			selected = (rowNum == 30) ? "selected" : "";
			content += selected + '>30</option></select></td></tr></table>';

			jQuery('#tabs').append(content);
		}
	}

	jQuery(function() {
		jQuery("#tabs").tabs();

	});
</script>
</head>
<body style="background-image:url(${pageContext.request.contextPath}/images/background2.jpg) ;
 background-repeat: no-repeat;
 back center center;
background-size:cover;
fixed ">

	<div class="topWrapper">
		<div class="topBar">
			<div class="divP">
				Welcome, <span>Pilot</span>
			</div>
		</div>
	</div>
	<div class=sidebar style="z-index:2"> <%@ include file="/WEB-INF/fragment/sidebar.jsp"%></div>
	<div class="step">
	<div style="font-size: 16px; padding-bottom:10px;font-family: Georgia;font-style: italic;"><span>How To Use：</span></div>
		<div>
			<i class="fa fa-code-fork fa-2x" style="color: #5599FF;vertical-align: middle;"></i> <span>選擇開訓日期搜尋班級</span>&nbsp;&nbsp;&nbsp;or&nbsp;&nbsp;&nbsp;<i class="fa fa-code-fork fa-2x" style="color: #5599FF;vertical-align: middle;"></i><span>直接搜尋</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div style="vertical-align: middle;">
			<i class="fa fa-hand-o-up fa-2x" style="color: #5599FF;vertical-align: middle;"></i> <span>點擊<img src="${pageContext.request.contextPath}/images/icon/reg_on.png">按鈕</span>
		</div>
		<div>
			<i class="fa fa-long-arrow-down fa-2x" style="align: center;"></i>
		</div>
		<div style="vertical-align: middle;">
			<i class="fa fa-pencil-square-o fa-2x" style="color: #5599FF;vertical-align: middle;"></i>進行該班級的報名流程</span>
		</div>
	</div>
	<table>
		<tr style="height:50px">
			<td>開訓日期： <input type="text" name="startDate1" style="height:30px;"  id="startDate1"
				size="13px" class="cal" readonly placeholder="請選擇日期" />
				～&nbsp;&nbsp;<input  style="height:30px;" type="text" name="startDate2" id="startDate2"
				size="13px" class="cal" readonly placeholder="請選擇日期" /> <input
				type="button" value="查詢" onclick="goSearchType(1,10)"
				style="width: 8%" /> <input type="button" value="清除"
				onclick="resetSearch()" style="width: 8%" />
			</td>
		</tr>
	</table>


	<h3 id="time" align="center" style="color: white; padding: 10px;"></h3><br>
	<div id="tabs" style="display: none; background: rgba(0, 0, 0, 0); border:0px; margin-top:-20px;"></div>


</body>
</html>