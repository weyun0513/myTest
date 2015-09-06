<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>手機版頁面</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reset.css">
	<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout.css">
</head>
<style>

	.wrapper {
		width: 328px;
		height: 677px;
		margin: auto;
		background: url("${pageContext.request.contextPath}/images/phone_1.png") no-repeat;
		padding: 123px 57px 0 60px;
	}
</style>
<body>
<div class="topWrapper">
		<div class="topBar">
			<div class="divP">
				Welcome, <span>Pilot</span>
			</div>
		</div>
	</div>
	<div class="wrapper">
		<iframe
			src="${pageContext.request.contextPath}/index_mobile.jsp"
			frameborder="0" width="343px" height="534px"></iframe>
	</div>
</body>
</html>