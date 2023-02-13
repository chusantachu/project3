<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>CS관리  - 공지사항관리</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<link href="${pageContext.request.contextPath }/Admin/css/sideNav.css" rel="stylesheet" type="text/css">
<style>
	.center .title {text-align: left;}

	/* 글쓰기버튼 css*/
	.outer2 { text-align: center; }
	.inner4 {
		width: 1100px;
		display: inline-block;
		text-align: right;
		margin-left: 0%;
	}
	
	/* 검색버튼 css */
	.search {
		width: 300px; 
		margin-left: 43%;
	}

	/* 테이블 css */
	.center {
     border-collapse: collapse;
     width: 1100px;
     margin-left: 24%;
	}
	.center th, .center td {
	     padding: 15px;
	     border-bottom: 1px solid #00C471;
	     text-align: center;
	}
	.center tr:hover { background-color: #F5F5F5; } 
	.center td a {color: black;}
	.center td a:hover {
		text-decoration: none;
		color: #00C471;
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
	  <li class="li"><a style="color: #00C471;" href="${pageContext.request.contextPath }/getNoticeAdminList.do">공지사항</a></li>
	  <li class="li"><a href="${pageContext.request.contextPath }/getAdminFaqList.do">자주묻는질문</a></li>
	  <li class="li"><a href="${pageContext.request.contextPath }/memberBoard/getMyQBoardListM.do">Q & A</a></li>
	</ul>
</div>
<br><br>

<!-- 검색창 -->
<form action="getNoticeAdminList.do" method="post">
	<div class="outer">
		<div class="search">
		  <div class="input-group mb-3">
			    <input type="text" class="form-control" placeholder="검색어를 입력하세요." size="10" name="searchKeyword">
			    <div class="input-group-append">
			      <button class="btn btn-success" type="submit">검색</button>  
			     </div>
		  </div>
		</div>
	</div>
</form>
<br>

<!-- 본문 -->
<table class="center">
	<thead>
		<tr>
		    <th width="25%">작성자</th>
		    <th>제목</th>
		    <th width="20%">등록일</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${not empty list }">
			<c:forEach var="notice" items="${list }">
				<tr>
				    <td>${notice.userId }</td>
				    <td class="title"><a href="getAdminNotice.do?boardNo=${notice.boardNo }">${notice.boardTitle }</a></td>
				    <td>${notice.boardRegdate.substring(0,10) }</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty list }">
			<tr>
				<td colspan="3">
					<span style="text-align: center;">데이터가 없습니다.</span>
				</td>
			</tr>
		</c:if>
	</tbody>
</table>
<br>

<div class="outer2">
	<div class="inner4">
		<div class="container">
	 		<button type="submit" class="btn btn-success" onclick="location.href='${pageContext.request.contextPath}/Admin/adminNoticeWrite.jsp'">글쓰기</button>
		</div>
	</div>
</div>
<br>
	
<!-- 페이징처리-->
<div class="page_wrap">
   <div class="page_nation">
	<c:if test="${pvo.beginPage != 1}">	
		<a class="arrow prev" href="getNoticeAdminList.do?cPage=${pvo.beginPage - 1 }">&lt</a>
	</c:if>
	
	<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
		<c:if test="${pageNo == pvo.nowPage }">
			<a class="active">${pageNo}</a>
		</c:if>
		<c:if test="${pageNo != pvo.nowPage }">
			<a href="getNoticeAdminList.do?cPage=${pageNo }">${pageNo}</a>
		</c:if>
	</c:forEach>	
	
	<c:if test="${pvo.endPage < pvo.totalPage}">
		<a class="arrow next" href="getNoticeAdminList.do?cPage=${pvo.endPage + 1 }">&gt</a>
	</c:if>
   </div>
</div> 		

<br><br>

<%@ include file="/Common/footer.jsp" %>
</body>
</html>