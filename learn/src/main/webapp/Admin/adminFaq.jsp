<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>CS관리 - FAQ관리</title>
<meta charset="utf-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

<link href="${pageContext.request.contextPath }/Admin/css/sideNav.css" rel="stylesheet" type="text/css">
<style>
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
	.outer { text-align: center; }
	.inner {
		width: 650px;
/* 		border: 1px solid black; */
		display: inline-block;
		margin-left: 10%;
		text-align: left;
	}
	.inner2 {
		width: 650px;
		display: inline-block;
		text-align: right;
	}
	.inner3 {
		display: inline-block;
		text-align: right;
	}
</style>

</head>
<body>
<%@ include file="/Admin/common/adminHeader.jspf" %>

<!-- 사이드 -->
<div class="menu">
	<ul class="ul" style="text-align: center;">
	  <li class="li"><a href="${pageContext.request.contextPath }/getNoticeAdminList.do">공지사항</a></li>
	  <li class="li"><a style="color: #00C471;" href="${pageContext.request.contextPath }/getAdminFaqList.do">자주묻는질문</a></li>
	  <li class="li"><a href="${pageContext.request.contextPath }/memberBoard/getMyQBoardListM.do">Q & A</a></li>
	</ul>
</div>
<br><br><br>

<!-- 본문 -->

<div class="outer">
	<div class="inner">
		<button type="submit" id="btn_toggle" class="btn btn-success">FAQ 추가</button>
		<br><br>
		<div id="Toggle" style="display:none">
			<form method="post" action="${pageContext.request.contextPath }/insertFaq.do">
				<div class="outer">
					<div class="inner3">
						<textarea rows="1" cols="80" name="faqQuestion" placeholder="질문을 입력하세요."></textarea>
						<textarea rows="4" cols="80" name="faqAnswer" placeholder="답변을 입력하세요."></textarea>
						<button type="submit" class="btn btn-dark">저장</button>

					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<br>
<div class="outer">
	<div class="inner">
		<table>
			<tbody>
				<c:if test="${not empty list }">
					<tr>
						<td>
							<c:forEach var="faq" items="${list }">
								<c:set var="i" value="${i + 1 }" />
								<div class="faq-content">
									<button class="question" id="que-${i}"><span id="que-${i}-toggle">+</span><span>${faq.faqQuestion }</span></button>
									<div class="answer" id="ans-${i}">${faq.faqAnswer }<br><br>				
									<div>
										<div id="box01" class="box">
											<div class="btn">
											<button type="button" class="btn btn-link" onclick="delete_go(${faq.faqNo })">삭제</button> | 
											<button type="button" class="btn btn-link" id="btn_toggle">수정</button>
											</div>
												<div class="cont" style="display:none;">
													<form method="post" action="${pageContext.request.contextPath }/updateFaq.do" >
														<div class="outer">
															<div class="inner2">
																<textarea rows="1" cols="90" name="faqQuestion">${faq.faqQuestion }</textarea>
																<textarea rows="4" cols="90" name="faqAnswer">${faq.faqAnswer }</textarea>
																<button type="submit" class="btn btn-dark">저장</button>
																<input type="hidden" name="faqNo" value="${faq.faqNo }">
															</div>
														</div>
													</form>
												</div>
											</div>		 
										</div>  
									</div>
								</div>
							</c:forEach>
						</td>
					</tr>
				</c:if>
				<c:if test="${empty list }">
					<tr>
						<td>
							<p style="text-align: center;">데이터가 없습니다.</p>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
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
	
	function delete_go(faqNo) {
		console.log(faqNo)
		var con_test = confirm("게시글을 삭제하시겠습니까?");
		if (con_test == true) {
			alert("게시글이 삭제 되었습니다.");
			location.href = '${pageContext.request.contextPath }/deleteFaq.do?faqNo=' + faqNo;
		}
		//else if (con_test == false) {
		//}
	}

 	$('.btn').click(function(){
		$(this).next('.cont').toggle();
	}); 
 	
 	$(function (){
 		$("#btn_toggle").click(function (){
 	  	$("#Toggle").toggle();
 	  });
 	});
	
</script>
</html>