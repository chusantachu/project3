<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet"
          href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
          crossorigin="anonymous">
    <title>로드맵 페이지 - 로드맵 상세 조회</title>
    <script src='https://cdn.jsdelivr.net/npm/sweetalert2@10'></script>
</head>
<style>
  .active-btn {
    color: #fff;
    background-color: #00C471;
    border-style: none;
    padding: 5px;
    border-radius: 5px;
  }
  .black-btn {
    color: #fff;
    background-color: #004e2d;
    border-style: none;
    padding: 5px;
    border-radius: 5px;
  }
  .tape {
    height: 150px;
    margin: 20px auto;
    padding-top: 40px;
    color: white;
  }
  .num-circle {
    width: 25px;
    height: 25px;
    border-radius: 100%;
    background-color: #00C471;
    text-align: center;
    color: #fff;
  }
</style>
<body>
<%@include file="/Common/header.jsp" %>
<div class="container-fluid bg-dark">
    <div class="container tape">
        <section class="tapeContent">
            <h2>${roadmap.rboardTitle}</h2>
            <p><i class="far fa-user"></i> ${roadmap.userCount}</p>
        </section>
    </div>
</div>
<div class="container-fluid">
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link active" data-toggle="tab" href="#home">로드맵 소개</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#menu1">코스 상세</a>
        </li>
    </ul>
</div>
<div class="container-fluid mt-5 pb-3 d-flex justify-content-center">
    <div class="row w-100 pb-4 justify-content-center">
        <!-- 왼쪽 네비 -->
        <div class="col-1 d-flex justify-content-center">
        </div>

        <!-- 중앙 위 내용 - 글내용 -->
        <div class="col-7 pl-3 gray-line">
            <div class="tab-content">
                <div class="tab-pane container active" id="home" style="word-break:break-all">${roadmap.rboardContent}</div>
                <div class="tab-pane container fade" id="menu1">
                    <table class="table">
                        <c:forEach items="${lectureList}" var="lec" varStatus="status">
                            <tr>
                                <td style="width: 5%">
                                    <div class="num-circle">${status.index + 1}</div>
                                </td>
                                <td style="width: 30%">
                                    <img class="w-100" src="${pageContext.request.contextPath}/filepath/${lec.lectureCoverimg}"/>
                                </td>
                                <td style="width: 65%;" class="pt-4">
                                    <div><h5><b>${lec.lectureTitle}</b></h5></div>
                                    <div class="pb-3">${lec.lectureSummary}</div>
                                    <button class="btn btn-light"
                                            onclick="location.href='${pageContext.request.contextPath}/Member/getLecture.do?lectureNo=${lec.lectureNo}'">
                                        강의 보러가기 >
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-3">
            <div class="w-100 d-flex justify-content-center">
                <ul class="list-group list-group-flush border" style="width: 75%; border-radius: 5px">
                    <c:if test="${not empty myroadmap}">
                        <li class="list-group-item pt-3 pb-3" style="background-color: #1dc078;">
                            <div class="pb-2">
                                <div class="float-right"><a href="${pageContext.request.contextPath}/Lecture/removeMyroadmap.do?rboardNo=${roadmap.rboardNo}" style="color: #fff;"><u>그만두기</u></a></div>
                                <div><button class="black-btn" style="border-radius: 10px">${myroadmap.roadmapStart} 시작</button></div>
                            </div>
                            <div class="pt-2">
                                <div class="pb-1" style="color: #fff">
                                    <fmt:formatNumber value="${myroadmap.roadmapRate * (100 / lectureList.size())}" pattern="0.0"/>%
                                </div>
                                <div class="progress">
                                    <div class="progress-bar" style="background-color:#fff; width:${myroadmap.roadmapRate * (100 / lectureList.size())}%"></div>
                                </div>
                            </div>
                        </li>
                    </c:if>
                    <li class="list-group-item">
                        <h5 class="pt-1"><b>로드맵 코스
                            <span style="color: #1dc078">${lectureList.size()}</span>
                        </b></h5>
                    </li>
                    <li class="list-group-item">
                        <ul class="list-group">
                            <c:forEach items="${lectureList}" var="lec">
                                <c:choose>
                                    <c:when test="${empty myroadmap}">
                                        <li class="list-group-item" style="background-color: #f8f9fa; color: #adb5bd">${lec.lectureTitle}</li>
                                    </c:when>
                                    <c:when test="${lec.isBuy == 1}">
                                        <li class="list-group-item">${lec.lectureTitle}</li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="list-group-item" style="background-color: #f8f9fa; color: #adb5bd">${lec.lectureTitle}</li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </ul>
                    </li>
                    <c:if test="${empty myroadmap}">
                        <li class="list-group-item">
                            <button onclick="startRoadmap()" class="active-btn w-100">무료로 로드맵 시작하기</button>
                            <script>
                                function startRoadmap() {
                                  if('${empty user}' === 'true') {
                                    Swal.fire({
                                      icon: 'error',
                                      title: '로드맵 시작 실패',
                                      text: '로그인이 필요합니다!'
                                    });
                                  } else {
                                    location.href='${pageContext.request.contextPath}/Lecture/addMyroadmap.do?rboardNo=${roadmap.rboardNo}';
                                  }
                                }
                            </script>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
        <div class="col-1 d-flex justify-content-center"></div>
    </div>
</div>
<%@include file="/Common/footer.jsp" %>
</body>
</html>