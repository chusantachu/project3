<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
  <style>
  </style>
  <script>
 
	
	$(function(){
		var now = new Date();	// 현재 날짜 및 시간
		document.getElementById("endMonth").value = now.toISOString().substring(0, 10);
		document.getElementById("endMonth").setAttribute("max", now.toISOString().substring(0, 10));
		document.getElementById("startMonth").value = new Date(now.setMonth(now.getMonth()-5)).toISOString().substring(0, 10);
		
		// Load the Visualization API and the corechart package.
	    google.charts.load('current', {'packages':['corechart']});
	    google.charts.setOnLoadCallback(drawVisualization);
	    
	    
	    
	})

    function drawVisualization() {
    	
      var data = new google.visualization.DataTable();
		var jsonData = $.ajax("${pageContext.request.contextPath }/admin/getRevenues.do", {
			type : "post",
			dataType: "json",
			async: false
		}).responseText;
	
	  console.log(jsonData);
 
      data.addColumn('string', 'Month');
      data.addColumn('number', 'Online');
      data.addColumn('number', 'Offline');
      data.addColumn('number', 'Total');
    
      var length = JSON.parse(jsonData).length;
      
      $.each(JSON.parse(jsonData), function(idx, obj){
    	  data.addRow([obj.filter, obj.onRevenue, obj.offRevenue, obj.totRevenue]);
      });
    
      
      // Set chart options
      var options = {
        title : '매출 통계',
        vAxis: {title: '수수료 수익'},
        hAxis: {title: '월'},
        seriesType: 'bars',
        series: {2: {type: 'line'}},
        //legend: { position: 'bottom'},
      };

      // Instantiate and draw our chart, passing in some options.
      var chart = new google.visualization.ComboChart(document.getElementById('revenueChart'));
      chart.draw(data, options);

    }
	
    $(document).on("change", "#startMonth", function(){
		ajaxProcess ("${pageContext.request.contextPath }/admin/getRevenueFiltering.do", $("#nowPage").text(), null);
    })
	
    $(document).on("change", "#endMonth", function(){
		ajaxProcess ("${pageContext.request.contextPath }/admin/getRevenueFiltering.do", $("#nowPage").text(), null);
    })
    
    
   	$(document).on("click", ".page-link", function () {
		ajaxProcess ("${pageContext.request.contextPath }/admin/getRevenueFiltering.do", $(this).attr('value'), null);
	});
    
   	$(document).on("click", "#byMonth", function () {
		ajaxProcess ("${pageContext.request.contextPath }/admin/getRevenueFiltering.do", $("#nowPage").text(), "byMonth");
	});
   	
   	$(document).on("click", "#byWeek", function () {
		ajaxProcess ("${pageContext.request.contextPath }/admin/getRevenueFiltering.do", $("#nowPage").text(), "byWeek");
	});
   	
   	$(document).on("click", "#byDay", function () {
		ajaxProcess ("${pageContext.request.contextPath }/admin/getRevenueFiltering.do", $("#nowPage").text(), "byDay");
	});
    
   	$(document).on("click", "#download", function () {
		//alert("해당 기간 매출 내역 다운로드");
		var startDate =  $("#startMonth").val().split("-").join("");
		var endDate = $("#endMonth").val().split("-").join("");
		location.href="${pageContext.request.contextPath }/admin/getRevenueExcel.do?startDate="+startDate+"&endDate="+endDate;
	});
    
    
    function ajaxProcess (url, page, filter) {
		var find = {};
		find.filter = filter;
		find.page = page;
		find.startDate =  $("#startMonth").val().split("-").join("");
		find.endDate = $("#endMonth").val().split("-").join("");
		
		console.log(JSON.stringify(find));
		
	    google.charts.load('current', {'packages':['corechart']});
	    google.charts.setOnLoadCallback(drawVisualization);
	    
	    function drawVisualization() {
	    	
	        var data = new google.visualization.DataTable();
	        
			$.ajax(url, {
				
		        type : "post",
		        data : JSON.stringify(find),
		        contentType : "application/json",
		        dataType: "json",
		        success : function(datas){
		            
		        	//alert("성공");
		            console.log(datas.orderList);
		            var dispHTML = "";
					
		            console.log(datas.list);
		            console.log(datas.list.length);

			        data.addColumn('string', 'Month');
			        data.addColumn('number', 'Online');
			        data.addColumn('number', 'Offline');
			        data.addColumn('number', 'Total');
			      
			        var length = datas.list.length;
			        
			        $.each(datas.list, function(idx, obj){
			      	  data.addRow([obj.filter, obj.onRevenue, obj.offRevenue, obj.totRevenue]);
			        });
			      
			        
			        // Set chart options
			        var options = {
			          title : '매출 통계',
			          vAxis: {title: '수수료 수익'},
			          hAxis: {title: '월'},
			          seriesType: 'bars',
			          series: {2: {type: 'line'}},
			          //legend: { position: 'bottom'}
			        };

			        // Instantiate and draw our chart, passing in some options.
			        var chart = new google.visualization.ComboChart(document.getElementById('revenueChart'));
			        chart.draw(data, options);
			        
		            if (datas.orderList.length == 0) {
		            	
		            	dispHTML += '<tr style="height:40px;">';
		            	dispHTML += '<td colspan="8" class="h6 text-center">주문 정보가 없습니다</td>';
		            	dispHTML += '</tr>';
		            	
						$("#revenueList").html(dispHTML);
						$("#pagingArea").html("");
						
		            } else {
		            	
		            	$.each(datas.orderList, function(index, obj){
		            		
				            console.log(obj);
				            
			            	dispHTML += '<tr style="height:40px;">';
			            	dispHTML += '<td class="h6 text-center">'+obj.orderNo+'</td>';
			            	dispHTML += '<td class="h6 text-center">'+obj.buyer.split('@')[0]+'</td>';
			            	dispHTML += '<td class="h6" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">'+obj.lectureTitle+'</td>';
			            	dispHTML += '<td class="h6 text-center">'+ obj.teacher.split('@')[0]+'</td>';
			            	dispHTML += '<td class="h6 text-center">'+obj.lectureOnOff+'</td>';
			            	dispHTML += '<td class="h6 text-center">'+obj.orderRegdate+'</td>';
			            	dispHTML += '<td class="h6 text-center">'+obj.lecturePrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+'</td>';
			            	dispHTML += '<td class="h6 text-center">'+obj.commission.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+'</td>';
			            	dispHTML += '</tr>';
				           
	           			});
		            	
		            	$("#revenueList").html(dispHTML);
		            	
			            var p = datas.p;
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

	}
    
</script>
</head>
<body>
<%@ include file="/Admin/common/adminHeader.jspf" %>
<br><br>
<div class="container">
<div>
	<input type="date" id="startMonth" min="2022-01" class="h6">
	<input type="date" id="endMonth" class="h6">
</div>
  <div class="row">
    <div class="col-sm-12">
      <h3>매출통계</h3>
      <input type="button" id="byMonth" value="월간" class="h6 btn btn-ligh">
      <input type="button" id="byWeek" value="주간" class="h6 btn btn-ligh">
      <input type="button" id="byDay" value="일간" class="h6 btn btn-ligh">
      <div id="revenueChart" style="font-size: 3rem">
      </div>
    </div>
  </div>
</div>

<div class="container" style="margin-top:30px">
  <div class="row">
    <div class="col-sm-12">
      <p><input type="button" id="download" value="다운로드" class="h6 btn btn-ligh"></p>
      <h3>수익 상세 내역</h3>
      <div class="RevenueDetail">
      	<table class="w-100" style="table-layout: fixed">
	      	<colgroup>
	      	    <col width="8%">
	      	    <col width="13%">
	      	    <col width="30%">
	      	    <col width="13%">
       			<col width="7%">
       			<col width="15%">
       			<col width="7%">
       			<col width="7%">
	      	</colgroup>
     		<thead class="text-center">
     			<tr>
     				<th class="h6 font-weight-bold">주문번호</th>
     				<th class="h6 font-weight-bold">주문자</th>
     				<th class="h6 font-weight-bold">강의명</th>
     				<th class="h6 font-weight-bold">강사</th>
     				<th class="h6 font-weight-bold">온/오프</th>
     				<th class="h6 font-weight-bold">구매일자</th>
     				<th class="h6 font-weight-bold">결제가</th>
     				<th class="h6 font-weight-bold">수수료</th>
     			</tr>
     		</thead>
     		<tbody id="revenueList">
     			<c:choose>
     				<c:when test="${empty orderList }">
     					<tr style="height:40px;">
     						<td colspan="8" class="h6 text-center">주문 정보가 없습니다</td>
     					</tr>
     				</c:when>
     				<c:otherwise>
     					<c:forEach var="order" items="${orderList }">
     						<tr style="height:40px;">
     							<td class="h6 text-center">${order.orderNo }</td>
     							<td class="h6 text-center">${fn:substringBefore(order.buyer, '@') }</td>
     							<td class="h6" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">${order.lectureTitle }</td>
     							<td class="h6 text-center">${fn:substringBefore(order.teacher, '@') }</td>
     							<td class="h6 text-center">${order.lectureOnOff }</td>
     							<td class="h6 text-center">${order.orderRegdate }</td>
     							<td class="h6 text-center">
     								<fmt:formatNumber type="number" maxFractionDigits="3" value="${order.lecturePrice }" /> 								
     							</td>
     							<td class="h6 text-center">
     								<fmt:formatNumber type="number" maxFractionDigits="3" value="${order.commission}" />
     							</td>
     						</tr>
     					</c:forEach>
     				</c:otherwise>
     			</c:choose>
     		</tbody>
      	</table>
      </div>
	<div id="pagingArea">
	 	<%@include file="/Lecture/paging.jspf" %>
	</div>	
    </div>
  </div>
</div>
<%@ include file="/Common/footer.jsp" %>
</body>
</html>
