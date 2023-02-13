<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>웹소켓 채팅</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>
	<script type="text/javascript">
		var webSocket = {
			init: function(param) {
				this._url = param.url;
				console.log("당신의 주소값은?" + param.url);
				this._initSocket();
			},
			sendChat: function() {
				if($('#message').val() == ''){
					alert("입력값이 없습니다.");
					return false;
				}
				var content2 = $('#message').val();
				var userId2 = "${user.userId}";
				var typeVl = null;
				var bang_id2 = "${param.bang_id}";
				
				typeVl = {
						userId : bang_id2,
						content : content2,
						sendId : userId2
					};
						$.ajax({
							url : "${pageContext.request.contextPath }/admin/updateContent.do",
							data : typeVl,
							type : "post",
							async : false,

							success : function(data) {
								console.log("업데이트 성공");
								
							},
							error : function() {
								console.log("실패");
							}
						});
				this._sendMessage('${param.bang_id}', 'CMD_MSG_SEND', $('#message').val());
				// this._sendMessage 하기 전에 컨텐트 내용 업데이트 하기
			},
			sendEnter: function() {
				this._sendMessage('${param.bang_id}', 'CMD_ENTER', $('#message').val());
				$('#message').val('');
			},
			receiveMessage: function(msgData) {
				var myMsg = $('#message').val();
				console.log(myMsg);
				console.log(msgData.msg);
				// 정의된 CMD 코드에 따라서 분기 처리
				if(msgData.msg == myMsg){
					if(msgData.cmd == 'CMD_MSG_SEND') {		
						var str = "<div class='col-12' style='text-align: right;'>";
						str += "<div class='alert alert-success'>";
						str += "<div>" + msgData.msg + "</div></div></div>";
						$('#divChatData').append(str);
					}
				}else {
					if(msgData.cmd == 'CMD_MSG_SEND') {		
						var str = "<div class='col-12' style='text-align: left;'>";
						str += "<div class='alert alert-warning'>";
						str += "<div>" + msgData.msg + "</div></div></div>";
						$('#divChatData').append(str);
					}
				}
				$('#message').val('');
				
				// 입장
				if(msgData.cmd == 'CMD_ENTER') {
					$('#divChatData').append('<div>' + msgData.msg + '</div>');
				}
				// 퇴장
				else if(msgData.cmd == 'CMD_EXIT') {					
					$('#divChatData').append('<div>' + msgData.msg + '</div>');
				}
				$("#mydiv").scrollTop($("#mydiv")[0].scrollHeight);
			},
			closeMessage: function(str) {
				$('#divChatData').append('<div>' + '연결 끊김 : ' + str + '</div>');
				$("#mydiv").scrollTop($("#mydiv")[0].scrollHeight);
			},
			disconnect: function() {
				this._socket.close();
			},
			_initSocket: function() {
				this._socket = new SockJS(this._url);
				this._socket.onopen = function(evt) {
					webSocket.sendEnter();
				};
				this._socket.onmessage = function(evt) {
					webSocket.receiveMessage(JSON.parse(evt.data));
				};
				this._socket.onclose = function(evt) {
					webSocket.closeMessage(JSON.parse(evt.data));
				}
			},
			_sendMessage: function(bang_id, cmd, msg) {
				var msgData = {
						bang_id : bang_id,
						cmd : cmd,
						msg : msg
				};
				var jsonData = JSON.stringify(msgData);
				this._socket.send(jsonData);
			}
		};
	</script>	
	<script type="text/javascript">
        $(window).on('load', function () {
			webSocket.init({ url: '<c:url value="/chat" />' });	
		});
	</script>
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
	<div class="container">
			<div class="col-12 justify-content-center" style='text-align: center; flex-direction:column_reverse; color: green; '>
				<h2>인프런에 문의하기</h2>
				<div style="color: gray;"></div>
				<p>성장 기회의 평등</p>
				<p>궁금한 점은 언제든지 문의해주세요.</p>
				<c:if test="${user.grade == '관리자'}">
					<button class="btn" style="float: left;" 
					onclick="location.href='${pageContext.request.contextPath}/Admin/chatGoAdmin.do'">나가기</button>
					<br>
				</c:if>
			</div>
			<br>
			<div class="col-12 justify-content-center" id="mydiv" style="overflow-y: scroll; height:600px; overflow: auto;">
				<div id="divChatData" class="">
					<c:if test="${not empty contentList}">
						<c:forEach var="contentList" items="${contentList }">
							<c:if test="${contentList.sendId == user.userId}">
								<div class='col-12' style='text-align: right;'>
									<div class='alert alert-success'>
										<div>${contentList.content }</div>
									</div>
								</div>
							</c:if>
							<c:if test="${contentList.sendId != user.userId}">
								<div class='col-12' style='text-align: left;'>
									<div class='alert alert-warning'>
										<div>${contentList.content }</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</c:if>
				
				</div>
			</div>
			<div class="col-12 justify-content-center"><!--  style="position: absolute; bottom: 5%;" -->
					<div class="row">
						<div class="col-11">
							<input type="text" id="message" class="form-control" style="width: 100%;"
							onkeypress="if(event.keyCode==13){webSocket.sendChat();}" />
						</div>
						<div class="col-1">
							<input type="button" id="btnSend" value="전송" onclick="webSocket.sendChat()" />
						</div>
					</div>
			</div>
			<div class="col-6"></div>
		</div>
</body>
	<footer>
		<%@ include file="../Common/footer.jsp"%>
	</footer>
</html>