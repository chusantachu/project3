<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아웃풋런 - 미래의 동료들과 함께</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/Common/css/slide.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/Common/css/index.css" />
<script src="https://kit.fontawesome.com/80bed6a544.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
	<script src='https://cdn.jsdelivr.net/npm/sweetalert2@10'></script>
	<script>
		$().ready(function () {
			if(${not empty loginError}) {
				Swal.fire({
					icon: 'error',
					title: '로그인 실패',
					text: '아이디와 비밀번호를 확인해주세요'
				});
			}
		});
	</script>
</head>
<%@include file ="/Common/header.jsp" %>
<br><br>
<!-- <a href="getLecture.do?lectureNo=10">오프라인</a><br>
<a href="getLecture.do?lectureNo=3">온라인</a> -->

<%-- 배너부분 --%>
<div class="slide slide_wrap">
	<div class="slide_item item1">
		<div class="inner" style="color: white;">
			<h2>무슨 강의 들을지 고민이라면?<br>현직자 Top50 강의 보기👑</h2><br>
			<p>입문부터 실전까지,<br>믿고 보는 실무자 Pick!</p>
		</div>
		<img src="${pageContext.request.contextPath}/picture/images/1.webp">
	</div>
	<div class="slide_item item2">
		<div class="inner" style="color: white;">
			<h2>누구나 쉬운 입문 강의<br>여기 다 모였다!🐣</h2><br>
			<p>어디서부터 시작해야 할지 모르는<br> 당신을 위한 입문 강의</p>
		</div>
		<img src="${pageContext.request.contextPath}/picture/images/4.webp">
	</div>
	<div class="slide_item item3">
		<div class="inner" style="color: white;">
			<h2>바쁘다 바빠 현대사회!<br>딱 3시간만 투자하세요⏰</h2><br>
			<p>부담은 적게 성장은 빠르게!<br>오늘부터 나도 프로 완강러</p>
		</div>
		<img src="${pageContext.request.contextPath}/picture/images/3.webp">
	</div>
	<div class="slide_item item4">
		<div class="inner">
			<h2>IT 왕초보부터 실무까지<br>아웃풋런 로드맵📖</h2><br>
			<p>코딩, 디자인, 게임, 마케팅.. 모든 IT 실무지식!<br>
			프로로 가는 최고의 길잡이가 되어드릴게요🔥</p>
		</div>
		<img src="${pageContext.request.contextPath}/picture/images/2.gif">
	</div>
	<div class="slide_item item5">
		<div class="inner" style="color: white;">
			<br><h2>나만 몰랐었던 이 강의~♬</h2><br>
			<p>매일 업데이트 되는<br> 인프런 신규강의를 만나보세요!</p>
		</div>
		<img src="${pageContext.request.contextPath}/picture/images/5.gif">
	</div>
	<div class="slide_item item6">
		<div class="inner" style="color: white;">
			<h2>강의 고르기 어려울 땐<br>램프 요정아 도와줘!✨</h2><br>
			<p>클릭 5번으로 찾아보는 맞춤 입문 강의</p>
		</div>
		<img src="${pageContext.request.contextPath}/picture/images/6.png">
	</div>
	<div class="slide_item item7">
		<div class="inner">
			<h2>지금 할인 중인 강의💰</h2><br>
			<p>신규 강의부터 베스트셀러까지<br>지금 바로 부담없이 시작해보세요!</p>
		</div>
		<img src="${pageContext.request.contextPath}/picture/images/7.gif">
	</div>
	<div class="slide_item item8">
		<div class="inner" style="color: white;">
			<h2>나누는 지식만큼<br> 커지는 보람과 보상</h2><br>
			<p>인프런 지식공유자로<br>높은 수익과 가치를 만들어보세요.</p>
		</div>
		<img src="${pageContext.request.contextPath}/picture/images/8.gif">
	</div>
	<div class="slide_item item9">
		<div class="inner" style="color: white;">
			<h2>우리는 성장기회의<br>평등을 추구합니다.</h2><br>
			<p>누구나 배움의 기회를 누리고 꿈을 이룰 수 있도록!<br>인프런과 함께 배우고, 나누고, 성장하세요.</p>
		</div>
		<img src="${pageContext.request.contextPath}/picture/images/9.png">
	</div>
	<div class="slide_item item10">
		<div class="inner" style="color: white;">
			<h2>함께 성장할<br>동료를 찾아요🌿</h2><br>
			<p>#우리 #함께성장해요<br>#동료여어디계신가요?</p>
		</div>
		<img src="${pageContext.request.contextPath}/picture/images/10.gif">
	</div>
	<div class="slide_prev_button slide_button">◀</div>
	<div class="slide_next_button slide_button">▶</div>
	<ul class="slide_pagination"></ul>
	<script src="${pageContext.request.contextPath}/Common/js/slide.js"></script>
	</div>
