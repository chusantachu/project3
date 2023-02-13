<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>공지사항</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>
	.getNotice a {color: black;}
	.getNotice a:hover {
	  	text-decoration: none;
	  	color: #00C471;
	 }
	.center { text-align: center; }
	.tape {
		height: 100px;
		margin: 50px auto;
		padding-top: 15px;
		color: white;
	}
	.table #N { color: #00C471;}  
	.table #fontSize { font-size: 0.7em }
	.inner {
		display: inline-block;
		text-align: left;
	}
	.outer {
		text-align: center;
	}
	.menuborder {
	    list-style-type: none;
	    margin: 0;
	    padding: 0;
	    overflow: hidden;
		border-bottom: 1px solid #e7e7e7; 
	}
	.menu {
	    float: left;
	}
	.menu a {
	    display: block;
		color: black;
	    text-align: center;
	    padding: 14px 16px;
	    text-decoration: none;
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
<script>
	function getJsonNoticeListData(frm) {
		//alert("getJsonNoticeListData(frm) 실행");
		//console.log($(frm).serialize());
		
		$.ajax("getJsonNoticeList.do", {
			type: "get",
			data: $(frm).serialize(), //서버쪽으로 JSON 문자열 전달
			dataType: "json", //서버로부터 응답받는 데이터 형식
			success: function(data){ 
				
				let list = "";
				
				for (let notice of data.list) {				
					console.log("list : " + notice.boardTitle);
					list += '<tr>';
					list += '<td class="getNotice">';
					list += '<a href="getNotice.do?boardNo=' + notice.boardNo + '">';
					list += '<span id="N">N.</span>' + notice.boardTitle;     
					list += "<br>";
					list += '<span id="fontSize">' + notice.boardRegdate.substring(0,10) + ' 관리자</span>';
					list += "</a>";
					list += "</td>";
					list += "</tr>";
				}
				
		        console.log("page : " + data.pvo.beginPage);  
	            let page = "";
	            page += '<div class="page_wrap">';
	            page += '<div class="page_nation">';
	            if (data.pvo.beginPage != 1) {
	            	page += '<a class="arrow prev" href="getJsonNoticeList.do?cPage=' + data.pvo.beginPage + '- 1 ">&lt</a>';
				}
	            for (let i = data.pvo.beginPage; i <= data.pvo.endPage; i++) {
					if (i == data.pvo.nowPage) {
						page += '<a class="active">' + i + '</a>';
					} else if (i != data.pvo.nowPage) {
						page += '<a href="getJsonNoticeList.do?cPage=${pageNo }">' + i + '</a>';
					}
				}
	            if (data.pvo.endPage < data.pvo.totalPage) {
	            	 page += '   <a class="arrow next" href="getJsonNoticeList.do?cPage=' + data.pvo.endPage + ' + 1">&gt</a>';    
	            }
	            page += '</div>';
	            page += '</div>';
		            
				$("#dispBody").html(list);
				$("#dispBody2").html(page);
				
			},
			error: function(){
				alert("[ERROR]오류");
			}
		});
		
	}
</script>
</head>
<body>
	<!-- 헤더 -->
    <%@ include file="/Common/header.jsp" %>
    <div class="container-fluid bg-dark">
		<div class="container tape">
			<section class="tapeContent">		
				<h2>새로운 소식들!</h2>
				<p>신규 컨텐츠, 이벤트, 기능 추가 등의 새로운 아웃풋런의 이야기를 들어주세요.</p>
			</section>
		</div>
	</div>
	<!-- 검색기능 -->
	<div class="outer">
		<div class="inner">
			<div class="container">
				<div class="row">
					<%--<form method="get" name="search"> --%>
					<form action="getNoticeList.do" method="post">
						<table class="pull-right">
							<tr>
								<td>
									<input type="text" class="form-control" placeholder="검색어를 입력하세요." name="searchKeyword">
								</td>
								<td>
 									<button type="button" class="btn btn-success" onclick="getJsonNoticeListData(this.form)">검색</button>
									<!--  <button type="submit" class="btn btn-success">검색</button> -->
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>

 	<br><br>
    
    <!-- 리스트 출력 -->
	<div class="container">      
	  <table class="table">
	    <tbody id="dispBody">
	    <c:if test="${not empty list }">
	      <c:forEach var="notice" items="${list }">
		      <tr>
		        <td class="getNotice">
			        <a href="getNotice.do?boardNo=${notice.boardNo }">
			        	<span id="N">N.</span> ${notice.boardTitle }
						<br>
						<span id="fontSize">${notice.boardRegdate.substring(0,10) } 관리자</span>
					</a>	
				</td>
		      </tr>
	      </c:forEach>
	    </c:if>
	    <c:if test="${empty list }">
			<tr>
				<td class="center">데이터가 없습니다.</td>
			</tr>
		</c:if>		
	    </tbody>
	  </table>
	</div>
	
	<!-- 페이징처리-->
	<div id="dispBody2">
		<div class="page_wrap">
		   <div class="page_nation">
			<c:if test="${pvo.beginPage != 1}">	
				<a class="arrow prev" href="getNoticeList.do?cPage=${pvo.beginPage - 1 }">&lt</a>
			</c:if>
			
			<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
				<c:if test="${pageNo == pvo.nowPage }">
					<a class="active">${pageNo}</a>
				</c:if>
				<c:if test="${pageNo != pvo.nowPage }">
					<a href="getNoticeList.do?cPage=${pageNo }">${pageNo}</a>
				</c:if>
			</c:forEach>	
			
			<c:if test="${pvo.endPage < pvo.totalPage}">
				<a class="arrow next" href="getNoticeList.do?cPage=${pvo.endPage + 1 }">&gt</a>
			</c:if>
		   </div>
		</div> 		
	</div>
	<br><br><br>
	 <%@ include file="/Common/footer.jsp" %>
</body>
</html>
