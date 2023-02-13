<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/80bed6a544.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>

    <style>
      html, body {
        height: 100%;
      }

      .tape {
        height: 100px;
        margin: 50px auto;
        padding-top: 15px;
        color: white;
      }

      .sidebar-nav li a:hover {
        text-decoration: none;
        background: #d3d3d3;
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
    <script>
      $(function(){
        $('#summernote').summernote({
          width: 800,
          height: 500,                 // set editor height
          minHeight: null,             // set minimum height of editor
          maxHeight: null,             // set maximum height of editor
          focus: true,                  // set focus to editable area after initializing summernote
          callbacks: { // 콜백을 사용
            // 이미지를 업로드할 경우 이벤트를 발생
            /*
            onImageUpload: function(files, editor, welEditable) {
                 // 파일 업로드(다중업로드를 위해 반복문 사용)
                 for (var i = files.length - 1; i >= 0; i--) {
                     uploadSummernoteImageFile(files[i],
                    this);
                 }
            },
            */
          }
        });
      });
      $(document).on("click", "#introEdit", function(){
        $("#summernoteArea").modal();
      });

      $(document).on("click", "#send", function(){
        var frmString = $("#introFrm").serialize() ;
        console.log(frmString);

        $.ajax("${pageContext.request.contextPath }/member/editUserIntro.do", {
          type : "post",
          data : frmString,
          contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
          dataType: "json",
          success : function(data){

            console.log(data);
            $("#introHTML").html(data.intro);
          },
          error: function(){
            alert("실패");
          }
        });

      });
    </script>
</head>
<body>
<%@include file="/Common/header.jsp" %>
<div class="container mt-5 pb-3d-flex">
    <div class="row w-100 my-3 pb-4">
        <div class="col-3 w-100 mx-auto">
            <!-- 사이드 바 영역 -->
            <div class="mx-auto w-100 row">
                <div class="col-sm-9" style="height: 70px;">
                    <p class="font-weight-bold h5">${person.userName }</p>
                </div>
                <div class="col-sm-3" style="height: 70px;">
                    <img class="rounded-circle" src="${pageContext.request.contextPath}/picture/inflearn.png" alt="profile" width="50px;" height="50px;">
                </div>
            </div>
            <div class="mx-auto w-100">
                <nav class="w-100">
                    <ul class="navbar-nav sidebar-nav comNav rounded">
                        <li class="nav-item d-flex p-2 w-100">
                            <a href="${pageContext.request.contextPath}/member/goToPersonalPage.do?userId=${person.userId}" class="text-dark">홈</a>
                        </li>
                        <li class="nav-item d-flex p-2 w-100">
                            <a href="#" class="text-dark">게시글</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
        <div class="col-9 justify-content-center">
            <div class="w-100">
                <div id="board">
                    <div class="pb-2">
                        <span class="h4 d-inline font-weight-bold">게시글</span>
                        <div class="form-inline float-right">
                            <select id="typeSelect" name="type" class="form-control mr-2" onchange="paging(1)">
                                <option value="0">전체</option>
                                <option value="1">질문&답변</option>
                                <option value="2">자유주제</option>
                            </select>
                            <select id="orderSelect" name="order" class="form-control" style="width: 125px" onchange="paging(1)">
                                <option value="1">최신순</option>
                                <option value="2">오래된순</option>
                                <option value="3">좋아요순</option>
                            </select>
                            <script>
                              let type = $('#typeSelect');
                              let order = $('#orderSelect');

                              function paging(cPage) {
                                let data = {
                                  userId: '${person.userId}',
                                  type: type.val(),
                                  order: order.val(),
                                  cPage: cPage
                                }
                                console.log("data", data);

                                $.ajax({
                                  data : data,
                                  type : "GET",
                                  url : "${pageContext.request.contextPath}/member/userBoardPageAjax.do",
                                  dataType: "json",
                                  success : function(data) {
                                    console.log(data);
                                    $('#rtContent').html('');
                                    $.each(data.pmap, function() {
                                      let dispHtml = '<div class="pt-3 pb-3 row" style="border-bottom: 1px solid lightgrey">';
                                      if(this.boardAdopt != null) {
                                        dispHtml += '<div class="col-4">질문&답변&nbsp;';
                                        if(this.boardAdopt === 'FALSE') {
                                          dispHtml += '<span style="color: darkgray">미해결</span>';
                                        } else {
                                          dispHtml += '<span style="color: #00a760">해결됨</span>';
                                        }
                                        dispHtml += '</div>';
                                      } else {
                                        dispHtml += '<div class="col-4">자유주제</div>';
                                      }

                                      dispHtml += '<div class="col-8 text-right">';
                                      dispHtml += '<span style="color: darkgray">' + this.boardRegdate + '</span>';
                                      dispHtml += '</div>';
                                      dispHtml += '<div class="col-12 pt-2 pb-1">';
                                      if(this.boardAdopt != null) { // 질문게시판
                                        dispHtml += '<a class="h5" href="#">' + this.boardTitle + '</a>';
                                      } else { // 자유게시판
                                        dispHtml += '<a class="h5" href="#">' + this.boardTitle + '</a>';
                                      }
                                      dispHtml += '</div>';
                                      dispHtml += '<div class="col-12">';
                                      dispHtml += '<i class="fa-regular fa-heart"></i> ' + this.boardLike + '&nbsp;&nbsp;';
                                      dispHtml += '<i class="fa-regular fa-comment-alt"></i> ' + this.commentCnt;
                                      dispHtml += '</div></div>';

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
                                  error: function() {
                                    console.log("실패");
                                  }
                                })
                              }
                            </script>
                        </div>
                    </div>
                    <div id="rtContent">
                        <c:forEach items="${boardList}" var="board">
                            <div class="pt-3 pb-3 row" style="border-bottom: 1px solid lightgrey">
                                <c:if test="${not empty board.boardAdopt}">
                                    <div class="col-4">질문&답변&nbsp;
                                        <c:if test="${board.boardAdopt == 'FALSE'}">
                                            <span style="color: darkgray">미해결</span>
                                        </c:if>
                                        <c:if test="${board.boardAdopt == 'TRUE'}">
                                            <span style="color: #00a760">해결됨</span>
                                        </c:if>
                                    </div>
                                </c:if>
                                <c:if test="${empty board.boardAdopt}">
                                    <div class="col-4">자유주제</div>
                                </c:if>
                                <div class="col-8 text-right">
                                    <span style="color: darkgray">${board.boardRegdate}</span>
                                </div>
                                <div class="col-12 pt-2 pb-1">
                                    <!-- 질문게시판: 링크 연결해야 함!!! -->
                                    <c:if test="${not empty board.boardAdopt}">
                                        <a class="h5" href="#">${board.boardTitle}</a>
                                    </c:if>
                                    <!-- 자유게시판: 링크 연결해야 함!!! -->
                                    <c:if test="${empty board.boardAdopt}">
                                        <a class="h5" href="#">${board.boardTitle}</a>
                                    </c:if>
                                </div>
                                <div class="col-12">
                                    <i class="fa-regular fa-heart"></i> ${board.boardLike}&nbsp;&nbsp;
                                    <i class="fa-regular fa-comment-alt"></i> ${board.commentCnt}
                                </div>
                            </div>
                        </c:forEach>
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
</div>
<%@include file="/Common/footer.jsp" %>
</body>
</html>