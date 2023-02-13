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
	.inner {
		width: 1100px;
		display: inline-block;
		text-align: left;
		margin-left: 0%;
		border-bottom: 2px solid lightgrey;
		padding: 1%;
	}
	.outer {
		text-align: center;
	}
	.inner2 {
		width: 1100px;
		display: inline-block;
		text-align: left;
		margin-left: 0%;
		padding: 1%;
		border-bottom: 2px solid lightgrey;
	}
	.inner3 {
		width: 1100px;
		display: inline-block;
		text-align: right;
		margin-left: 0%;
	}
	

</style>

</head>
<body>
<%@ include file="/Admin/common/adminHeader.jspf" %>
<br><br>

<!-- 본문 -->
<br><br>
<div class="outer">
	<div class="inner">
		<c:if test="${adminStatus eq 'notDel'}">
			<h3>${vo.boardTitle }</h3>
		</c:if>
		<c:if test="${adminStatus eq 'del'}">
			<h3>${vo.resultTitle }</h3>
		</c:if>
	</div>
</div>
<div class="outer">
	<div class="inner2">
		<c:if test="${adminStatus eq 'notDel'}">
			${vo.boardContent }
		</c:if>
		<c:if test="${adminStatus eq 'del'}">
			${vo.resultContent }
		</c:if>
	</div>
</div>
<br>
<div class="outer">
	<div class="inner3">
		<div class="container">
 			<button type="submit" class="btn btn-success" onclick="location.href='${pageContext.request.contextPath}/getFalseReport.do'">목록</button>
		</div>
	</div>
</div>

<br><br>
<%@ include file="/Common/footer.jsp" %>
</body>
</html>