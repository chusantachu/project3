<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지 - 강의자관리 - 상세보기</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
	.outer {
		text-align: center;
	}
	.inner {
		display: inline-block;
		text-align: center;
	}
	.inner2 {
		display: inline-block;
		text-align: right;
		width: 550px;
	}
	body {
		background-color: rgb(245,245,245);
	}
	
	#customers {
	  font-family: Arial, Helvetica, sans-serif;
	  border-collapse: collapse;
	  width: 550px;
	}
	
	#customers td, #customers th {
	  border: 1px solid #ddd;
	  padding: 8px;
	}
	
	#customers tr:nth-child(even){background-color: #f2f2f2;}
	
	#customers tr:hover {background-color: #ddd;}
	
	#customers th {
	  padding-top: 12px;
	  padding-bottom: 12px;
	  text-align: center;
	  background-color: #00C471;
	  color: white;
	  width: 15%;
	}
</style>
<script>
	function frameclose() { 
		parent.close() 
		window.close() 
		self.close() 
	} 
	
	function newPageOpne() {
		window.open("http://www.naver.com", '자기소개 링크', 'height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes');		
	}
	
	function resumeApprove(userId) {
		var con_test = confirm(userId + " 님의 강의자 신청을 승인하시겠습니까?");
		if (con_test == true) {
			var email = userId;
			console.log("수신이메일주소 : " + userId);
			
			$.ajax({
				type : 'get',
				url : '<c:url value ="/Member/approveResumeMail.do?email="/>' + email, 
				success : function (data) {
					console.log("data : " +  data);
					checkInput.attr('disabled',false);
					code =data;
					//alert('전송!');
				}		
			}); 
			alert(userId + " 님에게 안내 메일 전송이 완료되었습니다.");
			opener.location.href='${pageContext.request.contextPath}/Admin/resumeApprove.do?userId=' + userId; 
			window.close();
		}
	}
	
	function resumeReject(userId) {
		var con_test = confirm(userId + " 님의 강의자 신청을 거절하시겠습니까?");
		if (con_test == true) {
			var email = userId;
			console.log("수신이메일주소 : " + userId);
			
			$.ajax({
				type : 'get',
				url : '<c:url value ="/Member/rejectResumeMail.do?email="/>' + email, 
				success : function (data) {
					console.log("data : " +  data);
					checkInput.attr('disabled',false);
					code =data;
					//alert('전송!');
				}		
			}); 
			alert(userId + " 님에게 안내 메일 전송이 완료되었습니다.");
			opener.location.href='${pageContext.request.contextPath}/Admin/resumeReject.do?userId=' + userId; 
			window.close();
		}
	}
</script>
</head>
<body>
<div class="outer">
	<div class="inner">
<!-- 		<br><br> -->
<!-- 		<h3>상세보기</h3> -->
		<br><br>
		<table id="customers">
			<tr>
				<th>아이디</th>
				<td>${resume.userId }</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>${resume.userName }</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${resume.userTel }</td>
			</tr>
			<tr>
				<th>신청분야</th>
				<td>${resume.categoryName }</td>
			</tr>
			<tr>
				<th>자기소개</th>
				<td>${resume.userIntroduce }</td>
			</tr>
			<tr>
				<th>소개링크</th>
				<td><a a href="javascript:newPageOpne();">${resume.userLink }</a></td>
			</tr>
			<tr>
				<th>신청일</th>
				<td>${resume.regdate.substring(0,10) }</td>
			</tr>
			<c:if test="${resume.resumeStatus eq 'false' }">
				<tr>
					<th>상태</th>
					<td>대기</td>
				</tr>
			</c:if>
			<c:if test="${resume.resumeStatus eq 'true' }">
				<tr>
					<th>상태</th>
					<td>승인</td>
				</tr>
			</c:if>
		</table>
		<div class="outer">
			<div class="inner2">
				<c:if test="${resume.resumeStatus eq 'false' }">
					<br>
					<button type="button" class="btn btn-success" onclick="resumeApprove('${resume.userId}')">승인</button> 
					<button type="button" class="btn btn-dark" onclick="resumeReject('${resume.userId}')">거절</button>
				</c:if>
			</div>
		</div>
		<br>
		<button class="btn btn-outline-success" onclick="frameclose()">닫기</button>
	</div>
</div>
</body>
</html>