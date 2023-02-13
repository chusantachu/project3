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
	
		function timeCal(){
			var today = new Date();   

			var hours = ('0' + today.getHours()).slice(-2); 
			var minutes = ('0' + today.getMinutes()).slice(-2);

			var timeString = hours + ':' + minutes;
			
			return timeString;
		}
	
	
		var webSocket = {
				
			init: function(param) {
				this._url = param.url;
				this._initSocket();
			},
			
			
			sendChat: function() {
				if($('#message').val() == ''){
					alert("입력값이 없습니다.");
					return false;
				}
				
				var ChatroomNo = "${memberChatRoomList.chatroomNo}";
				var SenderId = "${user.userId}";
				var ChatContent = $('#message').val();
				
				sendMessages = {
						chatroomNo : ChatroomNo,
						senderId :  SenderId,
						chatContent : ChatContent
				};
				
				$.ajax({
					url : "${pageContext.request.contextPath }/memberChat/sendMessage.do",
					data : sendMessages,
					type : "post",
					async : false,

					success : function(data) {
						console.log("업데이트 성공");
						
					},
					error : function() {
						console.log("실패");
					}
				});
						
				// this._sendMessage 하기 전에 컨텐트 내용 업데이트 하기
				var time = timeCal();
				this._sendMessage('${memberChatRoomList.chatroomNo}', 'CMD_MSG_SEND', $('#message').val(), '${user.userName}', time);
				
			},
			
			
			sendEnter: function() {
				var time = timeCal();
				this._sendMessage('${memberChatRoomList.chatroomNo}', 'CMD_ENTER', $('#message').val(), '${user.userName}', time);
				$('#message').val('');
				
			},
			
			
			receiveMessage: function(msgData) {
				
				var myMsg = $('#message').val();
				console.log(myMsg);
				console.log(msgData.msg);
				
				console.log(msgData);

				
				// 정의된 CMD 코드에 따라서 분기 처리
				if(msgData.msg == myMsg){
					if(msgData.cmd == 'CMD_MSG_SEND') {		
						var str = "<div class='col-10' style='text-align: right;'>";
						str += "<div class='alert alert-success'>";
						str += "<div><b>" + msgData.userName + "</b> (" + msgData.time +")</div>";
						str += "<div>" + msgData.msg + "</div></div></div>";
						$('#divChatData').append(str);
					}
				}else {
					if(msgData.cmd == 'CMD_MSG_SEND') {		
						var str = "<div class='col-10' style='text-align: left;'>";
						str += "<div class='alert alert-warning'>";
						str += "<div><b>" + msgData.userName + "</b></div>";
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
// 					webSocket.closeMessage(JSON.parse(evt.data));
				}
				
			},
			
			_sendMessage: function(bang_id, cmd, msg, userName, time) {
				
				var msgData = {
						bang_id : bang_id,
						cmd : cmd,
						msg : msg,
						userName : userName,
						time : time
				};
				var jsonData = JSON.stringify(msgData);
				this._socket.send(jsonData);
			}
		};
		
		function seeYourMsg(){
			// 룸 번호랑 상대방아이디 받아와야 함			
			var memberChatRoomNo = '${memberChatRoomList.chatroomNo}';
			var myId = '${user.userId}';
			
			console.log("memberChatRoomNo : " + memberChatRoomNo);
			console.log("myId : " + myId);

			var gogo = "${pageContext.request.contextPath }/memberChat/seeYourMsg.do";
			gogo = gogo + "?chatroomNo=" +  memberChatRoomNo;
			gogo = gogo + "&senderId=" + myId;
			
			$.ajax({
				url : gogo,
				type : "post",
				async : false,

				success : function(data) {
					console.log("업데이트 성공");
					
				},
				error : function() {
					console.log("실패");
				}
			});
		}
		
	</script>	
	<script type="text/javascript">
	
        $(window).on('load', function () {
        	
			webSocket.init({ url: '<c:url value="/memberChat" />' });	
			
			seeYourMsg();
			
		});
        
        
	</script>
	<style type="text/css">
	#inquiry {
		display: none;
	}
	</style>
</head>
<body>
	<%@ include file="../../Common/header.jsp"%>
	<div class="container-fluid" style="background-color: lightgreen;">
		<h2>&nbsp; </h2>
	</div>
	<div class="container">
			<div class="col-12 justify-content-center" style='text-align: center; flex-direction:column_reverse; color: green; '>
				<h2>
				<c:choose>
					<c:when test="${user.userId != memberChatRoomList.senderId } ">
						${memberChatRoomList.senderName }님과의 채팅방
					</c:when>
					<c:otherwise>
						${memberChatRoomList.receiverName }님과의 채팅방
					</c:otherwise>
				</c:choose>
				</h2>
				<div style="color: gray;"></div>
				<p>성장 기회의 평등 평화로운 채팅되세요</p>
			</div>
			<div class="col-12 justify-content-center" id="mydiv" style="overflow-y: scroll; height:600px; overflow: auto;">
				<div id="divChatData" class="">
				
				
					<c:if test="${not empty memberChatContents}">
						<c:forEach var="contentList" items="${memberChatContents }">
							<c:if test="${contentList.senderId == user.userId}">

								<div class='col-10' style='text-align: right;'>
									<div class='alert alert-success'>
										<div>
											<c:choose>
												<c:when test="${memberChatRoomList.senderId == user.userId}">
													<b>${memberChatRoomList.senderName} </b> (${contentList.chatRegdate.substring(0,16)})
												</c:when>
												<c:otherwise>
													<b>${memberChatRoomList.receiverName}</b> (${contentList.chatRegdate.substring(0,16)})
												</c:otherwise>
											</c:choose>
										</div>									
										<div>${contentList.chatContent }</div>
									</div>
								</div>
								
							</c:if>
							
							<c:if test="${contentList.senderId != user.userId}">
								<div class='col-10' style='text-align: left;'>
									<div class='alert alert-warning'>
										<div>
											<c:choose>
												<c:when test="${memberChatRoomList.senderId != user.userId}">
													<b>${memberChatRoomList.senderName}</b> (${contentList.chatRegdate.substring(0,16)})
												</c:when>
												<c:otherwise>
													<b>${memberChatRoomList.receiverName}</b> (${contentList.chatRegdate.substring(0,16)})
												</c:otherwise>
											</c:choose>
										</div>										
										<div>${contentList.chatContent }</div>
									</div>
								</div>
							</c:if>
							
						</c:forEach>
					</c:if>
					
					
				
				</div>
			</div>
			<br>
			<div class="col-12 justify-content-center"><!--  style="position: absolute; bottom: 5%;" -->
					<div class="row">
						<div class="col-11">
							<input type="text" placeholder="메세지를 입력해주세요" id="message" class="form-control" style="width: 100%;"
							onkeypress="if(event.keyCode==13){webSocket.sendChat();}" />
						</div>
<!-- 						<div class="col-1"> -->
<!-- 							<input type="button" id="btnSend" value="전송" onclick="webSocket.sendChat()" /> -->
<!-- 						</div> -->
					</div>
			</div>
			<br>
			<br>
			
			<div class="col-6"></div>
		</div>
</body>
	<footer>
		<%@ include file="../../Common/footer.jsp"%>
	</footer>
</html>