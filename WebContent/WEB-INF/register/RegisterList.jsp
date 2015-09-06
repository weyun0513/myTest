<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css">
<link
	href="http://netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
<script type="text/javascript" src="../js/jquery-1.10.2.js"></script>
<script type="text/javascript" src="../js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../js/ajax2.js"></script>
<script src="../js/jquery-ui-1.10.4.custom.min.js"></script>
<link href="../css/jquery-ui-1.10.4.custom.min.css" rel="stylesheet">
<link href="../css/jquery.dataTables.min.css" rel="stylesheet">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/mqtt.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout.css">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
<title>報名表檢視</title>
<script type="text/javascript">
	jQuery(document)
			.ready(function () {
					jQuery("table").dataTable({"pageLength": 10,  "lengthMenu": [ 10, 20,30]});		  
				
 
 jQuery("#cancel").dialog({
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
 
 jQuery("#cancelMessage").dialog({
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
			
					});
</script>
<script>

var classID ="${sessionScope.classID}";
var classNum ="${sessionScope.classNum}";

jQuery(function() {
	jQuery( "#checkcancel" ).dialog({	
    autoOpen: false,
    modal : true,
    height:250,
    width:300
  });
});
	
	function cancelReg(regID){
		jQuery( "#checkcancel" ).dialog( "open" );
		jQuery( "#regID" ).val(regID);
		jQuery( "#checkcancel input[name=regID]" ).val(regID);
		jQuery( "input[name=classID]" ).val(classID);
		jQuery( "input[name=classNum]" ).val(classNum);
		jQuery( "#classID" ).val(classID+classNum);
	
//     return false;
  };
	
</script>

</head>
<body
	style="background:url(${pageContext.request.contextPath}/images/tweed.png);">
	 <div class=sidebar style="z-index:2"> <%@ include file="/WEB-INF/fragment/sidebar.jsp"%></div>	
	<div><%@ include file="/WEB-INF/fragment/Top.jsp"%></div>
	<div>
		<table>
			<thead>
				<tr>
					<th style="width: 60px" align=center><span>取消報名</span></th>
					<th style="width: 50px" align=center><u>變更訓練期別 </u></th>
					<th align=center style="width: 40px"><u>報名流水號 </u></th>
					<th align=center style="width: 50px; font-size:14px"><u>身分證號碼 </u></th>
					<th align=center  style="width: 70px; font-size:15px"><u>姓名</u></th>
					<th align=center><u>可駕駛機種</u></th>
					<th align=center><u>上次訓練日期</u></th>
					<th align=center><u>上次訓練有效日期 </u></th>
					<th align=center><u>下次審驗日期 </u></th>
					<th align=center><u>下次訓練有效日期 </u></th>
					<th align=center  style="width: 70px"><u>報名狀態 </u></th>
					<th align=center><u>班級序號</u></th>
					<th align=center><u>報名日期</u></th>
					<th align=center><u>繳費狀態</u></th>
					<th align=center  style="width:40px"><u>後台建立人員</u></th>
				</tr>
			</thead>
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate pattern="yyyy-MM-dd" value="${now}" var="nowDate" />
			<tbody id="registerData">
				<c:if test="${empty RegisterList}">
					<h1>沒有報名資料</h1>
				</c:if>
				<p class="p">檢視報名表</p>
				<c:forEach var="registerVO" items="${RegisterList}">
					<TR>
					
						<Td class="first" align="center">
						<c:if test="${registerVO.classListVO.startDate >= nowDate}">
							
						
						
						<button
								id=${registerVO.regID } onclick='cancelReg(${registerVO.regID})'
								class="opener" value=${registerVO.regID} >Cancel
							</button></c:if>
							<c:if test="${registerVO.classListVO.startDate < nowDate}">
							<button
								id=${registerVO.regID } disabled="disabled"   value=${registerVO.regID} >Cancel
							</button>
							</c:if>
							</Td>
						<c:if test="${registerVO.classListVO.startDate > nowDate}">
							<Td class="first" align=center><form
									action="${pageContext.request.contextPath}/GraduationChangeServlet"
									method="post">
									<input type="image" width="25px"
										src='${pageContext.request.contextPath}/images/icon/change_reg_on.png'>
									<input type="hidden" name="regID" VALUE='${registerVO.regID}'>
								</form></Td>
						</c:if>
						<c:if test="${registerVO.classListVO.startDate <= nowDate}">
							<td class="first" align=center><img
								src="${pageContext.request.contextPath}/images/icon/change_reg_off.png"></td>
						</c:if>
						<Td class="first" align=center style="font-size:15px;">${registerVO.regID}</Td>
						<Td class="first" align=center style="font-size:18px;">${registerVO.pilotVO.pilotID }</Td>
						<Td class="first" align=center  style="font-size:18px;">${registerVO.pilotVO.pilotName}</Td>
						<Td class="first" align=center>${registerVO.pilotVO.aircraftVO.craftType}</Td>
						<Td class="first" align=center style="font-size:5px;">${registerVO.pilotVO.lastTrainDate}</Td>
						<Td class="first" align=center style="font-size:9px;">${registerVO.pilotVO.lastValidDate}</Td>
						<Td class="first" align=center>${registerVO.pilotVO.nextValidDate}</Td>
						<Td class="first" align=center>${registerVO.pilotVO.nextValidDate}</Td>
						<Td class="first" align=center>${registerVO.regStatus}</Td>
						<Td class="first" align=center><span>${registerVO.classListVO.classTypeVO.classID}</span><span>${registerVo.classListVO.classNum}${registerVO.classListVO.classNum}</span></Td>
						<td class="first" align=center><fmt:formatDate
								pattern="yyyy-MM-dd" value="${registerVO.regDate}" /></td>
						<Td class="first" align=center>${registerVO.payStatus=='true'?"已繳費":"未繳費"}</Td>
						<Td class="first" align=center>${registerVO.managerVO.managerAccnt}</Td>
					</TR>
				</c:forEach>

			</tbody>
		</table>
	</div>
	<i class="fa fa-reply 5x"></i>
	<a href="${pageContext.request.contextPath}/classlist/ClassView">回到班級頁面查詢</a>
	<!-- 	//=================對話框=============================	 -->
	<div id="checkcancel" title="確認取消">

		<form action="cancelRegister.do" method="post">
			<label>報名流水號:</label> <input type="text" id="regID" value="" disabled
				style="width: 100px" /><br> 報名班級期別:<input align="center"
				type="text" id="classID" value="" disabled style="width: 100px" /><br>
			<input type="hidden" name="regID" value=regID /> <input
				type="hidden" name="action" value="regRegistList" /> <input
				type="hidden" name="regStatus" value=regID /> <input type="hidden"
				name="classID" value=classID /> <input type="hidden"
				name="classNum" value=classNum /> <input type="hidden" id="submit"
				name="submit" value="submit" /> <br> <input type="submit"
				value="確認" />
		</form>

	</div>

	<!-- 	//==============================================	 -->
	<c:if test="${not empty errorMsgs}">
		<div id="cancel">
			<p style="color: red;">${errorMsgs.regStatus}</p>
			<p style="color: red;">${errorMsgs.payStatus}</p>
			<c:remove var="errorMsg" scope="request" />
		</div>
	</c:if>


	<c:if test="${not empty Message}">
		<div id="cancelMessage">
			<p style="color: black;">${cancelMessage.cancelMessage}</p>

			<c:remove var="cancelMessage" scope="request" />
		</div>
	</c:if>





	<!-- 		//============================================== -->




</body>
<script type="text/javascript">
	jQuery("tr").not(':first').hover(function() {
		$(this).css("background-color", "rgba(227,228,229, 0.1)");
	}, function() {
		$(this).css("background", "");
	});
</script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout.css">
<style>
body {
	background: url(../images/swirl.png) repeat;
}

table {
	border-width: 0px;
	border-collapse: collapse;
}

th {
	ALIGN: CENTER;
	width: 100px;
}

form{
	color:black
}


.first {
	border-width: 0px;
	border-left-width: 0px;
	border-bottom-style: solid;
	border-top-style: solid;
	border-left-style: solid;
	border-top-color: #1F497D;
	border-left-color: #1F497D;
	border-bottom-color: #1F497D;
}

thead {
	font-family: "微軟正黑體";
	font-size: 10px;
	padding: 0px 0px 0px 0px;
}

td {
	border-width: 0px;
	color: white;
	vertical-align: middle;
	text-align: center;
	font-family: "微軟正黑體";
	font-size: 10px; 
	padding: 10px 10px 10px 10px;
	color: white;
}

tr {
	border-width: 0px;
}

.p {
	border-width: 0px;
	padding: 10px;
	text-align: center;
	font-family: '微軟正黑體';
	font-size: 18px;
	font-weight: bold;
}
</style>

</html>