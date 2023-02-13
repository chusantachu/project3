<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a5c2dd5faeea39d640a9f6af6c8ddef1&libraries=services"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<title>강의 상세페이지</title>
<style>
	#mainimg {
		position: absolute;
		top:120px;
		left:40px;
	}
	#maintext {
		position:absolute;
		left: 750px;
		top: 250px;
		
	}
	.col {
		margin: 0 30 0 0;
		width: 50px;
		height: 50px;
		font-size: 20px;
	}
	.col a:hover, .col a{
		text-decoration: none;
		color: black;
	}

	#order a, order a:hover{
		color:black;
		text-decoration: none;
	}

	#review_info a{
		color:black;
		text-decoration: none;
	}
	.addreply{
		float:right;
	}
	.letright{
		float:right;
	}
</style>

</head>
<body>

<%@include file ="/Common/header.jsp" %>
<fmt:requestEncoding value="utf-8"/>


<div class= "container-fluid " style="margin: 0; padding:  0; background-color: #002333">
<img id="mainimg" src="${pageContext.request.contextPath}/filepath/${lecture.lectureCoverimg}" alt="강의 이미지" width="640px" height="400px">
<div id="maintext" class='maintext text-white'>

<p>${lecture.categoryName }</p>
<h2>${lecture.lectureTitle }</h2>
<c:set var="avg"  value="${(count.rate5*5 + count.rate4*4 + count.rate3*3 + count.rate2*2 + count.rate1*1)/count.totalComment}"></c:set>	
<p>
			
			<c:forEach begin="1" end="${avg+((avg%1>0.5)?(1-(avg%1))%1:-(avg%1))}">
			<i class='fas fa-star' style='font-size:18px;color:orange'></i>

			</c:forEach>
			
			<c:if test="${count.totalComment ne null && count.totalComment ne 0}">
			(<fmt:formatNumber pattern="0.0" value="${(count.rate5*5 + count.rate4*4 + count.rate3*3 + count.rate2*2 + count.rate1*1)/count.totalComment} " />)
</c:if>			
			
${count.totalComment}

개의 수강평 
 ∙ 
<c:if test="${lecture.studentCount eq null}">0</c:if>
<c:if test="${lecture.studentCount ne null}">${lecture.studentCount}</c:if>
명의 수강생</p>
<span><i style='font-size:24px' class='fas'>&#xf521;</i>
${lecture.lectureWriter } 
&nbsp;|&nbsp;

<c:if test="${lecture.lectureOnOff == 1}">오프라인 수업</c:if>
<c:if test="${lecture.lectureOnOff == 0}">온라인 수업</c:if>
</span>
	<span id="realtimeDiv" class="ml-2" style="display: none">
		<button class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/lecture/realtimeQuestion.do?lectureNo=${lecture.lectureNo}'">실시간 질문</button>
	</span>
</div>

<br><br><br>
<br><br><br><br>
<br><br><br>
<br><br><br><br>
<br><br><br><br><br><br><br>
<br><br><br>

</div>
<div>

</div>
<br>
<div class="container-fluid" style="padding-left: 100px; padding-right: 100px;">
	
		<span class="col"><a href="#contents">강의소개</a></span>
		<span class="col"><a href="#curriculum">커리큘럼</a></span>
		<span class="col"><a href="#review">수강평</a></span>
		<span class="col"><a href="#">커뮤니티</a></span>
		<span class="col"><a href="#">새소식</a></span>
	
<br><br>
<div id="introTitle" >
<div class="row" style="height: auto;" >
  <div class="col-sm-8">
  <section id="contents">
<h2>${lecture.lectureSummary }</h2><br>
<p style="font-size: 20px;">
${lecture.lectureContent }

</section>
<!-- 오프라인인 경우 -->
<c:if test="${lecture.lectureOnOff == 1}"><br><br><br><br>
<div id="offline" style="font-size: 20px;">
<h2>오시는길</h2>
<p><c:forEach var="time" items="${timetables}" begin="0" end="0">
	<c:set var="placeidpast" value="${time.lecturePastAddress}"/>
	<c:set var="placeid" value="${time.lectureAddress}"/>
	${time.lecturePastAddress}<br>
	${time.lectureAddress }
</c:forEach>
</p>
<div id="map" style="width:100%;height:400px;"></div>

<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = {
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};  



//지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

//주소로 좌표를 검색합니다
var place = '<c:out value="${placeidpast}"/>';
geocoder.addressSearch(place, function(result, status) {

// 정상적으로 검색이 완료됐으면 
 if (status === kakao.maps.services.Status.OK) {

    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

    // 결과값으로 받은 위치를 마커로 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: coords
    });

    // 인포윈도우로 장소에 대한 설명을 표시합니다
    var infowindow = new kakao.maps.InfoWindow({
        content: '<div style="width:150px;text-align:center;padding:6px 0;">강의실</div>'
    });
    infowindow.open(map, marker);

    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
    map.setCenter(coords);
} 
});    
</script>

<br>
<h2>선택가능한 시간대</h2>
<c:forEach var="time" items="${timetables}"> 
<p>${fn:substring(time.timetableStart,0,16) }~ ${fn:substring(time.timetableEnd,0,16) }
<input id="chk${time.timetableNo}"  class="timetableNo" type="radio" name='timetables' value="${time.timetableNo}" >
</p>

</c:forEach>
</div>

<!-- 오프라인일때 수강신청하기 버튼을 눌렀을때 연결되는 함수 변경
<script>
window.onload=function(){
	let sentence = ""
	
}
</script>
 -->
</c:if>
<!-- 온라인인 경우 -->
<c:if test="${lecture.lectureOnOff == 0}"><br><br>

