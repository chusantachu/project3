<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
  <title>관리자 페이지</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script src="https://kit.fontawesome.com/80bed6a544.js" crossorigin="anonymous"></script>
  <style>
  .fakeimg {
    height: 200px;
    background: #aaa;
  }
  </style>
  <script>
	
	$(function(){
	  // Load Charts and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Draw the pie chart for Sarah's pizza when Charts is loaded.
      google.charts.setOnLoadCallback(drawChart);

      // Callback that draws the pie chart for Anthony's pizza.
		function drawChart() {	    	  
	  		
			var jsonData = $.ajax("${pageContext.request.contextPath }/admin/getInfos.do", {
				type : "post",
				dataType: "json",
				async: false
			}).responseText;
		
			var revenue = JSON.parse(jsonData)[0];
			var joiner = JSON.parse(jsonData)[1];
			
			
			$("#revenueTot").html("총 "+(revenue.thisMonthOnRevenue+revenue.thisMonthOffRevenue).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+" 원");
			$("#joinerTot").html("총 "+(joiner.thisMonthGeneralJoiner+joiner.thisMonthGoogleJoiner+joiner.thisMonthNaverJoiner)+" 명");
	    	 
			
			var dataRevenue = new google.visualization.DataTable();			
			dataRevenue.addColumn('string', 'Title');
			dataRevenue.addColumn('number', 'Revenue');
			
			dataRevenue.addRows([
			  ['온라인', revenue.thisMonthOnRevenue],
			  ['오프라인', revenue.thisMonthOffRevenue],
			]);
			
			var dataJoiner = new google.visualization.DataTable();			
			dataJoiner.addColumn('string', 'Title');
			dataJoiner.addColumn('number', 'Joiner');
			
			dataJoiner.addRows([
			  ['자사', joiner.thisMonthGeneralJoiner],
			  ['네이버', joiner.thisMonthGoogleJoiner],
			  ['구글', joiner.thisMonthNaverJoiner],
			]);
			
			var options = {
			               };
			
			var chartRevenue = new google.visualization.PieChart(document.getElementById('revenueChart'));  
			var chartJoiner = new google.visualization.PieChart(document.getElementById('joinerChart'));  
			
			chartRevenue.draw(dataRevenue, options);
			chartJoiner.draw(dataJoiner, options);

	      }
	  
		let date = new Date();	
		let today = (date.getMonth()+1) + "월 " + date.getDate() + "일";
		let prevDay = date.getFullYear() + "년 " + (date.getMonth()) + "월 " + date.getDate() + "일";
		
		$(".durationForm").html(prevDay+"~"+today);
	});
	
	$(document).on("click", ".pr-link", function(){
	 	var find = {};
	 	find.type = "resume";
	 	find.page = $(this).attr('value');
	 	console.log(JSON.stringify(find));

		$.ajax("${pageContext.request.contextPath }/admin/adminPaginging.do", {
			
	        type : "post",
	        data : JSON.stringify(find),
	        contentType : "application/json",
	        dataType: "json",
	        success : function(data){

	            if (data.list.length == 0) {
					$(".teacherResume").html("데이터가 없습니다.");
	            } else {
	            	
	            	var dispHTML = '';
	            	
	            	dispHTML += '';
					$.each(data.list, function(idx, obj){
						dispHTML += '<p class="h6" onclick="openPopUp(\''+obj.userId+'\')">'+obj.userId+'</p>';
					})
					$(".teacherResume").html(dispHTML);
					
	            	var p = data.p;
			        var dispPage = '';
			       			            
			        dispPage += '<nav aria-label="Page navigation">';
			        dispPage += '<ul class="pagination justify-content-center">';
					if (p.beginPage == 1) {
			            dispPage += '<li class="page-item disabled">';
			            dispPage += '<a class="page-link pr-link" href="#">《</a>';
			            dispPage += '</li>';	
			            
			            dispPage += '<li class="page-item disabled">';
			            dispPage += '<a class="page-link pr-link disabled" href="#">〈</a>';
			            dispPage += '</li>';	
					} else {
			            dispPage += '<li class="page-item">';
			            dispPage += '<a class="page-link pr-link" value="1">《</a>';
			            dispPage += '</li>';	
			            
			            dispPage += '<li class="page-item">';
			            dispPage += '<a class="page-link pr-link" value="'+(p.beginPage-1)+'">';
			            dispPage += '〈';
			            dispPage += '</a>';
			            dispPage += '</li>';
					}
				
					for (let i = p.beginPage; i <= p.endPage ; i++ ) {
						if (i == p.nowPage) {
				            dispPage += '<li class="page-item disabled">';
				            dispPage += '<a id="nowPage" class="page-link pr-link" href="#">'+i+'</a>';
				            dispPage += '</li>';
						} else {
				            dispPage += '<li class="page-item">';
				            dispPage += '<a class="page-link pr-link" value="'+i+'">'+i+'</a>';
				            dispPage += '</li>';
						}
					}
					
					if (p.endPage >= p.totalPage) {
			            dispPage += '<li class="page-item disabled">';
			            dispPage += '<a class="page-link pr-link" href="#">〉</a>';
			            dispPage += '</li>';
			            
			            dispPage += '<li class="page-item disabled">';
			            dispPage += '<a class="page-link pr-link" href="#">》</a>';
			            dispPage += '</li>';
					} else {
			            dispPage += '<li class="page-item">';
			            dispPage += '<a class="page-link pr-link" value="'+(p.endPage+1)+'">〉</a>';
			            dispPage += '</li>';
			            
			            dispPage += '<li class="page-item">';
			            dispPage += '<a class="page-link pr-link" value="'+p.totalPage+'">';
			            dispPage += '》</a>';
			            dispPage += '</li>';
					}
			        dispPage += '</ul>';
			        dispPage += '</nav>';
			        
			        $(".pagingAreaResume").html(dispPage);
	            	
	            }
		    	
		        
	        },
	        error: function(){
	            alert("실패");
	        }
	   });
		

	});
  
	$(document).on("click", ".pc-link", function(){
		
	 	var find = {};
	 	find.type = "callcanter";
	 	find.page = $(this).attr('value');
	 	console.log(JSON.stringify(find));

		$.ajax("${pageContext.request.contextPath }/admin/adminPaginging.do", {
			
	        type : "post",
	        data : JSON.stringify(find),
	        contentType : "application/json",
	        dataType: "json",
	        success : function(data){

	            var dispHTML = "";
	
	            if (data.list.length == 0) {
					$(".callcenter").html("데이터가 없습니다.");
	            } else {
	            	
	            	var dispHTML = '';
	            	
	            	dispHTML += '';
					$.each(data.list, function(idx, obj){
						dispHTML += '<p class="h6" onclick="location.href=\'${pageContext.request.contextPath}/memberBoard/viewPage.do?qnaNo='+obj.qnaNo+'\';">'+obj.qnaTitle+'</p>';
					})
					$(".callcenter").html(dispHTML);
					
	            	console.log(data.list);
	            	
	            	var p = data.p;
	                var dispPage = '';
	               			            
	                dispPage += '<nav aria-label="Page navigation">';
	                dispPage += '<ul class="pagination justify-content-center">';
	        		if (p.beginPage == 1) {
	                    dispPage += '<li class="page-item disabled">';
	                    dispPage += '<a class="page-link pc-link" href="#">《</a>';
	                    dispPage += '</li>';	
	                    
	                    dispPage += '<li class="page-item disabled">';
	                    dispPage += '<a class="page-link pc-link disabled" href="#">〈</a>';
	                    dispPage += '</li>';	
	        		} else {
	                    dispPage += '<li class="page-item">';
	                    dispPage += '<a class="page-link pc-link" value="1">《</a>';
	                    dispPage += '</li>';	
	                    
	                    dispPage += '<li class="page-item">';
	                    dispPage += '<a class="page-link pc-link" value="'+(p.beginPage-1)+'">';
	                    dispPage += '〈';
	                    dispPage += '</a>';
	                    dispPage += '</li>';
	        		}
	        	
	        		for (let i = p.beginPage; i <= p.endPage ; i++ ) {
	        			if (i == p.nowPage) {
	        	            dispPage += '<li class="page-item disabled">';
	        	            dispPage += '<a id="nowPage" class="page-link pc-link" href="#">'+i+'</a>';
	        	            dispPage += '</li>';
	        			} else {
	        	            dispPage += '<li class="page-item">';
	        	            dispPage += '<a class="page-link pc-link" value="'+i+'">'+i+'</a>';
	        	            dispPage += '</li>';
	        			}
	        		}
	        		
	        		if (p.endPage >= p.totalPage) {
	                    dispPage += '<li class="page-item disabled">';
	                    dispPage += '<a class="page-link pc-link" href="#">〉</a>';
	                    dispPage += '</li>';
	                    
	                    dispPage += '<li class="page-item disabled">';
	                    dispPage += '<a class="page-link pc-link" href="#">》</a>';
	                    dispPage += '</li>';
	        		} else {
	                    dispPage += '<li class="page-item">';
	                    dispPage += '<a class="page-link pc-link" value="'+(p.endPage+1)+'">〉</a>';
	                    dispPage += '</li>';
	                    
	                    dispPage += '<li class="page-item">';
	                    dispPage += '<a class="page-link pc-link" value="'+p.totalPage+'">';
	                    dispPage += '》</a>';
	                    dispPage += '</li>';
	        		}
	                dispPage += '</ul>';
	                dispPage += '</nav>';
	            	
				}
	            
	            
	            $(".pagingAreaCallcenter").html(dispPage);
	            
	        },
	        error: function(){
	            alert("실패");
	        }
	   });
		

	});
	
	function openPopUp(userId) {
		window.open("${pageContext.request.contextPath }/Admin/getResumeDetail.do?userId="+userId, "상세보기", "width=570, height=580, top=150, left=600");
	}
