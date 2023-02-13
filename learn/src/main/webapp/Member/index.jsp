<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시작페이지</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<body>
	
<div id="container">
	<h1>[index.jsp]</h1>
	<hr>
	<p>
		<a href="newMember.jsp">회원가입 페이지로 이동</a>
		<a href="login.jsp">로그인 페이지로 이동</a>
		<a href="myPage.jsp">마이 페이지로 이동</a>
		<a href="changePassword.jsp">비밀변호 변경</a>
		<a href="findId.jsp">아이디 찾기</a>
		<a href="findPassword.jsp">비밀번호 찾기</a>
		<a href="/learn/getNoticeList.do">공지사항</a>
		<a href="/learn/getFaqList.do">자주묻는질문</a>
		<a href="findPassword.jsp">지식 공유 참여</a>
		<a href="getResume.do?userId=${user.userId }">지식 공유 참여</a>
		
	</p>
	<hr><hr>
</div>
</body>
</html>