<!-- 섹션 갯수 구하기 -->
<c:forEach var="num" items="${classes }" varStatus="status">
		<c:if test="${status.last}">
				<c:set var="maxsection" value="${num.sectionNo}"></c:set>
		</c:if>
		<c:set var="max" value="${num.sectionNo}"/>
</c:forEach>

<!-- 클래스 갯수 구하기 -->
<c:forEach var="num" items="${classes }" varStatus="status">
		<c:if test="${status.last}">
			<c:set var="countclass" value="${status.index + 1}"/>
		</c:if>
</c:forEach>

<!-- 클래스 넘버 최소 최대 구하기 -->
<c:forEach var="num" items="${classes }" varStatus="status">
		<c:if test="${status.first}">
			<c:set var="classNoMin" value="${num.classNo}"/>
		</c:if>
		<c:if test="${status.last}">
			<c:set var="classNoMax" value="${num.classNo}"/>
		</c:if>
</c:forEach>

<!-- 프리뷰 할수있는 클래스 넘버 최소 최대 구하기 잘못됨.. -->
<c:forEach var="num" items="${classes }" varStatus="status">
	<c:if test="${num.preview eq 0}">	
			<c:set var="previewclassNoMax" value="${num.classNo}"></c:set> 
	</c:if>	
</c:forEach>


<section id="curriculum">
<b style="font-size: 32px;">커리큘럼</b> &nbsp;
<span class="text-secondary">총 ${countclass} 개</span>
<p style="font-size: 20px;">이 강의는 영상, 수업 노트, 첨부 파일이 제공됩니다. 미리보기를 통해 콘텐츠를 확인해보세요.</p>

<div id="accordion">
<c:forEach var="section" items="${classes}" begin="0" end="${maxsection }" varStatus="status">
	<div class="card-header">
        <a class="card-link" data-toggle="collapse" href="#collapse${status.index}" style="color: black;">
          섹션 ${status.index }
          
        </a>
	</div>

		<c:forEach var="so" items="${classes}">
        <c:if test="${so.sectionNo eq status.index}">

			<div id="collapse${so.sectionNo}" class="collapse" >
        		<div class="card-body">
         			${so.className }
         			
         			<!-- 강의자, 수강생, 관리자가 아닌 경우 미리보기만 가능 -->
         			<c:if test="${so.preview eq 0 && lecturer != 'student' && lecturer != 'lecturer' && user.grade != '관리자'}">
         			<span style="float: right"><button class='btn btn-outline-success'  onclick="location.href='previewD.do?classNo=${so.classNo}&min=${classNoMin}&max=${previewclassNoMax}'">미리보기</button></span>
         			</c:if>
         			<c:if test="${lecturer == 'student' || lecturer == 'lecturer' || user.grade == '관리자'}">
         			<span style="float: right"><button class='btn btn-outline-success'  onclick="location.href='previewD.do?classNo=${so.classNo}&min=${classNoMin}&max=${classNoMax}'">영상보기</button></span>
         			</c:if>
       		 </div>
	</div>
		</c:if>
        </c:forEach>
      </c:forEach>  
</div>

</section>
</c:if>















<section id="review">
<div style="margin-top: 100px">
<span style="font-size: 25px;"><b>수강평</b></span>&nbsp;
<span style="font-size: 16px; color: gray;"><b>총 ${count.totalComment}개</b></span><br>
<span>수강생들이 직접 작성하신 수강평입니다.</span><br>

	<div class="row">
		
		
		
			<div class="col-sm-4 rounded-lg border text-center">
			<c:if test="${count.totalComment ne null && count.totalComment ne 0}">
			<h1><fmt:formatNumber pattern="0.0" value="${(count.rate5*5 + count.rate4*4 + count.rate3*3 + count.rate2*2 + count.rate1*1)/count.totalComment} " /></h1>
			</c:if>
			
			<c:forEach begin="1" end="${avg+((avg%1>0.5)?(1-(avg%1))%1:-(avg%1))}">
			<i class='fas fa-star' style='font-size:18px;color:orange'></i>

			</c:forEach>
			<br>
			<span style="font-size: 16px; color: gray;"><b>총 ${count.totalComment}개</b></span><br>
		
			
			</div>
			
			<div class="col-sm-1">
				<div  style="float:right;">
			5점<br>
			4점<br>
			3점<br>
			2점<br>
			1점
			</div>
			</div>
					
			<div class="col-sm-7">
		<c:if test="${count.totalComment ne null && count.totalComment ne 0}">
	<div class="progress" style="margin-bottom: 9px;">	
 	<div class="progress-bar" style="width:<fmt:formatNumber type="number" maxFractionDigits="0"  value="${count.rate5/count.totalComment * 100} " />%; background-color: orange; "></div>
  </div>
 <div class="progress" style="margin-bottom: 9px;">
    <div class="progress-bar" style="width:<fmt:formatNumber type="number" maxFractionDigits="0"  value="${count.rate4/count.totalComment * 100} " />%;  background-color: orange; "></div>
  </div>
  <div class="progress" style="margin-bottom: 9px;">
    <div class="progress-bar" style="width:<fmt:formatNumber type="number" maxFractionDigits="0"  value="${count.rate3/count.totalComment * 100} " />%;  background-color: orange; "></div>
  </div>
  <div class="progress" style="margin-bottom: 9px;">
    <div class="progress-bar" style="width:<fmt:formatNumber type="number" maxFractionDigits="0"  value="${count.rate2/count.totalComment * 100} " />%;  background-color: orange; "></div>
  </div>
  <div class="progress">
    <div class="progress-bar" style="width:<fmt:formatNumber type="number" maxFractionDigits="0"  value="${count.rate1/count.totalComment * 100} " />%;  background-color: orange; "></div>
  </div>
  	</c:if>
			</div>
	
		<div id="order" style="margin-top: 50px;">
			<span style="font-size: 18px; padding-right: 10px;"><b>VIEW</b></span>
			<span style="font-size: 18px; padding-right: 10px;"><button class="btn btn-default" onclick="orderByDate()"> ·최신 순</button></span>
			<span style="font-size: 18px; padding-right: 10px;"><button class="btn btn-default" onclick="orderRateDesc()"> ·높은 평점 순</button></span>
			<span style="font-size: 18px; padding-right: 10px;"><button class="btn btn-default" onclick="orderRateAsc()"> ·낮은 평점 순</button></span>
		</div>
		
	</div>


