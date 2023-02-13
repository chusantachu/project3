<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <link href="${pageContext.request.contextPath}/summernote/summernote-bs4.css" rel="stylesheet">
  <script src="${pageContext.request.contextPath}/summernote/summernote-bs4.js"></script>

  <title>강의자 페이지 - 로드맵 관리 - 로드맵 작성</title>
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
</style>
<body>
<%@include file="/Common/header.jsp" %>
<div class="container-fluid bg-dark">
  <div class="container tape">
    <section class="tapeContent">
      <h2>로드맵 작성</h2>
    </section>
  </div>
</div>
<div class="container-fluid mt-5 pb-3 d-flex justify-content-center">
  <div class="row w-100 pb-4 justify-content-center">
    <!-- 왼쪽 네비 -->
    <div class="col-2 d-flex justify-content-center">
      <%@ include file="sidebar.jspf"%>
    </div>
    <!-- 중앙 위 내용 - 글내용 -->
    <div class="col-8 pl-3 gray-line">
      <form id="form" class="mt-4" method="post" enctype="multipart/form-data">
        <table class="table">
          <tr>
            <th><label for="categoryName">카테고리: </label></th>
            <td>
              <select id="categoryName" name="categoryName" class="custom-select">
                <option selected disabled>로드맵 카테고리</option>
                <c:forEach items="${categories}" var="cat">
                  <c:choose>
                    <c:when test="${cat.categoryName == roadmap.categoryName}">
                      <option selected value="${cat.categoryName}">${cat.categoryName}</option>
                    </c:when>
                    <c:otherwise>
                      <option value="${cat.categoryName}">${cat.categoryName}</option>
                    </c:otherwise>
                  </c:choose>
                </c:forEach>
              </select>
            </td>
          </tr>
          <tr>
            <th>커버 이미지: </th>
            <td>
              <input type="file" id="uploadFile" name="uploadFile" style="display:none;" accept="image/gif, image/jpeg, image/png"/>
              <label class="active-btn" for="uploadFile" style="border-radius: 5px 0px 0px 5px; margin-right: -4px">업로드</label>
              <c:if test="${not empty roadmap}">
                <span class="border" style="border-radius: 0px 5px 5px 0px; padding: 5px 5px 6px 5px;">
                  <i class="fas fa-image" style="color: #00C471"></i>
                  <a class="filePreview" href="${pageContext.request.contextPath}/filepath/${roadmap.rboardCoverimg}">${roadmap.rboardCoverimg}</a>
                </span>
              </c:if>
              <c:if test="${empty roadmap}">
                <span class="border" style="border-radius: 0px 5px 5px 0px; padding: 5px 5px 6px 5px;">
                  <i class="fas fa-image" style="color: #00C471"></i>
                  <a class="filePreview">이미지</a>
                </span>
              </c:if>
              <script>
                $('#uploadFile').change(function() {
                  let file = $(this).val().substring(12);
                  let filePreview = $('.filePreview');
                  filePreview.html(file);
                  filePreview.removeAttr('href');
                });
              </script>
            </td>
          </tr>
          <tr>
            <th><label for="rboardTitle">제목: </label></th>
            <td><input type="text" class="form-control" id="rboardTitle" name="rboardTitle" placeholder="로드맵 제목" value="${roadmap.rboardTitle}"></td>
          </tr>
          <tr>
            <th><label for="rboardTitle">강의목록: </label></th>
            <td>
              <select name="lectureSel" class="custom-select">
                <option selected disabled>강의목록</option>
                <c:forEach items="${lectureList}" var="lec">
                  <option value="${lec.lectureNo}">${lec.lectureTitle}</option>
                </c:forEach>
              </select>
            </td>
          </tr>
          <tr>
            <td></td>
            <td>
              <div class="border pt-3" style="border-radius: 5px">
                <ul id="listDisp">
                </ul>
              </div>
            </td>
          </tr>
          <tr>
            <th><label for="summernote">내용: </label></th>
            <td>
              <textarea id="summernote" name="rboardContent">${roadmap.rboardContent}</textarea>
              <script>
                $('#summernote').summernote({
                  tabsize: 2,
                  height: 400,
                  width: 1080,
                  callbacks: { // 콜백을 사용
                    // 이미지를 업로드할 경우 이벤트를 발생
                    onImageUpload: function(files, editor, welEditable) {
                      sendFile(files[0], this);
                    }
                  }
                });

                function sendFile(file, editor) {
                  // 파일 전송을 위한 폼생성
                  data = new FormData();
                  data.append("file", file);
                  $.ajax({ // ajax를 통해 파일 업로드 처리
                    data : data,
                    type : "POST",
                    url : "${pageContext.request.contextPath}/Teacher/uploadImage.do",
                    cache : false,
                    contentType : false,
                    processData : false,
                    success : function(url) { // 처리가 성공할 경우
                      console.log(url);
                      // 에디터에 이미지 출력
                      $(editor).summernote('editor.insertImage', '${pageContext.request.contextPath}/filepath/' + url);
                    },
                    error: function(){
                      alert("실패~~");
                    }
                  });
                }
              </script>
            </td>
          </tr>

          <input type="hidden" name="userId" value="${user.userId }"/>
          <input type="hidden" name="userName" value="${user.userName }"/>
          <input type="hidden" name="rboardNo" value="${roadmap.rboardNo }"/>
          <input type="hidden" id="lectureList" name="lectureList" value=""/>
          <tr>
            <td colspan="2">
              <button id="send" type="button" class="active-btn">
                <c:if test="${empty roadmap}">로드맵 작성</c:if>
                <c:if test="${not empty roadmap}">로드맵 수정</c:if>
              </button>

              <script>
                let send = document.getElementById("send");
                send.addEventListener('click', function () {
                  let lecStr = '';
                  for(let str of arr) {
                    lecStr = lecStr + str + '/';
                  }
                  document.getElementById('lectureList').value = lecStr;
                  let form = document.getElementById('form');
                  let actionStr;
                  if('${empty roadmap}' == 'true') {
                    actionStr = '${pageContext.request.contextPath}/Teacher/goRoadmapWrite.do';
                  } else {
                    actionStr = '${pageContext.request.contextPath}/Teacher/goRoadmapEdit.do';
                  }
                  form.action = actionStr;
                  form.submit();
                });
              </script>
              <button class="active-btn float-right" onclick="location.href='roadmapManager.jsp'; return false;">로드맵 관리로 돌아가기</button>
            </td>
          </tr>
        </table>
      </form>
    </div>
    <div class="col-2 d-flex justify-content-center">
    </div>
  </div>
