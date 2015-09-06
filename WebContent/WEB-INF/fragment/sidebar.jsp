<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href='http://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>
<link href="http://netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jquery-ui-1.10.4.custom.min.css" />
<!-- =============================================================================== -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
<!-- <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script> -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.dataTables.min.js"></script>
 <script type="text/javascript"	src="${pageContext.request.contextPath}/js/mqtt.js"></script>	
<script type="text/javascript">
 


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
		var year = now.getFullYear();
		var month = now.getMonth() + 1;
		var date = now.getDate();
		var hour = now.getHours();
		var minute = now.getMinutes();
		var second = now.getSeconds();
		sysTime += 50;

		function changeType(type) {
			return (type < 10) ? "0" + type : "" + type;
		}

		jQuery('#time').text(
				'系統時間：' + changeType(year) + '-' + changeType(month) + '-'
						+ changeType(date) + ' ' + changeType(hour) + ':'
						+ changeType(minute) + ':' + changeType(second));
	}

	function query_pilot_changeRowNum(value) {
		var index;
		//		alert(value);
		index = (query_pilot_pageNum1 - 1) * query_pilot_rowNum + 1;
		query_pilot_pageNum1 = Math.ceil(index / value);
		query_pilot_rowNum = value;
		query_pilot_goSearchType(query_pilot_pageNum1, query_pilot_rowNum);
	}
	 
	var xmlhttp = null;


	function query_pilot_goSearchType(query_pilot_pageNum1, query_pilot_rowNum) {

		var path = "${pageContext.request.contextPath}/ChangeClassServlet";
		xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange = query_pilot_callback;
		xmlhttp.open("POST", path);
		xmlhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
	 

		var query = "startDate1=" + $("#startDate1").val() + "&startDate2="
				+ $("#startDate2").val() + "&pageNum1=" + query_pilot_pageNum1 + "&rowNum="
				+ query_pilot_rowNum;
		xmlhttp.send(query);
	}

	function query_pilot_callback() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				query_pilot_processJSON(xmlhttp.responseText);
			}
		}
	}

	function query_pilot_resetSearch() {
		jQuery('#startDate1,#startDate2').val(null);
	}

	var query_pilot_pageNum1;
	var query_pilot_rowNum;
	var intervalID;
	function query_pilot_processJSON(text) {
		var array = eval(text);
		if (array[0].hasMoreData) {
			clearInterval(intervalID);
			sysTime = array[1].sysTime;
			intervalID = setInterval("getSysTime()", 50);
			query_pilot_pageNum1 = array[1].pageNum1;

			query_pilot_rowNum = array[1].rowNum;
			var content = "";
			var count = array[1].count;
			var totalPage = array[1].totalPage;

			jQuery('#tabs').empty();
			document.getElementById("tabs").style.display = "block";

			content += '<table class="tab"><tr><th>班級代號/期別</th><th>名稱</th><th>班級狀態</th><th>開訓日期</th>'
					+ '<th>結訓日期</th><th>開課人數</th><th>報名人數</th><th>上課時間</th></tr>';
			for (var i = 2; i < array.length; i++) {
				var craftType = array[i].craftType;
				var classID = array[i].classID;
				var classNum = array[i].classNum;
				var classStatus = array[i].classStatus;
				var startDate = array[i].startDate;
				var endDate = array[i].endDate;
				var maxNum = array[i].maxNum;
				var query_pilot_regNum = array[i].regNum;
				var classSchedule = array[i].classSchedule;

				content += '<td>' + classID + classNum + '</td><td>'
						+ craftType + '</td><td>' + classStatus + '</td><td>'
						+ startDate + '</td><td>' + endDate + '</td><td>'
						+ maxNum + '</td>';

				if (maxNum > query_pilot_regNum && classStatus == ("開放報名")) {
					content += '<td><form action="${pageContext.request.contextPath }/classlist/ClassView" method="get">'
							+ query_pilot_regNum
							+ ' '
							+ '<input type="image" src="${pageContext.request.contextPath}/images/icon/reg_on.png" value="報名" align="right">'
							+ '<input type="hidden" name="classID" value='+classID+'>'
							+ '<input type="hidden" name="classNum" value='+classNum+'>'
							+ '<input type="hidden" name="action" value="goReg"></form>';
				} else {
					content += '<td><form>'
							+ query_pilot_regNum
							+ ' <img src="${pageContext.request.contextPath}/images/icon/reg_off.png" align="right"></form>';
				}

				content += '</td><td>' + classSchedule + '</td></tr>';
			}//end for

			var pageNum = query_pilot_pageNum1;

			content += '<tr style="height: 50px"><td><font color="red">'
					+ count
					+ '</font>個搜尋結果</td>'
					+ '<td>第<font color="red">'
					+ pageNum
					+ '</font>頁/共'
					+ totalPage
					+ '頁</td>'
					+ '<td><img src="${pageContext.request.contextPath}/images/icon/first.png" value="第一頁" onclick="query_pilot_goSearchType(';

			var pageType1 = 1;

			content += pageType1
					+ ','
					+ query_pilot_rowNum
					+ ')"></td><td><img'
					+ ' src="${pageContext.request.contextPath}/images/icon/previous.png" value="上一頁" onclick="query_pilot_goSearchType(';

			pageType1 =query_pilot_pageNum1 - 1;
			content += pageType1 + ',' + query_pilot_rowNum + ')"></td><td>';

			var begin = ((pageNum - 3) > 1 ? (totalPage - pageNum) > 3 ? pageNum - 3
					: totalPage - 6
					: 1);
			var end = pageNum + 3 < totalPage ? ((pageNum - 3) > 1 ? pageNum + 3
					: 7)
					: totalPage;

			for (var page = begin; page <= end; page++) {
				pageType1 = page;

				content += ' <a href="javascript:query_pilot_goSearchType(' + pageType1
						+ ',' + query_pilot_rowNum + ')">' + page + '</a>';
			}

		content += '</td><td><img src="${pageContext.request.contextPath}/images/icon/next.png" value="下一頁" onclick="query_pilot_goSearchType(';

			pageType1 = query_pilot_pageNum1 + 1;

			content += pageType1
					+ ','
					+ query_pilot_rowNum
					+ ')"></td><td><img src="${pageContext.request.contextPath}/images/icon/last.png"'
					+ ' value="最末頁" onclick="query_pilot_goSearchType(';

			pageType1 = totalPage;

			content += pageType1
					+ ','
					+ query_pilot_rowNum
					+ ')"></td><td>每頁顯示<select name="rowNum"'
					+ ' onchange="query_pilot_changeRowNum(this.value)"><option value="10" >10</option><option value="20" ';
			var selected = (query_pilot_rowNum == 20) ? "selected" : "";

			content += selected + '>20</option><option value="30" ';

			selected = (query_pilot_rowNum == 30) ? "selected" : "";
			content += selected + '>30</option></select></td></tr></table>';

			jQuery('#tabs').append(content);
		}
	}

	jQuery(function() {
		jQuery("#tabs").tabs();

	});
 