</div>
<hr>


<div id="review_comment">
	
</div>






		<c:if test="${lecturer ne 'visitor' && lecturer ne 'lecturer'}">
	<div id="writeComment">

	<span><b>${user.userId}</b></span><br>

	<button type="button" id="rate1" class="btn btn-default" style="padding: 0;"><i id="star1" class='fas fa-star star' style='font-size:18px;color:#f5f5dc'></i></button>
	<button type="button" id="rate2" class="btn btn-default" style="padding: 0;"><i id="star2" class='fas fa-star star' style='font-size:18px;color:#f5f5dc'></i></button>
	<button type="button" id="rate3" class="btn btn-default" style="padding: 0;"><i id="star3" class='fas fa-star star' style='font-size:18px;color:#f5f5dc'></i></button>
	<button type="button" id="rate4" class="btn btn-default" style="padding: 0;"><i id="star4" class='fas fa-star star' style='font-size:18px;color:#f5f5dc'></i></button>
	<button type="button" id="rate5" class="btn btn-default" style="padding: 0;"><i id="star5" class='fas fa-star star' style='font-size:18px;color:#f5f5dc'></i></button>


	

	
	<br>
	
	
	<textarea id="boardContent" rows="5" cols="70"></textarea>
	<input type="button" name="boardContent" class="btn btn-default" value="코멘트 쓰기" onclick="submitComment(${lecture.lectureNo})">
	
	
</div>
</c:if>
</section>


</div>


<div class="col-sm-4" style="position: fixed; top:630px; right: 50px;" >
  <div class="card rounded-lg" >
    <div class="card-header bg-white">
    <c:if test="${lecture.lectureSalerate eq 0}">
	<h4>${lecture.lecturePrice }원</h4>
	</c:if>
	 <c:if test="${lecture.lectureSalerate ne 0}">
	 <c:set var="discountedPrice" value="${lecture.lecturePrice*(100-lecture.lectureSalerate)/100.0}"></c:set>
	 
	 <div style="display: flex;">
	<h4><span class="text-danger">${lecture.lectureSalerate}%</span>&nbsp; <fmt:formatNumber value="${discountedPrice }" pattern="0,000" groupingUsed="true"/>원</h4>
	 &nbsp; <span class="text-muted" style="text-decoration:line-through"><fmt:formatNumber value="${lecture.lecturePrice}" pattern="0,000" groupingUsed="true"/>원</span>
	 </div>
	</c:if>
	
	
	
	<br>
	<div id="buttons">
	<c:if test="${lecturer eq 'visitor'}">
	<button class="btn btn-success" style="width: 300px; height: 60px; margin-bottom: 10px;" disabled>수강신청<br>로그인이 필요한 기능입니다</button><br>
	</c:if>
	
	<!--  오프라인 -->
	<c:if test="${lecturer ne 'visitor'}">
	<c:if test="${lecture.lectureOnOff == 1}">
	<button class="btn btn-success" style="width: 300px; height: 60px; margin-bottom: 10px;" onclick="offlineInsertCart()">수강신청 하기</button><br>
	</c:if>
	
	<!--  온라인 -->
	<c:if test="${lecture.lectureOnOff == 0}">
	<button class="btn btn-success" style="width: 300px; height: 60px; margin-bottom: 10px;" onclick="location.href='insertCart.do?lectureNo=${lecture.lectureNo}'">수강신청 하기</button><br>
	</c:if>
	
	<!-- <button class="btn" style="width: 300px; height: 60px; border: solid 1px black">바구니에 담기</button> -->
	</c:if>
	</div>
	
	
 	<script>
	function offlineInsertCart(){
		var check;
		if ($('.timetableNo').is(':checked')){
			var radioVal = $('input[class="timetableNo"]:checked').val();
			alert(radioVal);
			location.href="insertCart.do?timetableNo=" + radioVal + "&lectureNo=${lecture.lectureNo}";
			
		}
		
		
		/* location.href="insertCart.do?lectureNo=${lecture.lectureNo}'"; */
	}
	
	</script>
	
	

	
	
	<c:if test="${checkLike == 0}">
	<span id="lectureNum">
	 <button  type="button" class="btn btn-default" onclick="ajaxAddLike(${lecture.lectureNo})">
          <i class="fas fa-heart" style="color: #f5f5dc;" ></i>
          <span> ${ lectureLike}</span>      
        </button>
     </span>
       </c:if>
       
       <c:if test="${checkLike == 1}">
       <span id="lectureNum">
        <button type="button" class="btn btn-default" onclick="ajaxDeleteLike(${lecture.lectureNo})">
         <i class="fas fa-heart" style="color: red;" ></i>
         <span>${ lectureLike}</span>
        
       </button>
      </span>
       </c:if>
        
	<c:if test="${checkLike == 2}">
	<span id="lectureNum">
	 <button  type="button" class="btn btn-default">
          <i class="fas fa-heart" style="color: #f5f5dc;" ></i>
          <span> ${ lectureLike}</span>      
        </button>
     </span>
       </c:if>
        
        
	&nbsp;&nbsp;|&nbsp;&nbsp;
	<button type="button" class="btn btn-default" onclick="copyToClipboard('${lecture.lectureUrl}');">
			<span><img src="${pageContext.request.contextPath}/picture/lectureDetail/shareicon.png" alt="공유버튼">
			&nbsp;공유
			</span>
	</button>
	

	
