<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班級列表檢視</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-2.1.1.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-ui-1.10.4.custom.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/jquery-ui-1.10.4.custom.min.css">
<link href='http://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>
<link href="http://netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
<script>

function stepon(){
	jQuery('.step').show();
}
	
	var sysTime;		
	function getSysTime() {
		var now = new Date(sysTime);
		var year = now.getFullYear();
		var month = now.getMonth() + 1;
		var date = now.getDate();
		var hour = now.getHours();
		var minute = now.getMinutes();
		var second = now.getSeconds();
		sysTime+=50;
		 
		function changeType(type){
			return (type<10)?"0"+type:""+type;
		}

		jQuery('#time').text('系統時間：'+changeType(year) + 
						'-' + changeType(month) + '-' + changeType(date) + ' ' + 
						changeType(hour) + ':' + changeType(minute) + ':' + changeType(second));
	}
				

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
// 			alert("searchType="+searchType+"pageNum1="+pageNum1+"pageNum2="+pageNum2+"pageNum3="+pageNum3)

			goSearchType(1, pageNum1, pageNum2, pageNum3, rowNum);
	}
	
	
	var s_classID;
	var s_craftID;
	var startDate1;
	var startDate2;
	var endDate1;
	var endDate2;

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
		
		jQuery('.step,#steps').hide();
	}

	function resetSearch() {
		jQuery('#search select[name="classID"]').val(null);
		jQuery('#search select[name="craftID"]').val(null);
		jQuery('#search input[name="startDate1"]').val(null);
		jQuery('#search input[name="startDate2"]').val(null);
		jQuery('#search input[name="endDate1"]').val(null);
		jQuery('#search input[name="endDate2"]').val(null);
	}

	var searchType;
	var pageNum1;
	var pageNum2;
	var pageNum3;
	var rowNum;

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
	
	function goJump(searchType){	
		var pageNum=jQuery('#jump'+searchType).val();
		pageNum1=(searchType==1)?pageNum:pageNum1;
		pageNum2=(searchType==2)?pageNum:pageNum2;
		pageNum3=(searchType==3)?pageNum:pageNum3;
// 		alert("pageNum="+pageNum+"searchType="+searchType+",pageNum1="+pageNum1+",pageNum2="+pageNum2+",pageNum3="+pageNum3);
		goSearchType(searchType,pageNum1,pageNum2,pageNum3,rowNum);
	}

	var xmlhttp = null;

	function goSearchType(searchType, pageNum1, pageNum2, pageNum3, rowNum) {
		var path = "${pageContext.request.contextPath}/classlist/ClassView";
		xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange = callback;
		xmlhttp.open("POST", path);
		xmlhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");

		var query = "classID=" + s_classID + "&craftID=" + s_craftID
				+ "&startDate1=" + startDate1 + "&startDate2=" + startDate2
				+ "&endDate1=" + endDate1 + "&endDate2=" + endDate2
				+ "&searchType=" + searchType + "&pageNum1=" + pageNum1
				+ "&pageNum2=" + pageNum2 + "&pageNum3=" + pageNum3
				+ "&rowNum=" + rowNum + "&action=searchList";

		xmlhttp.send(query);
	}

	function callback() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				processJSON(xmlhttp.responseText);
			}
		}
	}

	var intervalID;
	var content;
	var regNum;
	
	function processJSON(text) {
		var array = eval(text);

		if (array[0].hasMoreData) {
			clearInterval(intervalID);
			sysTime = array[1].sysTime;
			intervalID = setInterval("getSysTime()", 50);
			pageNum1 = array[1].pageNum1;
			pageNum2 = array[1].pageNum2;
			pageNum3 = array[1].pageNum3;
			rowNum = array[1].rowNum;
			searchType = array[1].searchType;
			content = "";
			var count = array[1].count;
			var totalPage = array[1].totalPage;

			jQuery('#tab' + searchType).empty();
			document.getElementById("tabs").style.display = "block";
			if (array.length == 2)
				jQuery('#tab' + searchType).append('<h3>此範圍無課程資訊</h3>');
			else {
				content += '<table class="tab" style="width:100%;"><tr>';
				getPageInfo();
				content +='</form></td></tr><tr><th>編輯</th><th>刪除</th><th>代號/期別</th><th>班級狀態</th><th>開訓日期</th>'
						+ '<th>結訓日期</th><th>開課人數</th><th>報名人數</th><th>上課時間</th>'
						+ '<th>檢視報名表</th><th>匯出報名表</th><th>匯入結訓表</th></tr>';

				for (var i = 2; i < array.length; i++) {
					var classID = array[i].classID;
					var classNum = array[i].classNum;
					var classStatus = array[i].classStatus;
					var startDate = array[i].startDate;
					var endDate = array[i].endDate;
					var maxNum = array[i].maxNum;
					var regNum = array[i].regNum;
					var classSchedule = array[i].classSchedule;

					if (searchType != 1) {
						content += '<tr style="height:50px;"><td><img value="編輯"'+
									 ' src="${pageContext.request.contextPath}/images/icon/edit_off.png"></td><td>';
					} else {
						content += '<tr style="height:50px;"><td><form method="post" action="${pageContext.request.contextPath}/classlist/ClassView">'
								+ '<input type="image" src="${pageContext.request.contextPath}/images/icon/edit_on.png" value="編輯">'
								+ '<input type="hidden" name="classID" value='+classID+'>'
								+ '<input type="hidden" name="classNum" value='+classNum+'>';
						getPageInfo();
						content += '<input type="hidden" name="action" value="classPreview"></form></td><td>';
					}

					if (new Date(startDate).getTime() < sysTime + 7 * 24 * 60
							* 60 * 1000) {
						content += '<img src="${pageContext.request.contextPath}/images/icon/delete_off.png" value="刪除">';
					} else {
						content += '<input type="image" src="${pageContext.request.contextPath}/images/icon/delete_on.png" '
								+ 'onclick="showConfirm(' + i +',' + regNum + ');" value="刪除">'
								+ '<form method="post" id="delete" name="'+i+'" action="${pageContext.request.contextPath}/classlist/Class.do">'
								+ '<input type="hidden" name="classID" value='+classID+'>'
								+ '<input type="hidden" name="classNum" value='+classNum+'>';
						getPageInfo();
						content += '<input type="hidden" name="action" value="deleteClass"></form>';
					}

					content += '</td><td>' + classID + classNum + '</td><td>'
							+ classStatus + '</td><td>' + startDate
							+ '</td><td>' + endDate + '</td><td>' + maxNum
							+ '</td>';

					if (searchType != 1) {
						content += '<td><form>' + regNum;
					} else {
						if (maxNum > regNum && classStatus == ("開放報名")) {
							content += '<td><form method="post" action="${pageContext.request.contextPath}/classlist/ClassView">'
									+ regNum
									+ '<input type="image" src="${pageContext.request.contextPath}/images/icon/reg_on.png"'+
									' value="報名" style="padding-top: 20px;" align="right" ><input type="hidden" name="classID" value='+classID+'>'
									+ '<input type="hidden" name="classNum" value='+classNum+'>';
							getPageInfo();
							content += '<input type="hidden" name="action" value="goReg">';
						} else {
							content += '<td><form>' + regNum
									+ ' <img src="${pageContext.request.contextPath}/images/icon/reg_off.png" value="報名" style="padding-top: 20px;" align="right">';
						}
					}
					content += '</form></td><td  style="font-size:3px;">' + classSchedule + '</td>'
							+ '<td><form method="post" action="${pageContext.request.contextPath}/register/register.view">'
							+ '<input type="image" src="${pageContext.request.contextPath}/images/icon/show_on.png"value="檢視">'
							+ '<input type="hidden" name="classID" value='+classID+'>'
							+ '<input type="hidden" name="classNum" value='+classNum+'>';
					getPageInfo();
					content += '<input type="hidden" name="action" value="viewRegister"></form></td>'
							+ '<td><form method="post" action="${pageContext.request.contextPath}/classlist/Downloadxlsx.do"">'
							+ '<input type="image" src="${pageContext.request.contextPath}/images/icon/register_on.png" value="匯出">'
							+ '<input type="hidden" name="classID" value='+classID+'>';
					getPageInfo();
					content += '<input type="hidden" name="classNum" value='+classNum+'></form></td><td>';
					if (searchType != 3) {
						content += '<img src="${pageContext.request.contextPath}/images/icon/graduation_off.png" value="匯入"></td></tr>';
					} else {
						content += '<input type="image" src="${pageContext.request.contextPath}/images/icon/graduation_on.png" '
								+ 'value="匯入" onclick="uploadFile(' + i
								+ ');"><form name="importForm" method="post" '+
								'action="${pageContext.request.contextPath}/ImportServlet" enctype="multipart/form-data">'
								+ '<input type="file" onchange="jQuery(\'#importLoader\').dialog(\'open\');this.form.submit();" name="graduationFile" value='
								+ i + ' style="display:none" '
								+ 'accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel">'
								+ '<input type="hidden" name="classID" value='+classID+'>';
						getPageInfo();
						content += '<input type="hidden" name="classNum" value='+classNum+'></form></td></tr>';
					}
				}//end for

				var pageNum;
				if (searchType == 3) {
					pageNum = pageNum3;
				} else {
					pageNum = (searchType == 2) ? pageNum2 : pageNum1;
				}
				content += '<tr><td colspan="12"></td></tr><tr style="height: 50px">'
						+ '<td colspan="3"><font color="red">' + count + '</font>個搜尋結果&nbsp;&nbsp;&nbsp;'
						+ '第<font color="red">' + pageNum + '</font>頁/共' + totalPage + '頁</td>'
						+ '<td><img src="${pageContext.request.contextPath}/images/icon/first.png"'
						+ ' value="第一頁" onclick="goSearchType(' + searchType + ',';

				var pageType1 = (searchType == 1 ? 1 : pageNum1);
				var pageType2 = (searchType == 2 ? 1 : pageNum2);
				var pageType3 = (searchType == 3 ? 1 : pageNum3);

				content += pageType1 + ',' + pageType2 + ',' + pageType3 + ','
						+ rowNum + ')"></td><td><img' + ' src="${pageContext.request.contextPath}/images/icon/previous.png"'
						+ ' value="上一頁" onclick="goSearchType(' + searchType + ',';

				pageType1 = (searchType == 1 ? pageNum1 - 1 : pageNum1);
				pageType2 = (searchType == 2 ? pageNum2 - 1 : pageNum2);
				pageType3 = (searchType == 3 ? pageNum3 - 1 : pageNum3);

				content += pageType1 + ',' + pageType2 + ',' + pageType3 + ','
						+ rowNum + ')"></td><td colspan="2">';

				var begin = ((pageNum - 3) > 1 ? (totalPage - pageNum) > 3 ? pageNum - 3
						: totalPage - 6 : 1);
				var end = pageNum + 3 < totalPage ? ((pageNum - 3) > 1 ? pageNum + 3
						: 7) : totalPage;
				if(begin<=1)begin=1;
				if(end>totalPage)end=totalPage;
				for (var page = begin; page <= end; page++) {
					pageType1 = (searchType == 1 ? page : pageNum1);
					pageType2 = (searchType == 2 ? page : pageNum2);
					pageType3 = (searchType == 3 ? page : pageNum3);
					content += ' <a href="javascript:goSearchType('
							+ searchType + ',' + pageType1 + ',' + pageType2
							+ ',' + pageType3 + ',' + rowNum + ')">' + page + '</a>';
				}

				content += '</td><td><img src="${pageContext.request.contextPath}/images/icon/next.png"'
						+ ' value="下一頁" onclick="goSearchType(' + searchType + ',';

				pageType1 = (searchType == 1 ? pageNum1 + 1 : pageNum1);
				pageType2 = (searchType == 2 ? pageNum2 + 1 : pageNum2);
				pageType3 = (searchType == 3 ? pageNum3 + 1 : pageNum3);

				content += pageType1 + ',' + pageType2 + ',' + pageType3
						+ ',' + rowNum + ')"></td><td>'
						+ '<img src="${pageContext.request.contextPath}/images/icon/last.png"'
						+ ' value="最末頁" onclick="goSearchType(' + searchType + ',';

				pageType1 = (searchType == 1 ? totalPage : pageNum1);
				pageType2 = (searchType == 2 ? totalPage : pageNum2);
				pageType3 = (searchType == 3 ? totalPage : pageNum3);

				content += pageType1 + ',' + pageType2 + ',' + pageType3
						+ ',' + rowNum + ')"></td><td colspan="3">' + '跳至第&nbsp;<input type="text" id="jump'+searchType+'" maxlength="3" style="width:15%">'
						+ '&nbsp;頁<input type="image" src="${pageContext.request.contextPath}/images/icon/jump.png" onclick="goJump('+searchType+');">&nbsp;&nbsp;'
						+ '每頁顯示&nbsp;'
						+ '<select name="rowNum" onchange="changeRowNum(this.value)" style="width:20%">'
						+ '<option value="10" >10</option><option value="20" ';
				var selected = (rowNum == 20) ? "selected" : "";

				content += selected + '>20</option><option value="30" ';

				selected = (rowNum == 30) ? "selected" : "";
				content += selected + '>30</option></select>&nbsp;筆</td></tr></table>';

				jQuery('#tab' + searchType).append(content);
			}
		}
	}

	function getPageInfo() {
		content += '<input type="hidden" name="s_classID" value='+s_classID+'>'
				+ '<input type="hidden" name="s_craftID" value='+s_craftID+'>'
				+ '<input type="hidden" name="startDate1" value='+startDate1+'>'
				+ '<input type="hidden" name="startDate2" value='+startDate2+'>'
				+ '<input type="hidden" name="endDate1" value='+endDate1+'>'
				+ '<input type="hidden" name="endDate2" value='+endDate2+'>'
				+ '<input type="hidden" name="searchType" value='+searchType+'>'
				+ '<input type="hidden" name="pageNum1" value='+pageNum1+'>'
				+ '<input type="hidden" name="pageNum2" value='+pageNum2+'>'
				+ '<input type="hidden" name="pageNum3" value='+pageNum3+'>'
				+ '<input type="hidden" name="rowNum" value='+rowNum+'>';
	}

	var index;

	function showConfirm(i , reg) {
		index = i;
		if (reg == 0) {
			jQuery("#delete-confirm").empty();
			var classID = jQuery(
					'#delete[name="' + index + '"] input[name=classID]').val();
			var classNum = jQuery(
					'#delete[name="' + index + '"] input[name=classNum]').val();
			jQuery("#delete-confirm").append(
					'<p>是否刪除 [' + classID + classNum + '] ?</p>');
			jQuery("#delete-confirm").dialog("open");
		} else {//有值，使用noDelete對話窗
			jQuery("#noDelete").empty();
			jQuery("#noDelete").append(
					'<p>本班級已經有人報名，無法進行刪除，請先將班級註記為暫停報名'
							+ '並將報名飛行員移動至其他班級，待本班級皆無報名飛行員後，方可刪除此班級。</p>');
			jQuery("#noDelete").dialog("open");
		}
	}

	function deleteClass() {
		jQuery('#delete[name="' + index + '"]').submit();
	}

	function uploadFile(i) {
		jQuery('input[name="graduationFile"][value=' + i + ']').click();
	}

	jQuery(function() {
		jQuery("#tabs").tabs();

		jQuery(".cal")
				.datepicker(
						{
							changeMonth : true,
							changeYear : true,
							dateFormat : "yy-mm-dd"
						});

		jQuery("#message").dialog({
			draggable : false,
			resizable : false,
			height : 250,
			modal : true,
			title : "系統訊息",
			buttons : {
				"確定" : function() {
					jQuery(this).dialog("close");
				}
			}
		});

		jQuery("#delete-confirm").dialog({
			autoOpen : false,
			draggable : false,
			resizable : false,
			modal : true,
			height : 250,
			title : "確認刪除",
			buttons : {
				"確定" : function() {
					deleteClass();
					jQuery(this).dialog("close");
				},
				"取消" : function() {
					jQuery(this).dialog("close");
				}
			}
		});

		jQuery("#noDelete").dialog({
			autoOpen : false,
			draggable : false,
			resizable : false,
			height : 310,
			modal : true,
			title : "系統訊息",
			buttons : {
				"確定" : function() {
					jQuery(this).dialog("close");
				}
			}
		});			
	});
