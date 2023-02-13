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
	
	  var find = {};

      var data = new google.visualization.DataTable();
      var dataGeneral = new google.visualization.DataTable();
      var dateNaver = new google.visualization.DataTable();
      var dataGoogle = new google.visualization.DataTable();
      
		var jsonData = $.ajax("${pageContext.request.contextPath }/admin/getJoiner.do", {
			type : "post",
	        data : JSON.stringify(find),
	        contentType : "application/json",
			dataType: "json",
			async: false
		}).responseText;
	
	  console.log(jsonData);
	
	    data.addColumn('string', 'Month');
	    data.addColumn('number', '자사');
	    data.addColumn('number', '네이버');
	    data.addColumn('number', '구글');
	    data.addColumn('number', 'Total');
	    
	    dataGeneral.addColumn('string', 'Month');
	    dataGeneral.addColumn('number', '자사');
	    
	    dateNaver.addColumn('string', 'Month');
	    dateNaver.addColumn('number', '네이버');
	    
	    dataGoogle.addColumn('string', 'Month');
	    dataGoogle.addColumn('number', '구글');
	    
	    $.each(JSON.parse(jsonData), function(idx, obj){
	  	  data.addRow([obj.month, obj.general, obj.naver, obj.google, obj.total]);
	  	  dataGeneral.addRow([obj.month, obj.general]);
	  	  dateNaver.addRow([obj.month, obj.naver]);
	  	  dataGoogle.addRow([obj.month, obj.google]);
	    });
	  
	    
	    // Set chart options
	    var options = {
	      title : '가입자 통계',
	      vAxis: {title: '명'},
	      hAxis: {title: '월'},
	      seriesType: 'bars',
	      series: {3: {type: 'line'}},
	      //legend: { position: 'bottom'}
	    };
	    
	    var optionGeneral = {colors: ['#0000FF']};
	    var optionNaver = {colors: ['#e0440e']};
	    var optionGoogle = {colors: ['#FFA500']};
	
	    // Instantiate and draw our chart, passing in some options.
	    var chart = new google.visualization.ComboChart(document.getElementById('joinerChart'));
	    var chartGeneral = new google.visualization.ComboChart(document.getElementById('generalChart'));
	    var chartNaver = new google.visualization.ComboChart(document.getElementById('naverChart'));
	    var chartGoogle = new google.visualization.ComboChart(document.getElementById('googleChart'));
	    
	    chart.draw(data, options);
	    chartGeneral.draw(dataGeneral, optionGeneral);
	    chartNaver.draw(dateNaver, optionNaver);
	    chartGoogle.draw(dataGoogle, optionGoogle);
    }
	
    $(document).on("change", "#startMonth", function(){ 	
		// Load the Visualization API and the corechart package.
	    google.charts.load('current', {'packages':['corechart']});
	    google.charts.setOnLoadCallback(changeChart);
    })
    
    $(document).on("change", "#endMonth", function(){ 	
		// Load the Visualization API and the corechart package.
	    google.charts.load('current', {'packages':['corechart']});
	    google.charts.setOnLoadCallback(changeChart);
    })

    function changeChart(){
		var find = {};
		find.startDate =  $("#startMonth").val().split("-").join("");
		find.endDate = $("#endMonth").val().split("-").join("");
		console.log(JSON.stringify(find));

	      var data = new google.visualization.DataTable();
	      var dataGeneral = new google.visualization.DataTable();
	      var dateNaver = new google.visualization.DataTable();
	      var dataGoogle = new google.visualization.DataTable();
        
		var jsonData = $.ajax("${pageContext.request.contextPath }/admin/getJoiner.do", {
			type : "post",
	        data : JSON.stringify(find),
	        contentType : "application/json",
			dataType: "json",
			async: false
		}).responseText;
	
	  console.log(jsonData);
 
      data.addColumn('string', 'Month');
      data.addColumn('number', '자사');
      data.addColumn('number', '네이버');
      data.addColumn('number', '구글');
      data.addColumn('number', 'Total');
    
	    dataGeneral.addColumn('string', 'Month');
	    dataGeneral.addColumn('number', '자사');
	    
	    dateNaver.addColumn('string', 'Month');
	    dateNaver.addColumn('number', '네이버');
	    
	    dataGoogle.addColumn('string', 'Month');
	    dataGoogle.addColumn('number', '구글');
	    
      $.each(JSON.parse(jsonData), function(idx, obj){
    	  data.addRow([obj.month, obj.general, obj.naver, obj.google, obj.total]);
	  	  dataGeneral.addRow([obj.month, obj.general]);
	  	  dateNaver.addRow([obj.month, obj.naver]);
	  	  dataGoogle.addRow([obj.month, obj.google]);
      });
    
      
      // Set chart options
      var options = {
        title : '가입자 통계',
        vAxis: {title: '명'},
        hAxis: {title: '월'},
        seriesType: 'bars',
        series: {3: {type: 'line'}}
      };

	    var optionGeneral = {colors: ['#e0440e']};
	    var optionNaver = {colors: ['#0000FF']};
	    var optionGoogle = {colors: ['#FFA500']};
	
	    // Instantiate and draw our chart, passing in some options.
	    var chart = new google.visualization.ComboChart(document.getElementById('joinerChart'));
	    var chartGeneral = new google.visualization.ComboChart(document.getElementById('generalChart'));
	    var chartNaver = new google.visualization.ComboChart(document.getElementById('naverChart'));
	    var chartGoogle = new google.visualization.ComboChart(document.getElementById('googleChart'));
	    
	    chart.draw(data, options);
	    chartGeneral.draw(dataGeneral, optionGeneral);
	    chartNaver.draw(dateNaver, optionNaver);
	    chartGoogle.draw(dataGoogle, optionGoogle);
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
	      <h3>가입자통계</h3>
	      <div id="joinerChart" style="font-size: 3rem">
	      </div>
	    </div>
	    <div class="col-sm-4">
	      <h3>자사</h3>
	      <div id="generalChart" style="font-size: 3rem">
	      </div>
	    </div>
	    <div class="col-sm-4">
	      <h3>네이버</h3>
	      <div id="naverChart" style="font-size: 3rem">
	      </div>
	    </div>
	    <div class="col-sm-4">
	      <h3>구글</h3>
	      <div id="googleChart" style="font-size: 3rem">
	      </div>
	    </div>
	    
	  </div>

</div>
<%@ include file="/Common/footer.jsp" %>
</body>
</html>