<br><br><br>

<%-- 검색기능 --%>
<div class="outer">
	<div class="inner2">
		<p style="font-size: 25px;">배우고, 나누고, 성장하세요</p>
		<form action="${pageContext.request.contextPath}/common/getIndexSearch.do">
			<div class="search">
				<input class="searchInput" type="text" placeholder="  배우고 싶은 지식을 입력해보세요." name="searchKeyword">
				<button class="searchButton" type="submit"><img src="${pageContext.request.contextPath}/picture/images/search.png"></button>
			</div>
		</form>
	</div>
</div>
<br><br><br><br>

<%-- 강의바로가기 --%>
<div class="w-100" style="text-align: center;">
	<div id="lecturesDefault" class="row" style="display: inline-block; width: 1100px;"> 
		<div class="classWrite" style="padding-left: 12px;">
			<h4 style="text-align: left; font-weight: bold;">왕초보도 할 수 있어요💪</h4>
			<p style="color: #A2A2A2; text-align: left;">이미 검증된 쉽고 친절한 입문 강의!!</p>
		</div>	
		<c:choose>
			<c:when test="${not empty starterLectureList }">
				<c:forEach var="lecture" items="${starterLectureList }">
				<div class="col-4 card course course_card_item border-0 mb-5" style="height:400px; width: 260px; float: left; text-align: left;">
					<div class="card h-100 border-0" style="float: left;">
					  	<div class="card-image h-50">
							<img class="card-img-top" src="${lecture.lectureCoverimg }" width="100%" alt="${lecture.lectureTitle }">
					  	</div>
					  	<div class="card-body w-100 overflow-hidden">
						    <p class="card-title font-weight-bold" style="height:50px;">${lecture.lectureTitle }</a></p>
						    <br>								
							<span class="card-user font-weight-bold">${lecture.lectureWriter }</span>
							<br>
							<span>
								<c:forEach var="num" begin="1" end="${Math.round(lecture.lectureRate) }" step="1"> 
									<i class="fa-solid fa-star" style="color: #fada5e;"></i>
								</c:forEach>
								<c:forEach var="num" begin="1" end="${5 - Math.round(lecture.lectureRate) }" step="1">
									<i class="fa-regular fa-star" style="color: #fada5e;"></i>											
								</c:forEach>
								(${lecture.reviewCount })
							</span>
							<c:choose>
							<c:when test="${lecture.lecturePrice != lecture.salePrice}">
								<p class="card-price">	
									<del class="text-secondary">&#8361; 
										<fmt:formatNumber type="number" maxFractionDigits="3" value="${lecture.lecturePrice }" />
									</del>
									<span class="text-primary font-weight-bold h5">&#8361;
										<fmt:formatNumber type="number" maxFractionDigits="3" value="${Math.round(lecture.salePrice) }" />
									</span>
								</p>
							</c:when>
							<c:otherwise>
								<p class="card-price">
									<span class="font-weight-bold h5">&#8361;
										<fmt:formatNumber type="number" maxFractionDigits="3" value="${lecture.lecturePrice }" />		
									</span>
								</p>										
							</c:otherwise>
							</c:choose>
					      	<a href="${pageContext.request.contextPath}/Common/getLecture.do?lectureNo=${lecture.lectureNo }" class="stretched-link"></a>
					  		<span class="badge badge-success">+${lecture.studentCount }명</span>
					  	</div>
					    <div class="info">
						     <div class="w-100 h-75 overflow-hidden">
							      <p class="font-weight-bold">${lecture.lectureTitle }</p>
									<c:choose>
										<c:when test="${fn:length(lecture.lectureSummary) gt 100}">
											<p>${fn:substring(lecture.lectureSummary, 0, 100)}...</p>
										</c:when>
										<c:otherwise>
											<p>${lecture.lectureSummary }</p>
										</c:otherwise>
									</c:choose>
						     </div>
						     <div class="position-absolute bottom-0 w-100 h-15">
							      <p class="text-info font-weight-bold">${lecture.lectureLevel }</p>
							      <p class="text-info font-weight-bold">${lecture.categoryName }</p>
						     </div>
					    </div>
					</div>
				</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				데이터가 없습니다.
			</c:otherwise>
		</c:choose>
	</div> 
</div>
<br><br>


