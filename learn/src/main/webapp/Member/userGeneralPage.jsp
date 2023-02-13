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