<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script>
window.onload=function(){
	alert("이미 구매하신 상품입니다");
	location.href="getLecture.do?lectureNo=" + ${lecture.lectureNo};
	
}
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>