</script>
</head>
<style>
h3{
color:black
}
.sidebar applet, object, iframe,
h1, h2, h3, h4, h5, h6,, blockquote, pre,
a,   var,
b, u, i, center,
dl, dt, dd, ol, ul, li, 
menu    {
	margin: 0;
	padding: 0;
	border: 0;
	font-size: 100%;
	font: inherit;
	vertical-align: baseline;
}
.sidebar ol, ul {
	list-style: none;
}
  .tab{
  	line-height: 68px;
  	width:100%
  }
.sidebar {
  line-height: 10px;
  position: relative;
  left: 0;
  -webkit-transition:left  .3s;
  transition: left  .3s;
}

.sidebar.open {
    left: 330px;
  }
  .sidebar html,body  { height: 100%; }
  .sidebar {
  color: #fff;
  margin: 0 auto;
  font: 1em/1.3em Times, serif;
  font-family: 'Montserrat', serif;

}

.sidebar.header {
  margin-bottom: 95px;
  position: relative;
 z-index:10;
 
}
.sidebar.menucontainer {
  position: relative;
  text-align: center;
  height: 100%;
}

.sidebar a {
  text-decoration: none;
  color: #fff;  
  margin: 0px 0px;
}
.sidebar a.menu-icon {
	  color: #00C0F2;   
  position: absolute;
  top:-60px;
  left: 00px;
  font-size: 33px;
}
.sidebar ul.side-menu {
  position: fixed;
  top: 0px;
  left: -300px;
  width: 270px;
  height: 100%;
  background-color:  rgba(59,126,126,.5);
  -webkit-transition: left .3s;
  transition: left .3s;
}

