<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문게시판</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Community/css/jyStyle.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>


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
	
	
	$(document).on("click", ".ordering", function(){
		$(".ordering").removeClass('active');
		$(this).addClass('active');		
		ajaxserachh();
	});
	
	$(document).on("click", ".orderingItem", function(){
		$(".orderingItem").removeAttr('id', 'ordering');
		$(this).attr('id', 'ordering');
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
		var ordering = $("#ordering").text();
		var boardAdopt =  $("#adopt").text();
		
		console.log("ordering : " + ordering);
		
		var gogo = "${pageContext.request.contextPath}/board/getQnaBoardListAj.do?searchKeyword=" + searchKeyword
		if (pageNum != null){
			var gogo = gogo + '&cPage=' + pageNum
		}
		if (ordering != null){
			var gogo = gogo + '&ordering=' + ordering
		}
		if (ordering != null){
			var gogo = gogo + '&boardAdopt=' + boardAdopt
		}
		var gogo = gogo + '&section=qboard'
		
		
		$.ajax({
			url: gogo,
			type : "get",
			async : true,
			
			success : function(data){
				console.log("에이젝스 성공!!");
				console.log(data);
				
				var inHtml = "";
				
				if (data.length == 0){
					inHtml = '<div class="row w-100">검색 결과가 없습니다.</div>';
				} else {
					
					$.each(data.qnaBoardList, function(index, obj){
					
						inHtml += '<tr>';
						inHtml += '<td style="height: 100px">';
						inHtml += '<div class="row">';
						inHtml += '<div class="col-10">';
						inHtml += '<a class="boardCon" href="${pageContext.request.contextPath}/board/viewQnaPage.do?qboardNo='+ this.qboardNo +'">';
						inHtml += '<h4 class="boardTi">'+ this.boardTitle +'</h4>';
						inHtml += '<div class="contentWrap">'+ this.boardContent +'</div>';
						inHtml += '<p class="boardEtc">'+ this.userId +'·'+ this.boardRegdate.substring(0,10) +'</p></a>';
						inHtml += '</div>';
						inHtml += '<div class="col-2">';
						inHtml += '<div class="row d-flex justify-content-center">';
						inHtml += '<div class="ball">';
						inHtml += '<p>'+ this.commentCnt +'</p>';
						inHtml += '<p>답변</p>';
						inHtml += '</div>';
						inHtml += '</div>';
						inHtml += '<div class="row d-flex justify-content-center">';
						inHtml += '<p class="text-center"> ♥'+ this.boardLike + '</p>';
						inHtml += '</div>';
						inHtml += '</div>';
						inHtml += '</div>';
						inHtml += '</td>';
						inHtml += '</tr>';
									
					})
				
				$("#searchList").html(inHtml);
				
				
					var pvo = data.pvo;
					var inPage = "";
					var preP = pvo.beginPage -1;
					var nexP = pvo.endPage +1;
					
					inPage += '<ul>';
					if (pvo.beginPage == 1){
						inPage += '<a href="#" class="disabled"><li>이전페이지</li></a>';
					}
					
					if (pvo.beginPage != 1){
						inPage += '<a href="javascript:pageGo('+ preP +') ">';
						inPage += '<li>이전페이지</li></a>';
					}
					
					for (var pageNo  = pvo.beginPage ; pageNo <= pvo.endPage ; pageNo++){
						if (pageNo == pvo.nowPage){
							inPage += '<a href="#" class="is-active disabled" ><li>'+ pageNo +'</li></a>';
						} else {
							inPage += '<a href="javascript:pageGo('+pageNo+') "><li>'+ pageNo +'</li></a>';
						}
					}
					
					if (pvo.endPage < pvo.totalPage){
						inPage += '<a href="javascript:pageGo('+ nexP +') "><li>다음페이지</li></a>';
					} else {
						inPage += '<a href="#" class="disabled" ><li>다음페이지</li></a>';
					}
					inPage += '</ul>';						        
							
					$("#paginations").html(inPage);
				}
				
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
		location.href='${pageContext.request.contextPath}/board/qnaWriteForm.do';
	}
	
</script>

<style type="text/css">

 	
 	a.nav-link, a.nav-link:hover{
 		color: black;
 	}
 	 	
 	a.boardCon, a.boardCon:hover {
 		text-decoration: none;
 		font-weight: inherit;
 	}
 	
 	h4.boardTi{
 		color: black;
 		font-size: 1.2em;
 		font-weight: bold;
 	}
 	
 	p.boardEtc{
 		color: #888888;
 		font-style: 0.9em
 	}
 	
 	
 	div.contentWrap p:not(:first-of-type){
 		display: none;
 	}
 	 
 	div.contentWrap p:first-of-type, h4.contentWrap, p.contentWrap {
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
 	} 
 	
	div.contentWrap {
 		color: #444444;
 		margin-bottom: 5px;
 	}
 	
 	
 	
 	a.nav-link{
 		color: black;
 		text-decoration: none;
 		font-weight: bold;
 	}
 	
 	a.nav-link:hover{
 		color: #666666;
 		text-decoration: none;
 		font-weight: bold;
 	}
 	
 	a.actived{
 		color: #00C471;
 		font-weight: bold;
 		font-size: 1.1em;
 	}
 	
 	a.actived:hover{
 		color: #00D481;
 		font-weight: bold;
 	}
 	
 	.topTitle, .topUserName, .topA,.topTitle:hover, .topUserName:hover, .topA:hover {
 		color: #444444;
 		text-decoration: none;
 		font-weight: normal;
 	}
 	
 	.topUserName,.topUserName:hover{
 		color: black;
 		font-weight: bold;
 	}
 	
 	.topRanking:hover{
 		background-color: #eeeeee;
 	}
 	
 	.topTable{
 		border: 1px solid #eeeeee;
 		border-radius: 50px;
 	}
 	
 	
 	
 	
 	

</style>

</head>
<body>
	
	<%@include file="/Common/header.jsp" %>
	<%@include file="/Community/qna/qnaTape.jsp" %>

	<div class="container-fluid">
		<div class="row justify-content-center">
		
			<!-- 왼쪽 네비 -->
			<div class="col-sm-2 pl-5 ml-5">
			<p style="color: #999999; font-size: 0.8em">함께 공부해요!</p>
				  <ul class="nav flex-column">
				    <li class="nav-item">
				      <a class="nav-link actived" href="${pageContext.request.contextPath}/board/getQnaBoardList.do?section=qboard">질문 & 답변</a>
				    </li>
				    <li class="nav-item">
				      <a class="nav-link" href="${pageContext.request.contextPath}/board/getQnaBoardList.do?section=fboard">자유주제</a>
				    </li>
				  </ul>
			</div>
			
			<div class="col-sm-6 align-content-center">
				<div class="flex-row d-flex align-content-center p-3">
					<form method="get" class="w-100">
					
					<nav class="navbar navbar-expand-sm navbar-light p-3">
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
					<div class="p-3">
						<input type="text" class="w-100 float-left" id="searchKeyword" name="searchKeyword" placeholder="궁금한 질문을 검색해보세요!">
					</div>	
					</form>
				</div>


				
				<div class="flex-row d-flex align-content-center p-3">
					<nav class="navbar navbar-expand-sm navbar-light">
                        <ul class="navbar-nav">
                            <li class="nav-item active ordering">
                            <a class="nav-link orderingItem" id="ordering" >최신순</a>
                            </li>
                            <li class="nav-item ordering">
                            <a class="nav-link orderingItem" >답변많은순</a>
                            </li>
                            <li class="nav-item ordering">
                            <a class="nav-link orderingItem" >좋아요순</a>
                            </li>
                        </ul>
					</nav>					
					<input type="button" class="btn btn-dark ml-auto my-auto h-50"
					 onclick="javascript:qnaWriteForm()" value="글쓰기"/>
				</div>
				
				
				<table class="table table-hover mt-1 p-5" style="table-layout: fixed">
					<tbody id="searchList">
						<c:forEach var="qnaBoard" items="${qnaBoardList  }" >
						
						<tr>
							<td style="height: 100px;">
							<div class="row">
								<div class="col-10">
								<a class="boardCon" href="${pageContext.request.contextPath}/board/viewQnaPage.do?qboardNo=${qnaBoard.qboardNo }">
								<h4 class="boardTi contentWrap">${qnaBoard.boardTitle }</h4>
								<div class="contentWrap">${qnaBoard.boardContent }</div>
								<p class="boardEtc">${qnaBoard.userName } · ${fn:substring(qnaBoard.boardRegdate,0,10) }  </p></a> <!--몇분전 , 강의 제목 추가 할까?? --> 
								
								</div>

								<div class="col-2">
									<div class="row d-flex justify-content-center">
										<div class="ball">
											<p>${qnaBoard.commentCnt }</p> <!--답변 몇개 달렸는지 확인해서 추가하기 VO에 추가하고 --> 
											<p>답변</p>
										</div>
									</div>
									<div class="row d-flex justify-content-center">
										<p class="text-center">♥ ${qnaBoard.boardLike }</p>
									</div>
								</div>
							</div>
							</td>
						</tr>						
						
						</c:forEach>
					</tbody>
				</table>
							    
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

			</div>	
			
			
					
			
			<!-- 오른쪽 네비 -->
			<div class="col-sm-2">
				<table class="table table-borderless topTable" style="table-layout: fixed">
					<thead>
						<tr>
							<th style="font-size: 1.2em">주간 인기글</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="tops" items="${topList }">
						<tr>
							<td class="topRanking" style="height: 20px; padding-top: 5px; padding-bottom: 5px;">
								<a class="topA" href="${pageContext.request.contextPath}/board/viewQnaPage.do?qboardNo=${tops.qboardNo }">
								<p class="topTitle contentWrap" style="margin-bottom: 8px;">${tops.boardTitle }</p>
								<p class="topUserName" style="margin-bottom: 8px;"> ${tops.userName } </p>
								</a>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				
			</div>
		</div>
	</div>
	
	<%@include file="/Common/footer.jsp" %>




</body>
</html>