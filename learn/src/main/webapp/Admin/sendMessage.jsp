<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
  <title>관리자 페이지</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
    
    
  <style>
  </style>
  <script>
  
	$(document).ready(function() {


		$('#summernote').summernote({
			  width: 1200,
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
			    onKeyup: function(e) {			        
			        var html = $(this).val();
			        
			        setTimeout(function(){
			        	console.log(html);
				        localStorage.setItem('html', html); //추가
				        //var html = localStorage.getItem('html'); //조회
				        //localStorage.removeItem('html'); //삭제
				        //localStorage.clear(); // 전체삭제
			        }, 5000);
			        
			    }
			}
		});
		
		$('#summernote').summernote('pasteHTML', localStorage.getItem('html'));
		
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
	
	$(document).on("click", "#selectAll", function(){
		
	    if ($(this).hasClass('allChecked')) {
	        $('input:checkbox[name="user"]').prop('checked', false);
	    } else {
	        $('input:checkbox[name="user"]').prop('checked', true);
	    }
	    
	    $(this).toggleClass('allChecked');
	})
	
	$(document).on("click", "#selectDone", function(){
		
		//$('input[name="checkbox_name"]').is(":checked")
		
		var dispHTML = '';
		dispHTML += '<ul class="list-unstyled">';
		$('input:checkbox[name="user"]').each(function(){
			if($(this).is(":checked")==true){
				//console.log($(this).val());
				dispHTML += '<li><input type="text" name="receiver" class="w-100 border-0" value="'+$(this).val()+'"></li>';
			}
		})
		dispHTML += '</ul>';
		$("#receiverList").append(dispHTML);
	})
	
	$(document).on("click", "#findUser", function(){
		console.log($("#searchUser").val());
		findUser($("#searchUser").val());
	})

	$(document).on("click", "#send", function(){
		//console.log($('#mailForm [name="receiver"]').val());
		localStorage.removeItem('html'); //삭제
		$('#mailForm').submit();
	})
	
	function selectUsers () {
		$("#selectArea").modal();
		findUser(null);
	}

	function findUser(keyword){
		
		var find = {};
		find.searchKeyword = keyword;

		var jsonData = $.ajax("${pageContext.request.contextPath }/admin/getUsers.do", {
			type : "post",
	        data : JSON.stringify(find),
	        contentType : "application/json",
			dataType: "json",
			async: false
		}).responseText;
		
		console.log(jsonData);

		console.log(JSON.parse(jsonData).length);
		
		var dispHTML = '';
		dispHTML += '<table class="w-100">';
		if (JSON.parse(jsonData).length == 0) {
			dispHTML += '<tr>조회된 사용자가 없습니다</tr>';			
		}
		$.each(JSON.parse(jsonData), function(idx, obj){
			dispHTML += '<tr>';
			dispHTML += '<td><input type="checkbox" name="user" value="'+obj.userId+'"></td>';
			dispHTML += '<td>'+obj.userName+'</td>';
			dispHTML += '<td>( '+obj.userId+' )</td>';
			dispHTML += '<td>['+obj.grade+']</td>';
			dispHTML += '</tr>';
		});
		dispHTML += '</table>';
		$("#selectBody").html(dispHTML);
	}

	function deleteUsers(){
		$("#receiverList").html("");
	}
	
	
    $(document).on('keyup', '#selectArea', function(e) {    	 
        if (window.event.keyCode == 13) {
            e.preventDefault();
            document.getElementById("findUser").click();      
        }
 
    });
	  
</script>
</head>
<body>
<%@ include file="/Admin/common/adminHeader.jspf" %>
<br><br>
<div class="container">
	<div id="mailArea" class="w-100">	
		<form id="mailForm" method="post" action="${pageContext.request.contextPath }/admin/sendMail.do">
			<p class="row">
				<span class="col-sm-1 h6">제목: </span>
				<input type="text" name="title" class="col-sm-11 border">
			</p>
			<div class="row">
				<span class="col-sm-1 h6">수신인</span>
				<div id="receiverList" class="border col-sm-10 overflow-auto" style="height:200px;">
				</div>
				<span class="col-sm-1">
					<input type="button" name="selectReceiver" value="추가" onclick="selectUsers()" class="h6 btn btn-outline-dark">
					<input type="button" name="selectReceiver" value="전체삭제" onclick="deleteUsers()" class="h6 btn btn-outline-dark">
				</span>
			</div>
			<textarea id="summernote" name="editordata" class="mx-auto"></textarea>
			<p class="mx-auto text-center"><input type="button" id="send" value="전송" class="h6 btn btn-outline-dark"></p>
		</form>
	</div>
	
	<div class="modal" id="selectArea">
		<div class="modal-dialog modal-dialog-centered">
		  <div class="modal-content">
		  	<form>
		  		<p class="text-center my-3">
		  			<span class="mx-auto">
			  			유저 찾기: <input type="text" id="searchUser" class="w-50">
						<input type="button" id="findUser" value="검색">		  		
		  			</span>
		  		</p>
			    <div id="selectBody" class="modal-body text-center  overflow-auto"  style="height:300px;">
			    </div>
			    <p class="text-center my-3">
					<input type="button" id="selectAll" value="전체선택">
				    <input type="button" id="selectDone" value="선택완료" data-dismiss="modal" aria-label="Close">
				</p>
		    	<input type="text" style="width 0px; visibility: hidden;">
			</form>
		  </div>
		</div>
	</div>
	
</div>

<%@ include file="/Common/footer.jsp" %>
</body>
</html>
