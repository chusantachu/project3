<%@ page    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
	<link href="${pageContext.request.contextPath}/summernote/summernote-bs4.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/summernote/summernote-bs4.js"></script>
	<title>강의자  - 강의 관리 - 새소식 수정</title>
</head>
<style>
	.active-menu {
		color: #1dc078;
		font-weight: bold;
	}
	.norm-menu {
		color: black;
	}
	.active-btn {
		color: #fff;
		background-color: #00C471;
		border-style: none;
		padding: 5px;
		border-radius: 5px;
		margin-right: 5px;
	}
	.outer2 {
		text-align: center;
	}
	.button {
		display: inline-block;
		float: right;
	}
	.dropdown:hover .dropdown-menu {
		display: block;
		margin-top: 0;
	}
</style>
<body>
<%@include file="/Common/header.jsp" %>
<div class="container-fluid mt-5 pb-3 d-flex justify-content-center">
    <div class="row w-100 pb-4 justify-content-center">
        <!-- 왼쪽 네비 -->
        <div class="col-2 d-flex justify-content-center">
			<%@ include file="sidebar.jspf"%>
			<script>
				var menu = $('#lectureManager');
				console.log(menu);
				menu.removeClass('norm-menu');
				menu.addClass('active-menu');
			</script>
        </div>

        <!-- 중앙 위 내용 - 글내용 -->
        <div class="col-8 pl-3 gray-line">
			<div class="d-flex flex-row p-3 writeComments">
				<form method="post" class="w-100" action="${pageContext.request.contextPath}/updateLectureNews.do"> 
					<table class="table table-borderless">
						<thead>
							<tr>
								<th>
									<h2><b><input class="w-100 mx-auto border border-0" type="text" name="newsTitle" value="${vo.newsTitle }"></b></h2>
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<textarea class="w-100 mx-auto" id="summernote" name="newsContent">${vo.newsContent }</textarea>
									<script>
										$('#summernote').summernote({
										   tabsize: 2,
										   height: 400,
										   lang : 'ko-KR',
										   callbacks: { // 콜백을 사용
										     // 이미지를 업로드할 경우 이벤트를 발생
										     onImageUpload: function(files, editor, welEditable) {
										       sendFile(files[0], this);
										     }
										   }
										 });
										    
										function sendFile(file, editor) {
										    // 파일 전송을 위한 폼생성
										    data = new FormData();
										    data.append("file", file);
										    $.ajax({ // ajax를 통해 파일 업로드 처리
										      data : data,
										      enctype: 'multipart/form-data',
										      type : "POST",
										      url : "${pageContext.request.contextPath}/uploadLecterNewsImage.do",
										      //cache : false,
										      contentType : false,
										      processData : false,
										      success : function(data) { // 처리가 성공할 경우
										        console.log("ajax 리턴받은 data : " + data);
										        // 에디터에 이미지 출력
										        $(editor).summernote('editor.insertImage', '${pageContext.request.contextPath}/filepath/' + data);
										      },
										      error: function(){
										        alert("실패~~");
										      }
										    });
										  }
									</script>
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td>
									<div class="outer">
										<div class="button">
									 		<button type="submit" class="btn btn-success">작성</button>
									 		<button type="button" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/getLectureNews.do?boardNo=${vo.boardNo }'">취소</button>
									 		<input type="hidden" class="btn btn-dark" name="boardNo" value="${vo.boardNo }">
									 		<input type="hidden" class="btn btn-dark" name="lectureNo" value="${vo.lectureNo }">
									 	</div>
							 		</div>
								</td>
							</tr>
						</tfoot>
					</table>
				</form>
				<br>
			</div>
        </div>
        <div class="col-2 d-flex justify-content-center">
        </div>
    </div>
</div>

<%@include file="/Common/footer.jsp" %>
</body>
</html>
