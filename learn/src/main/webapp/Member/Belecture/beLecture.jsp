<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">



<title>Insert title here</title>

<style>
	.image { position: relative;} 
	.image .text { position: absolute;
	
	} 
	.text { 
		
			top: 30px;
			left: 30px;
			
	 }
	b { font-size: 1.2em;}
	
	.disable { display: none;}
	
	.container { margin: 0 auto; }
	#set { width:90%;
        margin:auto;
        display:block;}
        
 	.container { margin: 0 auto;
 }
	#set { width:90%;
        margin:auto;
        display:block;}
        
</style>

</head>
<body>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<%@include file ="/Common/header.jsp" %>

<div class="container">
<br>

<div class="image">
<img src="../../picture/desk.jpg" alt="desk" width="100%" height="100%" class="rounded">

<div class="text">
<h1>나의 지식에 가치를 부여하세요</h1><br>
<p>
	전체 지식공유자 평균 수익 3025만원!!<br>
나의 지식을 나눠 사람들에게 배움의 기회를 주고, 의미있는 대가를 가져가세요.<br>
인프런은 지식으로 의미있는 수익과 공유가 가능한 한국 유일한 플랫폼 입니다.<br>
</p>
<br>
 <!-- Button to Open the Modal -->
 <c:if test="${user eq null}">
 <button type="button" class="btn btn-primary" style="background-color: green" data-toggle="modal" data-target="#myModal" disabled>
    지식공유자 참여(로그인이 필요한 과정입니다)
  </button>
 </c:if>
 <c:if test="${user ne null }">
<button type="button" class="btn btn-primary" style="background-color: green" data-toggle="modal" data-target="#myModal">
    지식공유자 참여
  </button>
  </c:if>
          </div>


<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">${user.userId} 님! 안녕하세요.</h4>
          
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
         <h4 class="modal-title">지식공유에 동참해 주셔서 감사합니다!</h4>
          <h4 class="modal-title">인프런의 이야기를 들어주세요!</h4><br>
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
        
        <!-- Modal footer -->
        <div class="modal-footer justify-content-sm-center">
         <!--  <button type="button" class="btn btn-success" data-dismiss="modal">지식공유자 참여하기</button> -->
         <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal2" data-dismiss="modal" style="background-color: green">지식공유자 참여하기</button>
        </div>
        
      </div>
    </div>
  </div>
    <!-- The Modal -->
  <div class="modal" id="myModal2">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
       
          <h4 class="modal-title">감사합니다, ${user.userId} 님</h4>

          
        </div>
        
        <!-- Modal body -->
        <div class="modal-body container">
         	<h4>지식공유자가 되기 위해서</h4>
	<h4>아래 정보가 필요해요.</h4>
	<br>
	<form method="post">
    <div class="form-group">
      <label for="email">인프런 계정</label>
      <input type="text" class="form-control" id="userId"  name="userId" value="${user.userId}" readonly >
    </div>
    <div class="form-group">
      <label for="pwd">이름(실명)</label>
      <input type="text" class="form-control" id="userName" placeholder="이름을 입력해주세요" name="userName">
    </div>
  	 <div class="form-group">
      <label for="pwd">연락처</label>
      <input type="text" class="form-control" id="userTel" placeholder="연락처를 입력해주세요" name="userTel">
    </div>
       <div class="form-group">
      <label for="text">희망분야</label>
      <input type="text" class="form-control" id="categoryName" placeholder="희망분야를 입력해주세요" name="categoryName">
    </div>
   
     <div class="form-group">
      <label for="text"> 나를 소개하는 글 *</label> 
      <textarea rows="10" cols="20" class="form-control" name="userIntroduce" id="userIntroduce"></textarea>
    </div>
    
    <div class="form-group modal-footer">
      <label for="text">나를 표현할 수 있는 링크</label>
     <input type="text" class="form-control" id="userLink" name="userLink" placeholder="test1234@gmail.com">
    </div>
    
    <button type="submit"  id="set" class="btn btn-success" onclick="submitAndclose(this.form)" disabled>제출</button>
  </form>
	
        </div>
        
      </div>
    </div>
  
  
  
</div>


<img src="../../picture/lecturedata1.png" alt="수익 회원수 누적 수강생" width=90%>

<img src="../../picture/lecturedata2.png" alt="수익 회원수 누적 수강생" width=40% style="float: right">
</div>
<br><div class="container">
	<h3>지식공유자를 위한<br>
높은 정산 비율</h3>
<br>

보통은 교육컨텐츠 수입의<br>
50% 이상을 플랫폼이나 학원이 가져갑니다.<br>
자신의 지식을 나누는 지식공유자에게<br>
더 많은 보상이 주어져야 하는 것 아닐까요?<br><br>
<h5>인프런은<br>
강의: 70%~90% , 멘토링: 100%<br>
비율로 정산합니다.<br><br></h5>
인프런은 합리적인 정책으로 지식공유자와<br>
학습자 모두에게 도움이 되는 선순환을 만들어 갑니다.<br><br>



