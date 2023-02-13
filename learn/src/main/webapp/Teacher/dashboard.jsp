<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://www.gstatic.com/charts/loader.js"></script>
    <script>
      google.charts.load('current', {packages: ['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        // Define the chart to be drawn.
        var data1 = new google.visualization.DataTable();
        var data2 = new google.visualization.DataTable();
        var data3 = new google.visualization.DataTable();

        data1.addColumn('string', 'title');
        data1.addColumn('number', 'price');

        <c:forEach items="${salesByMonth}" var="sbm">
        data1.addRows([
          ['${sbm.lectureTitle}', parseInt('${sbm.lecturePrice}')],
        ]);
        </c:forEach>

        data2.addColumn('string', 'num');
        data2.addColumn('number', 'price');
        <c:forEach items="${salesByLecture}" var="sbl">
        data2.addRows([
          ['${sbl.lectureTitle}', parseInt('${sbl.lecturePrice}')],
        ]);
        </c:forEach>

        data3.addColumn('string', 'num');
        data3.addColumn('number', 'price');
        <c:forEach items="${salesByLine}" var="sbl">
        data3.addRows([
          [('${sbl.lectureNo}' === '0' ? '온라인' : '오프라인'), parseInt('${sbl.lecturePrice}')],
        ]);
        </c:forEach>

        var options = { 'width': 390, 'height': 300, 'chartArea': {'height': '70%'},
          'legend': {'position': 'bottom'} };

        // Instantiate and draw the chart.
        var chart1 = new google.visualization.PieChart(document.getElementById('salesByMonth'));
        var chart2 = new google.visualization.PieChart(document.getElementById('salesByLecture'));
        var chart3 = new google.visualization.PieChart(document.getElementById('salesByLine'));
        chart1.draw(data1, options);
        chart2.draw(data2, options);
        chart3.draw(data3, options);
      }
    </script>
    <title>강의자 페이지 - 대시보드</title>
</head>
<style>
    .active-menu {
      color: #1dc078;
      font-weight: bold;
    }
    .norm-menu {
      color: black;
    }
    .tape {
      height: 70px;
      margin: 50px auto;
      padding-top: 15px;
      color: white;
    }
    .padH {
        padding-top: 15px;
        padding-bottom: 15px;
    }
    .row div h5 {
        font-weight: bold;
        padding-bottom: 10px;
    }
    .row div h2 {
        color: darkgrey;
        text-align: center;
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
            <h2>대시보드</h2>
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
          var menu = $('#dashboard');
          console.log(menu);
          menu.removeClass('norm-menu');
          menu.addClass('active-menu');
        </script>

        <!-- 중앙 위 내용 - 글내용 -->
        <div class="col-8 pl-3 gray-line">
            <div class="row justify-content-center">
                <div class="col-2 padH myhome border" style="background-color: #EDFFF4">
                    <h5>My Home</h5>
                    <h2 class="text-center">🏠</h2>
                </div>
                <div class="col-2 padH student border">
                    <h5>총 수강생 수</h5>
                    <h2>
                        <c:if test="${empty map.studentCnt}">0</c:if>
                        <c:if test="${not empty map.studentCnt}">${map.studentCnt}</c:if>
                        <small>명</small>
                    </h2>
                </div>
                <div class="col-2 padH lecture border">
                    <h5>총 강의 수</h5>
                    <h2>
                        <c:if test="${empty map.lectureCnt}">0</c:if>
                        <c:if test="${not empty map.lectureCnt}">${map.lectureCnt}</c:if>
                        <small>개</small>
                    </h2>
                </div>
                <div class="col-2 padH rate border">
                    <h5>평균 평점</h5>
                    <h2>
                        <c:if test="${empty lectureRate}">-</c:if>
                        <c:if test="${not empty lectureRate}">
                            ${lectureRate}<small></small>
                        </c:if>
                    </h2>
                </div>
                <div class="col-4 padH sales border">
                    <h5>총 수익</h5>
                    <h2>
                        <c:if test="${empty map.lectureSales}">0</c:if>
                        <c:if test="${not empty map.lectureSales}">
                            <fmt:formatNumber type="number" maxFractionDigits="3" value="${map.lectureSales}" />
                        </c:if>
                        <small>원</small>
                    </h2>
                </div>
            </div>
            <div class="row justify-content-center pt-4">
                <div class="col-4 border" style="padding-top: 15px; padding-bottom: 20px">
                    <h5>이번 달 현황</h5>
                    <div id="salesByMonth"></div>
                </div>
                <div class="col-4 border" style="padding-top: 15px; padding-bottom: 20px">
                    <h5>강의별 수익 분포</h5>
                    <div id="salesByLecture"></div>
                </div>
                <div class="col-4 border" style="padding-top: 15px; padding-bottom: 20px">
                    <h5>온/오프라인 수익 분포</h5>
                    <div id="salesByLine"></div>
                </div>
            </div>
            <div class="row justify-content-center pt-4">
                <div class="col-12 border" style="padding-top: 20px; padding-bottom: 10px">
                    <h5>실시간 수익 현황</h5>
                    <table class="table">
                        <thead>
                        <tr>
                            <th style="width: 60%">강의명</th>
                            <th style="width: 20%">최근구매시간</th>
                            <th style="width: 20%">총수익</th>
                        </tr>
                        </thead>
                        <tbody id="rtContent">
                        <c:forEach items="${realtimeSales}" var="lec">
                            <tr>
                                <td>${lec.lectureTitle}</td>
                                <td>${lec.lectureRegdate}</td>
                                <td>
                                    <fmt:formatNumber type="number" maxFractionDigits="3" value="${lec.lecturePrice}" />원
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
                            url : "${pageContext.request.contextPath}/Teacher/getRealtimeSales.do",
                            dataType: "json",
                            success : function(data) { // 처리가 성공할 경우
                              $('#rtContent').html('');
                              $.each(data.pmap, function() {
                                let dispHtml = '<tr>';
                                dispHtml += '<td>' + this.lectureTitle + '</td>';
                                dispHtml += '<td>' + this.lectureRegdate + '</td>';
                                dispHtml += '<td>' + this.lecturePrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '원</td>';
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
        <div class="col-2 d-flex justify-content-center">
        </div>
    </div>
</div>
<%@include file="/Common/footer.jsp" %>
</body>
</html>