<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理員專區</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/flexslider.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/mqtt.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-2.1.1.js"></script>
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
		$(".link1,.link2,.link3,.link4,.link6,.link7").mouseout(function() {
			$("#info").empty();
			$("#info").append("<p>請選擇以下功能</p>");
		});
	});

	function getText(x) {
		if (x == "手機版") {
			$("#info").empty();
			$("#info").append("<p>點擊進入手機版頁面</p>");
		} else if (x == "飛行課程") {
			$("#info").empty();
			$("#info").append("<p>點擊進入課程管理功能</p>");
		} else if (x == "更新排程器") {
			$("#info").empty();
			$("#info").append("<p>管理每日排程時間</p>");
		} else if (x == "報名進度查詢") {
			$("#info").empty();
			$("#info").append("<p>點擊進入報名進度查詢</p>");
		} else if (x == "稽核紀錄查詢") {
			$("#info").empty();
			$("#info").append("<p>點擊進入稽核紀錄查詢</p>");
		} else {
			$("#info").empty();
			$("#info").append("<p>點擊進入變更繳費狀態</p>");
		}
		;

	};
</script>
</head>
<body>
	<div><%@ include file="/WEB-INF/fragment/Top.jsp"%></div>
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
					href="${pageContext.request.contextPath}/classlist/ClassView"
					onmouseover="getText(this.text)"><p>飛行課程</p></a></li>
				<li class="link4"><a
					href="${pageContext.request.contextPath}/QueryRegServlet"
					onmouseover="getText(this.text)"><p>報名進度查詢</p></a></li>
				<li class="link7"><a href="#"
					onclick="jQuery('#modPayStatus').submit();"
					onmouseover="getText(this.text)"><p>變更繳費狀態</p></a></li>
				<li class="link6"><a href="#"
					onclick="jQuery('#modRecord').submit();"
					onmouseover="getText(this.text)"><p>稽核紀錄查詢</p></a></li>
				<li class="link2"><a
					href="${pageContext.request.contextPath}/Schedule"
					onmouseover="getText(this.text)"><p>更新排程器</p></a></li>
				<li class="link1"><a
					href="${pageContext.request.contextPath}/phoneView.jsp"
					onmouseover="getText(this.text)"><p>手機版</p></a></li>
			</ul>
		</div>
	</div>
	<form id="modPayStatus"
		action="${pageContext.request.contextPath}/Referred" method="post">
		<input type="hidden" name="action" value="modPayStatus">
	</form>
	<form id="modRecord"
		action="${pageContext.request.contextPath}/Referred" method="post">
		<input type="hidden" name="action" value="modRecord">
	</form>

</body>
</html>