<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <title>강의자 페이지 - 로드맵 관리</title>
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
  .rboardTitle {
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
  }
</style>
<body>
<%@include file="/Common/header.jsp" %>
<div class="container-fluid bg-dark">
    <div class="container tape">
        <section class="tapeContent">
            <h2>로드맵 관리</h2>
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
          var menu = $('#roadmapManager');
          console.log(menu);
          menu.removeClass('norm-menu');
          menu.addClass('active-menu');
        </script>

        <!-- 중앙 위 내용 - 글내용 -->
        <div class="col-8 pl-3 gray-line">
            <button class="active-btn" onclick="location.href='${pageContext.request.contextPath}/Teacher/roadmapWrite.do'">로드맵 작성</button>
            <table class="table mt-4" style="table-layout: fixed">
                <thead>
                <tr>
                    <th style="width: 15%">로드맵 ID</th>
                    <th style="width: 70%">로드맵 제목</th>
                    <th style="width: 15%" colspan="2"></th>
                </tr>
                </thead>
                <tbody id="rtContent">
                <c:forEach items="${roadmapList}" var="roadmap">
                    <tr>
                        <td>${roadmap.rboardNo}</td>
                        <td class="rboardTitle">
                            <a style="color: black" href="${pageContext.request.contextPath}/Lecture/roadmapDetail.do?rboardNo=${roadmap.rboardNo}">
                                    ${roadmap.rboardTitle}
                            </a>
                        </td>
                        <td colspan="2">
                            <button class="active-btn" onclick="location.href='${pageContext.request.contextPath}/Teacher/roadmapWrite.do?rboardNo=${roadmap.rboardNo}'">수정</button>
                            <button class="active-btn" onclick="location.href='${pageContext.request.contextPath}/Teacher/removeRoadmap.do?rboardNo=${roadmap.rboardNo}'">삭제</button>
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
            <script>
              function paging(cPage) {
                $.ajax({
                  data : {
                    cPage : cPage
                  },
                  type : "GET",
                  url : "${pageContext.request.contextPath}/Teacher/getRoadmapPaging.do",
                  dataType: "json",
                  success : function(data) { // 처리가 성공할 경우
                    $('#rtContent').html('');
                    $.each(data.pmap, function() {
                      let dispHtml = '<tr>';
                      dispHtml += '<td>' + this.rboardNo + '</td>';
                      dispHtml += '<td class="rboardTitle">';
                      dispHtml += '<a style="color: black" href="/learn/Lecture/roadmapDetail.do?rboardNo=' + this.rboardNo + '">' + this.rboardTitle + '</a>'
                      dispHtml += '</td>';
                      dispHtml += '<td colspan="2">'
                      dispHtml += '<a class="active-btn" href="/learn/Teacher/roadmapWrite.do?rboardNo=' + this.rboardNo + '">수정</button>';
                      dispHtml += '<a class="active-btn" href="/learn/Teacher/removeRoadmap.do?rboardNo=' + this.rboardNo +'">삭제</button>';
                      dispHtml += '</td>';
                      dispHtml += '</tr>';
                      $('#rtContent').append(dispHtml);
                    })

                    let pvo = data.pvo;
                    let pn = $('.pagination');
                    pn.html('');
                    let dispHtml = '<li class="page-item">';
                    if(pvo.beginPage === 1) {
                      dispHtml += '<a class="page-link disabled">이전</a>';
                    } else {
                      dispHtml += '<a class="page-link" onclick="paging(' + (pvo.beginPage - 1) + ')">이전</a>';
                    }
                    dispHtml += '</li>';
                    for(let pageNo = pvo.beginPage; pageNo <= pvo.endPage; pageNo++) {
                      if(pageNo === pvo.nowPage) {
                        dispHtml += '<li class="page-item active">';
                        dispHtml += '<a class="page-link">' + pageNo + '</a>';
                        dispHtml += '</li>';
                      } else {
                        dispHtml += '<li class="page-item">';
                        dispHtml += '<a class="page-link" onclick="paging(' + pageNo + ')">' + pageNo + '</a>';
                        dispHtml += '</li>';
                      }
                    }
                    dispHtml += '<li class="page-item">';
                    if(pvo.endPage < pvo.totalPage) {
                      dispHtml += '<a class="page-link" onclick="paging(' + (pvo.endPage + 1) + ')">다음</a>';
                    } else {
                      dispHtml += '<a class="page-link disabled">다음</a>';
                    }
                    dispHtml += '</li>';
                    pn.append(dispHtml);
                  },
                  error: function(){
                    alert("실패~~");
                  }
                })
              }
            </script>
        </div>
        <div class="col-2 d-flex justify-content-center">
        </div>
    </div>
</div>
<%@include file="/Common/footer.jsp" %>
</body>
</html>