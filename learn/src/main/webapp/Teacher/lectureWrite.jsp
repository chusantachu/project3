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
            <h2>강의 추가</h2>
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
                <li class="list-group-item" id="curriMenu">
                    <a class="norm-menu" data-toggle="tab" href="#curriculum">커리큘럼</a>
                </li>
                <li class="list-group-item">
                    <a class="norm-menu" data-toggle="tab" href="#coverimg">커버 이미지</a>
                </li>
                <li class="list-group-item">
                    <a class="norm-menu" data-toggle="tab" href="#setting">강의설정</a>
                    <div class="pt-3">
                        <button type="button" class="active-btn w-100" id="submitBtn">제출하기</button>
                        <script>
                          $('#submitBtn').on('click', function() {
                            // 섹션 저장
                            let ls = '';
                            $('.lectureSection').each(function () {
                              ls = ls + $(this).val() + '/';
                              console.log("ls: " + ls);
                            });
                            $('#lectureSection').val(ls.slice(0, -1));

                            // 실시간 질문 시간 저장: yyyy-MM-dd HH:mm:ss
                            let qsStart = $('#qsStart');
                            if(qsStart.val() !== '') {
                              let start = '2022-12-05 ' + qsStart.val() + ':00';
                              let end = '2022-12-05 ' + $('#qsEnd').val() + ':00';
                              $('#qsStartStr').val(start);
                              $('#qsEndStr').val(end);
                            }

                            let form = $('#testForm')[0];
                            let formData = new FormData(form);

                            let cnt = 0;

                            $.ajax({
                              type : 'POST',
                              url : '${pageContext.request.contextPath}/Teacher/addLecture.do',
                              data : formData,
                              dataType : 'json',
                              cache: false,
                              contentType: false,
                              processData: false,
                              error: function(){
                                alert('실패');
                              },
                              success: function(lectureNo) {
                                for (let i = 0; i <= secNum; i++) {
                                  let classes = $("form[id^='sn" + i + "']");
                                  if(classes.length !== 0) { // 섹션에 수업 있는지 확인
                                    classes.each(async function() {
                                      $(this).children('#lectureNo').val(lectureNo);
                                      $(this).children('#catName').val($('#categoryName').val());
                                      let formData = await new FormData($(this)[0]);
                                      $.ajax({
                                        type : 'POST',
                                        url : '${pageContext.request.contextPath}/Teacher/addClass.do',
                                        data : formData,
                                        dataType : 'json',
                                        async: false,
                                        cache: false,
                                        contentType: false,
                                        processData: false,
                                        error: function(data){
                                          alert('실패...');
                                        },
                                        success: function(data) {
                                        }
                                      })
                                    })
                                  }
                                } // 끝
                                cnt = 1;
                                if(cnt === 1) {
                                  location.href = '${pageContext.request.contextPath}/Teacher/lectureManager.do';
                                }
                              } // SUCCESS 끝
                            }); // AJAX 끝
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
                <input type="hidden" name="userId" value="${user.userId}"/>
                <input type="hidden" name="lectureWriter" value="${user.userName}"/>
                <div class="tab-content">
                    <div class="tab-pane container active border mt-2 p-5" id="info">
                        <h3>강의정보</h3>
                        <div>
                            <label>
                                <h6>강의제목</h6>
                                <input type="text" class="form-control" style="width: 700px"
                                       name="lectureTitle">
                            </label>
                        </div>
                        <div>
                            <label>
                                <h6>온/오프라인</h6>
                                <button type='button' class="active-btn light-btn" id="on"
                                        onclick="changeOnOff(0)">온라인</button>
                                <button type='button' class="active-btn light-btn" id="off"
                                        onclick="changeOnOff(1)">오프라인</button>
                                <input type="hidden" name="lectureOnOff" id="lectureOnOff">
                            </label>
                            <script>
                              function changeOnOff(num) {
                                if(num === 0) { // 온라인
                                  $('#on').removeClass('light-btn');
                                  $('#off').addClass('light-btn');
                                  $('#lectureOnOff').val(0);

                                  $('#curriMenu').css('display', ''); // 커리큘럼(사이드바) O
                                  $('#lectureDueDiv').css('display', ''); // 강의기한 O
                                  $('#realtimeQuestionDiv').css('display', ''); // 질문 O
                                } else if(num === 1) { // 오프라인
                                  $('#on').addClass('light-btn');
                                  $('#off').removeClass('light-btn');
                                  $('#lectureOnOff').val(1);

                                  $('#curriMenu').css('display', 'none'); // 커리큘럼(사이드바) X
                                  $('#lectureDueDiv').css('display', 'none'); // 강의기한 X
                                  $('#realtimeQuestionDiv').css('display', 'none'); // 질문 X
                                }
                              }
                            </script>
                        </div>
                        <div>
                            <label>
                                <h6>카테고리</h6>
                                <c:forEach items="${categories}" var="cat" varStatus="status">
                                    <button type='button' class="active-btn light-btn"
                                            id="cat${status.index}"
                                            onclick="changeCat(${status.index})">
                                            ${cat.categoryName}
                                    </button>
                                </c:forEach>
                                <input type="hidden" id="categoryName" name="categoryName">
                            </label>
                            <script>
                              function changeCat(num) {
                                <c:forEach items="${categories}" var="cat" varStatus="status">
                                if('${status.index}' === String(num)) {
                                  $('#cat${status.index}').removeClass('light-btn');
                                  $('#categoryName').val('${cat.categoryName}');
                                } else {
                                  $('#cat${status.index}').addClass('light-btn');
                                }
                                </c:forEach>
                              }
                            </script>
                        </div>
                        <div>
                            <label>
                                <h6>강의수준</h6>
                                <button type='button' class="active-btn light-btn" id="lv1"
                                        onclick="changeLevel(1)">입문</button>
                                <button type='button' class="active-btn light-btn" id="lv2"
                                        onclick="changeLevel(2)">초급</button>
                                <button type='button' class="active-btn light-btn" id="lv3"
                                        onclick="changeLevel(3)">중급이상</button>
                                <input type="hidden" id="lectureLevel" name="lectureLevel">
                            </label>
                            <script>
                                function changeLevel(num) {
                                  let level = $('#lectureLevel');
                                  let str = ['입문', '초급', '중급이상'];

                                  for(let i = 1; i <= 3; i++) {
                                    if(i === num) {
                                      $('#lv' + i).removeClass('light-btn');
                                      level.val(str[i - 1]);
                                    } else {
                                      $('#lv' + i).addClass('light-btn');
                                    }
                                  }
                                }
                            </script>
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
                            <textarea class="form-control" style="width: 900px" name="lectureSummary"></textarea>
                        </label>
                        <label>
                            <h6>강의 상세 내용
                                <span style="color: red">(해당 내용은 강의소개에서 보여집니다)</span>
                            </h6>
                            <textarea class="form-control" style="width: 900px" name="lectureContent"
                                      id="lectureContent">주제 소개, 왜 배워야 하는지, 이 강의에서 배우는 것들, 강의 특징, 섹션마다 간단한 소개 등을 작성해주세요.</textarea>
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
                    <div class="tab-pane container fade border mt-2 p-5" id="curriculum">
                        <input type="hidden" name="lectureSection" id="lectureSection"/>
                        <h3>커리큘럼</h3>
                        <button type="button" onclick="addSection()" class="active-btn">섹션 추가</button>
                        <div id="classDiv" class="pt-3">
                        </div>
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
                                <img width="400px" alt="lectureCoverimg"
                                     src="https://blog.kakaocdn.net/dn/PUn3J/btqCvx1gkCr/IiQ89PF6VfFqqDw3wFmpH1/img.png"/>
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
                                    <a class="filePreview">이미지</a>
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
                                <input type="number" class="form-control" style="width: 700px"
                                       id="lecturePrice" name="lecturePrice" value="0">
                                <script>
                                  $('#lecturePrice').change(function() {
                                    if($(this).val() === '0' || $(this).val() === '') {
                                      $('#discountDiv').css('display', 'none');
                                    } else {
                                      $('#discountDiv').css('display', '');
                                    }
                                  });
                                </script>
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
                                           id="lectureSalerate" name="lectureSalerate" placeholder="할인률(%)">
                                </div>
                                <div class="form-inline" id="saledueDiv">
                                    <span>할인기한&nbsp;:&nbsp;&nbsp;</span>
                                    <input type="date" class="form-control" style="width: 617px"
                                           id="lectureSaledue" name="lectureSaledue" placeholder="할인기한">
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
                                <button type='button' class="active-btn light-btn" id="free"
                                        onclick="setFree(1)">무제한</button>
                                <button type='button' class="active-btn light-btn mb-2" id="limit"
                                        onclick="setFree(0)">제한</button>
                                <input type="hidden" class="form-control" style="width: 700px"
                                       id="lectureDue" name="lectureDue">
                            </label>
                            <script>
                              function setFree(num) {
                                if(num === 1) {
                                  let due = $('#lectureDue');
                                  $('#free').removeClass('light-btn');
                                  $('#limit').addClass('light-btn');
                                  due.prop('type', 'hidden');
                                  due.val(0);
                                } else {
                                  $('#free').addClass('light-btn');
                                  $('#limit').removeClass('light-btn');
                                  $('#lectureDue').prop('type', 'number');
                                }
                              }
                            </script>
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
                                    <input class="form-control" type="time" id="qsStart"/>
                                    <input type="hidden" id="qsStartStr" name="qsStartStr">
                                </div>
                                <div class="form-inline" id="qsEndDiv" style="display:none">
                                    종료시간:&nbsp;&nbsp;
                                    <input class="form-control" type="time" id="qsEnd"/>
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
    let secNum = 0;
    let clsNum = 1;

    function addSection() {
      let dispHtml = '<div id="s' + secNum + '" class="border p-3 mb-3 section">';
      dispHtml += '<div class="pb-4 form-inline row" id="sec' + secNum + '">';
      dispHtml += '<div class="col-1" style="font-weight: bold;">섹션 : </div>';
      dispHtml += '<div class="col-9">';
      dispHtml += '<input type="text" class="form-control w-100 lectureSection "/>';
      dispHtml += '</div>';
      dispHtml += '<div class="col-2">';
      dispHtml += '<button type="button" class="btn btn-sm btn-link" onclick="addClass(' + secNum + ')">수업 추가</button>';
      dispHtml += '<button type="button" class="btn btn-sm btn-danger" onclick="removeSection(' + secNum + ')">삭제</button>';
      dispHtml += '</div>';
      dispHtml += '</div>';
      dispHtml += '</div>';
      $('#classDiv').append(dispHtml);
      secNum++;
    }

    function addClass(num) {
      // FORM 시작
      let dispHtml = '<form class="border row col-11 ml-2 mt-3 p-3" method="post" enctype="multipart/form-data" id="sn'+ num +'class'+ clsNum +'">';
      dispHtml += '<input type="hidden" name="sectionNo" value="' + num + '">';
      dispHtml += '<input type="hidden" id="lectureNo" name="lectureNo">';
      dispHtml += '<input type="hidden" id="catName" name="categoryName">';

      // 수업 이름
      dispHtml += '<div class="col-1">수업 : </div>';
      dispHtml += '<div class="col-9"><input name="className" type="text" class="form-control w-100 className"/></div>';
      dispHtml += '<div class="col-2 text-right">';
      dispHtml += '<button type="button" class="btn btn-sm btn-primary mr-2" data-toggle="collapse" data-target="#class' + clsNum + '">상세</button>';
      dispHtml += '<button type="button" class="btn btn-sm btn-danger" onclick="removeClass('+ num +', ' + clsNum + ')">삭제</button>';
      dispHtml += '</div>';

      // 수업 상세 시작
      dispHtml += '<div id="class'+ clsNum + '" class="w-100 collapse border p-3 mt-3 ml-1">';

      // 수업 상세: 강의 파일
      dispHtml += '<div>';
      dispHtml += '<input type="file" name="uploadVideo" class="uploadVideo" id="uploadVideo'+ clsNum + '" style="display:none;" accept="video/mp4, video/mkv"/>';
      dispHtml += '<label class="active-btn" for="uploadVideo'+ clsNum + '" style="padding-bottom: 5px; margin-bottom: 10px">영상 업로드</label>';
      dispHtml += '<span class="border" style="border-radius: 5px; padding: 5px;">';
      dispHtml += '<i class="fas fa-image" style="color: #00C471"></i>';
      dispHtml += '<a class="videoPreview">동영상(mp4, mkv 파일만 가능)</a>';
      dispHtml += '</span>';
      dispHtml += '</div>';

      // 수업 상세: 수업 미리보기 여부
      dispHtml += '<div class="pb-4 pt-4"><h6>무료 공개 여부</h6>';
      dispHtml += '<button type="button" class="active-btn light-btn openBtn">공개</button>';
      dispHtml += '<button type="button" class="active-btn light-btn closeBtn">비공개</button>';
      dispHtml += '<input type="hidden" name="preview" class="preview">';
      dispHtml += '</div>';

      // 수업 상세: 자료 파일
      dispHtml += '<div>';
      dispHtml += '<input type="file" name="uploadBook" class="uploadBook" id="uploadBook'+ clsNum + '" style="display:none;" accept="application/pdf"/>';
      dispHtml += '<label class="active-btn" for="uploadBook'+ clsNum + '" style="padding-bottom: 5px; margin-bottom: 10px">자료파일 업로드</label>';
      dispHtml += '<span class="border" style="border-radius: 5px; padding: 5px;">';
      dispHtml += '<i class="fas fa-image" style="color: #00C471"></i>';
      dispHtml += '<a class="bookPreview">자료파일(pdf 파일만 가능)</a>';
      dispHtml += '</span>';

      // 수업 상세 끝
      dispHtml += '</div>';

      // FORM 끝
      dispHtml += '</form>';
      $('#sec' + num).append(dispHtml);
      clsNum++;
    }

    function removeSection(num) {
      $('#s' + num).remove();
    }

    function removeClass(secNum, clsNum) {
      $('#sn' + secNum + 'class' + clsNum).remove();
    }

    $(document).on('change', '.uploadVideo', function() {
      let file = $(this).val().substring(12);
      let preview = $(this).parent('div').children('span').children('a');
      preview.html(file);
      preview.removeAttr('href');
    });

    $(document).on('change', '.uploadBook', function() {
      let file = $(this).val().substring(12);
      let preview = $(this).parent('div').children('span').children('a');
      preview.html(file);
      preview.removeAttr('href');
    });

    $(document).on('click', '.openBtn', function() {
      $(this).removeClass('light-btn');
      $(this).parent('div').children('button:eq(1)').addClass('light-btn');
      $(this).parent('div').children('input').val('0');
    });

    $(document).on('click', '.closeBtn', function() {
      $(this).removeClass('light-btn');
      $(this).parent('div').children('button:eq(0)').addClass('light-btn');
      $(this).parent('div').children('input').val('1');
    });

</script>
</body>
</html>