</div>
    <div class="card-body" style="background-color: #F8F9FA;">
    	<ul>
    		<li>지식공유자: ${lecture.lectureWriter }</li>
    		<li>총 24개 수업(시간)</li>
    		<li>수강기한: <b>
    	<c:if test="${lecture.lectureDue eq null}">
    		무제한
    	</c:if>
    	<c:if test="${lecture.lectureDue ne null }">
    		${lecture.lectureDue}
    	</c:if>
    		</b>
    		</li>
    		
    		<c:if test="${lecture.lectureLevel eq '입문' }">
    		<li>난이도: <b>입문</b> - 초급 - 중급이상</li>
    		</c:if>
    		<c:if test="${lecture.lectureLevel eq '초급' }">
    		<li>난이도:입문 -  <b>초급</b> - 중급이상</li>
    		</c:if>
    		<c:if test="${lecture.lectureLevel eq '중급이상' }">
    		<li>난이도:입문 - 초급 -  <b>중급이상</b></li>
    		</c:if>
    		
    	</ul>
    	<div style="color: #175CBE; background-color: #175CBE0F; text-align: center;">
    		<span>지식공유자 답변이 제공되는 강의입니다</span>
    	</div>
    </div> 
    
  </div>
  <br>
  <div class="border rounded-lg container" style="height: 50px;">
  			
  			<span><b>수강전 궁금한 점이 있나요?</b></span>
  			<a href="#" style="margin-left: 54px; color: black; text-decoration: underline;" >문의하기</a>
  
  </div>
  </div>
<br><br><br>
<br><br><br><br>
<br><br><br>
<br><br><br><br>
<br><br><br><br><br><br><br>
<br><br><br>
  </div>
<br><br><br>
<br><br><br><br>
<br><br><br>
<br><br><br><br>
<br><br><br><br><br><br><br>
<br><br><br>
  
  
</div>

<h3><a href="#" style="text-decoration: none; color: black;">${lecture.lectureWriter}님의 다른 강의<i class="fa fa-location-arrow"></i></a></h3>
<span style="color: #ADB5BD">지식공유자님의 다른 강의를 만나보세요!</span>



