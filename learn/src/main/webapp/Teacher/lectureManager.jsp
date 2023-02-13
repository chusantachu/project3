<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <title>강의자  - 강의 관리</title>
</head>
<style>
  .active-menu {
    color: #1dc078;
    font-weight: bold;
  }
  .norm-menu {
    color: black;
  }
  .active-btn {
    color: #fff;
    background-color: #00C471;
    border-style: none;
    padding: 5px;
    border-radius: 5px;
    margin-right: 5px;
  }
  .tape {
    height: 70px;
    margin: 50px auto;
    padding-top: 15px;
    color: white;
  }
  .pagination > li > a
  {
      background-color: white;
      color: #1dc078;
  }

  .pagination > li > a:focus,
  .pagination > li > a:hover,
  .pagination > li > span:focus,
  .pagination > li > span:hover
  {
      color: #5a5a5a;
      background-color: #eee;
      border-color: #ddd;
  }

  .pagination > .active > a
  {
      color: white;
      background-color: #00C471 !Important;
      border: solid 1px #00C471 !Important;
  }

  .pagination > .active > a:hover
  {
      background-color: #00C471 !Important;
      border: solid 1px #00C471;
  }
</style>
<body>
<fmt:requestEncoding value="utf-8"/>
<%@include file="/Common/header.jsp" %>
<div class="container-fluid bg-dark">
    <div class="container tape">
        <section class="tapeContent">
            <h2>강의 관리</h2>
        </section>
    </div>
</div>
<div class="container-fluid mt-5 pb-3 d-flex justify-content-center">
    <div class="row w-100 pb-4 justify-content-center">
        <!-- 왼쪽 네비 -->
        <div class="col-2 d-flex justify-content-center">
            <%@ include file="sidebar.jspf"%>
        </div>
        <script>
          var menu = $('#lectureManager');
          console.log(menu);
          menu.removeClass('norm-menu');
          menu.addClass('active-menu');
        </script>

        <!-- 중앙 위 내용 - 글내용 -->
        <div class="col-8 pl-3 gray-line">
            <button onclick="location.href='lectureWrite.do'" class="active-btn">강의 추가</button>
            <table class="table mt-4" style="table-layout: fixed">
                <thead>
                    <tr>
                        <th style="width: 8%">번호</th>
                        <th style="width: 8%">강의종류</th>
                        <th style="width: 12%">카테고리</th>
                        <th style="width: 20%">강의명</th>
                        <th style="width: 10%">가격</th>
                        <th style="width: 10%">강의기한</th>
                        <th style="width: 10%">강의등록일</th>
                        <th style="width: 22%" colspan="3"></th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${lectureList}" var="lec" varStatus="status">
                    <tr>
                        <td>${pvo.begin + status.index}</td>
                        <td>
                            <c:if test="${lec.lectureOnOff == 0}">온라인</c:if>
                            <c:if test="${lec.lectureOnOff == 1}">오프라인</c:if>
                        </td>
                        <td>${lec.categoryName}</td>
                        <td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
                            <a style="color: black" href="${pageContext.request.contextPath}/Member/getLecture.do?lectureNo=${lec.lectureNo}">${lec.lectureTitle}</a>
                        </td>
                        <td>
                            <fmt:formatNumber type="number" maxFractionDigits="3" value="${lec.lecturePrice}" />원
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${empty lec.lectureDue}">
                                    -
                                </c:when>
                                <c:when test="${lec.lectureDue == 0}">
                                    무제한
                                </c:when>
                                <c:otherwise>
                                    ${lec.lectureDue}일
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <c:set var="regdate" value="${lec.lectureRegdate}" />
                        <td>${fn:substring(regdate, 0, 10)}</td>
                        <td colspan="3">
                            <button onclick="location.href='lectureEdit.do?lectureNo=${lec.lectureNo}'" class="active-btn" style="background-color: #ffc107">수정</button>
                            <button onclick="location.href='${pageContext.request.contextPath}/getLectureNewsList.do?lectureNo=${lec.lectureNo}'" class="active-btn" style="background-color: #17a2b8">새소식</button>
                            <c:if test="${lec.lectureOnOff == 0}">
                                <button onclick="location.href='studentManager.do?lectureNo=${lec.lectureNo}'" class="active-btn">수강자</button>
                                <span id="realtimeDiv${status.index}">
                                    <button class="active-btn" style="background-color: #7dd99f"
                                            onclick="location.href='${pageContext.request.contextPath}/Teacher/realtimeQuestion.do?lectureNo=${lec.lectureNo}'">질문</button>
                                </span>
                                <script>
                                  today = new Date();
                                  thour = today.getHours();
                                  tminute = today.getMinutes();
                                  shour = '${lec.qsStart}'.substring(11, 13);
                                  sminute = '${lec.qsStart}'.substring(14, 16);
                                  ehour = '${lec.qsEnd}'.substring(11, 13);
                                  eminute = '${lec.qsEnd}'.substring(14, 16);

                                  earlyStart = (shour > thour || ((shour === String(thour)) && (sminute > tminute)) ); // 시간이 작거나 시간이 같으면 분이 작으면 true
                                  lateEnd = (ehour < thour || ((ehour === String(thour)) && (eminute < tminute)) ); // 시간이 크거나 시간이 같으면 분이 크면 true

                                  if(('${not empty lec.qsStart}' === 'true')) {
                                    if(String(today.getDay()) !== '${lec.qsWeekdays}') { // 해당 요일 아님
                                      $('#realtimeDiv${status.index}').css('display', 'none');
                                    } else if(earlyStart || lateEnd) { // 시작 시간 이전이거나 끝 시간 이후면 안 눌리게
                                      $('#realtimeDiv${status.index}').css('display', 'none');
                                    }
                                  } else { // 실시간 강의 없으면 버튼 안 보이게
                                    $('#realtimeDiv${status.index}').css('display', 'none');
                                  }
                                </script>
                            </c:if>
                            <c:if test="${lec.lectureOnOff == 1}">
                                <button onclick="location.href='timetableManager.do?lectureNo=${lec.lectureNo}'" class="active-btn" style="background-color: #007bff">시간표</button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="pt-4">
                <ul class="pagination justify-content-center">
                    <!-- 이전 -->
                    <li class="page-item">
                        <c:if test="${pvo.beginPage == 1 }">
                            <a class="page-link disabled">이전</a>
                        </c:if>
                        <c:if test="${pvo.beginPage != 1 }">
                            <a class="page-link" href="${pageContext.request.contextPath}/Teacher/lectureManager.do?cPage=${pvo.beginPage - 1 }">이전</a>
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
                                <a class="page-link" href="${pageContext.request.contextPath}/Teacher/lectureManager.do?cPage=${pageNo }">${pageNo }</a>
                            </li>
                        </c:if>
                    </c:forEach>
                    <!-- 다음 -->
                    <li class="page-item">
                        <c:if test="${pvo.endPage < pvo.totalPage }">
                            <a class="page-link" href="${pageContext.request.contextPath}/Teacher/lectureManager.do?cPage=${pvo.endPage + 1 }">다음</a>
                        </c:if>
                        <c:if test="${pvo.endPage >= pvo.totalPage }">
                            <a class="page-link disabled">다음</a>
                        </c:if>
                    </li>
                </ul>
            </div>
        </div>
        <div class="col-2 d-flex justify-content-center">
        </div>
    </div>
</div>
<%@include file="/Common/footer.jsp" %>
</body>
</html>