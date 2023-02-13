<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>자주묻는질문 FAQ</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <style>
  	.inner {
		width: 840px;
		display: inline-block;
		text-align: left;
	}
	.inner2 {
		width: 700px;
		display: inline-block;
		text-align: left;
		font-size: 1.3em;
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
	.menu a:hover:not(.active) {
		text-decoration: none;
		color: black;
	}
	.menu a.active {
	    color: white;
	    background-color: #00C471;
	}
	a:hover {
		text-decoration: none;
	}
	.main { 
		text-align: center; 
		font-size: 1.3em;
	}
	.answer {
	    display: none;
	    padding-bottom: 30px;
	    font-size: 15px;
	}
	.faq-content {
	    border-bottom: 1px solid #e0e0e0;
	}
	.question {
	    padding: 25px 0;
	    background: none;
	    cursor: pointer;
	    border: none;
	    outline: none;
	    width: 100%;
	    text-align: left;
	    font-size: 18px;
	    
	}
	.question:hover {
	    color: black;
	}
	[id$="-toggle"] {
	    margin-right: 10px;
	}
  </style>
</head>
<body>
	<%@ include file="/Common/header.jsp" %>
	<br><br>
	<div class="outer">
		<div class="inner">
			<ul class="menuborder">
			  <li class="menu"><a class="active" href="getFaqList.do">자주 묻는 질문</a></li>
			  <li class="menu"><a href="${pageContext.request.contextPath}/memberBoard/getMyQBoardList.do">고객센터 문의하기</a></li>
			  <li class="menu"><a href="${pageContext.request.contextPath }/Member/MemberBoard/serviceIntegrationPolicy.jsp">통합서비스 이용약관</a></li>
			  <li class="menu"><a href="${pageContext.request.contextPath }/Member/MemberBoard/generalPolicy.jsp">아웃풋런 이용약관</a></li>
			  <li class="menu"><a href="${pageContext.request.contextPath }/Member/MemberBoard/privacyPolicy.jsp">개인정보 취급방침</a></li>
			</ul>
		</div>
	</div>
	<br><br>
	<p class="main">궁금한 점이 있으신가요?<br>먼저 아래의 자주 묻는 질문 FAQ 리스트를 확인 해주세요!</p>
	<br>
	<div class="outer">
		<div class="inner2">
		 <c:if test="${not empty list }">
	      <c:forEach var="faq" items="${list }">
	      <c:set var="i" value="${i + 1 }" />
			<div class="faq-content">
			  <button class="question" id="que-${i}"><span id="que-${i}-toggle">+</span><span>${faq.faqQuestion }</span></button>
			  <div class="answer" id="ans-${i}">${faq.faqAnswer }</div>
			</div>
		  </c:forEach>
		</c:if>
		<c:if test="${empty list }">
			<p style="text-align: center;">데이터가 없습니다.</p>
		</c:if>
		<br><br><br>
			<p style="text-align:center; size:1.3em;">원하는 답변을 찾지 못하셨나요?<br>그럼 상단의 <span style="color: #00C471;">'고객센터 문의하기' </span>에서 문의 해주세요.<br>최대한 빠르게 답변드리도록 하겠습니다!</p>
		</div>
	</div>
	
	<%@ include file="/Common/footer.jsp" %>
</body>
<script>
	const items = document.querySelectorAll('.question');
	
	function openCloseAnswer() {
	  const answerId = this.id.replace('que', 'ans');
	
	  if(document.getElementById(answerId).style.display === 'block') {
	    document.getElementById(answerId).style.display = 'none';
	    document.getElementById(this.id + '-toggle').textContent = '+';
	  } else {
	    document.getElementById(answerId).style.display = 'block';
	    document.getElementById(this.id + '-toggle').textContent = '-';
	  }
	}
	items.forEach(item => item.addEventListener('click', openCloseAnswer));
</script>
</html>