</div>
<%@include file="/Common/footer.jsp" %>
</body>
<script>
  let menu = $('#roadmapManager');
  menu.removeClass('norm-menu');
  menu.addClass('active-menu');

  let arr = [];

  $(function(){
    let lectureList = '${roadmap.lectureList}'.slice(0, -1);
    if(lectureList !== '') {
      let lecArr = lectureList.split('/');
      for(let lec of lecArr) {
        data = new FormData();
        data.append("lectureNo", lec);
        $.ajax({
          data : data,
          type : "POST",
          url : "${pageContext.request.contextPath}/Teacher/getLecture.do",
          cache : false,
          contentType : false,
          processData : false,
          success : function(data) { // 처리가 성공할 경우
            let dispHtml = '<li>' + data + '</li>';
            $("#listDisp").append(dispHtml);
          },
          error: function(){
            alert("실패~~");
          }
        });
        arr.push(lec);
        console.log(arr);
      }
    }
  });

  $("select[name=lectureSel]").change(function() {
    let sel = $(this).val();
    // ajax 처리해서 강의 제목 받아오기
    if(arr.indexOf(sel) === -1) {
      data = new FormData();
      data.append("lectureNo", sel);
      $.ajax({
        data : data,
        type : "POST",
        url : "${pageContext.request.contextPath}/Teacher/getLecture.do",
        cache : false,
        contentType : false,
        processData : false,
        success : function(data) { // 처리가 성공할 경우
          let dispHtml = '<li>' + data + '</li>';
          $("#listDisp").append(dispHtml);
        },
        error: function(){
          alert("실패~~");
        }
      });
      arr.push(sel);
      console.log(arr);
    } else {
      alert('중복 강의는 추가할 수 없습니다');
    }
  });
</script>
</html>