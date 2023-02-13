<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<style type="text/css">
	#inquiry {
		display: none;
	}
</style>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<div class="container-fluid" style="background-color: lightgreen;">
				<h2>&nbsp; </h2>
	</div>
<!-- 	<input type="text" id="message" class="form-control"
							aria-label="Recipient's username"
							aria-describedby="button-addon2">
	<input type="button" id="sendBtn" value="submit"/>
	<div id="messageArea"></div>
	
	
	<hr><hr><hr><hr><hr> -->
	<div>
		<div class="container">
			<div class="col-12 justify-content-center" style='text-align: center; flex-direction:column_reverse; color: green; '>
				<h2>인프런에 끼리끼리 수다떨기</h2>
				<div style="color: gray;"></div>
				<p>성장 기회의 평등</p>
				<p>욕설, 음담패설 등 상대방을 기분나쁘게 하는 용어는 금지!!입니다.</p>
			</div>
			<div class="col-12 justify-content-center" id="mydiv" style="overflow-y: scroll; height:600px; overflow: auto;">
				<div id="msgArea" class=""></div>
			</div>
			<div class="col-12 justify-content-center"><!--  style="position: absolute; bottom: 5%;" -->
					<div class="row">
						<div class="col-11">
							<input type="text" id="msg" class="form-control" style="width: 100%;"
								aria-label="Recipient's username"
								aria-describedby="button-addon2"
								onkeypress="if(event.keyCode==13){enterKey();}" placeholder="내용을 입력해주세요.">
						</div>
<!-- 						<div class="col-1">
							<button class="btn btn-outline-secondary" type="button" id="button-send">
								전송
							</button>
						</div> -->
					</div>
			</div>
			<div class="col-6"></div>
		</div>
	</div>

</body>

<script>
	//전송 버튼 누르는 이벤트
	var myMsg = '';
	function enterKey(){
		myMsg = '';
		myMsg = $('#msg').val();
		if(myMsg == ''){
			alert("내용이 없습니다.");
			return false;
		}
		sendMessage();
		console.log(myMsg);
		$('#msg').val('')
	}
	/* $("#button-send").on("click", function(e) {
		myMsg = '';
		myMsg = $('#msg').val();
		if(myMsg == ''){
			alert("내용이 없습니다.");
			return false;
		}
		sendMessage();
		console.log(myMsg);
		$('#msg').val('')
	}); */

	var sock2 = new SockJS("http://192.168.18.10:8080/learn/echo?userId=${userId}");
	/*var sock2 = new SockJS("http://192.168.18.10:8080/learn/echo?userId=${userId}");*/
	sock2.onmessage = onMessage;
	sock2.onclose = onClose;
	sock2.onopen = onOpen;

	function sendMessage() {
		sock2.send($("#msg").val());
	}

	//서버에서 메시지를 받았을 때
	function onMessage(msg) {

		var data = msg.data;
		var sessionId = null; //데이터를 보낸 사람
		var message = null;
		console.log(data);
		var arr = data.split(":");

		for (var i = 0; i < arr.length; i++) {
			console.log('arr[' + i + ']: ' + arr[i]);
		}

		var cur_session = "${user.userId}"; //현재 세션에 로그인 한 사람
		console.log("cur_session : " + cur_session);

		/* sessionId = arr[0];
		message = arr[1]; */
		message = arr[0];
		var user = "${user.userName}";
		//로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
		if(myMsg == message){
			var str = "<div class='col-10' style='text-align: right;'>";
			str += "<div class='alert alert-success'>";
			str += "<b>" + message + "</b>";
			str += "</div></div>";

			$("#msgArea").append(str);
			$("#mydiv").scrollTop($("#mydiv")[0].scrollHeight);
			myMsg = '';
			
		}else{
			var str = "<div class='col-10' style='text-align: left;'>";
			str += "<div class='alert alert-warning'>";
			str += "<b>" + message + "</b>";
			str += "</div></div>";

			$("#msgArea").append(str);
			$("#mydiv").scrollTop($("#mydiv")[0].scrollHeight);
			myMsg = '';
		}


	}

	//채팅창에서 나갔을 때
	function onClose(evt) {

		var user = "${user.userName}";
		var str = user + " 님이 퇴장하셨습니다.";

		$("#msgArea").append(str);
	}
	//채팅창에 들어왔을 때
	function onOpen(evt) {

		var user = "${user.userName}";
		console.log(user);
		var str = user + "님이 입장하셨습니다.";

		$("#msgArea").append(str);
	}
</script>
	<footer>
		<%@ include file="../Common/footer.jsp"%>
	</footer>
</html>