<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewpoint" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link rel="stylesheet" type="text/css" href="themes/bluemix.min.css">
	<link rel="stylesheet" type="text/css" href="themes/jquery.mobile.icons.min.css">
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.3/jquery.mobile.structure-1.4.3.min.css" />
	<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.3/jquery.mobile-1.4.3.min.js"></script>
<title>班級資訊</title>

<style type="text/css">
img {
    width  : 45%;
    height : 9%;
}

span {
	color : red;
}

</style>
<script>
function ChangeCheckCode() {
    var images = document.getElementById("img");
    images.src= document.getElementById("img").src+'?';
   }
</script>

</head>
<body>
	<div data-role="page" id="page_main" >
        <div data-role="header">
        	<a data-role="button" onclick="document.myForm.submit()" 
        	   data-icon="back" data-iconpos="left">
               Back
            </a>
        	<h3>Soaring High</h3>
        	<a data-role="button" href="${pageContext.request.contextPath}/index_mobile.jsp" 
        	   data-icon="home" data-iconpos="left" data-inlne="true">
               Home
            </a>		
        </div>
        
        <div data-role="main" class="ui-content">
        	<h3>班級資訊</h3>
        	<form method="post" action="${pageContext.request.contextPath}/classlist/Class.do">
                    <div>
                        <label for="classID_classNum">代號/期別</label>
                        <input type="text" id="classID_classNum" value="${classListVO.classTypeVO.classID}${classListVO.classNum}" readonly style="background:#ffffff; color:#000000"/>
                    </div>
                    <div>
                        <label for="className">班級名稱</label>
                        <input type="text" id="className" value="${classListVO.classTypeVO.className}" readonly style="background:#ffffff; color:#000000"/>
                    </div>
                    <div>
                        <label for="craftType">機種類型</label>
                        <input type="text" id="craftType" value="${classListVO.classTypeVO.aircraftVO.craftType}" readonly style="background:#ffffff; color:#000000"/>
                    </div>
                    <div>
                        <label for="startDate">開訓日期</label>
                        <input type="text" id="startDate"  value="<fmt:formatDate pattern="yyyy/MM/dd"  value="${classListVO.startDate}" />"  readonly style="background:#ffffff; color:#000000"/>
                    </div>
                    <div>
                        <label for="deptName">訓練單位</label>
                        <input type="text" id="deptName" value="${classListVO.trainDeptVO.deptName}"  readonly style="background:#ffffff; color:#000000"/>
                    </div>
                    <div>
                        <label for="pilotID">身份證字號</label><span>${msg.message1}</span>
                        <input type="text" id="pilotID"  name="pilotID" value="${param.pilotID}" style="background:#ffffff; color:#000000"/>
                    </div>
                    <div>
                        <label for="birthday">出生日期</label><span>${msg.message2}</span>
                        <input type="date" id="birthday" name="birthday" value="${param.birthday}" style="background:#ffffff; color:#000000"/>
                    </div>
                    <div>
                    	<label for="checkCode">圖形驗證碼</label><span>${msg.message3}</span>
                    	<input type="text" id="checkCode" name="checkCode" value="" style="background:#ffffff; color:#000000"><img id="img" src="${pageContext.request.contextPath }/CheckCode"/><a href="javascript:ChangeCheckCode();">更新驗證碼</a>
                    </div>
                    
                    <div>
                        <input type="submit" value="確認" />
                        <input type="hidden" name="classID" value="${classListVO.classTypeVO.classID}">
						<input type="hidden" name="classNum" value="${classListVO.classNum}">
						<input type="hidden" name="action" value="addReg2">
                    </div>
             </form>		
        </div>
        <div data-role="footer">
        		
        </div>
    </div>
    
    <form name="myForm" action="${pageContext.request.contextPath}/PilotQueryServlet" method="post" style="display:inline">
    	<input type="hidden" name="month" value="${sessionScope.monthAfter}" style="display:inline">
    </form>
</body>
</html>