/* 藍背景底色移動 */
  ul.side-menu.open {
    left: -20px;
    top: 50px;
  }
    a.menu-icon.open {
    left: 270px;
    top: -150px;
  }
  
.sidebar  ul.side-menu li {
/* 	第一欄開頭 */
    position: absolute;
    top: 100%;
/*     left: 0; */
    padding: 0px 0px 0px 0px;
    text-align: left;
    height: 0px;
    line-height: 10px;
/*     每格底線 */

    border-bottom: 1px solid #fff;
    -webkit-transition: top .1s;
    transition: top .1s;
/*      -webkit-transition: all 0.5s ease; */
/*     transition: all 0.5s ease; */
  }
  
.sidebar  ul.side-menu li.row {
    border: 0;
    position: static;
    top: 0;
 
    -webkit-transition: none;
    transition: none;
  }
  
 .sidebar   ul.side-menu li.metro {
/*  改這邊條寬度 */
      position: absolute;
        padding: 10px 0px 19px 0px;
      height:63px;
      text-align: center;
  
      background-color: #fff;
        -webkit-transition: all 0.5s ease;
    transition: all 0.5s ease;
    }

  .sidebar  ul.side-menu h2.title {
      color: white;
      text-align: center;
         padding:  30px 0 20px 0px;
      position: relative;
      left: 0px;
      top: 90px;
      font-size: 33px;
      line-height: 0px;
      height: 10px;
      background-color:  rgba(47,79,79,1);
       border-bottom: 1px solid #000;
      -webkit-transition: top .1s;
      transition: top .1s;
        font-family: "Helvetica Neue", Helvetica, Arial, "微軟正黑體", sans-serif;
    }    
    .sidebar  ul.side-menu li a {
    
       display: block;
/*       font-size: 12px; */
      padding: 0;
 
      height: inherit;
      line-height: inherit;
      font-family: "Helvetica Neue", Helvetica, Arial, "微軟正黑體", sans-serif;    
    }
      .sidebar    ul.side-menu li.metro a {
/*   字體上下 */
/*          margin: 15px 0; */
        height: 60px;
 
      }
  ul.side-menu li.metro.mygray2{ background-color: rgba(44,130,136,0.9);        }
  ul.side-menu li.metro.half { width: 50%; font-size:20px}
   ul.side-menu li.metro.full { width: 100%;font-size:20px; }
  
