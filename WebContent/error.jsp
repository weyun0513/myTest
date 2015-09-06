<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<title>Insert title here</title>
</head>
<body>
系統忙線中<span>5</span>秒後自動轉向...........
<script type="text/javascript">
var t=setInterval(function(){
	if(jQuery('span').text()==1){
		window.location.href = '${pageContext.request.contextPath}/index.jsp';
	}else{
		jQuery('span').text(jQuery('span').text()-1);
	}
},1000);
</script>
<br>
<a href="${pageContext.request.contextPath}/index.jsp">立刻轉向</a>
</body>
</html>