<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<title>Insert title here</title>
<style>
	.container { margin: 0 auto;
 }
	#set { width:90%;
        margin:auto;
        display:block;}
</style>

</head>
<body>

<div class="container">

	<h2>감사합니다, ${user.userId} 님</h2>
	<h2>지식공유자가 되기 위해서</h2>
	<h2>아래 정보가 필요해요.</h2>
	<br>
	<form method="post">
    <div class="form-group">
      <label for="email">인프런 계정</label>
      <input type="text" class="form-control" id="userId"  name="userId" value="${user.userId}" readonly >
    </div>
    <div class="form-group">
      <label for="pwd">이름(실명)</label>
      <input type="text" class="form-control" id="userName" placeholder="이름을 입력해주세요" name="userName">
    </div>
  	 <div class="form-group">
      <label for="pwd">연락처</label>
      <input type="text" class="form-control" id="userTel" placeholder="연락처를 입력해주세요" name="userTel">
    </div>
       <div class="form-group">
      <label for="text">희망분야</label>
      <input type="text" class="form-control" id="categoryName" placeholder="희망분야를 입력해주세요" name="categoryName">
    </div>
   
     <div class="form-group">
      <label for="text"> 나를 소개하는 글 *</label> 
      <textarea rows="10" cols="20" class="form-control" name="userIntroduce" id="userIntroduce"></textarea>
    </div>
    
    <div class="form-group">
      <label for="text">나를 표현할 수 있는 링크</label>
     <input type="text" class="form-control" id="userLink" name="userLink" placeholder="test1234@gmail.com">
    </div>
    
    <button type="submit"  id="set" class="btn btn-success" onclick="submitAndclose(this.form)" disabled>제출</button>
  </form>
  
  <script>
  	function submitAndclose(frm){
  		frm.action="insertResume.do";
		return false;

  		}

  	$(".form-control").on("keyup", function(){
			var flag1 = $("#userId").val().length > 0 ? false : true;
			var flag2 = $("#userName").val().length > 0 ? false : true;
			var flag3 = $("#userTel").val().length > 0 ? false : true;
			var flag4 = $("#categoryName").val().length > 0 ? false : true;
			var flag5 = $("#userIntroduce").val().length > 0 ? false : true;
			var flag6 = $("#userLink").val().length > 0 ? false : true;
			
			if (flag1== false && flag2== false &&flag3== false &&
					flag4== false &&flag5== false &&flag6== false){
			$("#set").attr("disabled", false);
			}
	})
  </script>
  
	
	
	</div>
</body>
</html>