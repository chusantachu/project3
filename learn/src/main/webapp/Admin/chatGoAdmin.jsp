<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>


<style type="text/css">
	#inquiry {
		display: none;
	}
	

	a:link {color:black;}
	a:visited {color:black;}
	a:hover {font-size:150%; color:black;}

</style>
</head>
<body>
	<%@ include file="/Admin/common/adminHeader.jspf" %>
	<br>
	<div class="container-fluid" style="background-color: gray;">
				<h2>상담 확인하기 </h2>
	</div>
	<br><br>
	<div class ="cotainer">
	<div class="row">
	<div class="col-1"></div>
	<div class="col-8 justify-content-center">
	<div class="row">
				<c:if test="${not empty contentRoomList}">
					<div class="col-12">
						<p style="float: right">
							<select name="status" class="" id="status">
								<option value="미응답">미응답</option>
								<option value="응답">응답</option>
							</select>
							<select name="order" class="" id="order">
								<option value="chat_regdate">최신순</option>
								<option value="chat_no" selected="">방번호순</option>
							</select>
						</p>
					</div>
				</c:if>
				</div>
		<table class="table table-hover">
			<thead>
				<tr>
					<th class="col-2" style="text-align: center;">방 번호</th>
					<th class="col-5" style="text-align: center;">방 아이디</th>
					<th class="col-3" style="text-align: center;">최근 채팅일</th>
					<th class="col-2" style="text-align: center;">답변 상태</th>
				</tr>
			</thead>
			<tbody style="overflow-y: scroll; overflow: auto; " id="listDisp">
			<c:if test="${empty contentRoomList }">
					<tr><td colspan="4">채팅방이 없습니다</td></tr>
				</c:if>
			<c:if test="${not empty contentRoomList}">
				<c:forEach var="contentRoomList" items="${contentRoomList }">
					<tr>
						<td style="text-align: center;">${contentRoomList.chatNo }</td>
						<td><a href="${pageContext.request.contextPath}/Admin/chatTest2.do?bang_id=${contentRoomList.userId }&userId=${contentRoomList.userId }">${contentRoomList.userId }</a></td>
						<td style="text-align: center;">${contentRoomList.chatRegdate }</td>
						<c:if test="${contentRoomList.chatOk == 1}">
							<td style="text-align: center;">응답완료</td>
						</c:if>
						<c:if test="${contentRoomList.chatOk == 0}">
							<td style="text-align: center;">미응답</td>
						</c:if>
					</tr>
				</c:forEach>
			</c:if>
				
			</tbody>
		</table>
	</div>
</div>
</div>
<br><br><br><br>

	<script>
	
	//검색 카테고리 정렬
		$("select[name=status]").change(function(){
			var typeVl = null;
		  	var selectetext = $('#status').val();//미응답, 응답 둘중 하나
		  	var order = $('#order').val();//chat_regdate, chat_no 둘중 하나
		  	typeVl = {
		  			searchStatus : selectetext,
					searchOrder : order
				};
		  	
		  	$.ajax({
				url : "${pageContext.request.contextPath}/Admin/chatSearchAdmin.do",
				data : typeVl,
				type : "post",
				async : false,

				success : function(data) {
					///////////////
					console.log(data);
					let dispHtml = "";
					$.each(data, function(index, obj){
						dispHtml +=	'<tr><td style="text-align: center;">'+this.chatNo+'</td>';
						dispHtml +=	'<td><a href="${pageContext.request.contextPath}/Admin/chatTest2.do?bang_id='+this.userId+'&userId='+this.userId+'">'+this.userId+'</a></td>';
						dispHtml +=	'<td style="text-align: center;">'+new Date(this.chatRegdate).getFullYear()+'-'+new Date(this.chatRegdate).getMonth()+'-'+new Date(this.chatRegdate).getDate()+'</td>';
						if(this.chatOk == 1){
							dispHtml += '<td style="text-align: center;">응답완료</td>';	
						}
						if(this.chatOk == 0){
							dispHtml += '<td style="text-align: center;">미응답</td>';
						}
						dispHtml += '</tr>';			
					});
					$("#listDisp").html(dispHtml);
				},
				error : function() {
					console.log("실패");
				}
			});
		  	
		});
		
		$("select[name=order]").change(function(){
			var typeVl = null;
		  	var selectetext = $('#status').val();//미응답, 응답 둘중 하나
		  	var order = $('#order').val();//chat_regdate, chat_no 둘중 하나
		  	typeVl = {
		  			searchStatus : selectetext,
					searchOrder : order
				};
		  	
		  	$.ajax({
				url : "${pageContext.request.contextPath}/Admin/chatSearchAdmin.do",
				data : typeVl,
				type : "post",
				async : false,

				success : function(data) {
					///////////////
					console.log(data);
					let dispHtml = "";
					$.each(data, function(index, obj){
						dispHtml +=	'<tr><td style="text-align: center;">'+this.chatNo+'</td>';
						dispHtml +=	'<td><a href="${pageContext.request.contextPath}/Admin/chatTest2.do?bang_id='+this.userId+'&userId='+this.userId+'">'+this.userId+'</a></td>';
						dispHtml +=	'<td style="text-align: center;">'+new Date(this.chatRegdate).getFullYear()+'-'+new Date(this.chatRegdate).getMonth()+'-'+new Date(this.chatRegdate).getDate()+'</td>';
						if(this.chatOk == 1){
							dispHtml += '<td style="text-align: center;">응답완료</td>';	
						}
						if(this.chatOk == 0){
							dispHtml += '<td style="text-align: center;">미응답</td>';
						}
						dispHtml += '</tr>';			
					});
					$("#listDisp").html(dispHtml);
				},
				error : function() {
					console.log("실패");
				}
			});
		  	
		});
	
	</script>



	<footer>
		<%@ include file="../Common/footer.jsp"%>
	</footer>
</body>
</html>