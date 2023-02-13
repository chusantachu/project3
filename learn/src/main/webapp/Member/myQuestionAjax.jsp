<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div id="freeboard">
    <c:if test="${not empty list2}">
        <c:forEach var="free" items="${list2 }">
            <div class="pt-1 pl-4 pr-4">
                <h5>
                    <a href="#"><b> ${free.boardTitle }</b></a>
                </h5>
                <c:choose>
                    <c:when test="${fn:length(free.boardContent) gt 16}">
                        ${fn:substring(free.boardContent, 0, 15)}...
                    </c:when>
                    <c:otherwise>
                        ${free.boardContent}
                    </c:otherwise>
                </c:choose>
                <div class="pt-1">
                    <span>${free.boardRegdate }</span>
                </div>
                <hr>
            </div>
        </c:forEach>
    </c:if>
    <c:if test="${empty list2}">
        <div class="pt-1 pl-4 pr-4">
            <h5>작성한 게시글이 없습니다.</h5>
        </div>
    </c:if>
</div>
<div id="fpaging">
    <ul class="pagination justify-content-center">
        <!-- 이전 -->
        <li class="page-item">
            <c:if test="${pvo.beginPage == 1 }">
                <a class="page-link disabled">이전</a>
            </c:if>
            <c:if test="${pvo.beginPage != 1 }">
                <a class="page-link" onclick="paging(${pvo.beginPage - 1 })">이전</a>

            </c:if>
        </li>
        <!-- 페이지 번호 -->
        <c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
            <c:if test="${pageNo == pvo.nowPage }">
                <li class="page-item active">
                    <a class="page-link">${pageNo }</a>
                </li>
            </c:if>
            <c:if test="${pageNo != pvo.nowPage }">
                <li class="page-item">
                    <a class="page-link" onclick="paging(${pageNo })">${pageNo }</a>
                </li>
            </c:if>
        </c:forEach>
        <!-- 다음 -->
        <li class="page-item">
            <c:if test="${pvo.endPage < pvo.totalPage }">
                <a class="page-link" onclick="paging(${pvo.endPage + 1 })">다음</a>
            </c:if>
            <c:if test="${pvo.endPage >= pvo.totalPage }">
                <a class="page-link disabled">다음</a>
            </c:if>
        </li>
    </ul>
</div>