// classlist javascript
var s_classID;
	var s_craftID;
	var startDate1;
	var startDate2;
	var endDate1;
	var endDate2;

	var searchType;
	var pageNum1;
	var pageNum2;
	var pageNum3;
	var rowNum;
	
	function setPageInfo(){
			s_classID = "${pageInfo.classID}";
			s_craftID = "${pageInfo.craftID}";
			startDate1 = "${pageInfo.startDate1}";
			startDate2 = "${pageInfo.startDate2}";
			endDate1 = "${pageInfo.endDate1}";
			endDate2 = "${pageInfo.endDate2}";
			searchType = "${pageInfo.searchType}";
			pageNum1 = "${sessionScope.pageInfo.pageNum1}";
			pageNum2 = "${pageInfo.pageNum2}";
			pageNum3 = "${pageInfo.pageNum3}";
			rowNum = "${pageInfo.rowNum}";	
			goSearchType(1, pageNum1, pageNum2, pageNum3, rowNum);
	}
	
	function goSearch() {
		s_classID = jQuery('#search select[name="classID"] option:selected')
				.val();
		s_craftID = jQuery('#search select[name="craftID"] option:selected')
				.val();
		startDate1 = jQuery('#search .cal[name="startDate1"]').val();
		startDate2 = jQuery('#search .cal[name="startDate2"]').val();
		endDate1 = jQuery('#search .cal[name="endDate1"]').val();
		endDate2 = jQuery('#search .cal[name="endDate2"]').val();
		goSearchType(searchType, 1, 1, 1, rowNum);
	}

	function resetSearch() {
		jQuery('#search select[name="classID"]').val(null);
		jQuery('#search select[name="craftID"]').val(null);
		jQuery('#search input[name="startDate1"]').val(null);
		jQuery('#search input[name="startDate2"]').val(null);
		jQuery('#search input[name="endDate1"]').val(null);
		jQuery('#search input[name="endDate2"]').val(null);
	}
	function changeRowNum(value) {
		var index;
		index = (pageNum1 - 1) * rowNum + 1;
		pageNum1 = Math.ceil(index / value);
		index = (pageNum2 - 1) * rowNum + 1;
		pageNum2 = Math.ceil(index / value);
		index = (pageNum3 - 1) * rowNum + 1;
		pageNum3 = Math.ceil(index / value);
		rowNum = value;
		goSearchType(searchType, pageNum1, pageNum2, pageNum3, rowNum);
	}
	function goJump(){
		var pageNum=jQuery("#jump").val();
		pageNum1=(searchType==1)?pageNum:pageNum1;
		pageNum2=(searchType==2)?pageNum:pageNum2;
		pageNum3=(searchType==3)?pageNum:pageNum3;
		goSearchType(searchType,pageNum1,pageNum2,pageNum3,rowNum);
	}
