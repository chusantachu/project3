<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<style>
	
</style>




<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
   <script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<title>동영상 강의</title>
</head>
<body>
		<div class="container-fluid bg-dark text-light" style=" font-size: 22px;"  >
				<header>
				<span>
					<a href="getLecture.do?lectureNo=${lecture.lectureNo}"  class="text-light" style=" font-size: 26px;  padding: 0px 14px; ">강의 대시보드</a>&nbsp;&nbsp;&nbsp;
					섹션 ${classdetail.sectionNo} . ${classdetail.className}
					</span>
				</header>	
		</div>
		
		<div class="container-fluid">
		
<!-- 		<video width="100%" height="960px" controls>

    <source src="https://www.inflearn.com/course/java-to-kotlin/unit/110611" type="video/ogg">
    <source src="/examples/media/sample_video_mp4.mp4" type="video/mp4">
    브라우저가 video 태그를 지원하지 않을 때 화면에 표시됩니다!
</video> -->

 <video width="100%" height="960px" muted controls style= "object-fit: fill">
      <source src="${pageContext.request.contextPath}/filepath/${classdetail.videoname}" type="video/mp4"> <!-- 파일이름 사용하면 됨-->
     Your browser does not support the video tag.
    </video>

	
		</div>
		
			<div class="container-fluid row justify-content-center align-items-center text-light"  style="background-color: #171717B0;">
	<footer>
	<span>
		<c:if test="${classdetail.classNo - 1 < min}">
			<button class="btn btn-default text-light" style="font-size: 26px;margin: 0 auto; " onclick="location.href='preview.do?classNo=${classdetail.classNo - 1}'" disabled>이전 수업</button>
		</c:if>
		<c:if test="${classdetail.classNo - 1 >= min}">
			<button class="btn btn-default text-light" style="font-size: 26px;margin: 0 auto; " onclick="location.href='preview.do?classNo=${classdetail.classNo - 1}'" >이전 수업</button>
		</c:if>
	</span>&nbsp;&nbsp;
		
		<span><i class="fa fa-lock" style="font-size:24px"></i></span>&nbsp;&nbsp;
		<span>
		<c:if test="${classdetail.classNo + 1 > max}">
			<button class="btn btn-default text-light" style="font-size: 26px;margin: 0 auto; " onclick="location.href='preview.do?classNo=${classdetail.classNo + 1}'" disabled>다음 수업</button>
		</c:if>
		<c:if test="${classdetail.classNo + 1 <= max}">
			<button class="btn btn-default text-light" style="font-size: 26px;margin: 0 auto; " onclick="location.href='preview.do?classNo=${classdetail.classNo + 1}'" >다음 수업</button>
		</c:if>
	</span>
	</footer>
	</div>
</body>
</html>