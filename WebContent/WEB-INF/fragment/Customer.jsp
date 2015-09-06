<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/mqtt31.js"></script>

<style>
.chat_view {
background-color: white;
}
.time{
	font-size:10px;
}
.serviceMessage{
	margin:10px;
	color:black;
	text-align:right;
	border-style: outset;
	border-width: 1px;
	z-index:999;
	background:#4BC2ED;
	-moz-border-radius: 8px;
	-webkit-border-radius: 8px;
	box-shadow: 3px 3px 10px #666;
	-moz-box-shadow: 3px 3px 10px #666;
	-webkit-box-shadow: 3px 3px 10px #666;
}
.customerMessage{
	margin:10px;
	color:black;
	text-align:left;
	border-style: outset;
	border-width: 1px;
	z-index:999;
	background:#4BC2ED;
	-moz-border-radius: 8px;
	-webkit-border-radius: 8px;
	box-shadow: 3px 3px 10px #666;
	-moz-box-shadow: 3px 3px 10px #666;
	-webkit-box-shadow: 3px 3px 10px #666;
}
</style>
<script>
	jQuery(document).ready(function() {
		jQuery("#customservice_chat").hide();
		jQuery('#icon-small').hide();
		jQuery('#content').css('width','0px')
		  .css('height','0px');
		jQuery('#icon-small').click(function(){
			jQuery('#content').css('width','0')
							  .css('height','0').hide();
			jQuery('#icon-small').hide();
			jQuery('#icon-big').show();
		});
		jQuery('#icon-big').click(function(){
			jQuery('#content').css('width','180px')
			  				  .css('height','230px').show();
			jQuery('#icon-big').hide();
			jQuery('#icon-small').show();
		});
	});
	var wordArray=new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9");
	var rand ="";
	for(var i=0;i<6;i++)
		rand+= wordArray[Math.floor(Math.random() * 36)] ;
	
	var pilot = null;
	function init() {
		testWebSocket();
	}
	function testWebSocket() {
		pilot = new Paho.MQTT.Client("broker.mqtt-dashboard.com", 8000, "pilot"+rand);
		pilot.onConnectionLost = onConnectionLost;
		pilot.onMessageArrived = onMessageArrived;
		pilot.disconnect=function(){
			isConnect("嘗試連線.....");
		};
		var willMessageOB = new Paho.MQTT.Message(rand);
		willMessageOB.destinationName = 'yyyy/service/close';
		
	//	pilot.connect({onSuccess:onConnect,cleanSession:false});
		pilot.connect({onSuccess:onConnect,cleanSession:false,willMessage:willMessageOB});
		
	}
	function onConnect() {
		if(pilot.isConnected()) {
			pilot.subscribe('yyyy/'+rand,1);
			pilot.subscribe('yyyy/service/all', 1);
			isConnect("連線成功!");
		}
	}
	function onConnectionLost (evt) {
		testWebSocket();
		
	}
	function onMessageArrived(message) {
		
		var topic=message.destinationName;
		var payload=message.payloadString;
		//alert(topic+"  "+payload);
		
		payload=decodeURIComponent(payload);
		if(topic=='yyyy/service/all'){
			var title=payload.substring(0,payload.indexOf(','));
        	var msg=payload.substring(payload.indexOf(',')+1);
        	
			jQuery('#pop').html('<div id="pop2" title="'+title+'">'+msg+'</div>')
						  .find('#pop2').dialog({
								resizable: false,
			      				modal: true,
			     				buttons: {
			        				'離開': function() {
			          					$( this ).dialog( "close" );
			        			}
			    }
			});
		}
		else if(topic=='yyyy/'+rand){
			if(!jQuery("#customservice_chat").dialog('isOpen')){
				jQuery('#customservice').css("background-image","url(${pageContext.request.contextPath}/images/flash.gif)");
			}
			writeToScreen('<span style="float:right;"><span class="time">'+new Date().getHours()+':'+new Date().getMinutes()+'</span><span class="serviceMessage">客服：' + payload + '</span></span>');
		}
	}
	function doSend(message) {
		writeToScreen('<span  style="float:left;"><span class="customerMessage">我：' + message+'</span><span class="time">'+new Date().getHours()+':'+new Date().getMinutes()+'</span></span>');
		message=encodeURIComponent(message);
		var messageMQTT = new Paho.MQTT.Message(rand+','+message);
		messageMQTT.destinationName = 'yyyy/service';
		messageMQTT.qos=1;
		pilot.send(messageMQTT);
	}
	function writeToScreen(message) {
		jQuery('#chat_view').append('<br>'+message);
	}
	function isConnect(message){
		jQuery('#isConnect').html(message);
	}
window.addEventListener("load", init, false);

function doInput() {
		jQuery('#customservice').hide();
		jQuery("#customservice_chat").dialog({
			width : 400,
			height : 400,
			close : function() {
				$(this).dialog("close");
				jQuery('#customservice').show();
			}
		});
	}
</script>
<div id="customservice_chat">
	<div id="chat_view" class="chat_view"><div id="isConnect">嘗試連線.....</div></div>
	<div>
		<textarea id="sendText"></textarea>
		<input type="button" value="送出" id="sendBtn">
	</div>
</div>
<script>
	jQuery('#customservice_chat').hide();
	jQuery('#sendBtn').click(function() {
		var message = jQuery('#sendText').val();
		if (message.length > 0) {
			jQuery('#sendText').val("");
			doSend(message);
		}
	});
</script>

<div id="customservice">
	<div
		style="color:black;font-family:'微軟正黑體'; font-size:18px; text-align:center; vertical-align: middle;">
		線上客服系統
   	 	<a href="#"><img id="icon-small" src="${pageContext.request.contextPath}/images/icon/small.png"></a>
   	 	<a href="#"><img id="icon-big" src="${pageContext.request.contextPath}/images/icon/big.png"></a>
		</div>
	<div>
		<img id="content" src="${pageContext.request.contextPath}/css/customservice.jpg"
			onclick="doInput();">
	</div>
</div>
<div id='pop'></div>
<script> 
		    $( "#customservice" ).click(function(){
		    	jQuery(this).css("background-image","url(${pageContext.request.contextPath}/images/noflash.png)");
		    });
		    jQuery("#customservice_chat").hide();
</script>