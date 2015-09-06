<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Soaring High World</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icon/icon.png" type="image/vnd.microsoft.icon">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/video.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/jquery-ui-1.10.4.custom.min.css">	
	
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<style>
#login{
z-index:100;
}
</style>
<script type="text/javascript">
	function getCookieVal(offset) {
		var cookie = document.cookie;
		if (cookie.trim() == '')
			return '';
		var cookieArray = cookie.split(';');
		for (var i = 0; i < cookieArray.length; i++) {
			if (cookieArray[i].indexOf(offset) != -1) {
				return cookieArray[i].replace(offset + '=', '').trim();
			}
		}
	}

	function login() {
		var username = getCookieVal('username');
		var password = getCookieVal('password');
		var remember = getCookieVal('remember');
	//	alert(username+password+remember);
		if (remember == 'true') {
			jQuery('input[name="remember"]').prop("checked", true);
		} else {
			jQuery('input[name="remember"]').prop("checked", false);
		}
		jQuery('input[name="username"]').val(username);
		jQuery('input[name="password"]').val(password);
		$('#login').dialog("open");
	}
</script>
</head>
<body>
		<div id="video_pattern"></div>
		<video id="video_background" preload="auto" autoplay="true" loop="loop" volume="100">
			<!--靜音加上muted="muted" volume="100"-->
		<source src="videos/Video.mp4" type="video/mp4"> 
		Video not supported </video>
		<div class="wordShow">
			“A great way of life.” -Recruiting Slogan
		</div>
	
	<hr>
	<div class="btnWrapper">
		<ul>
			<li><a href="#" onclick="javascript:jQuery('#pilotInto').submit();">進入</a></li>
				<li><a href="##" onclick="login();">管理員登入</a></li>

			
		</ul>
	</div>
	<form id="pilotInto" action="<c:url value='Referred'/>" method="POST">
		<input type="hidden" name="action" value="air">
	</form>
	<div id="login" title="登入">
		<form action="${pageContext.request.contextPath}/LoginServlet" method="POST" id="form_login">
			<div><label>帳號:</label><input type="text" name="username" value=""><div><font style="color:red">${errorMSG.username}</font></div></div>
			<div><label>密碼:</label><input type="password" name="password" value=""><div><font style="color:red">${errorMSG.password}</font></div></div>
			<div><input type="checkbox" name="remember" value="true">
			<label>記住密碼</label> </div>
		</form>
	</div>

<script type="text/javascript">

		var tips = [ '最新課程：<br>『Tupolev Tu-95進階班』、'+
		            ' 『Boeing747SP特訓班』、『Lochkeed Martin F-22進階班』', '歡迎來到飛行員課程報名管理系統。<br/>Welcome to Soaring High World!','最新結訓班級：<br>'+
		            '北區訓練中心:PROK70、JSJQ66；中區訓練中心:CECJ65、MSIT70；南區訓練中心:WBUY60','“Libertatem Defendimus” – “Liberty We Defend” -2nd Bomb Wing (2nd BW)' ];
		var currentTipIndex = 0;

		function recursiveTimeout() {
		    setTimeout(function () {
		        currentTipIndex++;
		        if (currentTipIndex >= tips.length) {
		            currentTipIndex = 0;
		        }
		        $(".wordShow").fadeOut(800, function () {
		            $(".wordShow").html(tips[currentTipIndex]);
		        });

		        $(".wordShow").fadeIn(3000, recursiveTimeout());
		    }, 1 * 3 * 2000);

		};
	
		recursiveTimeout();
		

jQuery('#login').dialog({
			autoOpen: false,
		     show: {
		       effect: "blind",
		       duration: 500
		     },
		     hide: {
		       effect: "blind",
		       duration: 500
		     },
		    resizable: false,
		    height:300,
		    width:300,
		    modal: true,
		    buttons: {
		      "登入": function() {
		        jQuery('#form_login').submit();
		      },
		     "取消": function() {
		        $( this ).dialog( "close" );
		      }
		    }
		});
</script>
<c:if test="${param.isError=='yes'}"><script>$("#login").dialog("open");</script></c:if>
<c:remove var="errorMSG" scope="request"/>
</body>
</html>