<div class="w-100" style="text-align: center;">
	<div id="lecturesDefault" class="row" style="display: inline-block; width: 1100px;"> 
		<div class="classWrite" style="padding-left: 12px;">
			<h4 style="text-align: left; font-weight: bold;">무료강의? 오히려 좋아 🎁</h4>
			<p style="color: #A2A2A2; text-align: left;">무료 강의부터 가볍게 시작해 보세요.</p>
		</div>	
		<c:choose>
			<c:when test="${not empty freeLectureList }">
				<c:forEach var="lecture" items="${freeLectureList }">
				<div class="col-4 card course course_card_item border-0 mb-5" style="height:400px; width: 260px; float: left; text-align: left;">
					<div class="card h-100 border-0" style="float: left;">
					  	<div class="card-image h-50">
							<img class="card-img-top" src="${lecture.lectureCoverimg }" width="100%" height="100%" alt="${lecture.lectureTitle }">
					  	</div>
					  	<div class="card-body w-100 overflow-hidden">
						    <p class="card-title font-weight-bold" style="height:50px;">${lecture.lectureTitle }</a></p>
						    <br>								
							<span class="card-user font-weight-bold">${lecture.lectureWriter }</span>
							<br>
							<span>
								<c:forEach var="num" begin="1" end="${Math.round(lecture.lectureRate) }" step="1"> 
									<i class="fa-solid fa-star" style="color: #fada5e;"></i>
								</c:forEach>
								<c:forEach var="num" begin="1" end="${5 - Math.round(lecture.lectureRate) }" step="1">
									<i class="fa-regular fa-star" style="color: #fada5e;"></i>											
								</c:forEach>
								(${lecture.reviewCount })
							</span>
							<c:choose>
							<c:when test="${lecture.lecturePrice != lecture.salePrice}">
								<p class="card-price">	
									<del class="text-secondary">&#8361; 
										<fmt:formatNumber type="number" maxFractionDigits="3" value="${lecture.lecturePrice }" />
									</del>
									<span class="text-primary font-weight-bold h5">&#8361;
										<fmt:formatNumber type="number" maxFractionDigits="3" value="${Math.round(lecture.salePrice) }" />
									</span>
								</p>
							</c:when>
							<c:otherwise>
								<p class="card-price">
									<span class="font-weight-bold h5">&#8361;
										<fmt:formatNumber type="number" maxFractionDigits="3" value="${lecture.lecturePrice }" />		
									</span>
								</p>										
							</c:otherwise>
							</c:choose>
					      	<a href="${pageContext.request.contextPath}/Common/getLecture.do?lectureNo=${lecture.lectureNo }" class="stretched-link"></a>
					  		<span class="badge badge-success">+${lecture.studentCount }명</span>
					  	</div>
					    <div class="info">
						     <div class="w-100 h-75 overflow-hidden">
							      <p class="font-weight-bold">${lecture.lectureTitle }</p>
									<c:choose>
										<c:when test="${fn:length(lecture.lectureContent) gt 100}">
											<p>${fn:substring(lecture.lectureContent, 0, 100)}...</p>
										</c:when>
										<c:otherwise>
											<p>${lecture.lectureContent }</p>
										</c:otherwise>
									</c:choose>
						     </div>
						     <div class="position-absolute bottom-0 w-100 h-15">
							      <p class="text-info font-weight-bold">${lecture.lectureLevel }</p>
							      <p class="text-info font-weight-bold">${lecture.categoryName }</p>
						     </div>
					    </div>
					</div>
				</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				데이터가 없습니다.
			</c:otherwise>
		</c:choose>
	</div> 
</div>
<br><br>




<%-- 로드맵 바로가기 --%>
<div class="outer">
	<div class="inner8" style="padding-left: 12px;">
		<div class="roadMapWrite">
			<h4 style="text-align: left; font-weight: bold;">기본부터 실무까지 제시해주는 로드맵🏃‍♀️</h4>
			<p style="color: #A2A2A2; text-align: left;">아무것도 몰라도 따라오다 보면 전문가가 될 수 있어요!</p>
		</div>
		<div class="roadMapAll">
			<c:if test="${not empty indexRoadMapList }">
				<c:forEach var="list" items="${indexRoadMapList }">
					<a href="${pageContext.request.contextPath}/roadmap/roadmapDetail.do?rboardNo=${list.rboardNo}">
						<div class="roadMap">
						 	<div class="roadMapPicture">
								<img src="${list.rboardCoverimg }">
						 	</div>
						 	<div class="roadMapExplain" style="font-weight: bold;">
						 		${list.rboardTitle }
						 	</div>
						</div>
					</a>
					<div class="jump2"></div> <%-- 사이띄우는 용도 --%>
				</c:forEach>
			</c:if>
		</div>
	</div>