</div>

	<script>
	function addLike(lectureNo){
		location.href="addLike.do?lectureNo=" + lectureNo;
	}
	
	function deleteLike(lectureNo){
		location.href="deleteLike.do?lectureNo=" + lectureNo;
	}
	
	function copyToClipboard(val) {
		alert("주소가 복사되었습니다!");
	    var t = document.createElement("textarea");
	    document.body.appendChild(t);
	    t.value = val;
	    t.select();
	    document.execCommand('copy');
	    document.body.removeChild(t);
	    }
	
	// Ajax 요청처리로 데이터 가져와서 화면 표시
	function ajaxAddLike(lectureNo) {
		$.ajax("ajaxAddLike.do?lectureNo=" + lectureNo, {
			type: "get",
			dataType: "json",
			success: function(data){
				console.log(data);
				var sentence = "<button  type='button' class='btn btn-default' onclick='ajaxDeleteLike(${lecture.lectureNo})''>";
				sentence += " <i class='fas fa-heart' style='color: red;' ></i>";
				sentence +=" <span>"+ data + "</span></button>";
				$("#lectureNum").html(sentence);
			},
			error: function(){
				alert("실패~~");
			}
		});
	}
	
	function ajaxDeleteLike(lectureNo) {
		$.ajax("ajaxDeleteLike.do?lectureNo=" + lectureNo, {
			type: "get",
			dataType: "json",
			success: function(data){
				console.log(data);
				var sentence = "<button  type='button' class='btn btn-default' onclick='ajaxAddLike(${lecture.lectureNo})''>";
				sentence += "<i class='fas fa-heart' style='color: #f5f5dc;' ></i>";
				sentence +="<span> "+ data + "</span></button>";
				$("#lectureNum").html(sentence);
			},
			error: function(){
				alert("실패~~");
			}
		});
	}
	

	$('#rate1').on({'click' : function(){
		$('#star1').css("color", "orange");
		$('#star2').css("color", "#f5f5dc");
		$('#star3').css("color", "#f5f5dc");
		$('#star4').css("color", "#f5f5dc");
		$('#star5').css("color", "#f5f5dc");
		$('#rate1').off('mouseout');
	}, 'mouseenter' : function(){
		$('#star1').css("color", "orange");
	}, 'mouseout' : function(){
		$('.star').css("color", "#f5f5dc");
	}} );

	$('#rate2').on({'click' : function(){
		$('#star1').css("color", "orange");
		$('#star2').css("color", "orange");
		$('#star3').css("color", "#f5f5dc");
		$('#star4').css("color", "#f5f5dc");
		$('#star5').css("color", "#f5f5dc");
		$('#rate2').off('mouseout');
	}, 'mouseenter' : function(){
		$('#star1').css("color", "orange");
		$('#star2').css("color", "orange");
	}, 'mouseout' : function(){
		$('.star').css("color", "#f5f5dc");
	}} );

	$('#rate3').on({'click' : function(){
		$('#star1').css("color", "orange");
		$('#star2').css("color", "orange");
		$('#star3').css("color", "orange");
		$('#star4').css("color", "#f5f5dc");
		$('#star5').css("color", "#f5f5dc");
		$('#rate3').off('mouseout');
	}, 'mouseenter' : function(){
		$('#star1').css("color", "orange");
		$('#star2').css("color", "orange");
		$('#star3').css("color", "orange");
	}, 'mouseout' : function(){
		$('.star').css("color", "#f5f5dc");
	}} );

	$('#rate4').on({'click' : function(){
		$('#star1').css("color", "orange");
		$('#star2').css("color", "orange");
		$('#star3').css("color", "orange");
		$('#star4').css("color", "orange");
		$('#star5').css("color", "#f5f5dc");
		$('#rate4').off('mouseout');
	}, 'mouseenter' : function(){
		$('#star1').css("color", "orange");
		$('#star2').css("color", "orange");
		$('#star3').css("color", "orange");
		$('#star4').css("color", "orange");
	}, 'mouseout' : function(){
		$('.star').css("color", "#f5f5dc");
	}} );

	$('#rate5').on({'click' : function(){
		$('#star1').css("color", "orange");
		$('#star2').css("color", "orange");
		$('#star3').css("color", "orange");
		$('#star4').css("color", "orange");
		$('#star5').css("color", "orange");
		$('#rate5').off('mouseout');
	}, 'mouseenter' : function(){
		$('#star1').css("color", "orange");
		$('#star2').css("color", "orange");
		$('#star3').css("color", "orange");
		$('#star4').css("color", "orange");
		$('#star5').css("color", "orange");
	}, 'mouseout' : function(){
		$('.star').css("color", "#f5f5dc");
	}} );


	function submitComment(lectureNo){
		var star1 = document.getElementById("star1");
		var star1style = star1.style;
		var star2 = document.getElementById("star2");
		var star2style = star2.style;
		var star3 = document.getElementById("star3");
		var star3style = star3.style;
		var star4 = document.getElementById("star4");
		var star4style = star4.style;
		var star5 = document.getElementById("star5");
		var star5style = star5.style;
		
		var score;
		if (star5style.color == 'orange'){
			score = 5;
		} else if (star4style.color == 'orange'){
			score = 4;
		} else if (star3style.color == 'orange'){
			score = 3;
		} else if (star2style.color == 'orange'){
			score = 2;
		} else {
			score = 1;
		}
		console.log(score);
		
		var content = $("#boardContent").val();
		console.log(content);
		
		$.ajax("ajaxInsertLectureComment.do?boardRate=" + score + "&lectureNo=" + lectureNo+"&boardContent=" + content, {
			type: "get",
			dataType: "json",
			success: function(data){
				
				
				let dispHtml ="";
				
				$.each(data, function(index, obj){
					dispHtml += "<div id='review_header'>";
					
					for (var i =0; i<this.boardRate; i++){
						dispHtml += "<i class='fas fa-star' style='font-size:18px;color:orange'></i>"
					}
					
					dispHtml += "&nbsp;<b>" +  this.userId +"</b><br></div>";
					dispHtml += "<div id='review_content'><p>" + this.boardContent + "</p>";
					dispHtml += "<div id='review_info'><span>" + this.boardRegdate;
					
					var lecturer = ${lecturer eq 'lecturer'};
					
					if (lecturer){
						dispHtml += '<button id="reply" value="'  + this.boardNo + '"class="btn btn-default" onclick="addreply()"> 답글쓰기</button>';
					}
					
					dispHtml += '</span>';
					dispHtml += "</div>";
					dispHtml += "</div><hr>";
					dispHtml += "</div>";
					dispHtml +="<div id='replyForm'></div>";
				})
				$("#review_comment").html(dispHtml);
				
			},
			error: function(){
				alert("실패~~");
			}
		});

	}

	function orderByDate(){
		var lectureNo = "<c:out value ='${lecture.lectureNo}'/>";
		console.log(lectureNo);
		$.ajax("ajaxGetLectureComment.do?lectureNo=" + lectureNo, {
			type: "get",
			dataType: "json",
			async    : false,
			success: function(data){
				
				
				let dispHtml ="";
				
				$.each(data, function(index, obj){
					dispHtml += "<div id='reviewComment" + this.boardNo + "'><div id='review_header'>";
					
					for (var i =0; i<this.boardRate; i++){
						dispHtml += "<i class='fas fa-star' style='font-size:18px;color:orange'></i>"
					}
					
					dispHtml += "&nbsp;<b>" +  this.userId +"</b>";
					
					/* 사용자 댓글 삭제 */
					var lecturer = ${lecturer eq 'lecturer'};
					if (lecturer){
						dispHtml += '<button id="deletereply' + this.boardNo +'" class="btn btn-default letright" onclick="deleteComment(' + this.boardNo +')"><i class="fa fa-trash" aria-hidden="true"></i></button><br></div>';
					}
					
					dispHtml += "<div id='review_content'><p>" + this.boardContent + "</p>";
					dispHtml += "<div id='review_info'><span>" + this.boardRegdate;
					dispHtml +="<span id='replyfor" + this.boardNo + "' ></span>";	
					
					
					if (lecturer){
						dispHtml += '<button id="reply'+ this.boardNo + '" value="'  + this.boardNo + '"class="btn btn-default addreply" onclick="showReply(this)">답글쓰기</button>';
					}
					
					dispHtml += '</span>';
					dispHtml += "</div>";
					dispHtml += "</div><hr>";
					dispHtml +="<div id='replyForm" + this.boardNo + "' style='display:none'>	";				
					dispHtml +="<i class='material-icons' style='font-size:24px;color:black'>subdirectory_arrow_right</i><br>	";				
					dispHtml +="<span style='position: relative; left: 50px;'><textarea id='replytext" + this.boardNo + "' rows='5' cols='70'></textarea>";
					dispHtml +="<input type='button' name='boardContent' class='btn btn-default' value='답글 작성하기' onclick='submitReply(" + this.boardNo + ")'>";
					dispHtml +="</span></div>";
					dispHtml +="</div></div>";
					
					
				})
				$("#review_comment").html(dispHtml);
				
			},
			error: function(){
				alert("실패~~");
			}
		});
		
		$.ajax("ajaxGetCommentReply.do?lectureNo=" + lectureNo, {
			type: "post",
			dataType: "json",
			async    : false,
			success: function(data){
				let dispHtml="";
				$.each(data, function(index, obj){
					dispHtml = "";
					dispHtml += '<br><i class="fas fa-angle-down" style="font-size:24px"></i><br>';
					dispHtml += '<div style="background-color: #f8f9fa;">';
					dispHtml += '<div id="reply_header">';
					dispHtml += '<span class="border" >지식공유자</span>';
					dispHtml += '<span><b>' + this.lectureWriter +  '</b>'; 
					
					var lecturer = ${lecturer eq 'lecturer'};
					
					if (lecturer){
						dispHtml += '<button id="deletereply' + this.boardNo +'" class="btn btn-default letright" onclick="deletereply(' + this.boardNo +')"><i class="fa fa-trash" aria-hidden="true"></i></button>';
					}
					
					dispHtml +='</span></div><br>';
					dispHtml += '<div id="reply_content">';
					dispHtml += '<p>' + this.commentContent +'</p>';
					dispHtml += '<span>' + this.commentRegdate +'</span></div></div></div>';
					
					$("#replyfor" + this.boardNo).html(dispHtml);
					
					$("#reply" + this.boardNo).hide();
				})
				
			
				
			},
			error: function(){
				alert("실패~~");
			}
		});
		
	};
