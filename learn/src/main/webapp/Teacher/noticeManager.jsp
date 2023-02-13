<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <title>강의자  - 강의 관리 - 새소식 관리</title>
</head>
<style>
  .active-menu {
    color: #1dc078;
    font-weight: bold;
  }
  .norm-menu {
    color: black;
  }
  .active-btn {
    color: #fff;
    background-color: #00C471;
    border-style: none;
    padding: 5px;
    border-radius: 5px;
    margin-right: 5px;
  }
  .tape {
    height: 70px;
    margin: 50px auto;
    padding-top: 15px;
    color: white;
  }
  .title { color: black; }
  .title:hover { 
  	color: black; 
  	text-decoration: underline;
  }
  tr {text-align: center;}
  .left {text-align: left;}
  
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
  
  	/* 검색버튼 css */
	.search {
		width: 300px; 
 		margin-left: 43%; 
	}
	
	/* 글쓰기버튼 css*/
	.outer2 { text-align: center; }
	.inner4 {
		width: 1100px;
		display: inline-block;
		text-align: right;
		margin-left: 7%;
	}
</style>
<body>
<%@include file="/Common/header.jsp" %>
<div class="container-fluid bg-dark">
    <div class="container tape">
        <section class="tapeContent">
            <h2>새소식 관리</h2>
        </section>
    </div>
</div>
<div class="container-fluid mt-5 pb-3 d-flex justify-content-center">
    <div class="row w-100 pb-4 justify-content-center">
        <!-- 왼쪽 네비 -->
        <div class="col-2 d-flex justify-content-center">
            <%@ include file="sidebar.jspf"%>
        </div>
        <script>
          var menu = $('#lectureManager');
          console.log(menu);
          menu.removeClass('norm-menu');
          menu.addClass('active-menu');
        </script>

        <!-- 중앙 위 내용 - 글내용 -->
        <div class="col-8 pl-3 gray-line">
        	<h5>${lectureTitle }</h5>
            <button class="active-btn mt-2" onclick="location.href='${pageContext.request.contextPath}/Teacher/lectureManager.do'">강의 관리로 돌아가기</button>
        	<br><br>
        	<!-- 검색창 -->
			<form action="${pageContext.request.contextPath}/getLectureNewsList.do?lectureNo=${lectureNo}" method="post">
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
            <table class="table mt-4">
                <thead>
                <tr>
                	<th>작성자</th>
                    <th width=70%>제목</th>
                    <th>등록일</th>
                </tr>
                </thead>
                <tbody id="dispBody">
                	<c:if test="${not empty list }">
						<c:forEach var="news" items="${list }">
							 <tr>
							 	<td>${news.lectureWriter }</td>
			                    <td class="left">
			                        <a class="title" href="${pageContext.request.contextPath}/getLectureNews.do?boardNo=${news.boardNo }">${news.newsTitle }</a>
			                    </td>
			                    <td>${news.boardRegdate.substring(0,10) }</td>
			                </tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty list }">
						<tr>
							<td colspan="3" style="text-align: center;">데이터가 없습니다.</td>
						</tr>
					</c:if>
                </tbody>
                <tfoot>
                <tr>
                	<td colspan="3" style="padding: 25px; text-align: right;" >
				 		<button type="submit" class="btn btn-success" onclick="location.href='lectureNewsWrite.do?lectureNo=${lectureNo }'">새소식 작성</button>
                	</td>
                </tr>
                </tfoot>
            </table>
        </div>
        <div class="col-2 d-flex justify-content-center">
        </div>
    </div>
</div>
<!-- 페이징처리-->
<div class="page_wrap">
   <div class="page_nation">
	<c:if test="${pvo.beginPage != 1}">	
		<a class="arrow prev" href="getLectureNewsList.do?lectureNo=${lectureNo }&cPage=${pvo.beginPage - 1 }">&lt</a>
	</c:if>
	
	<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
		<c:if test="${pageNo == pvo.nowPage }">
			<a class="active">${pageNo}</a>
		</c:if>
		<c:if test="${pageNo != pvo.nowPage }">
			<a href="getLectureNewsList.do?lectureNo=${lectureNo }&cPage=${pageNo }">${pageNo}</a>
		</c:if>
	</c:forEach>	
	
	<c:if test="${pvo.endPage < pvo.totalPage}">
		<a class="arrow next" href="getLectureNewsList.do?lectureNo=${lectureNo }&cPage=${pvo.endPage + 1 }">&gt</a>
	</c:if>
   </div>
</div> 		

<%@include file="/Common/footer.jsp" %>
</body>
</html>