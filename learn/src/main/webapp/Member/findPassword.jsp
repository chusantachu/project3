<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정 비밀번호 재설정</title>
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
   <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
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
</style>

<script>

	function go_verify(frm) {
		var findId = {};
		findId.userId = frm.userId.value;
		
		console.log(JSON.stringify(findId));
		
		
		// 이메일 검사 정규식
		var mailJ = /^[0-9a-zA-Z]{4,22}([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		// 이메일 형식 체크
		
		if (mailJ.test(frm.userId.value)) {
			
			$.ajax("${pageContext.request.contextPath }/member/findPassword.do", {
		        type : "post",
		        data : JSON.stringify(findId),
		        contentType : "application/json",
		        dataType: "json",
		        success : function(data){
		            //alert("성공");

		            if (data.length == 0) {
		            	
		    			$("input[name=userId]").addClass("is-invalid");
		    			$("#caption").addClass("onError text-danger");
		    			$("#caption").text("메일 주소를 다시 확인해 주세요.");
		    			
		    			$("#user_email").keyup(function(){
		    				$("#caption").removeClass("onError text-danger");
		    				$("#caption").text("");
		    				$("input[name=userId]").removeClass("is-invalid");
		    			});
		    			
		            } else {

			         	let dispHtml = "";
			         	
		            	$.each(data, function(index, obj){
		            		
		            		if (obj.userPwd == null) {
		            			  
					            console.log(obj);
				    			$("input[name=userId]").addClass("is-invalid");
				    			$("#caption").addClass("onError text-danger");
				    			$("#caption").text(obj.socialType + " 로그인을 통해 가입한 회원입니다.");
			            		
			            	} else {
			            		
					            	console.log(obj);
					            	
					            	// 전달받은 아이디로 유저 유무 확인 후 메일 전송 후에 넘어 오는 폼
					            	dispHtml += '<h3 class="h3-bold py-5">비밀번호 설정 메일 발송</h3>';
					            	dispHtml += '<p class="py-3">';
					            	dispHtml += '위 주소로 인증 메일이 발송되었습니다. <br>';
					            	dispHtml += '이메일 인증을 통해 비밀번호 변경 화면으로 이동 가능합니다. <br>';
					            	dispHtml += '(몇 분 내로 확인되지 않으면 스팸 폴더를 확인해 주세요)';
					            	dispHtml += '</p>';
					            	dispHtml += '<div class="w-100 py-3 mx-auto">';
					            	dispHtml += '<form>';
					    	        dispHtml += '<input type="text" name="insertNo" class="form-control w-50 d-inline" placeholder="인증번호: ">';
					            	dispHtml += '<input type="button" class="m-3 btn btn-outline-secondary" value="인증요청" onclick="check_verify(this.form)">';
					            	dispHtml += '<br>';
					            	dispHtml += '<small id="verifyNoCheck" class="invalid"></small>';
					            	dispHtml += '<p class="text-left ml-1"><small class="timer text-danger"></small></p>';
					            	dispHtml += '</form>';
					            	dispHtml += '</div>';	
			            	}

		                });
		            	
			            $("#verifyForm").html(dispHtml);
		            	
		            	
		            	
		            	
		            }
		            	
		            
		        	$(function(){
		        		var time = 60*3; // 기준 시간 테스트용 30 초
		        		var min = ""; //분
		        		var sec = "";
		        		
		        		var x = setInterval(function(){
		        			min = parseInt(time/60);
		        			sec = time%60;
		        			
		        			$(".timer").text(min + "분" + sec + "초");
		        			time--;
		        			
		        			if (time < 0) {
		        				clearInterval(x);
		        				$("input[name=verifyNo]").attr("disabled", true);
		        				$(".timer").html("인증 시간이 만료되었습니다.<br>다시 이메일 입력부터 진행해 주세요.");
		        				//sessionStorage.removeItem("verifyNO");
		        			}
		        			
		        		}, 1000);
		        	});	       

		        },
		        error: function(){
		            alert("실패");
		        }
		   })		
			
		} else {
			$("#caption").addClass("onError text-danger");
			$("#caption").text("메일 형식을 다시 확인해 주세요.");
		}
		

		
		
		
	}
	
	
	function check_verify(frm) {
		
		var checkNO = {};
		checkNO.insertNo = frm.insertNo.value;
		
		console.log(JSON.stringify(checkNO));
		
		$.ajax("${pageContext.request.contextPath }/member/checkVerifyNO.do", {
	        type : "post",
	        data : JSON.stringify(checkNO),
	        contentType : "application/json",
	        dataType: "json",
	        success : function(data){
	            //alert("성공");
	            console.log(data);
	            
	            let dispHtml = "";
	            
	            if (data.length == 0) {
	            	
	            	 dispHtml += '<p class="text-left">';
	            	 dispHtml += '<small class="invalid text-danger mx-3">비밀번호가 일치하지 않습니다</small>';
	            	 dispHtml += '</p>';
	            	 
	            	 $("#verifyNoCheck").html(dispHtml);
	            	 
	            } else {
	            	location.href="${pageContext.request.contextPath }/member/changePasswordPage.do";
	            }

	        },
	        error: function(){
	            alert("실패");
	        }
	   })
	}

</script>

</head>
<body>
<%@include file="/Common/header.jsp" %>
<div class="container-fluid bg-dark">
		<div class="container tape">
			<section class="tapeContent">
				<h2>비밀번호 재설정</h2>
			</section>
		</div>
	</div>
<div class="container h-100 text-center">

	<div class="d-flex align-items-center mx-auto text-center h-100">
		<div id="findForm" class="mx-auto">
			<h3 class="h3-bold">비밀번호 재설정</h3>
			<p>
				비밀번호를 잃어버리셨나요? <br>
				이메일 인증을 통해 비밀번호 변경 화면으로 이동 가능합니다.
			</p>
			<div class="w-100 p-3 mx-auto">
				<form action="ajaxSendPassword" method="post" class="form-group">
					<input id="user_email" type="text" name="userId" class="form-control my-2" placeholder="example@gmail.com"> 
					<small id="caption" class="invalid"></small>
					<input type="button" class="btn-block btn btn-success my-2" value="인증번호 전송" onclick="go_verify(this.form)">
				</form>
				<div id="verifyForm">
				</div>
			</div>
		</div>
	</div>




</div>	
<%@include file="/Common/footer.jsp" %>
</body>
</html>