/*평점높은순*/
	function orderRateDesc(){
		var lectureNo = "<c:out value ='${lecture.lectureNo}'/>";
		console.log(lectureNo);
		$.ajax("ajaxGetLectureCommentRateDesc.do?lectureNo=" + lectureNo, {
			type: "get",
			dataType: "json",
			async    : false,
			success: function(data){
				
				
				let dispHtml ="";
				
				$.each(data, function(index, obj){
					dispHtml += "<div id='reviewComment" + this.boardNo + "'><div id='review_header'>";
					
					for (var i =0; i<this.boardRate; i++){
						dispHtml += "<i class='fas fa-star' style='font-size:18px;color:orange'></i>"
					}
					
					dispHtml += "&nbsp;<b>" +  this.userId +"</b>";
					
					/* 사용자 댓글 삭제 */
					var lecturer = ${lecturer eq 'lecturer'};
					if (lecturer){
						dispHtml += '<button id="deletereply' + this.boardNo +'" class="btn btn-default letright" onclick="deleteComment(' + this.boardNo +')"><i class="fa fa-trash" aria-hidden="true"></i></button><br></div>';
					}
					
					dispHtml += "<div id='review_content'><p>" + this.boardContent + "</p>";
					dispHtml += "<div id='review_info'><span>" + this.boardRegdate;
					dispHtml +="<span id='replyfor" + this.boardNo + "' ></span>";	
					
					
					if (lecturer){
						dispHtml += '<button id="reply'+ this.boardNo + '" value="'  + this.boardNo + '"class="btn btn-default addreply" onclick="showReply(this)">답글쓰기</button>';
					}
					
					dispHtml += '</span>';
					dispHtml += "</div>";
					dispHtml += "</div><hr>";
					dispHtml +="<div id='replyForm" + this.boardNo + "' style='display:none'>	";				
					dispHtml +="<i class='material-icons' style='font-size:24px;color:black'>subdirectory_arrow_right</i><br>	";				
					dispHtml +="<span style='position: relative; left: 50px;'><textarea id='replytext" + this.boardNo + "' rows='5' cols='70'></textarea>";
					dispHtml +="<input type='button' name='boardContent' class='btn btn-default' value='답글 작성하기' onclick='submitReply(" + this.boardNo + ")'>";
					dispHtml +="</span></div>";
					dispHtml +="</div></div>";
					
					
				})
				$("#review_comment").html(dispHtml);
				
			},
			error: function(){
				alert("실패~~");
			}
		});
		
		$.ajax("ajaxGetCommentReply.do?lectureNo=" + lectureNo, {
			type: "post",
			dataType: "json",
			async    : false,
			success: function(data){
				let dispHtml="";
				$.each(data, function(index, obj){
					dispHtml = "";
					dispHtml += '<br><i class="fas fa-angle-down" style="font-size:24px"></i><br>';
					dispHtml += '<div style="background-color: #f8f9fa;">';
					dispHtml += '<div id="reply_header">';
					dispHtml += '<span class="border" >지식공유자</span>';
					dispHtml += '<span><b>' + this.lectureWriter +  '</b>'; 
					
					var lecturer = ${lecturer eq 'lecturer'};
					
					if (lecturer){
						dispHtml += '<button id="deletereply' + this.boardNo +'" class="btn btn-default letright" onclick="deletereply(' + this.boardNo +')"><i class="fa fa-trash" aria-hidden="true"></i></button>';
					}
					
					dispHtml +='</span></div><br>';
					dispHtml += '<div id="reply_content">';
					dispHtml += '<p>' + this.commentContent +'</p>';
					dispHtml += '<span>' + this.commentRegdate +'</span></div></div></div>';
					
					$("#replyfor" + this.boardNo).html(dispHtml);
					
					$("#reply" + this.boardNo).hide();
				})
				
			
				
			},
			error: function(){
				alert("실패~~");
			}
		});
		
	};
	/*평점낮은순으로 정렬*/
	function orderRateAsc(){
		var lectureNo = "<c:out value ='${lecture.lectureNo}'/>";
		console.log(lectureNo);
		$.ajax("ajaxGetLectureCommentRateAsc.do?lectureNo=" + lectureNo, {
			type: "get",
			dataType: "json",
			async    : false,
			success: function(data){
				
				
				let dispHtml ="";
				
				$.each(data, function(index, obj){
					dispHtml += "<div id='reviewComment" + this.boardNo + "'><div id='review_header'>";
					
					for (var i =0; i<this.boardRate; i++){
						dispHtml += "<i class='fas fa-star' style='font-size:18px;color:orange'></i>"
					}
					
					dispHtml += "&nbsp;<b>" +  this.userId +"</b>";
					
					/* 사용자 댓글 삭제 */
					var lecturer = ${lecturer eq 'lecturer'};
					if (lecturer){
						dispHtml += '<button id="deletereply' + this.boardNo +'" class="btn btn-default letright" onclick="deleteComment(' + this.boardNo +')"><i class="fa fa-trash" aria-hidden="true"></i></button><br></div>';
					}
					
					dispHtml += "<div id='review_content'><p>" + this.boardContent + "</p>";
					dispHtml += "<div id='review_info'><span>" + this.boardRegdate;
					dispHtml +="<span id='replyfor" + this.boardNo + "' ></span>";	
					
					
					if (lecturer){
						dispHtml += '<button id="reply'+ this.boardNo + '" value="'  + this.boardNo + '"class="btn btn-default addreply" onclick="showReply(this)">답글쓰기</button>';
					}
					
					dispHtml += '</span>';
					dispHtml += "</div>";
					dispHtml += "</div><hr>";
					dispHtml +="<div id='replyForm" + this.boardNo + "' style='display:none'>	";				
					dispHtml +="<i class='material-icons' style='font-size:24px;color:black'>subdirectory_arrow_right</i><br>	";				
					dispHtml +="<span style='position: relative; left: 50px;'><textarea id='replytext" + this.boardNo + "' rows='5' cols='70'></textarea>";
					dispHtml +="<input type='button' name='boardContent' class='btn btn-default' value='답글 작성하기' onclick='submitReply(" + this.boardNo + ")'>";
					dispHtml +="</span></div>";
					dispHtml +="</div></div>";
					
					
				})
				$("#review_comment").html(dispHtml);
				
			},
			error: function(){
				alert("실패~~");
			}
		});
		
		$.ajax("ajaxGetCommentReply.do?lectureNo=" + lectureNo, {
			type: "post",
			dataType: "json",
			async    : false,
			success: function(data){
				let dispHtml="";
				$.each(data, function(index, obj){
					dispHtml = "";
					dispHtml += '<br><i class="fas fa-angle-down" style="font-size:24px"></i><br>';
					dispHtml += '<div style="background-color: #f8f9fa;">';
					dispHtml += '<div id="reply_header">';
					dispHtml += '<span class="border" >지식공유자</span>';
					dispHtml += '<span><b>' + this.lectureWriter +  '</b>'; 
					
					var lecturer = ${lecturer eq 'lecturer'};
					
					if (lecturer){
						dispHtml += '<button id="deletereply' + this.boardNo +'" class="btn btn-default letright" onclick="deletereply(' + this.boardNo +')"><i class="fa fa-trash" aria-hidden="true"></i></button>';
					}
					
					dispHtml +='</span></div><br>';
					dispHtml += '<div id="reply_content">';
					dispHtml += '<p>' + this.commentContent +'</p>';
					dispHtml += '<span>' + this.commentRegdate +'</span></div></div></div>';
					
					$("#replyfor" + this.boardNo).html(dispHtml);
					
					$("#reply" + this.boardNo).hide();
				})
				
			
				
			},
			error: function(){
				alert("실패~~");
			}
		});
		
	};
	
