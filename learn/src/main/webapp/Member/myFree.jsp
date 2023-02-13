<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
  <title>로그인</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script
          src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
  <script
          src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script
          src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
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
      padding-top: 15px;
      color: white;
    }

    .active {
      font-weight: bold;
      text-decoration: underline;
    }

    .nav-link {
      color: black;
    }

    .active-btn {
      color: #fff;
      background-color: #00C471;
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
</head>
<body>
<%@ include file="../Common/header.jsp"%>
<div class="container-fluid bg-dark">
  <div class="container tape">
    <section class="tapeContent">
      <h2>문의게시판</h2>
    </section>
  </div>
</div>
<div class="container-fluid mt-5 pb-3 d-flex justify-content-center">
  <div class="row w-100 pb-4 justify-content-center">
    <!-- 왼쪽 네비 -->
    <div class="col-2 d-flex justify-content-center">
      <%@ include file="sidebar.jspf"%>
      <script>
        var menu = $('#myboardMenu');
        console.log(menu);
        menu.removeClass('norm-menu');
        menu.addClass('active-menu');
      </script>
    </div>
    <div class="col-8 pl-3 gray-line">
      <h2>조회</h2>
      <div class="pb-3">
        <ul class="border nav p-1">
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/Member/myQuestion.do">질문</a>
          </li>
          <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath }/Member/myFree.do">자유주제</a>
          </li>
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/memberBoard/callCenterBoardList.do?userId=${user.userId}">문의글</a></li>
        </ul>
      </div>
      <div class="border">
        <select id="orderSelect" name="order" class="form-control ml-3 mt-3" style="width: 125px" onchange="paging(1)">
          <option value="1">최신순</option>
          <option value="2">오래된순</option>
          <option value="3">좋아요순</option>
        </select>
        <script>
          let order = $('#orderSelect');

          function paging(cPage) {
            let data = {
              order: order.val(),
              cPage: cPage
            }
            console.log("data", data);

            $.ajax({
              data : data,
              type : "GET",
              url : "${pageContext.request.contextPath}/member/myFreeAjax.do",
              success : function(data) {
                console.log(data);
                let html = jQuery('<div>').html(data);

                let freeboard = html.find("div#freeboard").html();
                let fpaging = html.find("div#fpaging").html();

                $('#listDisp').html(freeboard);
                $('.pagination').html(fpaging);
              },
              error: function() {
                console.log("실패");
              }
            })
          }
        </script>
        <div id="listDisp" class="pt-3">
          <c:if test="${not empty list}">
            <c:forEach var="free" items="${list }">
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
          <c:if test="${empty list}">
            <div class="pt-1 pl-4 pr-4">
              <h5>작성한 게시글이 없습니다.</h5>
            </div>
          </c:if>
        </div>
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
      </div>
    </div>
  </div>
</div>
<footer>
  <%@ include file="../Common/footer.jsp"%>
</footer>
</body>
</html>
