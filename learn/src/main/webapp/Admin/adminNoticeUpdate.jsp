<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>CS관리 - 공지사항 수정</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

<link href="${pageContext.request.contextPath }/Admin/css/sideNav.css" rel="stylesheet" type="text/css">

<!-- 서머노트를 위해 추가해야할 부분 -->
<script src="${pageContext.request.contextPath}/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/summernote/summernote-lite.css">
<!--  -->

<style>
	.table {
		width: 1120px;
		margin-left: 18%;
	}
	.outer2 {
		text-align: center;
	}
	.button {
		display: inline-block;
		float: right;
	}
</style>
</head>
<body>
<%@ include file="/Admin/common/adminHeader.jspf" %>

<!-- 본문 내용 시작 -->
<div class="table">
	<div class="main">
		<div class="col-sm-6 align-content-center">
			<div class="d-flex flex-row p-3 writeComments">
				<form method="post" class="w-100" action="${pageContext.request.contextPath}/updateNotice.do"> 
					<table class="table table-borderless">
						<thead>
							<tr>
								<th>
									<h2><b><input class="w-100 mx-auto border border-0" type="text" value="${vo.boardTitle }" name="boardTitle" ></b></h2>
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<textarea class="w-100 mx-auto" id="summernote" name="boardContent">${vo.boardContent }</textarea>
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
										      url : "${pageContext.request.contextPath}/uploadNoticeImage.do",
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
									 		<input type="hidden" class="btn btn-success" name="boardNo" value="${vo.boardNo }">
									 		<button type="button" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/getAdminNotice.do?boardNo=${vo.boardNo }'">취소</button>
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
	</div>
</div>

<%@ include file="/Common/footer.jsp" %>
</body>
</html>
