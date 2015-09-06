<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>變更繳費狀態</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
<link href="${pageContext.request.contextPath}/css/tablestyle.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/jquery-ui-1.10.4.custom.min.css" />
<script
	src="${pageContext.request.contextPath}/js/jquery-ui-1.10.4.custom.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/mqtt.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout.css">
<style>
.footer {
	right: 200px;
}
</style>

<script type="text/javascript">
	jQuery(document).ready(function() {

		
// 		有錯會顯示

		jQuery("#errorMsgs").dialog({
			draggable : false,
			resizable : false,
			height : 250,
			modal : true,
			title : "錯誤訊息",
			buttons : {
				"確定" : function() {
					jQuery(this).dialog("close");
				}
			}
		});
//顯示修正結果
		jQuery("#ModMessage").dialog({
			draggable : false,
			resizable : false,
			height : 250,
			modal : true,
			title : "繳費狀態改變",
			buttons : {
				"確定" : function() {
					jQuery(this).dialog("close");
				}
			}
		});
		
		
		// 進來先關閉 點擊後可以報名
// 			jQuery(function() {
				jQuery("#ModPayStatusLocalPage").dialog({	
			    autoOpen: false,
			    modal : true,
			    height:250,
			    width:300
// 			  });
			});
	});
</script>
</head>


<body style="background:url(${pageContext.request.contextPath}/images/tweed.png);">
<div><%@ include file="/WEB-INF/fragment/sidebar.jsp"%></div>
	
	<div><%@ include file="/WEB-INF/fragment/Top.jsp"%></div>
	<div id="psdgraphics-com-table">

		<div id="psdg-header">
			<span class="psdg-bold">變更繳費狀態</span><br />

		</div>



		<div id="psdg-middle">



			<div class="psdg-left">報名流水號</div>
			<div class="psdg-right">${registerVO.regID}</div>


			<div class="psdg-left">身分證號碼</div>
			<div class="psdg-right">${registerVO.pilotVO.pilotID}</div>



			<div class="psdg-left">姓名</div>
			<div class="psdg-right">${registerVO.pilotVO.pilotName}</div>

			<div class="psdg-left">可駕駛機種</div>
			<div class="psdg-right">${registerVO.pilotVO.aircraftVO.craftType}</div>


			<div class="psdg-left">上次訓練日期</div>
			<div class="psdg-right">${registerVO.pilotVO.lastTrainDate}</div>


			<div class="psdg-left">上次訓練有效日期</div>
			<div class="psdg-right">${registerVO.pilotVO.lastValidDate}</div>



			<div class="psdg-left">下次審驗日期</div>

			<div class="psdg-right">${registerVO.pilotVO.nextValidDate}</div>

			<div class="psdg-left">下次審驗有效日期</div>
			<div class="psdg-right">${registerVO.pilotVO.nextValidDate}</div>

			<div class="psdg-left">班級序號</div>
			<div class="psdg-right">${registerVO.classListVO.classTypeVO.classID}${registerVO.classListVO.classNum}</div>

			<div id="psdg-bottom">
				<div class="psdg-bottom-cell"
					style="width: 129px; text-align: left; padding-left: 24px;">Status:</div>
				<div class="psdg-bottom-cell">${registerVO.payStatus?"已繳費":"未繳費"}
				</div>

			</div>
		</div>
	</div>
	<form
		action="${pageContext.request.contextPath}/register/ModPayStatus.do "
		method="post">
		<input type="hidden" name="checkManagerID" value="1"> <input
			type="hidden" name="pilotID" value="${registerVO.pilotVO.pilotID}">
		<input type="hidden" name="regID" value="${registerVO.regID}">
		<input type="hidden" name="action" value="checkPay"> 
		<c:if test="${ registerVO.payStatus ==false }">
		<input 	type="submit" value="確認繳費"  style="margin-left:45%;margin-top:4%;height: 4.5em; width: 7em"></c:if>
	</form>


	<form
		action="${pageContext.request.contextPath}/register/ModPayStatus.do "
		method="post">
		<input type="hidden" name="checkManagerID" value="1"> <input
			type="hidden" name="pilotID" value="${registerVO.pilotVO.pilotID}">
		<input type="hidden" name="regID" value="${registerVO.regID}">
		<input type="hidden" name="action" value="cancelPayStatus"> 
		<c:if test="${ registerVO.payStatus ==true }">
		<input 	type="submit" value="退回繳費"  style="margin-left:45%;margin-top:4%;height: 4.5em; width: 7em"></c:if>
	</form>


	<div class="footer">
	<form
			action="javascript:ModPayStatus()">

			<input type="submit" value="重新查詢" style="margin-left:45%;margin-top:4%;height: 4.5em; width: 7em">

		</form>
	</div>

	<!--  == -->

	<c:if test="${not empty ModMessage}">
		<div id="ModMessage" class=error>
			<p style="color: red">${ModMessage.payStatus}</p>

			<c:remove var="ModMessage" scope="request" />
		</div>
	</c:if>
<!--  == -->
	<!--  == ERRORMSG -->
	<c:if test="${not empty errorMsgs}">
		<div id="errorMsgs" class=error>
			<p style="color: red">${errorMsgs.regID}</p>
		
			<c:remove var="errorMsgs" scope="request" />
		</div>
	</c:if>
	<!--  == -->
	
	
	
<div id="ModPayStatusLocalPage">
<form action="${pageContext.request.contextPath}/register/ModPayStatus.do" method="post">
<P style="color:black">請輸入報名流水號:<P><br>
<input type="text" name="regID" value="${param.regID}"><span id="message" class="error">${errorMsgs.regID}</span> 
<BR>
<BR> 
<input type="hidden" value="select" name="action">
<input type="submit" value="查詢"  >
</form>
</div>

</body>
<script>
// var dt = new Date();
// var month = dt.getMonth() + 1;
// var day = dt.getDate();
// var year = dt.getFullYear();
// document.getElementById("date").value = (year + '-' + month + '-' + day);



function ModPayStatus(){
	jQuery( "#ModPayStatusLocalPage" ).dialog( "open" );
}

	
</script>
</html>