<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <title>강의자  - 시간표 관리</title>
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
<%@include file="/Common/header.jsp" %>
<div class="container-fluid bg-dark">
    <div class="container tape">
        <section class="tapeContent">
            <h2>시간표 관리</h2>
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
            <button type="button" class="active-btn" data-toggle="modal" data-target="#addTT">시간표 추가</button>
            <div class="modal fade" id="addTT">
                <div class="modal-dialog modal-dialog-centered" style="width: 400px">
                    <div class="modal-content align-items-center pb-3">
                        <div class="w-100 pr-2 pb-4" style="float: right">
                            <button type="button" class="close" data-dismiss="modal">x</button>
                        </div>
                        <div class="text-center">
                            <h4 style="font-weight: bold">시간표 추가</h4>
                            <span style="color: red">수정이 불가하니 신중하게 작성해주세요.</span>
                        </div>
                        <form id="ttForm" action="${pageContext.request.contextPath}/Teacher/addTimetable.do" method="post" class="w-100 pl-4 pr-4 pt-2">
                            <label class="pb-2">최대인원
                                <input style="width: 250px" type="number" class="form-control" id="maxSeat" placeholder="숫자만 입력" name="maxSeat">
                            </label>
                            <!-- 주소, 시작시간, 끝시간 -->
                            <label class="pb-2">시작시간
                                <input style="width: 250px" class="form-control" type="datetime-local" name="ttStart"/>
                            </label>
                            <label class="pb-2">종료시간
                                <input style="width: 250px" class="form-control" type="datetime-local" name="ttEnd"/>
                            </label>
                            <label class="pb-2">주소
                                <input id="postBtn" class="btn-sm btn btn-success mb-2" type="button" onclick="daumPostcode()" value="우편번호 찾기"><br>
                                    <input onclick="daumPostcode()" style="width: 300px" class="form-control" type="text" id="daumAddress" placeholder="주소">
                                <input type="hidden" id="lecturePastAddress" name="lecturePastAddress" placeholder="지번주소">
                                <input type="hidden" id="lectureAddress" name="lectureAddress" placeholder="도로명주소">
                                <input style="width: 300px" class="form-control" type="text" id="detailAddress" placeholder="상세주소 입력">
                            </label>
                            <script>
                              function daumPostcode() {
                                new daum.Postcode({
                                  oncomplete: function(data) {
                                    var roadAddr = data.roadAddress; // 도로명 주소 변수

                                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                                    document.getElementById("daumAddress").value = roadAddr;
                                    document.getElementById("lecturePastAddress").value = data.jibunAddress;
                                  }
                                }).open();
                              }
                            </script>
                            <input type="hidden" name="lectureNo" value="${lectureNo}"/>
                            <button type="button" onclick="submitTT()" class="btn w-100" style="background-color: #00C471; color: white">추가</button>
                        </form>
                        <script>
                            function submitTT() {
                              let road = $('#lectureAddress');
                              let past = $('#lecturePastAddress');
                              let detail = $('#detailAddress');

                              let da = $('#daumAddress').val();
                              let pa = past.val();
                              da = da + ' ' + detail.val();
                              pa = pa + ' ' + detail.val();

                              road.val(da);
                              past.val(pa);
                              $('#ttForm').submit();
                            }
                        </script>
                    </div>
                </div>
            </div>
            <div class="pt-3">
                <h5><b>강의명:</b> ${ttList[0].lectureTitle}</h5>
            </div>
            <table class="table mt-4" style="table-layout: fixed">
                <thead>
                <tr>
                    <th style="width: 8%">번호</th>
                    <th style="width: 20%">시간</th>
                    <th style="width: 13%">인원</th>
                    <th style="width: 46%">주소</th>
                    <th style="width: 13%"></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${ttList}" var="tt" varStatus="status">
                    <tr>
                        <td>${pvo.getBegin() + status.index}</td>
                        <td>${fn:substring(tt.timetableStart, 0, 16)} ~ ${fn:substring(tt.timetableEnd, 11, 16)}</td>
                        <td>${tt.studentCount} / ${tt.maxSeat}</td>
                        <td>${tt.lectureAddress}</td>
                        <td>
                            <button class="active-btn" onclick="location.href='studentManager.do?timetableNo=${tt.timetableNo}'">수강자 관리</button>
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
                            <a class="page-link" href="${pageContext.request.contextPath}/Teacher/timetableManager.do?cPage=${pvo.beginPage - 1 }">이전</a>
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
                                <a class="page-link" href="${pageContext.request.contextPath}/Teacher/timetableManager.do?cPage=${pageNo }">${pageNo }</a>
                            </li>
                        </c:if>
                    </c:forEach>
                    <!-- 다음 -->
                    <li class="page-item">
                        <c:if test="${pvo.endPage < pvo.totalPage }">
                            <a class="page-link" href="${pageContext.request.contextPath}/Teacher/timetableManager.do?cPage=${pvo.endPage + 1 }">다음</a>
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