<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문글작성폼</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Community/css/jyStyle.css">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/summernote/summernote-bs4.js"></script>

	<script>
		$(document).ready(function() {
			
			var fontList = ['맑은 고딕','굴림','돋움','바탕','궁서','NotoSansKR','Arial','Courier New','Verdana','Tahoma','Times New Roamn'];
			
			$('#summernote').summernote({
				height: 300,                 // set editor height
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
			});
		});

		function uploadSummernoteImageFile(file, editor) {
		  // 파일 전송을 위한 폼생성
			data = new FormData();
			data.append("file", file);
		  	$.ajax({ // ajax를 통해 파일 업로드 처리
				data : data,
				type : "POST",
				url : "${pageContext.request.contextPath}/board/uploadSummernoteImageFile.do", // controller
				cache : false,
				contentType : false,
				enctype : 'multipart/form-data',
				processData : false,
				success : function(data) { // 처리가 성공할 경우
					
					console.log("에이젝스 성공!!");
				// 에디터에 이미지 출력
					$(editor).summernote('editor.insertImage', data.url);
				//$("#thumbnail").val(data.url); // 썸네일 설정
				},
				error : function(){
					console.log("에이젝스 실패!!");
				}
			});
		}
		
		
		
		
		$(document).on("click", "#submitBoard", function(){
			
			if ($("#boardTitle").val().trim() == ""){
				alert("제목을 입력해주세요");
				$("#boardTitle").focus();
				return false;
			}
			
			$("#submitForm").submit();
		});
		
		$(document).on("click", "#cancelWrite", function(){
			
			var cancelWrite = confirm("작성을 취소하시겠습니까?\n작성한 내용이 삭제됩니다");
			
			if(cancelWrite){
				location.href = "${pageContext.request.contextPath}/board/getQnaBoardList?section=fboard.do";
			}
			
		});
		
		
		$(document).on("click", ".nav-item", function(){
			$(".nav-item").removeClass("active");
			$(".nav-item").removeClass("green-line");
			$(this).addClass("active");
			$(this).addClass("green-line");
		});
		
		$(document).on("click", ".nav-link", function(){
			var firstForm = document.forms[0];
			if($(this).html() == '자유주제'){
				firstForm.action = "${pageContext.request.contextPath}/board/boardWrite.do?section=fboard";
			} else if ($(this).html() == '질문'){
				firstForm.action = "${pageContext.request.contextPath}/board/boardWrite.do?section=qboard";
			}
		});
		
	</script>

</head>
<body>
	<%@include file="/Common/header.jsp" %>

<div>
	<div class="container-fluid">
		<div class="row justify-content-center">
			<div class="col-sm-2">
				<p>-------왼쪽네비-------</p>
			</div>
			
			<div class="col-sm-6 align-content-center">
				
				<!-- 섹션 선택 -->
                <div class="flex-row w-100">
                    <nav class="navbar navbar-expand-sm navbar-light w-100">
                        <ul class="navbar-nav gray-botton w-100" style="border-bottom: 1px solid green;">
                            <li class="nav-item">
                            <a class="nav-link" href="#">질문</a>
                            </li>
                            <li class="nav-item active green-line">
                            <a class="nav-link" href="#">자유주제</a>
                            </li>
                        </ul>
                    </nav>                        
                </div>

                <div class="d-flex flex-row p-3 writeComments">
                	<form method="post" class="w-100" id="submitForm" action="${pageContext.request.contextPath}/board/boardWrite.do?section=fboard">
                    <table class="table table-borderless">
                        <thead>
                            <tr>
                                <th><h2><b><input class="w-100 mx-auto border border-0" type="text" id="boardTitle" name="boardTitle" placeholder="제목을 입력하세요"></b></h2></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><textarea class="w-100 mx-auto" id="summernote" name="boardContent" placeholder="학습과 관련된 질문을 남겨주세요"></textarea></td>
                            </tr>
                            <tr>
                                <td class="d-flex flex-row justify-content-end">
                                    <input type="button" id="submitBoard" class="btn btn-success mr-3" value="등록"/>
                                    <input type="button" id="cancelWrite" class="btn btn-light mr-3" value="취소"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    </form>

                    <form method="post">
                    </form>
                </div>
			</div>	

			<div class="col-sm-2">
				<p>------오른쪽네비--------</p>
			</div>
		</div>
	</div>
</div>

	<%@include file="/Common/footer.jsp" %>


</body>
</html>