/*화면 킬때 할 ajax*/
	window.onload=function(){
		let today = new Date();
		let thour = today.getHours();
		let tminute = today.getMinutes();
		let shour = '${lecture.qsStart}'.substring(11, 13);
		let sminute = '${lecture.qsStart}'.substring(14, 16);
		let ehour = '${lecture.qsEnd}'.substring(11, 13);
		let eminute = '${lecture.qsEnd}'.substring(14, 16);

		let earlyStart = (shour > thour || ((shour === String(thour)) && (sminute > tminute)) ); // 시간이 작거나 시간이 같으면 분이 작으면 true
		let lateEnd = (ehour < thour || ((ehour === String(thour)) && (eminute < tminute)) ); // 시간이 크거나 시간이 같으면 분이 크면 true

		let rtDiv = $('#realtimeDiv');
		let weekday = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
		let dispHtml = '<span>&nbsp;|&nbsp;실시간 질문: ' + weekday[today.getDay()] + ' ' +
				'${lecture.qsStart}'.substring(11, 16)  + ' ~ ' + '${lecture.qsEnd}'.substring(11, 16) + '</span>';

		if(('${not empty lecture.qsStart}' === 'true')) {
			if(String(today.getDay()) !== '${lecture.qsWeekdays}') { // 해당 요일 아님
				rtDiv.css('display', 'none');
				rtDiv.after(dispHtml);
			} else if(earlyStart || lateEnd) { // 시작 시간 이전이거나 끝 시간 이후면 안 눌리게
				rtDiv.css('display', 'none');
				rtDiv.after(dispHtml);
			} else {
				rtDiv.css('display', '');
			}
		} else { // 실시간 강의 없으면 버튼 안 보이게
			rtDiv.css('display', 'none');
		}

		var lectureNo = "<c:out value ='${lecture.lectureNo}'/>";
		console.log(lectureNo);
		$.ajax("ajaxGetLectureComment.do?lectureNo=" + lectureNo, {
			type: "get",
			dataType: "json",
			async    : false,
			success: function(data){
				
				
				let dispHtml ="";
				
				$.each(data, function(index, obj){
					dispHtml += "<div id='reviewComment" + this.boardNo + "'><div id='review_header'>";
					
					for (var i =0; i<this.boardRate; i++){
						dispHtml += "<i class='fas fa-star' style='font-size:18px;color:orange'></i>"
					}
					
					dispHtml += "&nbsp;<b>" +  this.userId +"</b>";
					
					/* 사용자 댓글 삭제 */
					var lecturer = ${lecturer eq 'lecturer'};
					var board = this.boardNo;
					
					if (lecturer){
						dispHtml += '<button id="deletereply' + this.boardNo +'" class="btn btn-default letright" onclick="deleteComment(' + this.boardNo +')"><i class="fa fa-trash" aria-hidden="true"></i></button><br></div>';
					}
					
					dispHtml += "<div id='review_content'><p>" + this.boardContent + "</p>";
					dispHtml += "<div id='review_info'><span>" + this.boardRegdate;
					dispHtml +="<span id='replyfor" + this.boardNo + "' ></span>";	
					
					
					if (lecturer){
						dispHtml += '<button id="reply'+ this.boardNo + '" value="'  + this.boardNo + '"class="btn btn-default addreply" onclick="showReply(this)">답글쓰기</button>';
					}
					
					dispHtml += '</span>';
					dispHtml += "</div>";
					dispHtml += "</div><hr>";
					dispHtml +="<div id='replyForm" + this.boardNo + "' style='display:none'>	";				
					dispHtml +="<i class='material-icons' style='font-size:24px;color:black'>subdirectory_arrow_right</i><br>	";				
					dispHtml +="<span style='position: relative; left: 50px;'><textarea id='replytext" + this.boardNo + "' rows='5' cols='70'></textarea>";
					dispHtml +="<input type='button' name='boardContent' class='btn btn-default' value='답글 작성하기' onclick='submitReply(" + this.boardNo + ")'>";
					dispHtml +="</span></div>";
					dispHtml +="</div></div>";
					
					
				})
				$("#review_comment").html(dispHtml);
				
			},
			error: function(){
				alert("실패~~");
			}
		});
		
		$.ajax("ajaxGetCommentReply.do?lectureNo=" + lectureNo, {
			type: "post",
			dataType: "json",
			async    : false,
			success: function(data){
				let dispHtml="";
				$.each(data, function(index, obj){
					dispHtml = "";
					dispHtml += '<br><i class="fas fa-angle-down" style="font-size:24px"></i><br>';
					dispHtml += '<div style="background-color: #f8f9fa;">';
					dispHtml += '<div id="reply_header">';
					dispHtml += '<span class="border" >지식공유자</span>';
					dispHtml += '<span><b>' + this.lectureWriter +  '</b>'; 
					
					var lecturer = ${lecturer eq 'lecturer'};
					
					if (lecturer){
						dispHtml += '<button id="deletereply' + this.boardNo +'" class="btn btn-default letright" onclick="deletereply(' + this.boardNo +')"><i class="fa fa-trash" aria-hidden="true"></i></button>';
					}
					
					dispHtml +='</span></div><br>';
					dispHtml += '<div id="reply_content">';
					dispHtml += '<p>' + this.commentContent +'</p>';
					dispHtml += '<span>' + this.commentRegdate +'</span></div></div></div>';
					
					$("#replyfor" + this.boardNo).html(dispHtml);
					
					$("#reply" + this.boardNo).hide();
				})
				
			
				
			},
			error: function(){
				alert("실패~~");
			}
		});
		
	};
