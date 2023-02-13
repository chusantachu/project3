<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	location.href="${pageContext.request.contextPath}/getLectureNews.do?lectureNo=${vo.lectureNo}&boardNo=${vo.boardNo}";
</script>