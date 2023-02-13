<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
   
<title>Insert title here</title>
<style>
	.container { margin: 0 auto; }
	#set { width:90%;
        margin:auto;
        display:block;}
</style>

</head>
<body>

<div class="container">
	<h2>${user.userId} 님! 안녕하세요.</h2>
	<h2>지식공유에 동참해 주셔서 감사합니다!</h2>
	<h2>인프런의 이야기를 들어주세요!</h2>
	<br>
	<h3>1. 인프런은 성장기회의 평등을 추구합니다.</h3>
	<p>우리는 때로 무언가를 배워야만 합니다.
하지만 여러 이유로 당연하다고 생각되어 지는것들이 누군가에게는 사치가 되기도 합니다.
인프런은 누구나, 경제적으로 시간적 제약없이 내가 원하는 것을 배우고, 지식을 나눌 수 있는 공간입니다.<br></p>
	<br>
	<h3>2. 전문 지식으로 수익이 가능한 유일한 곳.</h3>
	<p>인프런은 기술 강의, 멘토링으로 의미 있는 보상을 가질 수 있는 유일한 플랫폼 입니다.
	 99만명의 수강생이 강의를 신청할 때마다 수익을 얻을 수 있어요!
지속가능한 수익과 명예를 가져가세요 :)<br></p>
	<br>
	<h3>3. 인프런은 70% ~ 100% 의 비율의 높은 수익을 제공합니다.</h3>
	<p>좋은 지식은 합당한 보상에서 나온다고 인프런은 생각합니다.
	 때문에 인프런은 다른 학습 서비스에 비해 월등히 높은 수익을 드리고 있어요.
실제로 인프런엔 꾸준히 월 수백 ~ 수천 만원 이상의 수익을 가져가는 많은 지식공유자들이 계셔요. <br></p>
	<br>
	<h3>4. 인프런의 강의는 지식공유자가 자유롭게 운영할 수 있습니다.</h3>
	<p>지식공유자는 학생추가, 새소식 알림, 운영, 쿠폰 발행 등으로 자신의 강의를 자유롭게 운영할 수 있습니다.
	 학습자들과 소식을 공유하고 자유롭게 운영해 주세요.<br></p>
	<br>
	</div>	
	<button id= "set" class="btn btn-success" onclick="location.href='beLectureform2.jsp'">지식공유자 참여하기</button>
	

</body>
</html>