<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>CS관리  - QnA</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Community/css/jyStyle.css">

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

<script type="text/javascript">
$(document).ready(function(){
	removeImg();
});

function removeImg(){
	$(".contentWrap br").remove();
	$(".contentWrap img").unwrap();
	$(".contentWrap img").remove();		
	$(".contentWrap hr").remove();		
}

$(document).on("keyup", "#searchKeyword", function(){
	ajaxserachh();
});

$(document).on("click", ".adopt", function(){
	$(".adopt").removeClass('black-line');
	$(".adopt").removeClass('active');
	$(this).addClass('black-line');		
	$(this).addClass('active');		
	ajaxserachh();
});

$(document).on("click", ".adoptItem", function(){
	$(".adoptItem").removeAttr('id', 'adopt');
	$(this).attr('id', 'adopt');
});


function pageGo(pageNum){		
	ajaxserachh(pageNum);
}

function ajaxserachh(pageNum){
	var searchKeyword = $("#searchKeyword").val().trim();
	var boardAdopt =  $("#adopt").text();
	
	var gogo = "${pageContext.request.contextPath}/memberBoard/getMyQBoardListAj.do?searchKeyword=" + searchKeyword
	if (boardAdopt != null){
		var gogo = gogo + '&qnaAdopt=' + boardAdopt
	}
	if (pageNum != null){
		var gogo = gogo + '&cPage=' + pageNum
	}
	
	
	$.ajax({
		url: gogo,
		type : "get",
		async : true,
		
		success : function(data){
			console.log("에이젝스 성공!!");
			console.log(data);

			var html = jQuery('<div>').html(data);
			var center = html.find("div#center").html();
			
				$("#searchList").html(center);
			
			var paging = html.find("div#paging").html();
			
				$("#paginations").html(paging);
			
			removeImg();
		},
		
		error : function(){
			console.log("에이젝스 실패!!");
		}
			
	});
	
}


function qnaWriteForm() {
	if(${user.userId == null}){
		alert("로그인 후 입력해주시기 바랍니다");
		return false;
	}
	location.href='${pageContext.request.contextPath}/memberBoard/qnaWriteForm.do';
}

</script>


</head>
<body>
<%@ include file="/Admin/common/adminHeader.jspf" %>

<!-- 사이드 -->
<div class="menu">
	<ul class="ul" style="text-align: center;">
	  <li class="li"><a  href="${pageContext.request.contextPath }/getNoticeAdminList.do">공지사항</a></li>
	  <li class="li"><a  href="${pageContext.request.contextPath }/getAdminFaqList.do">자주묻는질문</a></li>
	  <li class="li"><a style="color: #00C471;" href="${pageContext.request.contextPath }/memberBoard/getMyQBoardListM.do">Q & A</a></li>
	</ul>
</div>
<br><br>

<br>

<div class="d-flex">
				<nav class="navbar navbar-expand-sm navbar-light p-3"  style="margin-left: 450px;">
              <ul class="navbar-nav gray-botton w-100" style="border-bottom: 1px solid gray">
                  <li class="nav-item active adopt black-line">
                  <a class="nav-link adoptItem" id="adopt" >전체</a>
                  </li>
                  <li class="nav-item adopt">
                  <a class="nav-link adoptItem" >미해결</a>
                  </li>
                  <li class="nav-item adopt">
                  <a class="nav-link adoptItem" >해결됨</a>
                  </li>
              </ul>
				</nav>
				
				<input type="text" placeholder="검색어를 입력하세요." id="searchKeyword" name="searchKeyword" style="margin-left: 450px; margin-top:20px; height: 30px; width: 500px;">
</div>
<!-- 본문 -->
<div id="searchList">	
<table class="center">
	<thead>
		<tr>
		    <th width="25%">작성자</th>
		    <th>제목</th>
		    <th width="20%">등록일</th>
		    <th width="10%">답변여부</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${not empty memberBoardList}">
	<c:forEach var="qna" items="${memberBoardList}">
				<tr>
				<td>${qna.userName }</td>
				    <!-- 게시글 상세링크 가져와서 걸어주기 재영씨 링크로 갈예정 -->
				    <c:if test="${qna.qnaTitle eq null}">
				    <td class="title"><a class='text-secondary' href="${pageContext.request.contextPath}/memberBoard/viewPage.do?qnaNo=${qna.qnaNo }">제목없음</a></td>
				    </c:if>
				     <c:if test="${qna.qnaTitle ne null}">
				    <td class="title"><a href="${pageContext.request.contextPath}/memberBoard/viewPage.do?qnaNo=${qna.qnaNo }">${qna.qnaTitle }</a></td>
				    </c:if>
				    <!-- 제목길경우를 대비해 10자리까만 표시 -->
				    <td>${qna.qnaRegdate.substring(0,10) }</td>
				    <c:if test="${qna.qnaAdopt eq 'FALSE'}">
				    <td>미답변</td>
				    </c:if>
				    <c:if test="${qna.qnaAdopt eq 'TRUE'}">
				    <td>답변완료</td>
				    </c:if>
				</tr>
			</c:forEach>
		</c:if>
		<!-- 게시글 없을 경우 표시할 내용 -->
		<c:if test="${empty memberBoardList}">
			<tr>
				<td colspan="3">
					<span style="text-align: center;">데이터가 없습니다.</span>
				</td>
			</tr>
		</c:if>
	</tbody>
</table>

</div>

<br>

<br>
	
<!-- 페이징처리-->
	<c:if test="${pvo.totalRecord != 0 }">
			
		<div id="paginations" class="pagination p12 justify-content-center">
	      <ul>
				<c:if test="${pvo.beginPage == 1 }">
	        	<a href="#" class="disabled"><li>이전페이지</li></a>
			</c:if>
			<c:if test="${pvo.beginPage != 1 }">
	        	<a href="javascript:pageGo(${pvo.beginPage -1 })">
	        	<li>이전페이지</li></a>
			</c:if>
			
			
			<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
				<c:if test="${pageNo == pvo.nowPage }">
		        	<a href="#" class="is-active disabled" ><li>${pageNo }</li></a>
				</c:if>
				
				<c:if test="${pageNo != pvo.nowPage }">
			        <a href="javascript:pageGo(${pageNo })"><li>${pageNo }</li></a>
				</c:if>
			</c:forEach>

			
			<c:if test="${pvo.endPage < pvo.totalPage }">
		        <a href="javascript:pageGo(${pvo.endPage + 1 })"><li>다음페이지</li></a>
			</c:if>
			<c:if test="${pvo.endPage >= pvo.totalPage }">
		        <a href="#" class="disabled" ><li>다음페이지</li></a>
			</c:if>
			
	      </ul>
	    </div>
    </c:if> 		

<br><br>

<%@ include file="/Common/footer.jsp" %>
</body>
</html>