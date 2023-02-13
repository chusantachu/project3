<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좋아요</title>
<style>
.tape {
	height: 100px;
	margin: 50px auto;
	padding-top: 15px;
	color: white;
}

.card .info {
	color: #fff;
	position: absolute;
	left: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.5);
	width: 100%;
	height: 100%;
	padding: 15px;
	box-sizing: border-box;
	opacity: 0;
	transition: opacity 0.35s ease-in-out;
}

.card:hover .info {
	opacity: 1;
}

.star-ratings {
  color: #aaa9a9; 
  position: relative;
  unicode-bidi: bidi-override;
  width: max-content;

}
 
.star-ratings-fill {
  color: #fff58c;
  padding: 0;
  position: absolute;
  z-index: 0;
  display: flex;
  top: 0;
  left: 0;
  overflow: hidden;
  -webkit-text-fill-color: gold;
}
 
.star-ratings-base {
  z-index: 0;
  padding: 0;
}

.active-menu {
        color: #1dc078;
        font-weight: bold;
      }
      .norm-menu {
        color: black;
      }



</style>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<div class="container-fluid bg-dark">
		<div class="container tape">
			<section class="tapeContent">
				<h2>좋아요</h2>
			</section>
		</div>
	</div>
	<div class="container-fluid mt-5 pb-3 d-flex justify-content-center">
		<div class="row pb-4 justify-content-center" style="width: 80%">
			<div class="col-2 d-flex justify-content-center">
				<%@ include file="sidebar.jspf"%>
				<script>
	              var menu = $('#mylike');
	              console.log(menu);
	              menu.removeClass('norm-menu');
	              menu.addClass('active-menu');
	            </script>
			</div>
			<div class="col-10 pl-3 gray-line">
				<div class="row">
				<c:if test="${not empty likeList}">
					<div class="col-12">
						<p style="float: right">
							<select name="status" class="" id="status">
								<option value="전체" selected="">유/무료</option>
								<option value="유료">유료</option>
								<option value="무료">무료</option>
							</select>
							<select name="order" class="" id="order">
								<option value="like_no">최신순</option>
								<option value="lecture_title">제목순</option>
								<option value="student_count">학생수순</option>
								<option value="reviewAverage">평점순</option>
							</select>
						</p>
						<p>
							전체 <span style="color: green"> 총갯수</span>
						</p>
					</div>
				</c:if>
				</div>
				<div class="row" id="listDisp">
				<c:if test="${empty likeList }">
					<tr><td colspan="9">좋아요가 비어 있습니다</td></tr>
				</c:if>
				<c:if test="${not empty likeList}">
					<c:forEach var="likeList" items="${likeList }">
						<div class="col-4" style="margin-bottom: 20px;">
							<div class="card" style="width: 100%; height: 500px;">
								<img class="card-img-top"
									src="${pageContext.request.contextPath}/filepath/${likeList.lectureCoverimg }"
									alt="Card image"
									style="width: 100%; height: auto; object-fit: cover;">
								<div class="card-body" style="overflow: hidden; padding: 10px;">
									<c:choose>
								        <c:when test="${fn:length(likeList.lectureTitle) gt 21}">
								        	<h4 class="card-title">${fn:substring(likeList.lectureTitle, 0, 20)}...</h4>
								        </c:when>
								        <c:otherwise>
								       		<h4 class="card-title">${likeList.lectureTitle}</h4>
								        </c:otherwise>
									</c:choose>
									<p class="card-text" style="color: gray;">${likeList.lectureWriter }</p>
									<div class="star-ratings">
										<div class="star-ratings-fill space-x-2 text-lg" style="width: ${likeList.reviewAverage*10*2 }%;">
											<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
										</div>
										<div class="star-ratings-base space-x-2 text-lg">
											<span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span>
											<span><small>(${likeList.reviewCnt })</small></span>
										</div>
									</div>
									<p></p>
				
									<c:if test="${likeList.orderCh == 0}">
										<c:if test="${likeList.lectureSalePrice == 0}">
											<p class="card-text" style="color: blue"> &#8361;${likeList.lecturePrice }</p>
										</c:if>
										<c:if test="${likeList.lectureSalePrice > 0}">
											<p class="card-text" style="color: blue"> &#8361;${likeList.lectureSalePrice }</p>
										</c:if>
									</c:if>
									<c:if test="${likeList.orderCh == 1}">
										<p class="card-text" style="color: green"><B>학습중</B></p>
									</c:if>
									<a href="#" class="stretched-link"></a>
								</div>
								<div class="info">
									<h3>${likeList.lectureTitle }</h3>
									<p>${likeList.lectureSummary }</p>
									<p>${likeList.lectureLevel }</p>
									<p>${likeList.categoryName }</p>
									<div id="menu">
									
									<a href="javascript:likeCancel(${likeList.lectureNo });" id="${likeList.lectureNo }"
									data-toggle="tooltip" data-placement="left" title="좋아요 취소" class="likeCheck"
									style="position: absolute; right: 15px; bottom: 10px; z-index: 2;">
									<i id="like${likeList.lectureNo }" class="fas fa-heart" style="color: red"></i></a>
									
									</div>
								</div>
								
							</div>
							<br>
						</div>
					</c:forEach>
				</c:if>



				</div>
			</div>
		</div>
	</div>
	

	<script>
	$(document).ready(function(){
		  $('[data-toggle="tooltip"]').tooltip(
				{trigger:"hover"}	  
		  );
		  
		});
	
	//검색 카테고리 정렬
		$("select[name=status]").change(function(){
			var typeVl = null;
			var userId2 = "${user.userId}";
		  	var order = $('#order').val();
		  	var selectetext = $('#status').val();
		  	typeVl = {
					userId : userId2,
					searchOrder : order,
					searchStatus : selectetext
				};
		  	$.ajax({
				url : "${pageContext.request.contextPath }/member/searchLike.do",
				data : typeVl,
				type : "post",
				async : false,

				success : function(data) {
					///////////////
					console.log(data);
					
					$("#listDisp").html(data);
				},
				error : function() {
					console.log("실패");
				}
			});
		});
		$("select[name=order]").change(function(){
			var typeVl = null;
			var userId2 = "${user.userId}";
		  	var order = $('#order').val();
		  	var selectetext = $('#status').val();
		  	typeVl = {
					userId : userId2,
					searchOrder : order,
					searchStatus : selectetext
				};
		  	$.ajax({
				url : "${pageContext.request.contextPath }/member/searchLike.do",
				data : typeVl,
				type : "post",
				async : false,

				success : function(data) {
					///////////////
					console.log(data);
					
					$("#listDisp").html(data);
				},
				error : function() {
					console.log("실패");
				}
			});
		});
	
	</script>
	
	<script>
	//좋아요 추가 삭제 구현
	function likeCancel(lno){
		var typeVl = null;
		var userId2 = "${user.userId}";
		var a = lno;
		typeVl = {
				lectureNo : a,
				userId : userId2
			};
		if(document.getElementById("like"+a).className == "far fa-heart"){
			$.ajax({
				url : "${pageContext.request.contextPath }/member/insertLike.do",
				data : typeVl,
				type : "post",
				async : false,
				success : function(data) {
					console.log(data);
        			
					if(socket){
	        			let socketMsg = "lectureLike,"+"${user.userId}"+","+data.userId+","+data.lectureNo+","+"좋아요 등록했다"+","+"했다";
	        			console.log(socketMsg);
	        			socket.send(socketMsg);
	           		}
				},
				error : function() {
					console.log("실패");
				}
			});
			alert("좋아요 등록");
			$("#"+a+"").attr('data-original-title','좋아요 취소');
			document.getElementById("like"+a).className = "fas fa-heart"
		}else{
			$.ajax({
				url : "${pageContext.request.contextPath }/member/deleteLike.do",
				data : typeVl,
				type : "post",
				async : false,
				success : function(data) {
					console.log(data);
					
					if(socket){
	        			let socketMsg = "lectureLikeCancle,"+"${user.userId}"+","+data.userId+","+data.lectureNo+","+"좋아요를취소"+","+"했다";
	        			console.log(socketMsg);
	        			socket.send(socketMsg);
	           		}
				},
				error : function() {
					console.log("실패");
				}
			});
			alert("좋아요 취소");
			$("#"+a+"").attr('data-original-title','좋아요 등록');
			document.getElementById("like"+a).className = "far fa-heart";	
		}
	}
	</script>

	<footer>
		<%@ include file="../Common/footer.jsp"%>
	</footer>
</body>
</html>