</div>
<br><br>

<div class="text-center">
<h1> 왜 인프런 일까요?</h1><br>

<div class="row">
      <div class="col-sm-4" >
		<img src="../../picture/img1.png" width="30%">
      </div>
      <div class="col-sm-4" >
		<img src="../../picture/img2.png" width="30%">
	</div>
      <div class="col-sm-4" >
		<img src="../../picture/img3.png" width="30%">
	</div>
</div>

<div class="row">
      <div class="col-sm-4" >
		<b>지식 콘텐츠를 함부로 다루지 않습니다.</b>
      </div>
      <div class="col-sm-4" >
	<b>수익이 가능한 유일한 곳</b>
</div>
      <div class="col-sm-4" >
	<b>사회적 가치를 실현하세요.</b>
</div>
</div>

<br>
  
<div class="row">
<div class="col-sm-4" >
		<p>너무 크고 잦은 할인은 결과적으로 콘텐츠의 질을 떨어뜨리
		고, 지식의 가치를 존중하지 않는 일이라 생각합니다. 인프런
		은 합리적인 가격 정책으로 지식공유자와 학습자 모두에게 도
		움이 되는 생태계를 만들어 가고 있습니다.</p>
      </div>
      <div class="col-sm-4" >
		<p>
		인프런은 기술 강의로 의미 있는 보상을 가질 수 있는 유일한 플랫폼
		입니다. 수강생이 강의를 신청할 때마다 수익을 얻으세요.
		지속가능한 수익과 명예를 가져가세요.
		강의 매출의 70% ~ 90% 를 가져가실 수 있습니다.
	</p>
</div>
      <div class="col-sm-4" >
	<p>
		오직 인프런에서만 가능합니다.
		자신의 지식으로 지속가능한 수익을 올리면서도,
		많은 사람들에게 경제적인 배움의 기회를 줄 수 있습니다.
		사람들이 성장하고, 자신의 능력을 향상하도록 인프런과
		함께해주세요.
	</p>
</div>
 </div>

<br>

<div class="row">
      <div class="col-sm-4" >
		<img src="../../picture/img4.png" width="30%">
      </div>
      <div class="col-sm-4" >
		<img src="../../picture/img5.png" width="30%">
	</div>
      <div class="col-sm-4" >
		<img src="../../picture/img6.png" width="30%">
	</div>
</div>

<div class="row">
      <div class="col-sm-4" >
		<b>자유로운 강의 운영</b>
      </div>
      <div class="col-sm-4" >
	<b>네트워크 & 인프라</b>
</div>
      <div class="col-sm-4" >
	<b>인프런 만의 노하우</b>
</div>
</div>
<br>
  
<div class="row">
<div class="col-sm-4" >
		<p>
		마음껏 자신의 강의를 운영해 보세요.
		쿠폰발행, 학생추가, 강의편집 등 자유롭게 강의를 운영할 수 있습니다.
		폭 넓은 활용 방법을 이용해서 자신만의 강의 영역을 확대해 보세요.
		</p>
      </div>
      <div class="col-sm-4" >
		<p>
		인프런의 네트워크를 활용하세요.
		수많은 IT 기업에서 이미 인프런과 연계를 맺고 함께 성장하고 있어요.
		인프런에 강의를 개설한다면, 수많은 사람들과
		기업들이 당신의 강의를 보게될 거에요.
	</p>
</div>
      <div class="col-sm-4" >
	<p>
		강의에 필요한 노하우와 지식이 없다고 걱정하지 마세요.
		기본적인 준비를 함께하며, 노하우를 알려드립니다.
		좋은 지식을 나누실 분들은 오피스를 찾아주세요.
		부담없이 이야기 나누며 강의를 함께 만들어요!
	</p>
</div>
 </div>

</div>

<br><br>
<div class="text-center">
<h1>지식공유자가 되어 주세요!</h1>


<div class="row">
	<div class="col-sm-6">
		<button class="btn" id="procedurebtn"><h2>절차</h2></button>
	</div>
	<div class="col-sm-6" id="faqbtn">
	<button class="btn"><h2>FAQ</h2></button>
	</div>
</div>

</div>
<br>

<div id="procedure">
<div class="row">
        <div class="col-sm-6">
			<div class="card">
			<div class="card-body">
			
        <p class="card-text"><b><span class="text-success">01.</span> 신청하고, 강의를 만드세요.</b><br>
커뮤니케이션 매니저가 강의 제작과 노하우를 공유해드려요!</p>
 		</div>
 </div>
 </div>
      <div class="col-sm-6">
			<div class="card">
			<div class="card-body">
			
        <p class="card-text"><b><span class="text-success">02.</span> 동영상을 업로드하고 소개글을 작성해주세요.</b><br>
콘텐츠 매니저가 강의 소개글과 이미지 최적화를 도와드립니다.</p>
 		</div>
 </div>
 </div>
      
</div>


