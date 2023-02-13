<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <style>
      .active-menu {
        color: #1dc078;
        font-weight: bold;
      }
      .norm-menu {
        color: black;
      }
      .tape {
        height: 100px;
        margin: 50px auto;
        padding-top: 30px;
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
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script
            src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <script
            src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<fmt:requestEncoding value="utf-8"/>
<%@ include file="../Common/header.jsp"%>
<div class="container-fluid bg-dark">
    <div class="container tape">
        <section class="tapeContent">
            <h2>포인트 조회</h2>
        </section>
    </div>
</div>
<div class="container-fluid mt-5 pb-3 d-flex justify-content-center">
    <div class="row w-100 pb-4 justify-content-center">
        <div class="col-2 d-flex justify-content-center">
            <%@ include file="sidebar.jspf"%>
            <script>
              var menu = $('#pointMenu');
              console.log(menu);
              menu.removeClass('norm-menu');
              menu.addClass('active-menu');
            </script>
        </div>
        <div class="col-8 pl-3 gray-line">
            <div class="pb-3">
                <h4>현재 사용가능 포인트:
                    <span style="font-weight: bold; color: #00C471;">
                        <fmt:formatNumber type="number" maxFractionDigits="3" value="${user.points}" />
                    </span> P</h4>
            </div>
            <table class="table">
                <thead>
                <tr class="text-center">
                    <th>주문번호</th>
                    <th>사용포인트</th>
                    <th>적립포인트</th>
                    <th>날짜</th>
                </tr>
                </thead>
                <tbody id="rtContent">
                <c:forEach items="${list}" var="p">
                    <tr class="text-center">
                        <td>${p.orderNo}</td>
                        <td>
                            <c:if test="${p.usepointLog != 0}">
                                <span style="color: blue">-
                                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${p.usepointLog}" />
                                </span>
                            </c:if>
                            <c:if test="${p.usepointLog == 0}">
                                0
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${p.earnPoint != 0}">
                                <span style="color: red">+
                                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${p.earnPoint}" />
                                </span>
                            </c:if>
                            <c:if test="${p.earnPoint == 0}">
                                0
                            </c:if>
                        </td>
                        <td>${fn:substring(p.pointDate, 0, 16)}</td>
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
                  url : "${pageContext.request.contextPath}/Member/getPointPaging.do",
                  dataType: "json",
                  success : function(data) { // 처리가 성공할 경우
                    $('#rtContent').html('');
                    $.each(data.pmap, function() {
                      let usepoint = this.usepointLog;
                      let earnpoint = this.earnPoint;
                      let date = new Date(this.pointDate);
                      let mon = date.getMonth() + 1;
                      let day = date.getDate();
                      let hour = date.getHours();
                      let min = date.getMinutes();
                      let pointDate = date.getFullYear() + '-' + (mon > 9 ? mon : '0' + mon)
                          + '-' + (day > 9 ? day : '0' + day) + ' '
                          + (hour > 9 ? hour : '0' + hour) + ':' + (min > 9 ? min : '0' + min);

                      let dispHtml = '<tr class="text-center">';
                      dispHtml += '<td>' + this.orderNo + '</td>';
                      dispHtml += '<td>';
                      if(usepoint !== 0) {
                        dispHtml += '<span style="color: blue">- ' + usepoint.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '</span>';
                      } else {
                        dispHtml += usepoint;
                      }
                      dispHtml += '</td>';
                      dispHtml += '<td>'
                      if(earnpoint !== 0) {
                        dispHtml += '<span style="color: red">+ ' + earnpoint.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '</span>'
                      } else {
                        dispHtml += earnpoint;
                      }
                      dispHtml += '</td>';
                      dispHtml += '<td>' + pointDate + '</td>'
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
    </div>
</div>
<%@include file="/Common/footer.jsp" %>
</body>
</html>