</script>

</head>
<body class=sidebar >
 <div id="home" class="menucontainer">
      <div class="header">
      <a class="menu-icon" href="#"><i class="fa fa-bars"></i></a>
       <ul class="side-menu">
              <h2 class="title">Menu</h2>
 
    <c:if test='${empty LoginOK}'>
   
                     <li class="row">
                           <ul>
                               <li class="metro mygray2  full">
                               <a href="${pageContext.request.contextPath}/QueryPilotServlet"><span>班級列表查詢</span><span style="margin-left:60px"><i class="fa fa-search fa-2x"></i></span></a>
                               </li>
                            </ul>
                       </li>  
    </c:if>                  
                     
                    
         
<!--  有登入才會出現 -->
<c:if test="${not empty LoginOK}"> 
        <li class="row">    
                    <ul>
                         <li class="metro mygray2 full"><a href="${pageContext.request.contextPath}/classlist/ClassView" style="margin-top:12px "><span style="margin-left:1px">後臺班級管理</span> <span style="margin-left:50px"><i class="fa fa-list fa-2x"></i></span></a></li>
                  </ul>
          </li>


          <li class="row">
                   <ul>
                    <li class="metro mygray2 full">
                       <a href="${pageContext.request.contextPath}/classlist/ClassView?action=goAddClass" style="margin-top:12px ">
                       <span style="margin-right:32px ">新增班級</span><span style="margin-left:50px">
                       <i class="fa fa-plus fa-2x"></i></span></a></li>
                    </ul>
          </li>      
          <li class="row">
                   <ul>
                    <li class="metro mygray2 full">
                          <a href="#" onclick="jQuery('#modRecord').submit();"><span>稽核紀錄查詢</span><span style="margin-left:50px"><i class="fa fa-eye fa-2x"></i></span></a></li>
                    </ul>
          </li>
                   <li class="row">
                          <ul>
                          <li class="metro mygray2 full"><a href="${pageContext.request.contextPath}/Referred?action=modPayStatus"><span>修改繳費狀態</span><span style="margin-left:50px"><i class="fa fa-money fa-2x"></i></span></a></li>
                  </ul>
           </li>
          
           <li class="row">    
                    <ul>
                      <li class="metro mygray2 full"><a href="${pageContext.request.contextPath}/Schedule" style="margin-top:12px "><span style="margin-left:1px">更新排程器時間</span> <span style="margin-top:12px;margin-left:20px"><i class="fa fa-clock-o fa-2x"></i></span></a></li>

                  </ul>
          </li>
  </c:if>         
    <li class="row">
                             <ul>
                                <li class="metro mygray2   full">
                                <a href="${pageContext.request.contextPath }/QueryRegServlet" ><span>報名進度查詢</span><span style="margin-left:60px"><i class="fa fa-file-o fa-2x"></i></span></a>    
                              </ul>
                       </li>                
<!--        second row -->
         <li class="row">                  
                               <ul>      
                                  <li class="metro mygray2 full">
                                  <a href="${pageContext.request.contextPath}/index.jsp"><span>回網站首頁</span><span style="margin-left:70px"><i class="fa fa-home fa-2x"></i></span></a></li>
                               </ul>
                      </li>
  </ul>
      </div>
  </div>  
	<form id="modRecord" action="${pageContext.request.contextPath}/Referred" method="post">
	<input type="hidden" name="action" value="modRecord">
	</form>
</body>
 
 <link href="${pageContext.request.contextPath}/css/menustyle.css" type="text/css" rel="stylesheet"  />
 <script type="text/javascript" src="${pageContext.request.contextPath}/js/init.js"></script>
 <script>
// 	function regStatus(){
// 		jQuery( "#regStatus" ).dialog( "open" );
// 	}
	$('#myTable').dataTable();
 </script>
 <link href="${pageContext.request.contextPath}/css/jquery.dataTables.min.css" rel="stylesheet">
</html>
 