<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="table">            
	<c:if test="${pvo.totalRecord == 0 }">
		<p>검색한 내용이 없습니다.</p>
	</c:if>
		
	<table class="table table-hover mt-5">
		<tbody>
			<c:forEach var="memberBoard" items="${memberBoardList }">							
				<tr>
					<td style="height: 100px">
					<div class="row">
						<div class="col-10">
						<a href="${pageContext.request.contextPath}/memberBoard/viewPage.do?qnaNo=${memberBoard.qnaNo }"><h4>${memberBoard.qnaTitle }</h4>
						<p>${memberBoard.qnaContent }</p>
						<p>${memberBoard.userName } ·${memberBoard.qnaRegdate } </p></a>
						</div>	
					</div>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div id="center">
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







<div id="paging">

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