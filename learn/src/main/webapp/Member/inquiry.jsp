<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<title>로그인</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<style>
	.tape {
		height: 100px;
		margin: 50px auto;
		padding-top: 15px;
		color: white;
	}

.active {
	font-weight: bold;
	text-decoration: underline;
}

.nav-link {
	color: black;
}

.active-btn {
	color: #fff;
	background-color: #00C471;
}
.active-menu {
        color: #1dc078;
        font-weight: bold;
      }
      .norm-menu {
        color: black;
      }
</style>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<div class="container-fluid bg-dark">
		<div class="container tape">
			<section class="tapeContent">
				<h2>문의게시판</h2>
			</section>
		</div>
	</div>
<div class="container-fluid mt-5 pb-3 d-flex justify-content-center">
		<div class="row w-100 pb-4 justify-content-center">
			<!-- 왼쪽 네비 -->
			<div class="col-2 d-flex justify-content-center">
				<%@ include file="sidebar.jspf"%>
				<script>
					var menu = $('#myboardMenu');
		            console.log(menu);
		            menu.removeClass('norm-menu');
		            menu.addClass('active-menu');
	            </script>
			</div>
			<div class="col-8 pl-3 gray-line">
				<h2>조회</h2>
				<div class="pb-3">
					<ul class="border nav p-1">
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/Member/myQuestion.do">질문</a>
						</li>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/Member/myFree.do">자유주제</a>
						</li>
						<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/memberBoard/callCenterBoardList.do?userId=${user.userId}">문의글</a></li>
					</ul>
				</div>
				<div class="border">
					<div class="pb-3">
						<ul class="nav pl-3 pt-3 pb-1">
							<li class="nav-item"><a id="allBtn"
								class="nav-link btn-sm mr-1 active-btn" href="javascript:cBoardList()">전체</a></li>
							<li class="nav-item"><a id="solvedBtn"
								class="nav-link btn-sm active-btn btn-light mr-1" href="javascript:resolvedCBoardList()">해결</a></li>
							<li class="nav-item"><a id="unsolvedBtn"
								class="nav-link btn-sm mr-1 active-btn btn-light" href="javascript:unResolvedCBoardList()">미해결</a></li>
						</ul>
					</div>
					<div id="listDisp">
					<c:if test="${not empty BoardList}">
						<c:forEach var="BoardList" items="${BoardList }">
							<div class="pt-1 pl-4 pr-4">
								<h5>
									<a href="${pageContext.request.contextPath }/memberBoard/inquiryDetail.do?qnaNo=${BoardList.qnaNo }"><b> ${BoardList.qnaTitle }</b></a>
								</h5>
								<c:choose>
							        <c:when test="${fn:length(BoardList.qnaContent) gt 16}">
							        	${fn:substring(BoardList.qnaContent, 0, 15)}...
							        </c:when>
							        <c:otherwise>
							       		${BoardList.qnaContent}
							        </c:otherwise>
								</c:choose>
								<div class="pt-1">
									<span>${BoardList.qnaRegdate }</span>
								</div>
								<hr>
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${empty BoardList}">
						<div class="pt-1 pl-4 pr-4">
							<h5>작성한 질문이 없습니다.</h5>
						</div>
					</c:if>
					</div>
				</div>
			</div>
		</div>
	</div> 
 	<script>

		function cBoardList() {
			$.ajax("${pageContext.request.contextPath}/memberBoard/cBoardList.do?userId=${user.userId}", {
				type : "get",
				dataType : "json", //서버로부터 응답받는 데이터 형식
				success : function(data) {
					console.log(data);
					
					$("#allBtn").removeClass("btn-light");
					$("#solvedBtn").addClass("btn-light");
					$("#unsolvedBtn").addClass("btn-light");
				
					console.log("data : " + data);
					let dispHtml = "";
					var summary = "";
					$.each(data, function(index, obj){
						summary = this.qnaContent;
						if(summary.length > 15) {
							summary = summary.substring(0, 15);
							summary += '...';
						}				
						dispHtml += '<div class="pt-1 pl-4 pr-4">';
						dispHtml += "<h5><a href='${pageContext.request.contextPath }/memberBoard/inquiryDetail.do?qnaNo="+this.qnaNo+"'>";
						dispHtml += "<b>" + this.qnaTitle + "</b></a></h5>";
						dispHtml += "<span>" + summary + "</span><br>";
						dispHtml += '<div class="pt-1"><span>' + this.qnaRegdate + "</span></div><hr></div>";	
					});
					$("#listDisp").html(dispHtml);
				},
				error : function() {
					alert("실패!");
				}
			});
		}
		</script>
		<script>
		function resolvedCBoardList() {
			alert("resolvedCBoardList() 실행");
			$.ajax("${pageContext.request.contextPath}/memberBoard/resolvedCBoardList.do?userId=${user.userId}", {
				type : "get",
				dataType : "json", //서버로부터 응답받는 데이터 형식
				success : function(data) {
					console.log("data : " + data);
					$("#allBtn").addClass("btn-light");
					$("#solvedBtn").removeClass("btn-light");
					$("#unsolvedBtn").addClass("btn-light");
					let dispHtml = "";
					var summary = "";
					$.each(data, function(index, obj){
						summary = this.qnaContent;
						if(summary.length > 15) {
							summary = summary.substring(0, 15);
							summary += '...';
						}
						dispHtml += '<div class="pt-1 pl-4 pr-4">';
						dispHtml += "<h5><a href='${pageContext.request.contextPath }/memberBoard/inquiryDetail.do?qnaNo="+this.qnaNo+"'>";
						dispHtml += "<b>" + this.qnaTitle + "</b></a></h5>";
						dispHtml += "<span>" + summary + "</span><br>";
						dispHtml += '<div class="pt-1"><span>' + this.qnaRegdate + "</span></div><hr></div>";	
					});
					$("#listDisp").html(dispHtml);
				},
				error : function() {
					alert("실패!");
				}
			});
		}
		</script>
		<script>
		function unResolvedCBoardList() {
			$.ajax("${pageContext.request.contextPath}/memberBoard/unResolvedCBoardList.do?userId=${user.userId}", {
				type : "get",
				dataType : "json", //서버로부터 응답받는 데이터 형식
				success : function(data) {
					console.log("data : " + data);
					$("#allBtn").addClass("btn-light");
					$("#solvedBtn").addClass("btn-light");
					$("#unsolvedBtn").removeClass("btn-light");
					let dispHtml = "";
					var summary = "";
					$.each(data, function(index, obj){
						summary = this.qnaContent;
						if(summary.length > 15) {
							summary = summary.substring(0, 15);
							summary += '...';
						}
						dispHtml += '<div class="pt-1 pl-4 pr-4">';
						dispHtml += "<h5><a href='${pageContext.request.contextPath }/memberBoard/inquiryDetail.do?qnaNo="+this.qnaNo+"'>";
						dispHtml += "<b>" + this.qnaTitle + "</b></a></h5>";
						dispHtml += "<span>" + summary + "</span><br>";
						dispHtml += '<div class="pt-1"><span>' + this.qnaRegdate + "</span></div><hr></div>";	
					});
					$("#listDisp").html(dispHtml);
				},
				error : function() {
					alert("실패!");
				}
			});
		}
	</script>
	<footer>
		<%@ include file="../Common/footer.jsp"%>
	</footer>
</body>
</html>
