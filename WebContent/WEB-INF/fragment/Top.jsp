<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout.css">
<style type="text/css">
.topWrapper {
	height: 30px;
	background:
		url("${pageContext.request.contextPath}/images/squared_metal.png")
		repeat;
}

.topBar {
	width: 1200px;
	margin: auto;
	text-align: right;
	font-size: 14px;
	font-family: "微軟正黑體";
	font-weight: bold;
	color: #666;
	line-height: 30px;
}

.topBar .divP:before {
	width: 14px;
	height: 14px;
	content: "";
	background:
		url("${pageContext.request.contextPath}/images/manager-26.png")
		no-repeat center;
	display: inline-block;
	margin-right: 5px;
	top: 4px;
}

.topBar span {
	color: #444;
}

.wrapper {
	width: 1200px;
	margin: auto;
	padding: 20px;
}

#container {
	border-radius: 20px;
	border-color: #d0e5f5;
	border-width: 2px;
}

#customservice {
	border-style: outset;
	border-width: 1px;
	z-index:100;
	float: right;
  	position: fixed; 
 	right: 0px; 
	bottom: 0px;
	border: 0;
	padding: 10px;
	margin-bottom: 10px;
	background: #EEE;

	-moz-border-radius: 8px;
	-webkit-border-radius: 8px;
	box-shadow: 3px 3px 10px #666;
	-moz-box-shadow: 3px 3px 10px #666;
	-webkit-box-shadow: 3px 3px 10px #666;
}

.chat_view {
	background-color: blue;
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
		$("#login").dialog("open");
	}
</script>


	<div id="login" title="登入">
		<form action="${pageContext.request.contextPath}/LoginServlet" method="POST" id="form_login">
			<div><label>帳號:</label> <input type="text" name="username" value=""><font style="color:red">${errorMSG.username}</font></div>
			<div><label>密碼:</label> <input type="text" name="password" value=""><font style="color:red">${errorMSG.password}</font></div>
			<div><input type="checkbox" name="remember" value="true">
			<label>記住密碼</label> </div>
		</form>
	</div>


<script type="text/javascript">
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
      "Login": function() {
        jQuery('#form_login').submit();
      },
      Cancel: function() {
        $( this ).dialog( "close" );
      }
    }
  });



</script>
<c:choose>
	<c:when test="${empty LoginOK}">
		<div class="topWrapper">
			<div class="topBar">
				<div class="divP">
					請登入： <span><a href="#" onclick="login();">Login </a></span>
				</div>
			</div>
		</div>
		<%@ include file="Customer.jsp"%>
	</c:when>
	<c:otherwise>
		<div class="topWrapper">
			<div class="topBar">
				<div class="divP">
					Welcome, 管理員${LoginOK.username} <span><a
						href="${pageContext.request.contextPath}/LoginServlet?action=logout">登出</a></span>
				</div>
			</div>
		</div>
		<%@ include file="CustomerService.jsp"%>
	</c:otherwise>
</c:choose>
<c:if test="${param.isError=='yes'}"><script>$("#login").dialog("open");</script></c:if>
<c:remove var="errorMSG" scope="request"/>