.sidebar ul.side-menu li.metro:hover {background:rgba(0,226,226,0.9);
}    
    .ui-widget-content
  {
  
  background-image:url(${pageContext.request.contextPath}/images/global_map.jpg)
  }
  
  .ui-state-default {
background-color: rgba(0, 0, 0, 0.6);
  }
</style>

<body>
<div id="importLoader" title="請稍候...."><img src="${pageContext.request.contextPath}/css/images/ajax-loader.gif"></div>
<script>
jQuery('#importLoader').dialog({
	autoOpen:false,
	modal:true
});

</script>
<div ><%@ include file="/WEB-INF/fragment/Top.jsp"%></div>
	<div><jsp:include page="/WEB-INF/classlist/search.jsp"></jsp:include></div>
<!-- 	====== -->
	<div class=sidebar style="z-index:5">
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
    </div>                     
<div style="z-index:1">
	<div id="tabs" style="display: none;"> 
		
		<ul><h3 id="time" align="center" style="padding-top:35%x; margin-left: 20%; display: inline"></h3>
			<li><a href="#tab1"
				onclick="goSearchType(1,pageNum1,pageNum2,pageNum3,rowNum)">未開訓</a></li>
			<li><a href="#tab2"
				onclick="goSearchType(2,pageNum1,pageNum2,pageNum3,rowNum)">已開訓</a></li>
			<li><a href="#tab3"
				onclick="goSearchType(3,pageNum1,pageNum2,pageNum3,rowNum)">已結訓</a></li>
		</ul>
		<div id="tab1"></div>
		<div id="tab2"></div>
		<div id="tab3"></div>
	</div>
	</div>
	<div id="steps" style="position: absolute;margin: 60% 0% 0 75%;color:red;" onclick="stepon()"><img id="idea" style="vertical-align: middle;text-align:center;"src="${pageContext.request.contextPath}/images/idea-50.png"><span id="tips">使用提示</span></div>
	<c:if test="${not empty message}">
	<div id="message">
	  <p>${message}</p>
	  <c:remove var="message" scope="session"/>
	</div>
	</c:if>

	<div id="delete-confirm"></div>
	<div id="noDelete"></div>
	
	<c:if test="${not empty sessionScope.pageInfo}">
		<script type="text/javascript">setPageInfo();</script>
		<c:remove var="pageInfo" scope="session"/>	
	</c:if>
<!-- 	=============== -->
<form id="modRecord" action="${pageContext.request.contextPath}/Referred" method="post">
	<input type="hidden" name="action" value="modRecord">
	</form>
<script>
$("#idea").hover(function(){
	$("#tips").empty();
	$("#tips").append("<span>請點擊</span>");
	  $(this).attr("src","${pageContext.request.contextPath}/images/idea-64.png");
	  },function(){
			$("#tips").empty();
			$("#tips").append("<span>使用提示</span>");
	  $(this).attr("src","${pageContext.request.contextPath}/images/idea-50.png");
	});
</script>
</body>
 <script type="text/javascript" src="${pageContext.request.contextPath}/js/init.js"></script>
<%--   <link href="${pageContext.request.contextPath}/css/menustyle2.css" type="text/css" rel="stylesheet"  /> --%>
<STYLE>
#ui-datepicker-div .ui-datepicker {
    background: #333;
    border: 1px solid #555;
    color: #EEE;
}
</STYLE>
</html>
