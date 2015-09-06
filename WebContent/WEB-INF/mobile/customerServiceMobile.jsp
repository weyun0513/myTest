<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpoint"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>客服</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/mqtt.js"></script>
<link rel="stylesheet" type="text/css" href="themes/bluemix.min.css">
	<link rel="stylesheet" type="text/css" href="themes/jquery.mobile.icons.min.css">
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.3/jquery.mobile.structure-1.4.3.min.css" />
	<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.3/jquery.mobile-1.4.3.min.js"></script>
	
<style type="text/css">
	.ui-dialog-contain {
	width: 92.5%;
	max-width: 500px;
	margin: 10% auto 15px auto;
	padding: 0;
	position: relative;
	top: -15px;
	}
	.chat_view{
	width: 92.5%;
	height:300px;
	max-height:40%;
	}
}
	</style>
<script>
	var rand = '0000000' + Math.floor(Math.random() * 1000000);
	rand = rand.substring(rand.length - 6);
	var pilot = null;

	function init() {
		testWebSocket();
	}

	function testWebSocket() {

		pilot = new Mosquitto();

		var url = "ws://broker.mqttdashboard.com:8000";
		var url2 = "ws://test.mosquitto.org:8080/mqtt";
		pilot.connect(url);
		pilot.subscribe('xxxx/' + rand, 0);
		pilot.subscribe('xxxx/service/all', 0);
		pilot.onconnect = function(evt) {
			alert()
			onOpen(evt);
		};
		pilot.ondisconnect = function(evt) {
			onClose(evt);
		};
		pilot.onmessage = function(topic, payload, qos) {
			if (topic != 'PING') {
				onMessage(topic, payload, qos);
			}
		};
	}

	function onOpen(evt) {
		writeToScreen('<span style="color:white;">CONNECTED</span>');

		// doSend("WebSocket rocks"); 
	}
	function onClose(evt) {
		testWebSocket();
		// writeToScreen("DISCONNECTED"); 
	}
	function onMessage(topic, payload, qos) {
		payload = decodeURIComponent(payload);
		if (topic == 'xxxx/service/all') {
			jQuery('#pop').empty().append('<p>' + payload + '</p>');
			jQuery('#toDialog').click();
		} else if (topic == 'xxxx/' + rand)
			writeToScreen('<span style="color: yellow;">客服:' + payload
					+ '</span>');
	}
	function doSend(message) {
		writeToScreen('<span style="color:white;">我:' + message+'</span>');
		message = encodeURIComponent(message);
		pilot.publish('xxxx/service', rand + ',' + message, 0, true);

	}
	function writeToScreen(message) {

		jQuery('#chat_view').append("<div>" + message + "</div>");
	}
	window.addEventListener("load", init, false);
</script>
</head>
<body>
	<div data-role="page" id="page_main" >
        <div data-role="header">
        	<a data-role="button" href="${pageContext.request.contextPath}/index_mobile_customerService.jsp" 
        	   data-icon="back" data-iconpos="left" data-inlne="true">
               Back
            </a>
			<h3>線上客服</h3>
		<a data-role="button" href="${pageContext.request.contextPath}/index_mobile.jsp"
        	   data-icon="home" data-iconpos="left" data-inlne="true">
               Home
            </a>
        </div>

		<div data-role="main" class="ui-content">
			<div id="chat_view" class="chat_view" >
			
			</div>
			<div>
				<input type="text" id="sendText" name="sendText" value="" />
			</div>
			<div>
				<input type="button" id="sendBtn" name="sendBtn" value="送出" />
			</div>
			 <a href="#dialogPage" data-rel="dialog" data-transition="flip"  id="toDialog" style="display:none">Open dialog</a>
		</div>

		<div data-role="footer"></div>
	</div>


	<div data-role="page" id="dialogPage">
		<div data-role="header">
			<h2>廣播</h2>
		</div>
		<div role="main" class="ui-content" id='pop' >
			
		</div>
		<a data-rel="back" data-role="button"  onclick="javascript:jQuery('#pop').empty();" >確認</a>
	</div>
	<script>
		jQuery('#sendBtn').click(function() {
			var message = jQuery('#sendText').val();
			if (message.length > 0) {
				jQuery('#sendText').val("");
				doSend(message);
			}
		});
	</script>
</body>
</html>