/*강의자 답글 삭제*/
	function deletereply(boardNo){
		
		$.ajax({
			url: "ajaxDeleteCommentReply.do?boardNo=" + boardNo + "&lectureNo=" + ${lecture.lectureNo},
			type: "post",
			dataType: "json",
			success: function(data){
				alert("답글 삭제");
				$("#replyfor" + boardNo).remove();
									
			},
			error: function(){
				alert("실패~~");
			}
					
		});
	}
	
	//댓글삭제
	function deleteComment(boardNo){
		$.ajax({
			url: "ajaxDeleteComment.do?boardNo=" + boardNo + "&lectureNo=" + ${lecture.lectureNo},
			type: "post",
			dataType: "json",
			success: function(data){
				alert("댓글 삭제");
				$("#reviewComment" + boardNo).remove();
									
			},
			error: function(){
				alert("실패~~");
			}
					
		});
	}
	
	function showReply(num){
		var findid = "#replyForm"+num.value;
		$(findid).toggle(700);
		
	}
	
	//답글 추가
	function submitReply(boardNo){
		
		var text = document.getElementById("replytext" + boardNo);
		var reply = $(text).val();  
		var findid = "#replyForm"+boardNo;
		$(findid).hide();
	
		$.ajax({
			url: "ajaxInsertCommentReply.do?boardNo=" + boardNo + "&lectureNo=" + ${lecture.lectureNo}+"&replyContent=" + reply,
			type: "post",
			dataType: "json",
			success: function(data){
				
				let dispHtml="";
				$.each(data, function(index, obj){
					dispHtml = "";
					dispHtml += '<br><i class="fas fa-angle-down" style="font-size:24px"></i><br>';
					dispHtml += '<div style="background-color: #f8f9fa;">';
					dispHtml += '<div id="reply_header">';
					dispHtml += '<span class="border" >지식공유자</span>';
					dispHtml += '<span><b>' + this.lectureWriter +  '</b>'; 
					
					var lecturer = ${lecturer eq 'lecturer'};
					
					if (lecturer){
						dispHtml += '<button id="deletereply' + this.boardNo +'" class="btn btn-default letright" onclick="deletereply(' + this.boardNo +')"><i class="fa fa-trash" aria-hidden="true"></i></button>';
					}
					
					dispHtml +='</span></div><br>';
					dispHtml += '<div id="reply_content">';
					dispHtml += '<p>' + this.commentContent +'</p>';
					dispHtml += '<span>' + this.commentRegdate +'</span></div></div></div>';
					
					$("#replyfor" + this.boardNo).html(dispHtml);
					
					$("#reply" + this.boardNo).hide();
					
				})
									
			},
			error: function(){
				alert("실패~~");
			}
					
		});
		
	}
	
	
	</script>




<%@include file ="/Common/footer.jsp"%>
</body>
</html>