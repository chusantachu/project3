<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
  <title>관리자 페이지 - 신고관리</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <style>
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
		background:#f8f8f8
		margin-right:7px;
	}
	.page_nation .next {
		background:#f8f8f8
		margin-left:7px;
	}
	.page_nation a.active {
		background-color : #00C471;
		color:white;
		border:1px solid #00C471;
	}
	
	/* 버튼 css */
	.button {
	  background-color: gray;
	  border: 1px solid white;
	  color: white;
	  padding: 10px 20px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 16px;
	  cursor: pointer;
	}
	
	#active {
		background-color: #00C471;
	}
  	.inner2 {
		width: 1100px;
		display: inline-block;
		text-align: left;
		margin-left: 0%;
	}
	.outer2 {
		text-align: center;
	}
	.button2:hover {
	  box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
	}
	.tabla {
		width: 1100px;
	}
	.table th, .table td {
		text-align: center;
	}
	.detail {
	  background-color: #00C471; 
	  border: none;
	  color: white;
 	  padding: 1px 10px 1px 10px; 
	  text-decoration: none;
	  display: inline-block;
 	  font-size: 15px; 
	  cursor: pointer;
	  border-radius: 12px;
	}
	.save {
	  background-color: #4CAF50;
	  border: none;
	  color: white;
	  padding: 2px 8px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  margin: 4px 2px;
	  cursor: pointer;
	}

  </style>
<script>
	function getTrueReport(cPage) {
		//alert("getTrueReport() 실행 : " + cPage);
		var url = null;
		
		if (cPage > 1) {
			url = "getTrueReport.do?cPage=" + cPage;
		} else {
			url = "getTrueReport.do";
		}
		
		$.ajax(url, {
			type: "get",
			dataType: "json", 
			success: function(data){ 
				//alert("성공");
				
				//테이블헤더 출력
				let header = "";
				header += '<th>신고자</th>';
				header += '<th>사유</th>';
				header += '<th>신고일</th>';
				header += '<th>게시판</th>';
				header += '<th>바로가기</th>';
				header += '<th>상태</th>';
				
				let list = "";		
				
				//데이터 리스트 출력
 				for (let report of data.list) {				
 					console.log("list : " + report.reportReason);
 					
					list += '<tr>';
					list += '<td>' + report.reporter +'</td>';
					list += '<td>' + report.reportReason + '</td>';
					list += '<td>' + report.reportDate.substring(0,10) +'</td>';
					if (report.boardType == 'questionBoard') {
						list += '<td>질문게시판</td>';
						list += '<td><a href="${pageContext.request.contextPath}/getReportPost.do?boardNo=' + report.boardNo + '&boardType=' + report.boardType + '">게시글 바로가기</a></td>';
					} else {
						list += '<td>자유게시판</td>';
						list += '<td><a href="${pageContext.request.contextPath}/getReportPost.do?boardNo=' + report.boardNo + '&boardType=' + report.boardType + '">게시글 바로가기</a></td>';
					}
					if (report.reportStatus == 1) {
						list += '<td>처리완료</td>';
					}
					list += '</tr>';
 				}
				
				//페이지 출력
		        console.log("page : " + data.pvo.beginPage);  
	            let page = "";
	            page += '<div class="page_wrap">';
	            page += '<div class="page_nation">';
	            if (data.pvo.beginPage != 1) {
	            	page += '<a class="arrow prev" href="${pageContext.request.contextPath}/getTrueReport.do?cPage=' + data.pvo.beginPage + '- 1 ">&lt</a>';
				}
	            for (let i = data.pvo.beginPage; i <= data.pvo.endPage; i++) {
					if (i == data.pvo.nowPage) {
						page += '<a class="active">' + i + '</a>';
					} else if (i != data.pvo.nowPage) {
						page += '<a href="javascript:getTrueReport(' + i + ')">' + i + '</a>';
					}
				}
	            if (data.pvo.endPage < data.pvo.totalPage) {
	            	 page += '   <a class="arrow next" href="${pageContext.request.contextPath}/getTrueReport.do?cPage=' + data.pvo.endPage + ' + 1">&gt</a>';    
	            }
	            page += '</div>';
	            page += '</div>';
	            
	            //버튼 active 변경
	            let button = "";
	            button += '<button class="button button2" onclick="getFalseReport()">승인대기</button>';
	            button += '<button class="button button2" id="active" onclick="getTrueReport()">처리완료</button>';
	            button += '<button class="button button2" onclick="getDeleteReport()">삭제완료</button>';
		            
 				$("#dispBody").html(list);
				$("#dispBody2").html(page);
				$("#dispBody3").html(button);
				$("#dispBody4").html(header);
	
			},
			error: function(){
				alert("[ERROR]오류");
			}
		});
	}

	function getDeleteReport(cPage) {
		//alert("getDeleteReport() 실행");
		var url = null;
		
		if (cPage > 1) {
			url = "getDeleteReport.do?cPage=" + cPage;
		} else {
			url = "getDeleteReport.do";
		}
		
		$.ajax(url, {
			type: "get",
			dataType: "json", 
			success: function(data){ 
				//alert("성공");
				//데이터 리스트 출력
				let list = "";		
				
				for (let result of data.list) {		
					list += '<tr>';
					list += '<td>' + result.resultId +'</td>';
					list += '<td>' + result.resultTitle + '</td>';
					list += '<td>' + result.resultRegdate.substring(0,10) +'</td>';
					list += '<td><a href="${pageContext.request.contextPath}/getDelReportPost.do?resultNo=' + result.resultNo + '">게시글 바로가기</a></td>';
					list += '<td>삭제완료</td>';
					list += '</tr>';
				}
				
				//테이블헤더 출력
				let header = "";
				header += '<th width="20%">작성자</th>';
				header += '<th>제목</th>';
				header += '<th width="15%">작성일</th>';
				header += '<th width="20%">바로가기</th>';
				header += '<th width="10%">상태</th>';
				
				//페이지 출력
		        console.log("page : " + data.pvo.beginPage);  
	            let page = "";
	            page += '<div class="page_wrap">';
	            page += '<div class="page_nation">';
	            if (data.pvo.beginPage != 1) {
	            	page += '<a class="arrow prev" href="${pageContext.request.contextPath}/getDeleteReport.do?cPage=' + data.pvo.beginPage + '- 1 ">&lt</a>';
				}
	            for (let i = data.pvo.beginPage; i <= data.pvo.endPage; i++) {
					if (i == data.pvo.nowPage) {
						page += '<a class="active">' + i + '</a>';
					} else if (i != data.pvo.nowPage) {
						page += '<a href="javascript:getDeleteReport(' + i + ')">' + i + '</a>';
					}
				}
	            if (data.pvo.endPage < data.pvo.totalPage) {
	            	 page += '   <a class="arrow next" href="${pageContext.request.contextPath}/getDeleteReport.do?cPage=' + data.pvo.endPage + ' + 1">&gt</a>';    
	            }
	            page += '</div>';
	            page += '</div>';
	            
	            //버튼 active 변경
	            let button = "";
	            button += '<button class="button button2" onclick="getFalseReport()">승인대기</button>';
	            button += '<button class="button button2" onclick="getTrueReport()">처리완료</button>';
	            button += '<button class="button button2" id="active" onclick="getDeleteReport()">삭제완료</button>';
		            
 				$("#dispBody").html(list);
				$("#dispBody2").html(page);
				$("#dispBody3").html(button);
				$("#dispBody4").html(header);
	
			},
			error: function(){
				alert("[ERROR]오류");
			}
		});
	}

	function getFalseReport() {
		location.href="${pageContext.request.contextPath }/getFalseReport.do";
	}

	function openPopUp(boardType, boardNo, reporter) {
		window.open("getReportDetail.do?boardType=" + boardType + "&boardNo=" + boardNo + "&reporter=" + reporter, "상세보기", "width=500, height=180, top=150, left=600");
	}
