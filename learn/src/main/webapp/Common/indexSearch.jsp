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
<script src="https://kit.fontawesome.com/80bed6a544.js" crossorigin="anonymous"></script>
<style>
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
	
	.card:hover .info {
	  opacity: 1;
	}
	
	.star_rating {font-size:0; letter-spacing:-4px;}
	.star_rating a {
	    font-size:22px;
	    letter-spacing:0;
	    display:inline-block;
	    margin-left:5px;
	    color:#ccc;
	    text-decoration:none;
	}
	.star_rating a:first-child {margin-left:0;}
	.star_rating a.on {color:#777;}
</style>
</head>
<%@include file ="/Common/header.jsp" %>
<br>
<div class="container mt-5 pb-3d-flex" id="dispBody">
	<div class="row w-100 my-3 pb-4">
		<div class="col-2 w-100 mx-auto">	
		
			<!-- 사이드 바 영역 -->
			<div class="mx-auto w-100">
				<nav class="w-100">
				  <ul class="navbar-nav sidebar-nav comNav border rounded">
					    <li class="nav-item d-flex justify-content-center p-2 w-100">
					    	<button class="btn btn-link" onclick="location.href='${pageContext.request.contextPath}/common/getIndexSearch.do?searchKeyword=${searchKeyword}'" style="color: black;">전체</button>
					    </li>
					    <li class="nav-item d-flex justify-content-center p-2 border-top">
							<button class="btn btn-link" onclick="location.href='${pageContext.request.contextPath}/common/getIndexSearch_on.do?searchKeyword=${searchKeyword}'" style="color: black;">온라인</button>
					    </li>
					    <li class="nav-item d-flex justify-content-center p-2 border-top">
							<button class="btn btn-link" onclick="location.href='${pageContext.request.contextPath}/common/getIndexSearch_off.do?searchKeyword=${searchKeyword}'" style="color: black;">오프라인</button>
					    </li>
				  </ul>
				</nav>
			</div>
		</div>
		<div class="col-10 justify-content-center" id="dispBody2">
			<div class="w-100 row">
				<div class="col-10">
				<c:if test="${result eq 'all' }">
					<h4>전체</h4>						
				</c:if>
				<c:if test="${result eq 'on' }">
					<h4>온라인</h4>						
				</c:if>
				<c:if test="${result eq 'off' }">
					<h4>오프라인</h4>						
				</c:if>
				</div>
			</div>
			<hr>
			
			<div class="w-100" id="dispBody">
				<div id="lecturesDefault" class="row"> 
					<c:choose>
						<c:when test="${not empty list }">
							<c:forEach var="lecture" items="${list }">
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
											<c:forEach var="num" begin="1" end="${lecture.lectureRate }" step="1"> 
												<i class="fa-solid fa-star" style="color: #fada5e;"></i>
											</c:forEach>
											<c:forEach var="num" begin="1" end="${5 - lecture.lectureRate }" step="1">
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
														<fmt:formatNumber type="number" maxFractionDigits="3" value="${lecture.salePrice }" />
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
						<c:otherwise></c:otherwise>
					</c:choose>
				</div> 
				<div id="pagingArea">
					<%@include file="/Lecture/paging.jspf" %>
				</div>		
			</div>
		</div>
	</div>
</div>

<%@include file ="/Common/footer.jsp"%>
</html>