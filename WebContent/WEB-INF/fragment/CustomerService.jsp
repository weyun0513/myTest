	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

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
var service=null;
function init() {
                testWebSocket();
            }
            function testWebSocket() {
            	var wordArray=new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9");
            	var rand ="";
            	for(var i=0;i<6;i++)
            		rand+= wordArray[Math.floor(Math.random() * 36)] ;
            	service = new Paho.MQTT.Client("broker.mqtt-dashboard.com", 8000, "service"+rand);
            	service.onConnectionLost = onConnectionLost;
            	service.onMessageArrived = function(message) {
            		var topic=message.destinationName;
            		var payload=message.payloadString;
            		if(topic=='yyyy/service/close'){
            			closePilot(payload);
            		}else if(topic!='yyyy/service/all'&&topic!='PING'&&payload.trim().indexOf(',')!=0){
        				onMessage(topic, payload);
        			}
        		};
            	service.disconnect=function(){
            		jQuery('#customservice').css("background","#CCCCCC");
        		};
        		service.connect({onSuccess:onConnect,cleanSession:false});
            }
            //websocket.onopen這個事件是用來判斷前面的 wsUri 是否有順利抓到
            function onConnect(evt) {
            	service.subscribe('yyyy/service/#', 1);
                writeToScreen("CONNECTED");
                jQuery('#customservice').css("background","white");
              
            }  
            function onConnectionLost(evt) { 
               // writeToScreen("DISCONNECTED"); 
                testWebSocket(); 
            }  
           
            function onMessage(topic, payload) {
            	var firstCarma=payload.indexOf(',');
            	var id=payload.substring(0,firstCarma);
            	var msg=payload.substring(firstCarma+1);
            	
            	if(jQuery('#customservice_chat'+id).length==0){
            		newDialog(id);
            		jQuery('#customservice').css("background-image","url(${pageContext.request.contextPath}/images/flash.gif)");	
            	}
            	else{
            		if(!jQuery('#customservice_chat'+id).dialog('isOpen')){
            			jQuery('#customservice').css("background-image","url(${pageContext.request.contextPath}/images/flash.gif)");
            			var number=parseInt(jQuery('#number'+id).text());
                		number++;
                		jQuery('#number'+id).empty().text(number);
            		}
            	}
            	msg=decodeURIComponent(msg);
            	writeToScreen('<span style="float:right;"><span class="time">'+new Date().getHours()+':'+new Date().getMinutes()+'</span><span class="serviceMessage">飛行員:' + msg + '</span></span>',id);
            }  
            function doSend(message,id) { 
            	writeToScreen('<span style="float:left;"><span class="customerMessage">我:' + message+'</span><span class="time">'+new Date().getHours()+':'+new Date().getMinutes()+'</span></span>',id);
                message=encodeURIComponent(message);
                var messageMQTT = new Paho.MQTT.Message(message);
        		messageMQTT.destinationName = 'yyyy/'+id;
        		messageMQTT.qos=1;
        		service.send(messageMQTT);
            }  
            function writeToScreen(message,id) { 
               jQuery('#chat_view'+id).append("<br>"+message).scrollTop =jQuery('#chat_view'+id).scrollHeight ;
            }  
            window.addEventListener("load", init, false);
//飛行員下線        
function closePilot(id){
        jQuery('#customservice_chat'+id).remove();
        jQuery('#content'+id).remove();
        
}
//新增對話框
function newDialog(id){
//新的dialog
	jQuery('#dialogAll').append('<div title="飛行員:'+id+'"id="customservice_chat'+id+'">'
			+'<div id="chat_view'+id+'" class="chat_view"></div>'
			+'<div><textarea id="sendText'+id+'"></textarea >'
			+'<input type="button" value="送出" id="sendBtn'+id+'"></div>'
			+'</div>');
	jQuery('#customservice_chat'+id).dialog({
		autoOpen: false,
		maxHeight:400,
		maxWidth:400,
		minHeight:400,
		minWidth:400
	});
//註冊事件	
	jQuery('#sendBtn'+id).click(function(){
        	var message=jQuery('#sendText'+id).val();
        	if(message.length>0){
        		jQuery('#sendText'+id).val("");
        		doSend(message,id);
        	}
	});
//點了才有對話框
	jQuery('#content').append('<div id="content'+id+'"><span  class="listBtn"'
			+'onclick="showDialog(\''+id+'\');">'+id+'</span>&nbsp;'
			+'<span id="number'+id+'">1</span><span>筆未看</span></div>');
}
function showDialog(id) {
	jQuery('#customservice_chat'+id).dialog('open');
	jQuery('#number'+id+'').empty().text('0');
}
jQuery(document).ready(function(){
	$( "#toAllPilot" ).hide();
	
	    $( "#toAllPilot" ).dialog({
	    						autoOpen: false,
	    					    height:540,
	    					    width:480,
	    					    modal: true,
	    					    buttons: {
	    					      "送出": function() {
	    					    	  var text=jQuery('input[name="title"]').val()+','+jQuery('#allTalk').val();
	    					    	  text=encodeURIComponent(text);
	    					    	  var messageMQTT = new Paho.MQTT.Message(text);
	    				        		messageMQTT.destinationName = 'yyyy/service/all';
	    				        		messageMQTT.qos=1;
	    				        		service.send(messageMQTT);
	    					    	  jQuery('#allTalk,input[name="title"]').val("");
	    					    	  $( this ).dialog( "close" );
	    					      },
	    					      Cancel: function() {
	    					        $( this ).dialog( "close" );
	    					      }
	    					    }
	    				 });
	 jQuery('#opener').click(function(){
		 $( "#toAllPilot" ).dialog("open");
		 
	 });
	jQuery('#icon-small').hide();
	
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

</script> 
    
	<div id="dialogAll"></div>
	<div id="customservice">
   	 	<div id="test" style="color:black;font-family:'微軟正黑體'; font-size:18px; text-align:center; vertical-align: middle;"><span>客服系統</span>
   	 	<a href="#"><img style="vertical-align: middle;" id="icon-small" src="${pageContext.request.contextPath}/images/icon/small.png"></a>
   	 	<a href="#"><img style="vertical-align: middle;" id="icon-big" src="${pageContext.request.contextPath}/images/icon/big.png"></a>
   	 	<a href="#"><img style="vertical-align: middle;" id="opener" src="${pageContext.request.contextPath}/images/icon/talkAll.png"></a>
   	 	</div>
   	 	<div id="content"></div>
	</div>
	<script>
			jQuery('#customservice').css("background","#CCCCCC");
	</script>
	<div id="toAllPilot" title="集體廣播">
	<div style="align:center;"><label>請輸入標題:</label><input type="text" name="title"></div>
	<textarea id="allTalk" style="margin:10px auto;width:420px;height:280px"></textarea>
	</div>
	<script> 
		    $( "#customservice" ).click(function(){
		    	jQuery(this).css("background-image","url(${pageContext.request.contextPath}/images/noflash.png)");
		    });
	</script> 