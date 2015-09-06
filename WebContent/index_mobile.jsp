<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link rel="stylesheet" type="text/css" href="themes/bluemix.min.css">
	<link rel="stylesheet" type="text/css" href="themes/jquery.mobile.icons.min.css">
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.3/jquery.mobile.structure-1.4.3.min.css" />
	<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.3/jquery.mobile-1.4.3.min.js"></script>
<title>Home</title>
</head>
<body>
	<div data-role="page" id="page_main">
        	
        <div data-role="main" class="ui-content">
        	<h3 style="text-align:center;color:#f6d375">Welcome to</h3>
        	<h3 style="text-align:center;color:#f6d375">Soaring High World</h3>
        	<div style="text-align:center"><img alt="logo" src="images/air2.png" height="70%" width="70%" align="middle"></div>
        	<form name="myForm" action="${pageContext.request.contextPath}/QueryPilotMobileServlet" method="post">
        		<input type="submit" value="START">
        	</form>		
        </div>
        
    </div>

	<div data-role="footer">
    	    		
    </div>

</body>
</html>