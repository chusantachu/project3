<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
</style>
<script>
	$(function(){
		
		$(document).on("click", ".page-link", function () {
			ajaxProcess ("${pageContext.request.contextPath }/roadmap/getRoadmapsFiltering.do", $(this).attr('value'));
	 
		});
		
		$(document).on("change", "#filter", function () {
			ajaxProcess ("${pageContext.request.contextPath }/roadmap/getRoadmapsFiltering.do", $("#nowPage").text());
		});

		$(document).on("click", "#search-button", function () {
			ajaxProcess ("${pageContext.request.contextPath }/roadmap/getRoadmapsFiltering.do", $("#nowPage").text());

		});
	});
	
	function ajaxProcess (url, page) {
		
		var find = {};
		
		find.searchKeyword = $.trim($("#searchRoadmap").val());
		find.searchFilter = $("#selectRoadmap").val();
		find.orderKeyword =  $("#filter").val();
		find.categoryName = "${categoryName }";
		find.page = page;
		
		console.log(JSON.stringify(find));

		$.ajax(url, {
			
	        type : "post",
	        data : JSON.stringify(find),
	        contentType : "application/json",
	        dataType: "json",
	        success : function(data){
	            
	        	//alert("성공");
	        	//alert(data.p.nowPage); //nowPage는 안 바뀜
	            
	            var dispHTML = "";
			
	            if (data.list.length == 0) {
					$("#roadmapDefault").html("데이터가 없습니다.");
					$("#pagingArea").html("");
	            } else {
	            	
	            	$.each(data.list, function(index, obj){
			            console.log(obj);
			            dispHTML += '';
			            dispHTML += '<div class="col-4 card course course_card_item border-0 mb-5" style="height:350px;">';
			            dispHTML += '<div class="card h-100 border-0">';
			            dispHTML += '<div class="card-image h-50">';
			            dispHTML += '<img class="card-img-top" src="${pageContext.request.contextPath}/filepath/'+this.rboardCoverimg+'" width="100%" alt="'+this.rboardTitle+'">';
			            dispHTML += '</div>';
			            dispHTML += '<div class="card-body w-100 overflow-hidden">';
			            dispHTML += '<p class="card-title font-weight-bold" style="height:50px;">'+this.rboardTitle+'</a></p>';
			            dispHTML += '<span class="card-user font-weight-bold">'+this.userName+'</span>';
			            dispHTML += '<a href="${pageContext.request.contextPath}/roadmap/roadmapDetail.do?rboardNo='+this.rboardNo+'" class="stretched-link"></a>';
			            dispHTML += '<p>';
			     
			            dispHTML += '<span class="badge badge-success">'+this.userCount+'명</span> ';
			            dispHTML += '<span class="badge badge-success">'+this.lectureCount+'개 강의</span>';
			            dispHTML += '</p>';
			            dispHTML += '</div>';
			            dispHTML += '</div>';
			            dispHTML += '</div>';
			           
           			});
	            	
	            	$("#roadmapDefault").html(dispHTML);
	            	
		            var p = data.p;
		            var dispPage = '';
		           			            
		            dispPage += '<nav aria-label="Page navigation">';
		            dispPage += '<ul class="pagination justify-content-center">';
		            
					if (p.beginPage == 1) {
			            dispPage += '<li class="page-item disabled">';
			            dispPage += '<a class="page-link" href="#">《</a>';
			            dispPage += '</li>';	
			            
			            dispPage += '<li class="page-item disabled">';
			            dispPage += '<a class="page-link disabled" href="#">〈</a>';
			            dispPage += '</li>';	
					} else {
			            dispPage += '<li class="page-item">';
			            dispPage += '<a class="page-link" value="1">《</a>';
			            dispPage += '</li>';	
			            
			            dispPage += '<li class="page-item">';
			            dispPage += '<a class="page-link" value="'+(p.beginPage-1)+'">';
			            dispPage += '〈';
			            dispPage += '</a>';
			            dispPage += '</li>';
					}

				
					for (let i = p.beginPage; i <= p.endPage ; i++ ) {
						if (i == p.nowPage) {
				            dispPage += '<li class="page-item disabled">';
				            dispPage += '<a id="nowPage" class="page-link" href="#">'+i+'</a>';
				            dispPage += '</li>';
						} else {
				            dispPage += '<li class="page-item">';
				            dispPage += '<a class="page-link" value="'+i+'">'+i+'</a>';
				            dispPage += '</li>';
						}
					}
					
					if (p.endPage >= p.totalPage) {
			            dispPage += '<li class="page-item disabled">';
			            dispPage += '<a class="page-link" href="#">〉</a>';
			            dispPage += '</li>';
			            
			            dispPage += '<li class="page-item disabled">';
			            dispPage += '<a class="page-link" href="#">》</a>';
			            dispPage += '</li>';
					} else {
			            dispPage += '<li class="page-item">';
			            dispPage += '<a class="page-link" value="'+(p.endPage+1)+'">〉</a>';
			            dispPage += '</li>';
			            
			            dispPage += '<li class="page-item">';
			            dispPage += '<a class="page-link" value="'+p.totalPage+'">';
			            dispPage += '》</a>';
			            dispPage += '</li>';
					}
					

		            dispPage += '</ul>';
		            dispPage += '</nav>';
		
		            $("#pagingArea").html(dispPage);
	            }
	        },
	        error: function(){
	            alert("실패");
	        }
	   });

	}
