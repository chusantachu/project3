<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/80bed6a544.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>

<style>
	html, body {
		height: 100%;
	}
	
	.tape {
		height: 100px;
		margin: 50px auto;
		padding-top: 15px;
		color: white;
	}
	
	.sidebar-nav li a:hover {
		text-decoration: none;
		background: #d3d3d3;
	}
</style>
<script>
	$(function(){
		$('#summernote').summernote({
			  width: 800,
			  height: 500,                 // set editor height
			  minHeight: null,             // set minimum height of editor
			  maxHeight: null,             // set maximum height of editor
			  focus: true,                  // set focus to editable area after initializing summernote
			callbacks: { // 콜백을 사용
			    // 이미지를 업로드할 경우 이벤트를 발생
			    /*
			    onImageUpload: function(files, editor, welEditable) {
			         // 파일 업로드(다중업로드를 위해 반복문 사용)
			         for (var i = files.length - 1; i >= 0; i--) {
			             uploadSummernoteImageFile(files[i],
			            this);
			         }
			    },
			    */
			}
		});
	});
	$(document).on("click", "#introEdit", function(){
		$("#summernoteArea").modal();
	});
	
	$(document).on("click", "#send", function(){
		var frmString = $("#introFrm").serialize() ;
		console.log(frmString);
		
		$.ajax("${pageContext.request.contextPath }/member/editUserIntro.do", {
			type : "post",
	        data : frmString,
	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
	        dataType: "json",
	        success : function(data){
	        	
				console.log(data);
				$("#introHTML").html(data.intro);
	        },
	        error: function(){
	            alert("실패");
	        }
		});
		
	});
</script>
</head>
<body>
<%@include file="/Common/header.jsp" %>
<div class="container mt-5 pb-3d-flex">
	<div class="row w-100 my-3 pb-4">
		<div class="col-3 w-100 mx-auto">	
			<!-- 사이드 바 영역 -->
			<div class="mx-auto w-100 row">
				<div class="col-sm-9" style="height: 70px;">
					<p class="font-weight-bold h5">${person.userName }</p>
					<div class="d-flex justify-content-between">
						<div>수강생수 ${studentCnt }</div>
						<div>평점 ${lectureRate }</div>
					</div>
				</div>
				<div class="col-sm-3" style="height: 70px;">
					<img class="rounded-circle" src="${pageContext.request.contextPath}/picture/inflearn.png" alt="profile" width="50px;" height="50px;">
				</div>
			</div>
			<div class="mx-auto w-100">
				<nav class="w-100">
				  <ul class="navbar-nav sidebar-nav comNav rounded">
					    <li class="nav-item d-flex p-2 w-100">
					      <a href="${pageContext.request.contextPath}/member/goToPersonalPage.do?userId=${person.userId}" class="text-dark">홈</a>
					    </li>
					    <li class="nav-item d-flex p-2 w-100">
					      <a href="#" class="text-dark">강의</a>
					    </li>
					  	<li class="nav-item d-flex p-2 w-100">
						  <a href="${pageContext.request.contextPath}/member/getGoToPersonalRoadPage.do?userId=${person.userId}" class="text-dark">로드맵</a>
					  	</li>
					    <li class="nav-item d-flex p-2 w-100">
					      <a href="#" class="text-dark">수강후기</a>
					    </li>
					    <li class="nav-item d-flex p-2 w-100">
					      <a href="#" class="text-dark">게시글</a>
					    </li>
				  </ul>
				</nav>
			</div>
		</div>
		<div class="col-9 justify-content-center">
			<div class="w-100">
				<div id="introduce">
					<p class="d-flex justify-content-between">
						<span class="h4 font-weight-bold ">로드맵(${fn:length(getrovo) })</span>
					</p>
				</div>
				<div id="roadmap"> <!-- 로드맵 출력 div 시작 -->
					<div id="roadmapDefault" class="row"> <!-- 로드맵 출력 div 시작 -->		
						<c:choose>
							<c:when test="${not empty getrovo }">
								<c:forEach var="getrovo" items="${getrovo }">
								<div class="col-4 card course course_card_item border-0 mb-5" style="height:350px;">
									<div class="card h-100 border-0">
									  	<div class="card-image h-50">
											<img class="card-img-top" src="${getrovo.rboardCoverimg }" width="100%" alt="${getrovo.rboardTitle }">
									  	</div>
									  	<div class="card-body w-100 overflow-hidden">
										    <p class="card-title font-weight-bold" style="height:50px;">${getrovo.rboardTitle }</p>								
											<span class="card-user font-weight-bold">${getrovo.userName }</span>
									      		<a href="${pageContext.request.contextPath}/roadmap/roadmapDetail.do?rboardNo=${getrovo.rboardNo }" class="stretched-link"></a>
									  		<p>
									  			<span class="badge badge-success">+${getrovo.userCount }명</span>
									  			<span class="badge badge-success">${getrovo.lectureCount }개 강의</span>
									  		</p>
									  	</div>
									</div>
								</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div class="d-flex" style="min-height: 200px;">
									<p class="align-self-center text-center mx-auto">로드맵이 없습니다.</p>
								</div>
							</c:otherwise>
						</c:choose>
					</div> <!-- 로드맵 출력 div 끝 -->
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal" id="summernoteArea">
	<div class="modal-dialog modal-dialog-centered" style="width:900px;">
	  <div class="modal-content" style="width:900px;">
		  <form id="introFrm">
		  	  <textarea id="summernote" name="userIntro" class="mx-auto p-2"></textarea>
			  <input type="hidden" name="userId" value="${user.userId }">
			  <p class="text-center mx-auto my-3">
			  	<input type="button" id="send" value="저장" data-dismiss="modal" aria-label="Close" class="btn btn-outline-dark">
			  </p>
		  </form>	
	  </div>
	</div>
</div>

<%@include file="/Common/footer.jsp" %>
</body>
</html>