</script>
</head>
<body>
<%@ include file="/Admin/common/adminHeader.jspf" %>
<br><br>
<div class="container">
  <div class="row">
	<div class="col-sm-4" style="height:350px;">
		<p class="d-flex justify-content-between">
			<span class="h3">총 매출</span>
			<span id="revenueTot" class="h3"></span>
		</p>
		<p class="durationForm font-italic h5"></p>
		<div id="revenueChart">
		</div>
	</div>
    <div class="col-sm-4" style="height:350px;">
		<p class="d-flex justify-content-between">
			<span class="h3">총 가입자</span>
			<span id="joinerTot" class="h3"></span>
		</p>
		<p class="durationForm font-italic h5"></p>
		<div id="joinerChart">
		</div>
    </div>
    <div class="col-sm-4" style="height:350px;">
		<p class="d-flex justify-content-between">
			<span class="h3">베스트 지식공유자 TOP5</span>
		</p>  
		<p class="durationForm font-italic h5"></p>
		<div id="bestTeacher">
			<c:forEach var="teacher" items="${bestTeachers }">
				<c:set var="i" value="${i+1 }"/>
				<p class="h6">${i}. ${teacher }</p>
			</c:forEach>
		</div>
    </div>
  </div>
</div>

<div class="container" style="margin-top:30px">
  <div class="row">
    <div class="col-sm-4">
	<h3 class="text-center">신규 강의 NEW5</h3> <!-- 금주 신규 강의 전부 페이징처리하려고 했는데 강의 테이블에 날짜가 없어서.. -->
		<div class="weeklyNewLectures">
			<c:forEach var="lecture" items="${newWeeklyLectures }">
				<c:set var="j" value="${j+1 }"/>
				<p class="h6" onclick="location.href='${pageContext.request.contextPath}/Member/getLecture.do?lectureNo=${lecture.lectureNo }';">${j}. ${lecture.lectureTitle }</p>
			</c:forEach>
		</div>
    </div>
    <div class="col-sm-4">
      <h3 class="text-center">미승인 지식공유자 신청</h3>
      	<div class="teacherResume" style="height:150px;">
			<c:forEach var="resume" items="${resumes }">
				<p class="h6" onclick="openPopUp('${resume.userId}')">${resume.userId }</p>
			</c:forEach>
      	</div>
      	<div class="pagingAreaResume mx-auto">
      		<%@include file="/Admin/pagingResume.jspf" %>
      	</div>
    </div>
    <div class="col-sm-4">
      <h3 class="text-center">미답변 문의</h3>
      <div class="callcenter" style="height:150px;">
     	<c:forEach var="call" items="${callcenters }">
			<p class="h6" onclick="location.href='${pageContext.request.contextPath}/memberBoard/viewPage.do?qnaNo=${call.qnaNo }';">${call.qnaTitle }</p>
		</c:forEach>
      </div>
      <div class="pagingAreaCallcenter mx-auto">
     	<%@include file="/Admin/pagingCall.jspf" %>
      </div>
    </div>
  </div>
</div>

<%@ include file="/Common/footer.jsp" %>
</body>
</html>
