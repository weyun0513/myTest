<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>飛行員專區</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/flexslider.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/mqtt.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-ui-1.10.4.custom.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/jquery-ui-1.10.4.custom.min.css">
<script
	src="${pageContext.request.contextPath}/js/jquery.flexslider-min.js"></script>
<script>
	// Can also be used with $(document).ready()
	$(window).load(function() {
		$('.flexslider').flexslider({
			animation : "fade",
			slideshowSpeed : 4000,
			controlNav : false,
			directionNav : false,
		});
		$(".link1,.link5,.link3,.link4").mouseout(function() {
			$("#info").empty();
			$("#info").append("<p>請選擇以下功能</p>");
		});
	});

	function getText(x) {
		if (x == "手機版") {
			$("#info").empty();
			$("#info").append("<p>點擊進入手機版頁面</p>");
		} else if (x == "聯絡客服") {
			$("#info").empty();
			$("#info").append("<p>有任何疑問嗎？點擊進入線上客服系統</p>");
		} else if (x == "飛行課程") {
			$("#info").empty();
			$("#info").append("<p>點擊進入查詢、報名最新上線課程</p>");
		} else {
			$("#info").empty();
			$("#info").append("<p>點擊查詢您的課程報名進度</p>");
		}
	};
</script>
<style type="text/css">
#container {
	border-radius: 20px;
	border-color: #d0e5f5;
	border-width: 2px;
}

#customservice {
	border-style: outset;
	border-width: 1px;
	float: right;
	position: fixed;
	right: 0px;
	bottom: 0px;
	border: 0;
	padding: 10px;
	margin-bottom: 10px;
	background: #EEE;
	border-radius: 8px;
	-moz-border-radius: 8px;
	-webkit-border-radius: 8px;
	box-shadow: 3px 3px 10px #666;
	-moz-box-shadow: 3px 3px 10px #666;
	-webkit-box-shadow: 3px 3px 10px #666;
}

.chat_view {
	background-color: white;
	border: 1px;
	width: 100%;
	height: 200px;
	margin: 10px auto;
	overflow: auto;
}

textarea {
	font-size: 3px;
	overflow: hidden;
}

.listBtn {
	margin: 1px;
	font-size: 20px;
	background: #b2e1ff; /* Old browsers */
	background: -moz-linear-gradient(-45deg, #b2e1ff 0%, #66b6fc 100%);
	/* FF3.6+ */
	background: -webkit-gradient(linear, left top, right bottom, color-stop(0%, #b2e1ff),
		color-stop(100%, #66b6fc)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(-45deg, #b2e1ff 0%, #66b6fc 100%);
	/* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(-45deg, #b2e1ff 0%, #66b6fc 100%);
	/* Opera 11.10+ */
	background: -ms-linear-gradient(-45deg, #b2e1ff 0%, #66b6fc 100%);
	/* IE10+ */
	background: linear-gradient(135deg, #b2e1ff 0%, #66b6fc 100%);
	/* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#b2e1ff',
		endColorstr='#66b6fc', GradientType=1);
	/* IE6-9 fallback on horizontal gradient */
	border: 1px solid;
}
</style>

</head>
<body>
	<c:if test="${not empty message}">
		<div id="message">
			<p>${message}</p>
			<c:remove var="message" scope="session" />
		</div>
		<script>
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
		</script>
	</c:if>
	<%@ include file="fragment/Customer.jsp"%>
	<div class="topWrapper">
		<div class="topBar">
			<div class="divP">
				Welcome, <span>Pilot</span>
			</div>
		</div>
	</div>
	<div class="wrapper">
		<div class="flexslider">
			<ul class="slides">
				<li><img
					src="${pageContext.request.contextPath}/images/Slider_1.jpg" /></li>
				<li><img
					src="${pageContext.request.contextPath}/images/Slider_2.jpg" /></li>
				<li><img
					src="${pageContext.request.contextPath}/images/Slider_3.jpg" /></li>
				<li><img
					src="${pageContext.request.contextPath}/images/Slider_4.jpg" /></li>
				<li><img
					src="${pageContext.request.contextPath}/images/Slider_5.jpg" /></li>
				<li><img
					src="${pageContext.request.contextPath}/images/Slider_6.jpg" /></li>
			</ul>
		</div>
		<div class="info">
			<p id="info">請選擇以下功能</p>
		</div>
		<div class="mainMenu">
			<ul>
				<li class="link3"><a
					href="${pageContext.request.contextPath}/QueryPilotServlet"
					onmouseover="getText(this.text)"><p>飛行課程</p></a></li>
				<li class="link4"><a
					href="${pageContext.request.contextPath}/QueryRegServlet"
					onmouseover="getText(this.text)"><p>報名進度查詢</p></a></li>
				<li class="link5" id="imgService"><a
					onmouseover="getText(this.text)"><p>聯絡客服</p></a></li>
				<li class="link1"><a
					href="${pageContext.request.contextPath}/phoneView.jsp"
					onmouseover="getText(this.text)"><p>手機版</p></a></li>

			</ul>
		</div>
	</div>
	<script type="text/javascript">
		jQuery('#customservice').hide();
		jQuery('#imgService').click(function() {
			jQuery("#customservice_chat").dialog({
				title : "線上客服系統",
				width : 400,
				height : 420,
				close : function() {
					$(this).dialog("close");
				}
			});
		});
	</script>
</body>
</html>