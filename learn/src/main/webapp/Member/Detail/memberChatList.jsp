<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅 목록</title>

<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<style type="text/css">
	#inquiry {
		display: none;
	}
	
	/* 버튼 css */
	.button {
	  background-color: gray;
	  border: 1px solid white;
	  color: white;
	  padding: 10px 20px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 16px;
	  cursor: pointer;
	}
	
	#active {
		background-color: #00C471;
	}
  	.inner2 {
		width: 1100px;
		display: inline-block;
		text-align: left;
		margin-left: 0%;
	}
	.outer2 {
		text-align: center;
	}
	.button2:hover {
	  box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
	}
	.tabla {
		width: 1100px;
	}
	.table th, .table td {
		text-align: center;
	}
	
	.detail {
	  background-color: #00C471; 
	  border: none;
	  color: white;
 	  padding: 1px 10px 1px 10px; 
	  text-decoration: none;
	  display: inline-block;
 	  font-size: 15px; 
	  cursor: pointer;
	  border-radius: 12px;
	}

</style>
</head>
<body>
	<%@ include file="../../Common/header.jsp"%>	
	
	<br><br>
<!-- 	이것은 답장 여부에 따라서 할지... -->
<!-- <div class="outer2"> -->
<!-- 	<div class="inner2"> -->
<!-- 		<div class="btn-group" id="dispBody3"> -->
<!-- 			<button class="button button2" id="active" onclick="getFalseResume()">승인대기</button> -->
<!-- 			<button class="button button2" onclick="getTrueResume()">승인완료</button> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->
	<br><br>
	
<div class="outer2">
	<div class="inner2">
		<table class="table">
			<thead>
				<tr>
					<th width="10%">방번호</th>
					<th width="20%">방 제목</th>
					<th width="30%">채팅내용</th>
					<th width="15%">최근 채팅일</th>
					<th>미응답</th>
				</tr>
			</thead>
			<tbody id="dispBody">
				<c:if test="${not empty memberChatList }">
					<c:forEach varStatus="vs" var="memberChat" items="${memberChatList }">
						<tr>
							<td>${vs.count }</td>
							<a></a>
							<c:if test="${memberChat.senderId != user.userId }">
								<td><a href="${pageContext.request.contextPath}/memberChat/memberChatRoom.do?senderId=${memberChat.senderId }&receiverId=${memberChat.receiverId }">
								${memberChat.senderName} 님과의 채팅방</a></td>
							</c:if>
							<c:if test="${memberChat.receiverId != user.userId }">
								<td><a href="${pageContext.request.contextPath}/memberChat/memberChatRoom.do?senderId=${memberChat.senderId }&receiverId=${memberChat.receiverId }">
								${memberChat.receiverName} 님과의 채팅방</a></td>
							</c:if>
							
							<td>
					         <c:choose>
					         	<c:when test="${memberChat.chatContents == null}">
					         		...
					         	</c:when>
					         	<c:when test="${fn:length(memberChat.chatContents) > 20}">
					          		${fn:substring(memberChats.chatContent,0,20)}
					         	</c:when>
					         	<c:otherwise>
					          		${memberChat.chatContents}
					         	</c:otherwise> 
					       	</c:choose>
							</td>
							
							<td>${memberChat.chatRegdate.substring(0,10) }</td>
							
							<c:choose>
								<c:when test="${memberChat.chatStatus == 'FALSE'}">
									<td><b style="color: red;">미응답</b></td>	
								</c:when>
								<c:otherwise>
									<td> - </td>
								</c:otherwise>
							</c:choose>
							
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty memberChatList }">
					<tr>
						<td colspan="6">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
<br><br>	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

</body>

	<footer>
		<%@ include file="../../Common/footer.jsp"%>
	</footer>
</html>