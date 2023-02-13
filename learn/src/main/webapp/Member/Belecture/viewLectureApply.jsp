<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지식공유참여 신청 현황</title>
</head>
<body>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<%@include file ="/Common/header.jsp" %>



<div class="container">
<br>
<h2 class="text-center">지식공유 참여 현황</h2>
<br>

<c:if test="${empty resume.userName}" >
<h4 class="text-center">신청한 기록이 없습니다</h4>
</c:if>

<c:if test="${not empty resume.userName}">
<form method="post">

 <div class="form-group">
    <label for="userId">이메일</label>
      <input type="text" class="form-control"  name="userId" value=${resume.userId } readonly>
     </div>
     
      <div class="form-group">
    <label for="categoryName">카테고리명</label>
        <input type="text" class="form-control"  name="categoryName" value=${resume.categoryName }>
      </div>
      
       <div class="form-group">
    <label for="userName">이름</label>
        <input type="text" class="form-control"   name="userName" value=${resume.userName }>
      </div>
      
       <div class="form-group">
    <label for="userTel">연락처</label>
        <input type="text" class="form-control"   name="userTel" value=${resume.userTel }>
     </div>
     
      <div class="form-group">
    <label for="userIntroduce">소개글</label>
        <input type="text" class="form-control"  name="userIntroduce" value=${resume.userIntroduce }>
     </div>
     
      <div class="form-group">
    <label for="userLink">소개할 링크</label>
        <input type="text" class="form-control"  name="userLink" value=${resume.userLink }>
     </div>
     
      <div class="form-group">
    <label for="resumeStatus">신청현황</label>
        <input type="text" class="form-control"  name="resumeStatus" value=${resume.resumeStatus } readonly>
        </div>
        <input type="submit" class="btn" value="변경" onclick="updateResume(this.form)">
        <input type="submit" class="btn" value="삭제" onclick="deleteResume(this.form)">
        

     </form>
</c:if>

</div>

<script>
	function updateResume(frm){
		alert("변경 처리되었습니다");
		frm.action="updateResume.do";
		
	} 
	
	function deleteResume(frm){
		alert("삭제 처리되었습니다");
		frm.action="deleteResume.do";
		
	}
</script>



<%@include file ="/Common/footer.jsp"%>
</body>
</html>