<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="utf-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

<link href="${pageContext.request.contextPath }/Admin/css/sideNav.css" rel="stylesheet" type="text/css">
<title>관리자 페이지 - CS관리</title>
<style>
	.row {
	 	font-size: 2em;
	 }
	.btn-group .button {
	  background-color: white; 
	  padding: 10px 15px;
	  text-decoration: none;
	  text-align: center;
	  font-size: 16px;
	  float: left;
	  border: 1px solid #00C471;;
	  color: gray;
	}
	#activeBtn, .active {
		color: white;
		background-color: #00C471;;
	}
	.main { margin-left: 27%;}
	.notice a, .faq a, .qna a{ color: black;}

</style>
<script>
	function getQnaListData() {
		//alert("getJsonNoticeListData() 실행");
		
		$.ajax("qnaAllList.do", {
			type: "get",
			dataType: "json", //서버로부터 응답받는 데이터 형식
			success: function(data){ 
				//alert("성공");
				let list = "";
				
				list += '<tr>';
				list += '<th colspan="2">';
				list += '<h4><a href="#">Q&A 바로가기</a></h4>';
				list += '</th>';
				list += '</tr>';
				list += '<tr>';
				list += '<td>';
				list += '<div class="btn-group">';
				list += '<button class="button" onclick="goFalseQna()">대  기</button>';
				list += '<button class="button" id="activeBtn" onclick="getQnaListData()">전  체</button>';
				list += '</div>';
				list += '</td>';
				list += '</tr>';
				
				if (data != null) {
					for (let qna of data) {
						console.log("data : " + qna.qnaTitle);
						
						list += '<tr>';
						list += "<td><a href='${pageContext.request.contextPath }/memberBoard/viewPage.do?qnaNo=" + qna.qnaNo + "'>" + qna.qnaTitle + '</a></td>';
						list += '</tr>';
					}
				} else if (data == null) {
					list += '<tr>';
					list += '<td>데이터가 없습니다.</td>';
					list += '</tr>';
				}
				
				$("#dispBody").html(list);	
				
			},
			error: function(){
				alert("[ERROR]오류");
			}
		});
		
	}
	
	function goFalseQna() {
		location.href='${pageContext.request.contextPath }/latestInfo.do';
	}
</script>
</head>
<body>
<%@ include file="/Admin/common/adminHeader.jspf" %>

<br>
	<div class="main">
		<div class="container" style="margin-top:30px">
		  <br><br><br><br>
		  <div class="row">
			<table class="notice">
				<tr>
					<th colspan="2">
						<div>
							<h4><a href="${pageContext.request.contextPath }/getNoticeAdminList.do">공지사항 바로가기</a></h4>
						</div>
					</th>
				</tr>
				<c:if test="${not empty noticeList }">
					<c:forEach var="notice" items="${noticeList }">
						<tr>
							<td><a href="getAdminNotice.do?boardNo=${notice.boardNo }">${notice.boardTitle }</a></td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty noticeList }">
				<tr>
					<td>데이터가 없습니다.</td>
				</tr>
				</c:if>
			</table>
		  </div>
		</div>
		
		<br><br><br>
		
		<div class="container" style="margin-top:30px">
		  <div class="row">
			<table>
				<tr>
					<th colspan="2">
						<h4 class="faq"><a href="${pageContext.request.contextPath }/getAdminFaqList.do">FAQ 바로가기</a></h4>
					</th>
				</tr>
				<c:if test="${not empty faqList }">
					<c:forEach var="faq" items="${faqList }">
						<tr>
							<td>${faq.faqQuestion }</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty faqList }">
				<tr>
					<td>데이터가 없습니다.</td>
				</tr>
				</c:if>
			</table>
		  </div>
		</div>
		
		<br><br><br>
		
		<div class="container" style="margin-top:30px">
			<div class="row">
				<table class="qna" id="dispBody">
					<tr>
						<th colspan="2">
							<h4><a href="${pageContext.request.contextPath }/memberBoard/getMyQBoardListM.do">Q&A 바로가기</a></h4>
						</th>
					</tr>
					<tr>
						<td>
							<div class="btn-group">
						  		<button class="button" id="activeBtn" onclick="goFalseQna()">대  기</button>
						  		<button class="button" onclick="getQnaListData()">전  체</button>
							</div>
						</td>
					</tr>
					<c:if test="${not empty qnaList }">
						<c:forEach var="qna" items="${qnaList }">
								<tr>
									<td><a href='${pageContext.request.contextPath }/memberBoard/viewPage.do?qnaNo=${qna.qnaNo }'>${qna.qnaTitle }</a></td>
								</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty qnaList }">
					<tr>
						<td>데이터가 없습니다.</td>
					</tr>
					</c:if>
				</table>
			</div>
		</div>
	</div>
</body>
</html>