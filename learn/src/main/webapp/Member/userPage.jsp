<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 조회</title>
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
	
	/* 강의파트 css */
	.card .info {
	color: #fff;
	position: absolute; left: 0; bottom: 0;
	background: rgba(0,0,0,0.8);
	width: 100%;
	height: 100%;
	padding: 15px;
	opacity: 0;
	transition: opacity 0.35s ease-in-out;
	}
	.card:hover .info {opacity: 1;}
	/* ======== */
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
			    onImageUpload: function(files, editor, welEditable) {
			         // 파일 업로드(다중업로드를 위해 반복문 사용)
			         for (var i = files.length - 1; i >= 0; i--) {
			             uploadSummernoteImageFile(files[i],
			            this);
			         }
			    },
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
				var text = data.intro;
				$("#introHTML").html(text);
				
	        },
	        error: function(){
	            alert("실패");
	        }
		});
		
	});
	
	
	function uploadSummernoteImageFile(file, el) {
	    var data = new FormData();	
	    data.append("file",file);
	    console.log(data);
	    
	    $.ajax({
	      url: "${pageContext.request.contextPath }/common/imgUpload.do",
	      type: "POST",
	      enctype: 'multipart/form-data',
	      data: data,
	      cache: false,
	      contentType : false,
	      processData : false,
	      success : function(data) {
	    	  alert("성공");
	                
	                console.log(data);
	                console.log("${pageContext.request.contextPath}/filepath");
	                $(el).summernote('editor.insertImage', 'http://localhost:8080/${pageContext.request.contextPath}/filepath/' + data);
	            },
	            error : function(e) {
	                console.log(e);
	            }
	   });
	}   
	    
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
    					  <a href="${pageContext.request.contextPath}/member/goToPersonalPage_Lecture.do?userId=${person.userId }" class="text-dark">강의</a>
					    </li>
   					  	<li class="nav-item d-flex p-2 w-100">
						  <a href="${pageContext.request.contextPath}/member/getGoToPersonalRoadPage.do?userId=${person.userId}" class="text-dark">로드맵</a>
					  	</li>
					    <li class="nav-item d-flex p-2 w-100">
					      <a href="#" class="text-dark">수강후기</a>
					    </li>
					    <li class="nav-item d-flex p-2 w-100">
					      <a href="userBoardPage.do?userId=${person.userId}" class="text-dark">게시글</a>
					    </li>
				  </ul>
				</nav>
			</div>
		</div>
		<div class="col-9 justify-content-center">
			<div class="w-100">
				<div id="introduce">
					<p class="d-flex justify-content-between">
						<span class="h4 font-weight-bold ">소개</span>
						<c:if test="${person.userId == user.userId}">
							<input type="button" id="introEdit" class="btn btn-outline-dark" value="편집">
						</c:if>
					</p>
					<div id="introArea" class="d-flex" style="min-height: 200px;">
						<c:choose>
							<c:when test="${not empty person.userIntro }">
								<div id="introHTML">
									${person.userIntro }
								</div>
							</c:when>
							<c:otherwise>
								<p class="align-self-center text-center mx-auto">소개가 없습니다.</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<hr>
				<div id="lecture"> 
					<p class="h4 d-inline font-weight-bold">강의</p>
					<br><br>
					<div class="d-flex" style="min-height: 200px;">
						<c:if test="${not empty lectures }">
							<c:forEach var="lecture" items="${lectures }">
								<div class="col-4 card course course_card_item border-0 mb-5" style="height:400px; width: 260px; float: left; text-align: left;">
									<div class="card h-100 border-0" style="float: left;">
									  	<div class="card-image h-50">
											<img class="card-img-top" src="${pageContext.request.contextPath}/filepath/${lecture.lectureCoverimg }" width="100%" alt="${lecture.lectureTitle }">
									  	</div>
									  	<div class="card-body w-100 overflow-hidden">
										    <p class="card-title font-weight-bold" style="height:50px;">${lecture.lectureTitle }</a></p>
										    <br>								
											<span class="card-user font-weight-bold">${lecture.lectureWriter }</span>
											<br>
											<span>
												<c:forEach var="num" begin="1" end="${Math.round(lecture.lectureRate) }" step="1"> 
													<i class="fa-solid fa-star" style="color: #fada5e;"></i>
												</c:forEach>
												<c:forEach var="num" begin="1" end="${5 - Math.round(lecture.lectureRate) }" step="1">
													<i class="fa-regular fa-star" style="color: #fada5e;"></i>											
												</c:forEach>
												(${lecture.reviewCount })
											</span>
											<c:choose>
											<c:when test="${lecture.lecturePrice != lecture.salePrice}">
												<p class="card-price">	
													<del class="text-secondary">&#8361; 
														<fmt:formatNumber type="number" maxFractionDigits="3" value="${lecture.lecturePrice }" />
													</del>
													<span class="text-primary font-weight-bold h5">&#8361;
														<fmt:formatNumber type="number" maxFractionDigits="3" value="${Math.round(lecture.salePrice) }" />
													</span>
												</p>
											</c:when>
											<c:otherwise>
												<p class="card-price">
													<span class="font-weight-bold h5">&#8361;
														<fmt:formatNumber type="number" maxFractionDigits="3" value="${lecture.lecturePrice }" />		
													</span>
												</p>										
											</c:otherwise>
											</c:choose>
									      	<a href="${pageContext.request.contextPath}/Common/getLecture.do?lectureNo=${lecture.lectureNo }" class="stretched-link"></a>
									  		<span class="badge badge-success">+${lecture.studentCount }명</span>
									  	</div>
									    <div class="info">
										     <div class="w-100 h-75 overflow-hidden">
											      <p class="font-weight-bold">${lecture.lectureTitle }</p>
													<c:choose>
														<c:when test="${fn:length(lecture.lectureSummary) gt 100}">
															<p>${fn:substring(lecture.lectureSummary, 0, 100)}...</p>
														</c:when>
														<c:otherwise>
															<p>${lecture.lectureSummary }</p>
														</c:otherwise>
													</c:choose>
										     </div>
										     <div class="position-absolute bottom-0 w-100 h-15">
											      <p class="text-info font-weight-bold">${lecture.lectureLevel }</p>
											      <p class="text-info font-weight-bold">${lecture.categoryName }</p>
										     </div>
									    </div>
									</div>
								</div>
							</c:forEach>
						</c:if>
						<c:if test="${empty lectures }">
							<p class="align-self-center text-center mx-auto">강의가 없습니다.</p>
						</c:if>
					</div>
				</div>
				<c:if test="${not empty lectures }">
					<c:if test="${lecturesSize > 3}">
						<p class="align-self-center text-center mx-auto">
							<button type="submit" class="btn btn-success" onclick="location.href='${pageContext.request.contextPath}/member/goToPersonalPage_Lecture.do?userId=${person.userId }'">더보기</button>
						</p>
					</c:if>
				</c:if>		
				<hr>
				<div id="roadmap"> <!-- 로드맵 출력 div 시작 -->
					<p class="h4 d-inline font-weight-bold">로드맵</p>
					
					<div id="roadmapDefault" class="row"> <!-- 로드맵 출력 div 시작 -->		
						<c:choose>
							<c:when test="${not empty get3rovo }">
								<c:forEach var="get3rovo" items="${get3rovo }">
								<div class="col-4 card course course_card_item border-0 mb-5" style="height:350px;">
									<div class="card h-100 border-0">
									  	<div class="card-image h-50">
											<img class="card-img-top" src="${get3rovo.rboardCoverimg }" width="100%" alt="${get3rovo.rboardTitle }">
									  	</div>
									  	<div class="card-body w-100 overflow-hidden">
										    <p class="card-title font-weight-bold" style="height:50px;">${get3rovo.rboardTitle }</p>								
											<span class="card-user font-weight-bold">${get3rovo.userName }</span>
									      		<a href="${pageContext.request.contextPath}/roadmap/roadmapDetail.do?rboardNo=${get3rovo.rboardNo }" class="stretched-link"></a>
									  		<p>
									  			<span class="badge badge-success">+${get3rovo.userCount }명</span>
									  			<span class="badge badge-success">${get3rovo.lectureCount }개 강의</span>
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
					<c:if test="${not empty get3rovo }">
						<p style="text-align: center;">
							<button class="btn btn-success" type="button" value="더보기+" onclick="location.href='${pageContext.request.contextPath}/member/getGoToPersonalRoadPage.do?userId=${person.userId}'">더보기</button>
						</p>
					</c:if>
				</div>
				<hr>
				<div id="review">	
					<p class="h4 d-inline font-weight-bold">수강후기</p>
					<div class="d-flex" style="min-height: 200px;">
						<p class="align-self-center text-center mx-auto">후기가 없습니다.</p>
					</div>
				</div>
				<hr>
				<div id="board">	
					<div>
						<span class="h4 d-inline font-weight-bold">게시글</span>

						<a class="float-right" href="userBoardPage.do?userId=${person.userId}">전체 보기 ></a>

					</div>
					<c:if test="${empty boardList }">
						<div class="d-flex" style="min-height: 200px;">
							<p class="align-self-center text-center mx-auto">게시글이 없습니다.</p>
						</div>
					</c:if>

					<c:forEach items="${boardList}" var="board">

						<div class="pt-3 pb-3 row" style="border-bottom: 1px solid lightgrey">
							<c:if test="${not empty board.boardAdopt}">
								<div class="col-4">질문&답변&nbsp;
									<c:if test="${board.boardAdopt == 'FALSE'}">
										<span style="color: darkgray">미해결</span>
									</c:if>
									<c:if test="${board.boardAdopt == 'TRUE'}">
										<span style="color: #00a760">해결됨</span>
									</c:if>
								</div>
							</c:if>
							<c:if test="${empty board.boardAdopt}">
								<div class="col-4">자유주제</div>
							</c:if>
							<div class="col-8 text-right">
								<span style="color: darkgray">${board.boardRegdate}</span>
							</div>
							<div class="col-12 pt-2 pb-1">
								<!-- 질문게시판: 링크 연결해야 함!!! -->
								<c:if test="${not empty board.boardAdopt}">
									<a class="h5" href="#">${board.boardTitle}</a>
								</c:if>
								<!-- 자유게시판: 링크 연결해야 함!!! -->
								<c:if test="${empty board.boardAdopt}">
									<a class="h5" href="#">${board.boardTitle}</a>
								</c:if>
							</div>
							<div class="col-12">
								<i class="fa-regular fa-heart"></i> ${board.boardLike}&nbsp;&nbsp;
								<i class="fa-regular fa-comment-alt"></i> ${board.commentCnt}
							</div>
						</div>
					</c:forEach>
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