<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 조회 - 강의페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/80bed6a544.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<script>
	function chageSelect(userId){
		var userId = userId;
		console.log("userId : " + userId);
		
		var select = document.getElementById("filter");  
		console.log(select);
		  
		var selectValue = filter.options[filter.selectedIndex].value;  
		console.log("selectValue : " + selectValue);
		
		var selectText = filter.options[filter.selectedIndex].text;  
		console.log("selectText : " + selectText);
		
		if (selectValue == 'new') {
			location.href="${pageContext.request.contextPath}/member/goToPersonalPage_Lecture.do?userId=" + userId;
		} else if (selectValue == 'old') {
			location.href="${pageContext.request.contextPath}/member/goToPersonalPage_Lecture_old.do?userId=" + userId;
		} 
	}  
</script>

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
	
	.card .info {
	color: #fff;
	position: absolute; left: 0; bottom: 0;
	background: rgba(0,0,0,0.8);
	width: 100%;
	height: 100%;
	padding: 15px;
	opacity: 0;
	transition: opacity 0.35s ease-in-out;
	}
	.card:hover .info {opacity: 1;}
	
	/* 페이징처리 css */
	.page_wrap {
		text-align:center;
		font-size:0;
	 }
	.page_nation {
		display:inline-block;
	}
	.page_nation .none {
		display:none;
	}
	.page_nation a {
		display:block;
		margin:0 3px;
		float:left;
		border:1px solid #e6e6e6;
		width:28px;
		height:28px;
		line-height:28px;
		text-align:center;
		background-color:#fff;
		font-size:13px;
		color:#999999;
		text-decoration:none;
	}
	.page_nation .arrow {
		border:1px solid #ccc;
	}
	.page_nation .prev {
		background:#f8f8f8 url('img/page_prev.png') no-repeat center center;
		margin-right:7px;
	}
	.page_nation .next {
		background:#f8f8f8 url('img/page_next.png') no-repeat center center;
		margin-left:7px;
	}
	.page_nation a.active {
		background-color : #00C471;
		color:white;
		border:1px solid #00C471;
	}
	
</style>
<script>

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
					<div class="d-flex justify-content-between">
						<div>수강생수 ${studentCnt }</div>
						<div>평점 ${lectureRate }</div>
					</div>
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
    					  <a href="${pageContext.request.contextPath}/member/goToPersonalPage_Lecture.do?userId=${person.userId }" class="text-dark">강의</a>
					    </li>
     					<li class="nav-item d-flex p-2 w-100">
						  <a href="${pageContext.request.contextPath}/member/getGoToPersonalRoadPage.do?userId=${person.userId}" class="text-dark">로드맵</a>
					  	</li>
					    <li class="nav-item d-flex p-2 w-100">
					      <a href="#" class="text-dark">수강후기</a>
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
				<p class="d-flex justify-content-between">
					<c:if test="${not empty lecturesSize}">
						<span class="h4 font-weight-bold ">강의(${lecturesSize })</span>
					</c:if>
					<c:if test="${empty lecturesSize }">
						<span class="h4 font-weight-bold ">강의(0)</span>
					</c:if>
				</p>
				<c:if test="${not empty lecturesSize}">
				<div>
					<div class="col-2 form-group pr-0" style="float: right;">
						<select id="filter" name="filter" class="form-control w-100 float-right pr-0" onchange="chageSelect('${person.userId }')"> 
							<c:if test="${listUp eq 'new'}">
								<option value="new" selected="selected">최신순</option>
								<option value="old">오래된순</option>
							</c:if>
							<c:if test="${listUp eq 'old'}">
								<option value="new">최신순</option>
								<option value="old" selected="selected">오래된순</option>
							</c:if>
						</select>	
					</div>
				</div>
				<br><br><br>
				</c:if>
				
				<div class="w-100">
					<div id="lecturesDefault" class="row"> 	
						<c:choose>
							<c:when test="${not empty lectures }">
								<c:forEach var="lecture" items="${lectures }">
								<div class="col-4 card course course_card_item border-0 mb-5" style="height:400px;">
									<div class="card h-100 border-0">
									  	<div class="card-image h-50">
											<img class="card-img-top" src="${pageContext.request.contextPath}/filepath/${lecture.lectureCoverimg }" width="100%" alt="${lecture.lectureTitle }">
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
									      	<a href="${pageContext.request.contextPath}/Member/getLecture.do?lectureNo=${lecture.lectureNo }" class="stretched-link"></a>
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
			 		<!-- 페이징처리-->
			 		<c:if test="${listUp eq 'new'}">
					<div id="dispBody2">
						<div class="page_wrap">
						   <div class="page_nation">
							<c:if test="${pvo.beginPage != 1}">	
								<a class="arrow prev" href="${pageContext.request.contextPath}/member/goToPersonalPage_Lecture.do?userId=${person.userId }&cPage=${pvo.beginPage - 1 }">&lt</a>
							</c:if>
							
							<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
								<c:if test="${pageNo == pvo.nowPage }">
									<a class="active">${pageNo}</a>
								</c:if>
								<c:if test="${pageNo != pvo.nowPage }">
									<a href="${pageContext.request.contextPath}/member/goToPersonalPage_Lecture.do?userId=${person.userId }&cPage=${pageNo }">${pageNo}</a>
								</c:if>
							</c:forEach>	
							
							<c:if test="${pvo.endPage < pvo.totalPage}">
								<a class="arrow next" href="${pageContext.request.contextPath}/member/goToPersonalPage_Lecture.do?userId=${person.userId }&cPage=${pvo.endPage + 1 }">&gt</a>
							</c:if>
						   </div>
						</div> 		
					</div>
					</c:if>
					
			 		<c:if test="${listUp eq 'old'}">
					<div id="dispBody2">
						<div class="page_wrap">
						   <div class="page_nation">
							<c:if test="${pvo.beginPage != 1}">	
								<a class="arrow prev" href="${pageContext.request.contextPath}/member/goToPersonalPage_Lecture_old.do?userId=${person.userId }&cPage=${pvo.beginPage - 1 }">&lt</a>
							</c:if>
							
							<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
								<c:if test="${pageNo == pvo.nowPage }">
									<a class="active">${pageNo}</a>
								</c:if>
								<c:if test="${pageNo != pvo.nowPage }">
									<a href="${pageContext.request.contextPath}/member/goToPersonalPage_Lecture_old.do?userId=${person.userId }&cPage=${pageNo }">${pageNo}</a>
								</c:if>
							</c:forEach>	
							
							<c:if test="${pvo.endPage < pvo.totalPage}">
								<a class="arrow next" href="${pageContext.request.contextPath}/member/goToPersonalPage_Lecture_old.do?userId=${person.userId }&cPage=${pvo.endPage + 1 }">&gt</a>
							</c:if>
						   </div>
						</div> 		
					</div>
					</c:if>
					
				</div>		
			</div>
		</div>
	</div>
</div>
<%@include file="/Common/footer.jsp" %>
</body>
</html>