</script>
</head>
<body>
<%@include file="/Common/header.jsp" %>
<div class="container-fluid text-center mx-auto mt-5 pb-3">
	<h3>시작부터 실전까지. 로드맵</h3>
	<div class="row w-50 mx-auto">
		<div class="col-8 input-group mx-auto">
			<select id="selectRoadmap" name="selectfilter" class="form-control w-10 text-left">
				<option value="title" selected="selected">제목</option>
				<option val
				ue="content">본문</option>
				<option value="user">작성자</option>
			</select>
			<input type="search" id="searchRoadmap" placeholder="학습 관련 스킬/로드맵 이름/강사명 검색하기" value=""
					class="w-50 form-control">
			<button id="search-button" type="button" class="btn btn-success ">
			    <i class="fas fa-search"></i>
			</button>
		</div>
	</div>
</div>
<div class="container mt-5 pb-3 d-flex">
	<div class="row w-100 pb-4">
		<div class="col-2 w-100 mx-auto">	
			<div class="w-100 mx-auto form-group">
				<select id="filter"  name="filter" class="form-control w-100">
					<option value="student" selected="selected">학생수순</option>
					<option value="new" selected>최신순</option>
					<option value="old">오래된순</option>
				</select>	
			</div>
			<!-- 사이드 바 영역 -->
			<div class="mx-auto w-100">
				<nav class="w-100">
				  <ul class="navbar-nav sidebar-nav comNav border rounded">
					    <li class="nav-item d-flex justify-content-center p-2 w-100">
					      <a href="${pageContext.request.contextPath}/roadmap/getRoadmapList.do?categoryNo=" class="text-dark">전체</a>
					    </li>
				  	<c:forEach var="category" items="${categories}">
					    <li class="nav-item d-flex justify-content-center p-2 border-top">
					      <a href="${pageContext.request.contextPath}/roadmap/getRoadmapList.do?categoryNo=${category.categoryNo }" class="text-dark">${category.categoryName }</a>
					    </li>
					</c:forEach>
				  </ul>
				</nav>
			</div>
		</div>
		<div class="col-10 justify-content-center">
				<div id="roadmapDefault" class="row"> <!-- 로드맵 출력 div 시작 -->		
					<c:choose>
						<c:when test="${not empty roadmaps }">
							<c:forEach var="roadmap" items="${roadmaps }">
							<div class="col-4 card course course_card_item border-0 mb-5" style="height:350px;">
								<div class="card h-100 border-0">
								  	<div class="card-image h-50">
										<img class="card-img-top" src="${pageContext.request.contextPath}/filepath/${roadmap.rboardCoverimg }" width="100%" alt="${roadmap.rboardTitle }">
								  	</div>
								  	<div class="card-body w-100 overflow-hidden">
									    <p class="card-title font-weight-bold" style="height:50px;">${roadmap.rboardTitle }</a></p>								
										<span class="card-user font-weight-bold">${roadmap.userName }</span>
								      	<a href="${pageContext.request.contextPath}/roadmap/roadmapDetail.do?rboardNo=${roadmap.rboardNo }" class="stretched-link"></a>
								  		<p>
								  			<span class="badge badge-success">+${roadmap.userCount }명</span>
								  			<span class="badge badge-success">${roadmap.lectureCount }개 강의</span>
								  		</p>
								  	</div>
								</div>
							</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							데이터가 없습니다.
						</c:otherwise>
					</c:choose>
				</div> <!-- 로드맵 출력 div 끝 -->
			<div id="pagingArea">
			 	<%@include file="/Lecture/paging.jspf" %>
			</div>	
		</div>
	</div>
</div>


<%@include file="/Common/footer.jsp" %>
</body>
</html>