</div>

<%-- 리뷰 바로가기 --%>
<div class="outer">
	<div class="inner6">
		<div class="reviewWrite">
			<h1><span style="color: #00C471;">999,421</span> 명이<br>
			아웃풋런과 함께합니다.</h1>
			<br>
			<p style="color: #A2A2A2;">학교에서 배우기 어렵거나 큰 비용을<br>
			지불해야만 배울 수 있는 전문적인 지식들을 제공합니다.<br>
			오픈 플랫폼의 이점을 통해 다양성과 경제성을 모두 높입니다.</p>
		</div>
		<div class="review">
		<c:if test="${not empty indexReviewList }">
			<c:forEach var="list" items="${indexReviewList }">
				<div class="reviewGo">
					<span style="color: #A2A2A2; font-size: 12px;">${list.userName }</span>
					<div style="height: 13px;"> </div>
					<%-- 강의 상세페이지 바로가기 연결 --%>
					<a href="${pageContext.request.contextPath}/Common/getLecture.do?lectureNo=${list.lectureNo }">${list.lectureTitle } </a>
					<br>
					${list.boardContent }
				</div>
				<br>
			</c:forEach>
		</c:if>
		</div>
	</div>
</div>
<br><br><br><br>

<%-- 지식공유바로가기--%>
<div class="outer">
	<div class="inner3">
		<div class="lectureWrite">
			지식을 나눠주세요.<br>쉽게 시작하고 합방한 보상을 받을 수 있어요.
			<br><br>
			<button class="lectureButton" type="button" onclick='location.href="${pageContext.request.contextPath}/Member/Belecture/beLecture.jsp"'>지식공유 알아보기</button>
		</div>
		<div class="lecturer">
			<img src="${pageContext.request.contextPath}/picture/images/lecturer.png">
		</div>
	</div>
</div>
<br><br><br>

<%-- 기업소개 --%>
<div class="outer">
	<div class="inner4">
		<p style="font-weight: bold; font-size: 1.2em;">이미 많은 기업 구성원들이 아웃풋런에서 성장하고 있어요.</p>
		<img src="${pageContext.request.contextPath}/picture/images/company.png">
	</div>
</div>
<br><br><br>

<%-- 서비스 안내 --%>
<div class="outer">
	<div class="inner5">
		<div class="serviceWrite">
			<br><br>
			<h4 style="font-weight: bold;">다양한 서비스를 이용하세요.</h4>
			<span style="color: #A2A2A2;">아웃풋런의 지식공유자 / 묻고 답하기 / 자유게시판 이용방법에 대해 알아보세요.</span>
		</div>
		<br><br>
		<div class="serviceAll">
			<div class="service">
				<p style="font-weight: bold; font-size: 1.2em; ">지식공유자 되기</p>
				<span>9개월간 온라인 기술 강의로만 1억원!<br>나의 지식을 나눠 사람들에게 배움의 기회를 주고, 의미있는 대가를 가져가세요.</span>
				<br><br><br><br>
				<button class="serviceButton" type="button" onclick='location.href="${pageContext.request.contextPath}/Member/Belecture/beLecture.jsp"'><span style="font-weight: bold;">지식공유자 참여하기 →</span></button>
			</div>
			<div class="jump"></div> <%-- 사이띄우는 용도 --%>
			<div class="service">
				<p style="font-weight: bold; font-size: 1.2em; ">묻고 답하기</p>
				<span>99만명의 커뮤니티를 통해 <br>함께 토론하여 궁금증을 해결해봐요.</span>
				<br><br><br><br><br>
				<button class="serviceButton" type="button" onclick='location.href="${pageContext.request.contextPath}/board/getQnaBoardList.do?section=qboard"'><span style="font-weight: bold;">묻고답하기 이용하기 →</span></button>
			</div>
			<div class="jump"></div> <%-- 사이띄우는 용도 --%>
			<div class="service">
				<p style="font-weight: bold; font-size: 1.2em; ">자유게시판 이용하기</p>
				<span>회원들간의 소통을 위한 자유게시판을 통해<br>다양한 이야기를 나눠봐요.</span>
				<br><br><br><br><br>
				<button class="serviceButton" type="button" onclick='location.href="${pageContext.request.contextPath}/board/getQnaBoardList.do?section=fboard"'><span style="font-weight: bold;">자유게시판 이용하기 →</span></button>
			</div>
		</div>
	</div>
</div>

<%@include file ="/Common/footer.jsp"%>

</html>