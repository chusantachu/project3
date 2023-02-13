<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <link href="${pageContext.request.contextPath}/summernote/summernote-bs4.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/summernote/summernote-bs4.js"></script>
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
  .light-btn {
    color: black;
    background-color: #f8f9fa;
    padding: 5px;
    border: 1px solid #f5f5f5;
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

  .tab-pane h3 {
    font-weight: bold;
    padding-bottom: 15px;
  }
  .tab-pane label {
    padding-bottom: 10px;
  }
</style>
<body>
<%@include file="/Common/header.jsp" %>
<div class="container-fluid bg-dark">
    <div class="container tape">
        <section class="tapeContent">
            <h2>강의 수정</h2>
        </section>
    </div>
</div>
<div class="container-fluid mt-5 pb-3 d-flex justify-content-center">
    <div class="row w-100 pb-4 justify-content-center">
        <!-- 왼쪽 네비 -->
        <div class="col-2 d-flex justify-content-center">
            <ul class="list-group list-group-flush">
                <li class="list-group-item">
                    <h5><b>강의 추가</b></h5>
                </li>
                <li class="list-group-item" id="infoMenu">
                    <a class="norm-menu" data-toggle="tab" href="#info">강의정보</a>
                </li>
                <li class="list-group-item">
                    <a class="norm-menu" data-toggle="tab" href="#detail">상세소개</a>
                </li>
                <li class="list-group-item">
                    <a class="norm-menu" data-toggle="tab" href="#coverimg">커버 이미지</a>
                </li>
                <li class="list-group-item">
                    <a class="norm-menu" data-toggle="tab" href="#setting">강의설정</a>
                    <div class="pt-3">
                        <button type="button" class="active-btn w-100" id="submitBtn">수정하기</button>
                        <script>
                          $('#submitBtn').on('click', function() {
                            let form = $('#testForm')[0];
                            let formData = new FormData(form);

                            $.ajax({
                              type : 'POST',
                              url : '${pageContext.request.contextPath}/Teacher/editLecture.do',
                              data : formData,
                              dataType : 'json',
                              cache: false,
                              contentType: false,
                              processData: false,
                              error: function(data){
                                alert('실패');
                              },
                              success : function(data){
                                location.href = '${pageContext.request.contextPath}/Teacher/lectureManager.do';
                              }
                            });
                          })
                        </script>
                    </div>
                </li>
            </ul>
        </div>
        <script>
          var menu = $('#lectureManager');
          console.log(menu);
          menu.removeClass('norm-menu');
          menu.addClass('active-menu');
        </script>

        <!-- 중앙 위 내용 - 글내용 -->
        <div class="col-8 pl-3 gray-line">
            <button type="button"
                    onclick="location.href='${pageContext.request.contextPath}/Teacher/lectureManager.do'"
                    class="active-btn mb-2">강의 관리로</button>
            <form name="testForm" id="testForm" method="post" enctype="multipart/form-data">
                <input type="hidden" name="lectureNo" value="${lecture.lectureNo}"/>
                <div class="tab-content">
                    <div class="tab-pane container active border mt-2 p-5" id="info">
                        <h3>강의정보</h3>
                        <div>
                            <label>
                                <h6>강의제목</h6>
                                <input readonly type="text" class="form-control" style="width: 700px"
                                       value="${lecture.lectureTitle}">
                            </label>
                        </div>
                        <div>
                            <label>
                                <h6>온/오프라인</h6>
                                <c:if test="${lecture.lectureOnOff == 0}">
                                    <button type='button' class="active-btn light-btn" id="on">온라인</button>
                                </c:if>
                                <c:if test="${lecture.lectureOnOff == 1}">
                                    <button type='button' class="active-btn light-btn" id="off">오프라인</button>
                                </c:if>
                            </label>
                        </div>
                        <div>
                            <label>
                                <h6>카테고리</h6>
                                <button type='button' class="active-btn light-btn">
                                    ${lecture.categoryName}
                                </button>
                            </label>
                        </div>
                        <div>
                            <label>
                                <h6>강의수준</h6>
                                <button type='button' class="active-btn light-btn">${lecture.lectureLevel}</button>
                            </label>
                        </div>
                    </div>
                    <div class="tab-pane container fade border mt-2 p-5" id="detail">
                        <h3>상세소개</h3>
                        <label>
                            <h6>강의 두줄 요약
                                <span style="color: red">
                                    (해당 내용은 강의리스트와 강의소개 상단에 보여집니다.)
                                </span>
                            </h6>
                            <textarea class="form-control" style="width: 900px" name="lectureSummary">${lecture.lectureSummary}</textarea>
                        </label>
                        <label>
                            <h6>강의 상세 내용
                                <span style="color: red">(해당 내용은 강의소개에서 보여집니다)</span>
                            </h6>
                            <textarea class="form-control" style="width: 900px" name="lectureContent"
                                      id="lectureContent">${lecture.lectureContent}</textarea>
                        </label>
                        <script>
                          $('#lectureContent').summernote({
                            tabsize: 2,
                            width: 900,
                            height: 500,
                            callbacks: { // 콜백을 사용
                              // 이미지를 업로드할 경우 이벤트를 발생
                              onImageUpload: function(files) {
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
                                $(editor).summernote('editor.insertImage',
                                    '${pageContext.request.contextPath}/filepath/' + url);
                              },
                              error: function(){
                                alert("실패~~");
                              }
                            });
                          }
                        </script>
                    </div>
                    <div class="tab-pane container fade border mt-2 p-5" id="coverimg">
                        <h3>커버 이미지</h3>
                        <div class="p-4" style="background-color: #f5f5f5">
                            <b>커버 이미지 - 썸네일 등록</b><br>
                            강의 커버 이미지(썸네일)을 직접 제작하실 경우, 이미지 규정에 맞춰 주세요.<br>
                            이미지가 규정에 맞지 않을 경우, 운영팀 판단하에 임의로 변경될 수 있습니다.
                        </div>
                        <div class="row pt-3">
                            <div class="col-5 text-center">
                                <c:if test="${not empty lecture.lectureCoverimg}">
                                    <img width="400px" alt="lectureCoverimg" src="/learn/filepath/${lecture.lectureCoverimg}"/>
                                </c:if>
                                <c:if test="${empty lecture.lectureCoverimg}">
                                    <img width="400px" alt="lectureCoverimg"
                                         src="https://blog.kakaocdn.net/dn/PUn3J/btqCvx1gkCr/IiQ89PF6VfFqqDw3wFmpH1/img.png"/>
                                </c:if>
                            </div>
                            <div class="col-7">
                                <br><br>
                                <h5><b>강의를 대표하는 이미지</b></h5>
                                <ul>
                                    <li>확장자: jpg, jpeg, png</li>
                                    <li>폰트, 사진, 일러스트 저작권 확인</li>
                                    <li>페이스북 텍스트 오버레이 페널티 확인</li>
                                </ul>
                                <input type="file" name="uploadFile" id="uploadFile" style="display:none;"
                                       accept="image/gif, image/jpeg, image/png"/>
                                <label class="active-btn" for="uploadFile"
                                       style="border-radius: 5px 0 0 5px; margin-right: -4px">업로드</label>
                                <span class="border" style="border-radius: 0 5px 5px 0; padding: 5px 5px 11px 5px;">
                                    <i class="fas fa-image" style="color: #00C471"></i>
                                    <c:if test="${not empty lecture.lectureCoverimg}">
                                        <a class="filePreview">${lecture.lectureCoverimg}</a>
                                    </c:if>
                                    <c:if test="${empty lecture.lectureCoverimg}">
                                        <a class="filePreview">이미지</a>
                                    </c:if>
                                </span>
                            </div>
                            <script>
                              $('#uploadFile').change(function() {
                                let file = $(this).val().substring(12);
                                let filePreview = $('.filePreview');
                                filePreview.html(file);
                                filePreview.removeAttr('href');
                              });
                            </script>
                        </div>
                    </div>
                    <div class="tab-pane container fade border mt-2 p-5" id="setting">
                        <h3>강의설정</h3>
                        <div>
                            <label>
                                <h6>가격 설정
                                    <span style="color: red">(무료 강의는 '0'으로 입력해주세요.)</span>
                                </h6>
                                <input readonly type="number" class="form-control" style="width: 700px"
                                       id="lecturePrice" name="lecturePrice" value="${lecture.lecturePrice}">
                            </label>
                        </div>
                        <div>
                            <label id="discountDiv">
                                <h6>할인 설정
                                    <span style="color: red">(할인률과 할인기한을 입력해주세요.)</span>
                                </h6>
                                <button type='button' class="active-btn light-btn" id="dc"
                                        onclick="setDiscount(1)">할인</button>
                                <button type='button' class="active-btn light-btn mb-2" id="notdc"
                                        onclick="setDiscount(0)">정가</button>
                                <div class="form-inline" id="salerateDiv">
                                    <span>할인률(%)&nbsp;:&nbsp;</span>
                                    <input type="number" class="form-control mb-2" style="width: 617px"
                                           id="lectureSalerate" name="lectureSalerate" placeholder="할인률(%)"
                                           value="${lecture.lectureSalerate}">
                                </div>
                                <div class="form-inline" id="saledueDiv">
                                    <span>할인기한&nbsp;:&nbsp;&nbsp;</span>
                                    <input type="date" class="form-control" style="width: 617px"
                                           id="lectureSaledue" name="lectureSaledue" placeholder="할인기한"
                                           value="${fn:substring(lecture.lectureSaledue, 0, 10)}">
                                </div>
                            </label>
                            <script>
                              function setDiscount(num) {
                                let rate = $('#lectureSalerate');
                                let due = $('#lectureSaledue');

                                if(num === 0) { // 정가
                                  $('#dc').addClass('light-btn');
                                  $('#notdc').removeClass('light-btn');
                                  $('#salerateDiv').css('display', 'none');
                                  $('#saledueDiv').css('display', 'none');
                                  rate.val('0');
                                  due.val('');
                                } else { // 할인
                                  $('#dc').removeClass('light-btn');
                                  $('#notdc').addClass('light-btn');
                                  $('#salerateDiv').css('display', '');
                                  $('#saledueDiv').css('display', '');
                                }
                              }
                            </script>
                        </div>
                        <div id="lectureDueDiv">
                            <label>
                                <h6>수강 기한
                                    <span style="color: red">(일수를 입력하세요.)</span>
                                </h6>
                                <c:if test="${lecture.lectureDue == 0}">
                                    <button type='button' class="active-btn light-btn">무제한</button>
                                </c:if>
                                <c:if test="${lecture.lectureDue != 0}">
                                    <button type='button' class="active-btn light-btn mb-2">제한</button>
                                    <input readonly type="number" class="form-control" style="width: 700px" value="${lecture.lectureDue}">
                                </c:if>
                            </label>
                        </div>
                        <div id="realtimeQuestionDiv">
                            <label>
                                <h6>실시간 질문</h6>
                                <button type='button' class="active-btn light-btn" id="qok"
                                        onclick="setQuestion(1)">있음</button>
                                <button type='button' class="active-btn light-btn mb-2" id="qno"
                                        onclick="setQuestion(0)">없음</button>
                                <div class="form-inline pb-2" id="qsWeekdaysDiv" style="display:none">
                                    요일:&nbsp;&nbsp;
                                    <select class="form-control" name="qsWeekdays" id="qsWeekdays">
                                        <option value="0">일요일</option>
                                        <option value="1">월요일</option>
                                        <option value="2">화요일</option>
                                        <option value="3">수요일</option>
                                        <option value="4">목요일</option>
                                        <option value="5">금요일</option>
                                        <option value="6">토요일</option>
                                    </select>
                                </div>
                                <div class="form-inline pb-2" id="qsStartDiv" style="display:none">
                                    시작시간:&nbsp;&nbsp;
                                    <input type="hidden" id="qsStartStr" name="qsStartStr">
                                </div>
                                <div class="form-inline" id="qsEndDiv" style="display:none">
                                    종료시간:&nbsp;&nbsp;
                                    <input type="hidden" id="qsEndStr" name="qsEndStr">
                                </div>
                            </label>
                            <script>
                              function setQuestion(num) {
                                if(num === 0) { // 없음
                                  $('#qno').removeClass('light-btn');
                                  $('#qok').addClass('light-btn');
                                  $('#qsWeekdaysDiv').css('display', 'none');
                                  $('#qsStartDiv').css('display', 'none');
                                  $('#qsEndDiv').css('display', 'none');
                                  $('#qsWeekdays').val('');
                                  $('#qsStartStr').val('');
                                  $('#qsEndStr').val('');
                                } else { // 있음
                                  $('#qno').addClass('light-btn');
                                  $('#qok').removeClass('light-btn');
                                  $('#qsWeekdaysDiv').css('display', '');
                                  $('#qsStartDiv').css('display', '');
                                  $('#qsEndDiv').css('display', '');
                                }
                              }
                            </script>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-2 d-flex justify-content-center">
        </div>
    </div>
</div>
<%@include file="/Common/footer.jsp" %>
<script>
    $(function() {
      if('${lecture.lectureOnOff == 1}' === 'true') {
        $('#lectureDueDiv').css('display', 'none');
        $('#realtimeQuestionDiv').css('display', 'none');
      }

      if('${empty lecture.qsStart}' === 'true') {
        setQuestion(0);
      } else {
        let qsStart = '${lecture.qsStart}'.substring(11, 16);
        let qsEnd = '${lecture.qsEnd}'.substring(11, 16);
        setQuestion(1);
        $('#qsWeekdays').val(${lecture.qsWeekdays});
        $('#qsStartDiv').append('<input class="form-control" type="time" id="qsStart" value="' + qsStart + '" />')
        $('#qsEndDiv').append('<input class="form-control" type="time" id="qsEnd" value="' + qsEnd + '" />')
      }

      if('${lecture.lectureSalerate == 0}' === 'true') {
        setDiscount(0);
      } else {
        setDiscount(1);
      }
    })
</script>
</body>
</html>