<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글상세페이지</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Community/css/jyStyle.css">
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	
	<!-- include summernote css/js -->
	<link href="${pageContext.request.contextPath}/summernote/summernote-bs4.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/summernote/summernote-bs4.js"></script>
	

	<script>
	$(document).ready(function() {
		
		var fontList = ['맑은 고딕','굴림','돋움','바탕','궁서','NotoSansKR','Arial','Courier New','Verdana','Tahoma','Times New Roamn'];
		var setting = {
				height: 150,                 // set editor height
				minHeight: null,             // set minimum height of editor
				maxHeight: null,             // set maximum height of editor
				focus: true,                  // set focus to editable area after initializing summernote
				lang : 'ko-KR',
				fontNames: fontList,
				callbacks: { // 콜백을 사용
				// 이미지를 업로드할 경우 이벤트를 발생
				onImageUpload: function(files, editor, welEditable) {
					for (var i = files.length - 1; i >= 0; i--) {
						uploadSummernoteImageFile(files[i], this);
						}
					}
				}
		};				
		   
		$('#summernote').summernote(setting);
		
	});

		 function sendFile(file, editor) {
		   // 파일 전송을 위한 폼생성
		   data = new FormData();
		   data.append("uploadFile", file);
		   $.ajax({ // ajax를 통해 파일 업로드 처리
		     data : data,
		     type : "POST",
		     url : "knowhowImageUpload.do", // controller
		     cache : false,
		     contentType : false,
		     processData : false,
		     success : function(data) { // 처리가 성공할 경우
		       // 에디터에 이미지 출력
		       $(editor).summernote('editor.insertImage', data.url);
		       //$("#thumbnail").val(data.url); // 썸네일 설정
		     }
		   });
		 }
		 
		 function deleteBoard(obj){
			 if (confirm("삭제하시겠습니까??")){
				 location.href = "${pageContext.request.contextPath}/memberBoard/deleteBoard.do?qnaNo=${callBvo.qnaNo }" 
			 }
			 			 
		 }
		 
		 function deleteOk(commentNo){
			 if (confirm("삭제하시겠습니까??")){
				 location.href = "${pageContext.request.contextPath}/memberBoard/delCallcenterComment.do?commentNo="+commentNo; 
			 }
		 }

		
	</script>


</head>
<body>
	<c:if test="${user.grade != '관리자' }">
	<%@include file="/Common/header.jsp" %>
	</c:if>
	<c:if test="${user.grade == '관리자' }">
	<%@include file="/Admin/common/adminHeader.jspf" %>
	</c:if>
	
	

	<div class="container-fluid mt-5 pb-3 d-flex justify-content-center">
		<div class="row w-100 pb-4 justify-content-center">
			
			<!-- 왼쪽 네비 -->
			<div class="col-2 d-flex justify-content-center">
				<c:if test="${user.grade != '관리자' }">
<%-- 					<a href="${pageContext.request.contextPath}/memberBoard/getMyQBoardList.do" style="position: fixed;"><img class="mt-3" height="35px" src="${pageContext.request.contextPath}/Community/img/back.png"></a> --%>
					<a href="javascript:history.back()" style="position: fixed;"><img class="mt-3" height="35px" src="${pageContext.request.contextPath}/Community/img/back.png"></a>
				</c:if>
				<c:if test="${user.grade == '관리자' }">
