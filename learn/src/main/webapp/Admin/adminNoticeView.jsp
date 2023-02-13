<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>CS관리  - 공지사항 상세보기</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<link href="${pageContext.request.contextPath }/Admin/css/sideNav.css" rel="stylesheet" type="text/css">
<style>
	.inner2 {
		width: 1100px;
		display: inline-block;
		text-align: left;
		margin-left: 0%;
		border-bottom: 2px solid lightgrey;
		padding: 1%;
	}
	.outer2 {
		text-align: center;
	}
	.inner3 {
		width: 1100px;
		display: inline-block;
		text-align: left;
		margin-left: 0%;
		padding: 1%;
		border-bottom: 2px solid lightgrey;
	}
	.inner4 {
		width: 1100px;
		display: inline-block;
		text-align: right;
		margin-left: 0%;
	}

	/* 페이징처리 css */
	.page_wrap {
		text-align:center;
		font-size:0;
	 }
	.page_nation {
		display:inline-block;
	}
	.page_nation .none {
		display:none;
	}
	.page_nation a {
		display:block;
		margin:0 3px;
		float:left;
		border:1px solid #e6e6e6;
		width:28px;
		height:28px;
		line-height:28px;
		text-align:center;
		background-color:#fff;
		font-size:13px;
		color:#999999;
		text-decoration:none;
	}
	.page_nation .arrow {
		border:1px solid #ccc;
	}
	.page_nation .prev {
		background:#f8f8f8 url('img/page_prev.png') no-repeat center center;
		margin-right:7px;
	}
	.page_nation .next {
		background:#f8f8f8 url('img/page_next.png') no-repeat center center;
		margin-left:7px;
	}
	.page_nation a.active {
		background-color : #00C471;
		color:white;
		border:1px solid #00C471;
	}
</style>
</head>
<body>
<%@ include file="/Admin/common/adminHeader.jspf" %>

<!-- 사이드 -->
<div class="menu">
	<ul class="ul" style="text-align: center;">
<!-- 	  <li class="li"><a style="background: #00C471; color: white; font-size: 1.5em">CS관리</a></li> -->
	  <li class="li"><a style="color: #00C471;" href="${pageContext.request.contextPath }/getNoticeAdminList.do">공지사항</a></li>
	  <li class="li"><a href="${pageContext.request.contextPath }/getAdminFaqList.do">자주묻는질문</a></li>
	  <li class="li"><a href="getMyQBoardListM.do">Q & A</a></li>
	</ul>
</div>
<br><br>

<!-- 본문 -->
<br><br>
<div class="outer2">
	<div class="inner2">
		<h3>${vo.boardTitle }</h3>
	</div>
</div>
<div class="outer2">
	<div class="inner3">
		${vo.boardContent }
	</div>
</div>
<br>

<div class="outer2">
	<div class="inner4">
		<div class="container">
	 		<button type="submit" class="btn btn-success" onclick="location.href='${pageContext.request.contextPath }/getNoticeAdminList.do'">목록</button>
	 		<button type="submit" class="btn btn-success" onclick="location.href='${pageContext.request.contextPath }/getNoticeUpdateView.do?boardNo=${vo.boardNo }'">수정</button>
 	 		<%-- <button type="submit" class="btn btn-success" onclick="location.href='${pageContext.request.contextPath }/deleteNotice.do?boardNo=${vo.boardNo }'">삭제</button> --%>
	 		<button type="submit" class="btn btn-dark" onclick="delete_go()">삭제</button>
		</div>
	</div>
</div>

<%@ include file="/Common/footer.jsp" %>
</body>
<script>
	function delete_go() {
		var con_test = confirm("게시글을 삭제하시겠습니까?");
		if (con_test == true) {
			alert("게시글이 삭제 되었습니다.");
			location.href = '${pageContext.request.contextPath }/deleteNotice.do?boardNo=${vo.boardNo }';
		}
		else if (con_test == false) {
 		    //alert("목록 페이지로 이동합니다.");
 		    //location.href = '${pageContext.request.contextPath }/getNoticeAdminList.do';
		}
	}
</script>
</html>