<div class="row">
        <div class="col-sm-6">
			<div class="card">
			<div class="card-body">
			
        <p class="card-text"><b><span class="text-success">03.</span> 자기만의 커뮤니티를 만들어보세요.</b><br>
마케팅 매니저가 홍보와 연결을 도와드립니다.</p>
 		</div>
 </div>
 </div>
      <div class="col-sm-6">
			<div class="card">
			<div class="card-body">
			
        <p class="card-text"><b><span class="text-success">04.</span> 이제 합당한 보상을 받으세요</b><br>
운영 매니저가 정산 내역을 송부해드립니다.</p>
 		</div>
 </div>
 </div>
      
</div>
</div>

<div id="faq" class="disable">
<div class="row">
	<div class="col-sm-4">
		<b><span class="text-success">01.</span> 정산 비율은 어떻게 되나요?</b><br>
	</div>
	<div class="col-sm-8">
	<p>
		인프런의 정산 비율은 기본적으로 70:30 으로 지식공유자분이 70%의 수익을 가져가세요 :) 정산은 매 10영업일 이내에 지급됩니다.
	</p>
	</div>
</div>

<div class="row">
	<div class="col-sm-4">
		<b><span class="text-success">02.</span> 소득 신고는 어떻게 되나요?</b><br>
	</div>
	<div class="col-sm-8">
		<p>
개인으로 강의를 제작하실 경우, 사업소득으로 신고되며,
 수익에서 원천세 3.3% 정산이 진행돼요. 원천세 신고 및 납부는 인프런에서 모두 해 드립니다.
  사업자로 강의를 제작하신다면, 매입으로 처리되어 부가세를 포함한 금액으로 정산하며,
   추후 저희에게 세금계산서를 발급해주셔야 해요!
   </p>
	</div>
</div>

<div class="row">
	<div class="col-sm-4">
		<b><span class="text-success">03.</span> 심사에는 어느정도 소요가 되나요?</b><br>
	</div>
	<div class="col-sm-8">
		<p>
강의를 제작하고 나면 인프런 운영팀에서 간단한 심사가 진행돼요.
 심사에는 영업일 기준 10일까지 걸릴 수 있어요.
 심사가 모두 끝나면 담당 MD가 오픈 안내 메일을 드립니다.
   </p>
	</div>
</div>

<div class="row">
	<div class="col-sm-4">
		<b><span class="text-success">04.</span> 인프런에서 강의를 편집해주시나요?
       강의 제작 팁 같은게 있을까요?</b><br>
	</div>
	<div class="col-sm-8">
		<p>
인프런은 지식공유 플랫폼만 제공하며,
 별도로 영상편집을 해드리고 있지는 않아요.
  다만, 그동안 쌓인 노하우를 공유해드릴 수 있어요!
   이 노하우는 강의신청 후 담당 매니저에게서 안내 받으실 수 있습니다 :)
   </p>
	</div>
</div>

<div class="row">
	<div class="col-sm-4">
		<b><span class="text-success">05.</span> 내 강의의 수익을 투명하게 알 수 있나요?</b><br>
	</div>
	<div class="col-sm-8">
		<p>
네. 인프런에 강의를 올리면 실시간으로 수강생들의 신청기록을 확인할 수 있습니다.
   </p>
	</div>
</div>

<div class="row">
	<div class="col-sm-4">
		<b><span class="text-success">06.</span> 수익이 얼마나 될까요?</b><br>
	</div>
	<div class="col-sm-8">
		<p>
강의에 따라 매월 수천만원에서 수십만원 까지 천차만별 이라 예측하긴 어렵습니다.
 다만 좋은 지식을 올려주시면 그에 맞는 수익을 가져가실 수 있습니다.
  1억원 이상 수익을 거둔 분도 계세요. :D
   </p>
	</div>
</div>
</div>


</div>

<script>
$(document).ready(function(){
  $("#procedurebtn").click(function(){

	$("#faq").addClass("disable");
	$("#procedure").removeClass("disable");
	
  });   
  $("#faqbtn").click(function(){

		$("#procedure").addClass("disable");
		$("#faq").removeClass("disable");
		
	  });   
});

function submitAndclose(frm){
		frm.action="insertResume.do";
	return false;

		}

	$(".form-control").on("keyup", function(){
		var flag1 = $("#userId").val().length > 0 ? false : true;
		var flag2 = $("#userName").val().length > 0 ? false : true;
		var flag3 = $("#userTel").val().length > 0 ? false : true;
		var flag4 = $("#categoryName").val().length > 0 ? false : true;
		var flag5 = $("#userIntroduce").val().length > 0 ? false : true;
		var flag6 = $("#userLink").val().length > 0 ? false : true;
		
		if (flag1== false && flag2== false &&flag3== false &&
				flag4== false &&flag5== false &&flag6== false){
		$("#set").attr("disabled", false);
		}
})
</script>


<%@include file ="/Common/footer.jsp"%>
</body>
</html>