<%-- 					<a href="${pageContext.request.contextPath}/memberBoard/getMyQBoardListM.do" style="position: fixed;"><img class="mt-3" height="35px" src="${pageContext.request.contextPath}/Community/img/back.png"></a> --%>
					<a href="javascript:history.back()" style="position: fixed;"><img class="mt-3" height="35px" src="${pageContext.request.contextPath}/Community/img/back.png"></a>
				</c:if>
				
				
			</div>

			<!-- 중앙 위 내용 - 글내용 -->
			<div class="col-6 pl-3 gray-line">
				<div class="row align-items-center p-3">
					<img class="mr-2" style="height: 30px" src="${pageContext.request.contextPath}/Community/img/qqq.png">					
					<h3><b>${callBvo.qnaTitle }</b></h3>
				</div>
				<div class="row pl-3 pb-3">
					<p class="mr-2"><b>${callBvo.userName }</b></p><p class="text-muted">${callBvo.qnaRegdate }</p>
					
					<c:if test="${user.userId == callBvo.userId }">
					<p class="ml-auto">
						<a class="mr-3" href="${pageContext.request.contextPath}/memberBoard/qnaModifyForm.do?qnaNo=${callBvo.qnaNo }">수정</a>
						<a href="javascript:deleteBoard($(this))">작성자삭제</a>
					</p>
					</c:if>
					
					
				</div>

				<div class="d-flex flex-row p-3">
					<p>${callBvo.qnaContent }</p>
				</div>
			</div>
			
			<!-- 오른쪽 네비 -->
			<div class="col-2">				
				
			</div>
			
		</div>		
	</div>

	<!-- 글 아래 파트 회색부분 -->
	<div class="container-fluid py-5"  style="background-color: #F8F9FA;">

		<!-- 여기서부터 입력부분은 질문게시판(관리) 쪽은 관리자만 답변 할 수 있도록 해야 한다 -->
		
		
<!-- 		<div> 문의게시판에는 답글을 하나만 달 수 있습니다 </div> -->
		<c:if test="${user.grade eq '관리자' && cvoCnt < 1}">
		<div class="row w-50 border mx-auto rounded bg-white px-3 py-5" >
			<div class="w-100 mb-3 ml-3 text-editor-block d-flex align-items-center">
				<div class="ml-3">
					<img class="mr-2" style="height: 60px" src="${pageContext.request.contextPath}/Community/img/aaa.png">
				</div>
				<div class="ml-4">
					<div class="row">
					<span><h5><b><a href="#" style="font-size: 1em">${user.userName}</a>님, 답변해주세요!</b></h5></span>
					</div>
					<div class="row">
					<span class="text-secondary">모두에게 도움이 되는 답변의 주인공이 되어주세요!</span>
					</div>
				</div>
			</div>
			
			
		<!-- 댓글 입력 부분 -->
			<div class="row w-100 w-100 p-3 mx-auto">
				<form method="post" class="w-100" action="${pageContext.request.contextPath}/memberBoard/addCallcenterComment.do?qnaNo=${callBvo.qnaNo}">
					<textarea id="summernote" name="commentContent"></textarea>
					<div class="row mt-3">
						<button class="btn btn-success ml-auto">답변등록</button>
					</div>
				</form>
			</div>
		</div>
		</c:if>
		
		

		<!-- 답변 몇개인, 글 정렬 옵션-->
		<div class="w-75 d-flex flex-row justify-content-center mx-auto mt-4 p-3">
			<div class="row w-75 d-flex flex-row justify-content-around align-items-center" >
					<span class="w-75 ml-4">
					<h3 class="text-success">A</h3><p>총 ${cvoCnt }개의 답변이 달렸습니다</p>
					</span>
			</div>				
		</div>

		<!-- 댓글 출력 부분 여기 포이치 문으로 해줘야 한다 -->
		
		<c:forEach var="cvo" items="${cvoList }">
		
		<div class="row w-50 border mx-auto rounded bg-white p-3 mb-5" >
			<div class="row w-100  mt-3 mb-3">
				<div class="w-100 flex-row d-flex">
					<P class="ml-auto">
					<a href="javascript:deleteOk(${cvo.commentNo })">삭제</a>
					</P>
				</div>
			
				<div class="text-editor-block flex-row d-flex w-100 mt-3 mb-3">				
					<div class="ml-3">
						<img class="mr-2 ml-5" style="height: 60px" src="${pageContext.request.contextPath}/Community/img/aaa.png">
					</div>
					<div class="ml-3">
						<div class="row">
						<span><h5><b><a href="#">${cvo.userName }</a></b></h5></span>
						</div>
						<div class="row text-secondary">
						<span>${cvo.commentRegdate }</span>
						</div>
					</div>
				</div>

				<div class="row w-100 ml-5">
					<p> ${ cvo.commentContent}</p>
				</div>
			</div>
		</div>
		
		</c:forEach>
		



	</div>
	
	<%@include file="/Common/footer.jsp" %>




</body>
</html>