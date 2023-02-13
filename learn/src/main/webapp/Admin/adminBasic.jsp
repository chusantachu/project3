<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script> -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>	
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"
	charset="utf-8"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script> <!-- 추가한 부분 -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">
<style type="text/css">
	#inquiry {
		display: none;
	}
</style>
</head>
<body>

</body>
								
<!-- <button class="btn btn-info" id="listGo"><small>공지사항 리스트로 이동하기</small>	</button>
<br><br>
<button class="btn btn-info" id="detailGo"><small>작성한 공지사항 확인하기</small></button> -->
<script type="text/javascript">
var socket = null;
	$(document).ready(function(){
		if("${user.userId}" != null){
			connectWs();	
		}
})

function connectWs(){
	console.log("tttttt")
	var ws = new SockJS("http://192.168.18.10:8080/learn/alram");
	socket = ws;
	
		ws.onopen = function() {
			 console.log('open');
			 let socketMsg = "Notice,"+"${user.userId}"+","+"${user.userId}"+","+"${vo.boardNo }"+","+"New공지사항을 등록"+","+"했다";
				console.log(socketMsg);
				socket.send(socketMsg);
				console.log("실햇됬니?");
				location.href="getAdminNotice.do?boardNo=${vo.boardNo }";
	 };
	
		ws.onmessage = function(event) {
			console.log("onmessage"+event.data);
			let $socketAlert = $('div#socketAlert');
			$socketAlert.html(event.data)
			$socketAlert.css('display', 'block');
			
			setTimeout(function(){
				$socketAlert.css('display','none');
				
			}, 5000);
	};
	
		ws.onclose = function() {
		    console.log('close');
	 };
 
 
 

};

</script>