</script>
</head>
<body>
<%@ include file="/Admin/common/adminHeader.jspf" %>
<br><br>

<br><br>
<div class="outer2">
	<div class="inner2">
		<div class="btn-group" id="dispBody3">
			<button class="button button2" id="active" onclick="getFalseReport()">승인대기</button>
			<button class="button button2" onclick="getTrueReport()">처리완료</button>
			<button class="button button2" onclick="getDeleteReport()">삭제완료</button>
		</div>
	</div>
</div>
<div class="outer2">
	<div class="inner2">
		<table class="table">
			<thead id="dispBody4">
				<tr>
					<th>신고자</th>
					<th>사유</th>
					<th>신고일</th>
					<th>게시판</th>
					<th>바로가기</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody id="dispBody">
				<c:if test="${not empty list }">
					<c:forEach var="report" items="${list }">
						<tr>
							<td>${report.reporter}</td>
							<td>${report.reportReason }</td>
							<td>${report.reportDate.substring(0,10) }</td>
							 <c:choose>
								<c:when test="${report.boardType eq 'questionBoard' }">
									<td>질문게시판</td>
									<td><a href='${pageContext.request.contextPath}/getReportPost.do?boardNo=${report.boardNo}&boardType=${report.boardType}'>게시글 바로가기</a></td>
								</c:when>
								<c:otherwise>
									<td>자유게시판</td>
									<td><a href='${pageContext.request.contextPath}/getReportPost.do?boardNo=${report.boardNo}&boardType=${report.boardType}'>게시글 바로가기</a></td>
								</c:otherwise>
							</c:choose>
							<c:if test="${report.reportStatus eq 0}">
								<td>			
									<button type="button" class="detail" onclick="openPopUp('${report.boardType}','${report.boardNo}', '${report.reporter }')">승인대기</button>
								</td>
							</c:if>
							<c:if test="${report.reportStatus eq 1}">
								<td>삭제완료</td>
							</c:if>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty list }">
					<tr>
						<td colspan="6">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
<br><br>

<!-- 페이징처리-->
<div id="dispBody2">
	<div class="page_wrap">
	   <div class="page_nation">
		<c:if test="${pvo.beginPage != 1}">	
			<a class="arrow prev" href="${pageContext.request.contextPath}/getFalseReport.do?cPage=${pvo.beginPage - 1 }">&lt</a>
		</c:if>
		
		<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
			<c:if test="${pageNo == pvo.nowPage }">
				<a class="active">${pageNo}</a>
			</c:if>
			<c:if test="${pageNo != pvo.nowPage }">
				<a href="${pageContext.request.contextPath}/getFalseReport.do?cPage=${pageNo }">${pageNo}</a>
			</c:if>
		</c:forEach>	
		
		<c:if test="${pvo.endPage < pvo.totalPage}">
			<a class="arrow next" href="${pageContext.request.contextPath}/getFalseReport.do?cPage=${pvo.endPage + 1 }">&gt</a>
		</c:if>
	   </div>
	</div> 	
</div>	
<br><br>
<%@ include file="/Common/footer.jsp" %>
</body>
</html>