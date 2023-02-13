<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
	.tape {
		height: 100px;
		margin: 50px auto;
		padding-top: 15px;
		color: white;
	}

</style>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

 <%@ include file="../Common/header.jsp"%>
 <div class="container-fluid bg-dark">
	<div class="container tape">
		<section class="tapeContent">		
			<h2>회원가입</h2>
		</section>
	</div>
</div>
	<div class="container-fluid mt-5 pb-3 d-flex justify-content-center">

		<div class="row w-100 pb-4 justify-content-center">
			<!-- 왼쪽 네비 -->
			<div class="col-2 d-flex justify-content-center">
				<a href="#" style="position: fixed;"><img class="mt-3" height="35px" src="${pageContext.request.contextPath}/Community/img/back.png"></a>
			</div>
			<div class="col-6 pl-3 gray-line">

			<div class="text-center">
				<div>
					<h2>회원가입</h2>

					<div>
						<p class="">나의 온라인 사수, 인프런</p>
					</div>
					<div class="mx-auto" style="width: 25%;">
						<form action="${pageContext.request.contextPath}/Member/insertUser.do" method="get">
							<div>
								<label for="user_email" style="float: left;">이메일</label>
								<div>
									<input type="email" id="user_email" name="userId" class="w-100"
										placeholder="example@inflab.com" required>
								</div>
								<div class="" id="email_check"></div>
								<div class="input-group-addon">
									<button type="button" class="btn btn-primary" id="mail-Check-Btn" disabled="disabled">이메일인증</button>
								</div>
								<div class="mail-check-box">
									<input class="form-control mail-check-input" placeholder="인증번호를 입력해주세요!" disabled="disabled" maxlength="6">
								</div>
								<div>
									<span id="mail-check-warn"></span>
								</div>
							</div>
							<div class="">
								<label for="user_pw" style="float: left;">비밀번호</label>
								<div>
									<input id="user_pw" name="userPwd" class="w-100" type="password"
										placeholder="******" required>
								</div>
								<div class="" id="pw_check"></div>

							</div>

							<div class="">
								<label for="user_pw2" style="float: left;">비밀번호 확인</label>
								<div>
									<input id="user_pw2" name="pwdCh" class="w-100" type="password"
										placeholder="******" required>
								</div>
								<div id="pw2_check"></div>
							</div>
							
							<div class="">
								<label for="user_name" style="float: left;">이름</label>
								<div>
									<input id="user_name" name="userName" class="w-100" type="text"
										placeholder="홍길동" required>
								</div>
								<div id="name_check"></div>
							</div>
							
							<div class="">
								<label for="user_birth" style="float: left;">생년월일</label>
								<div>
									<input id="user_birth" name="userBirth" class="w-100" type="text"
										placeholder="19990101" required>
								</div>
								<div id="birth_check"></div>
							</div>
							<br>
							<button type="submit" class="btn btn-success w-100"
								id="reg_submit" disabled="disabled">가입하기</button>
						</form>
					</div>
					<div class="signup__social">
						<hr class="social__line">
						<span class="social__title">간편 회원가입</span>
						<div class="social__signup-buttons">

							<button
								class="social__button social__button--Kakao e-social-sign-up"
								data-provider="Kakao"
								data-link="https://kauth.kakao.com/oauth/authorize?response_type=code&amp;client_id=0de1184063abadc9cef9dbf417c567a5&amp;redirect_uri=https%3A%2F%2Fwww.inflearn.com%2Fauth%2Fkakao&amp;scope=profile%2Caccount_email%2Cbirthday%2Cbirthyear%2Cphone_number%2Cage_range%2Cgender&amp;state=%7B%22prev_url%22%3A%22https%3A%2F%2Fwww.inflearn.com%2Fsignin%22%7D">
								<svg width="18px" xmlns="http://www.w3.org/2000/svg" height="17"
									viewBox="0 0 18 17" backgroundcolor="yellow">
								<g
										transform="translate(0.000000,17.000000) scale(0.100000,-0.100000)"
										stroke="none">
								<path fill="#212529"
										d="M38 154 c-15 -8 -30 -25 -34 -38 -6 -26 10 -66 27 -66 7 0 9 -10 5 -26 -7 -25 -6 -25 16 -10 12 9 31 16 41 16 29 0 75 28 82 50 10 31 -3 59 -35 75 -36 19 -67 18 -102 -1z"></path></g></svg>
							</button>


							<button
								class="social__button social__button--Google e-social-sign-up"
								data-provider="Google"
								data-link="https://accounts.google.com/o/oauth2/v2/auth?access_type=offline&amp;prompt=consent&amp;scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.profile&amp;response_type=code&amp;client_id=887875630717-ror9t8ig4obhvokdij07eoochpqbu5kf.apps.googleusercontent.com&amp;redirect_uri=https%3A%2F%2Fwww.inflearn.com%2Fauth%2Fgoogle&amp;state=%7B%22prev_url%22%3A%22https%3A%2F%2Fwww.inflearn.com%2Fsignin%22%7D">
								<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
									fill="none" viewBox="0 0 18 18">
								<path fill="#4285F4"
										d="M17.785 9.169c0-.738-.06-1.276-.189-1.834h-8.42v3.328h4.942c-.1.828-.638 2.073-1.834 2.91l-.016.112 2.662 2.063.185.018c1.694-1.565 2.67-3.867 2.67-6.597z"></path>
								<path fill="#34A853"
										d="M9.175 17.938c2.422 0 4.455-.797 5.94-2.172l-2.83-2.193c-.758.528-1.774.897-3.11.897-2.372 0-4.385-1.564-5.102-3.727l-.105.01-2.769 2.142-.036.1c1.475 2.93 4.504 4.943 8.012 4.943z"></path>
								<path fill="#FBBC05"
										d="M4.073 10.743c-.19-.558-.3-1.156-.3-1.774 0-.618.11-1.216.29-1.774l-.005-.119L1.254 4.9l-.091.044C.555 6.159.206 7.524.206 8.969c0 1.445.349 2.81.957 4.026l2.91-2.252z"></path>
								<path fill="#EB4335"
										d="M9.175 3.468c1.684 0 2.82.728 3.468 1.335l2.531-2.471C13.62.887 11.598 0 9.175 0 5.667 0 2.638 2.013 1.163 4.943l2.9 2.252c.727-2.162 2.74-3.727 5.112-3.727z"></path></svg>
							</button>

						</div>
						<hr class="social__line social__line--mobile">
					</div>
				</div>
			</div>
			</div>
		</div>
	</div>

	<script>
	
		$('#mail-Check-Btn').click(function() {
			const email = $('#user_email').val(); // 이메일 주소값 얻어오기!
			console.log('완성된 이메일 : ' + email); // 이메일 오는지 확인
			const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
			console.log('여기까진 오죠?');
			$.ajax({
				type : 'get',
				url : '<c:url value ="/Member/mailCheck.do?email="/>'+email, // GET방식이라 Url 뒤에 email을 뭍힐수있다.
				success : function (data) {
					console.log("data : " +  data);
					checkInput.attr('disabled',false);
					code =data;
					alert('인증번호가 전송되었습니다.')
				}		
			}); // end ajax
		}); // end send eamil
		
		// 인증번호 비교 
		// blur -> focus가 벗어나는 경우 발생
		$('.mail-check-input').blur(function () {
			const inputCode = $(this).val();
			const $resultMsg = $('#mail-check-warn');
			
			if(inputCode === code){
				$resultMsg.html('인증번호가 일치합니다.');
				$resultMsg.css('color','green');
				$('#mail-Check-Btn').attr('disabled',true);
				$("#reg_submit").attr('disabled', false);
				$('#userEamil1').attr('readonly',true);
				$('#userEamil2').attr('readonly',true);
				$('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
		         $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
			}else{
				$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
				$resultMsg.css('color','red');
			}
		});
		// 이름 정규식
		var nameJ = /^[가-힣]{2,6}$/;
		// 비밀번호 정규식
		var pwJ = /^(?!((?:[A-Za-z]+)|(?:[~!@#$%^&*()_+=]+)|(?:[0-9]+))$)[A-Za-z\d~!@#$%^&*()_+=]{8,32}$/;
		// 이메일 검사 정규식
		var mailJ = /^[0-9a-zA-Z]{4,22}([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		// 비밀번호 체크 확인
		$('#user_pw').keyup(function() {
							if (pwJ.test($('#user_pw').val())) {
								console.log('true');
								$('#pw_check').text('비밀번호 통과');
								$('#pw_check').css('color', 'blue');
							} else {
								console.log('false');
								$('#pw_check').text('영문/숫자/특수문자 2가지 이상 포함+8자 이상 32자 이하 입력 (공백 제외)');
								$('#pw_check').css('color', 'red');
							}
						});

		$('#user_pw2').blur(function() {
			if ($('#user_pw').val() != $(this).val()) {
				console.log('false');
				$('#pw2_check').text('비밀번호가 일치하지 않습니다.');
				$('#pw2_check').css('color', 'red');
			} else {
				console.log('true');
				$('#pw2_check').text('비밀번호 통과');
				$('#pw2_check').css('color', 'blue');
			}

		});
		// 이메일
		$('#user_email').keyup(function() {
			$("#mail-Check-Btn").attr('disabled', true);
			var userId = $('#user_email').val();
			var typeVl = {userId: userId};
			$.ajax({
				url : "insertIdCheck.do",
				data : typeVl,
				type : "post",
				
				success : function(data){
					console.log("1 = 중복o / 0 = 중복x : "+ data);
					if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$("#email_check").text("사용중인 아이디입니다.");
						$("#id_check").css("color", "red");
					} else {
						if (mailJ.test($('#user_email').val())) {
							console.log('true');
							$('#email_check').text('사용가능한 아이디 입니다.');
							$('#email_check').css('color', 'blue');
							$("#mail-Check-Btn").attr('disabled', false);
						} else if($('#user_id').val() == ""){
							$('#email_check').text('아이디를 입력해주세요 :');
							$('#email_check').css('color', 'red');
							$("#mail-Check-Btn").attr('disabled', true);
						} else {
							console.log('false');
							$('#email_check').text('이메일을 확인해 주세요 :');
							$('#email_check').css('color', 'red');
							$("#mail-Check-Btn").attr('disabled', true);
						}		
						
					}
				}, error : function () {
							console.log("실패");
				}
			
			});
		});
		//이름에 특수문자 불가
		$("#user_name").keyup(function() {
			if (nameJ.test($(this).val())) {
					console.log(nameJ.test($(this).val()));
					$("#name_check").text('');
			} else {
				$('#name_check').text('이름을 확인해주세요');
				$('#name_check').css('color', 'red');
			}
		});		
		
		
		
		
		// 생년월일	birthJ 유효성 검사
		var birthJ = false;
		$('#user_birth').keyup(function(){
			// 생일 유효성 검사 변수선언
			birthJ = false;
			var dateStr = $(this).val();		
		    var year = Number(dateStr.substr(0,4)); // 입력한 값의 0~4자리까지 (연)
		    var month = Number(dateStr.substr(4,2)); // 입력한 값의 4번째 자리부터 2자리 숫자 (월)
		    var day = Number(dateStr.substr(6,2)); // 입력한 값 6번째 자리부터 2자리 숫자 (일)
		    var today = new Date(); // 날짜 변수 선언
		    var yearNow = today.getFullYear(); // 올해 연도 가져옴
			
		    if (dateStr.length <=8) {
				// 연도의 경우 1900 보다 작거나 yearNow 보다 크다면 false를 반환합니다.
			    if (1900 > year || year > yearNow){
			    	
			    	$('#birth_check').text('생년월일을 확인해주세요 :)');
					$('#birth_check').css('color', 'red');
			    	
			    }else if (month < 1 || month > 12) {
			    		
			    	$('#birth_check').text('생년월일을 확인해주세요 :)');
					$('#birth_check').css('color', 'red'); 
			    
			    }else if (day < 1 || day > 31) {
			    	
			    	$('#birth_check').text('생년월일을 확인해주세요 :)');
					$('#birth_check').css('color', 'red'); 
			    	
			    }else if ((month==4 || month==6 || month==9 || month==11) && day==31) {
			    	 
			    	$('#birth_check').text('생년월일을 확인해주세요 :)');
					$('#birth_check').css('color', 'red'); 
			    	 
			    }else if (month == 2) {
			    	 
			       	var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
			       	
			     	if (day>29 || (day==29 && !isleap)) {
			     		
			     		$('#birth_check').text('생년월일을 확인해주세요 :)');
						$('#birth_check').css('color', 'red'); 
			    	
					}else{
						$('#birth_check').text('');
						birthJ = true;
					}//end of if (day>29 || (day==29 && !isleap))
			     	
			    }else{
			    	
			    	$('#birth_check').text(''); 
					birthJ = true;
				}//end of if
				
			} else{
				//1.입력된 생년월일이 8자 초과할때 :  auth:false
				$('#birth_check').text('생년월일을 확인해주세요 :)');
				$('#birth_check').css('color', 'red');  
			}
		}); //End of method /*
	</script>
	<script>
		var inval_Arr = new Array(4).fill(false);
		let go = document.forms[0];
		$('#reg_submit').click(
				function() {
					// 이름 정규식
					if (nameJ.test($('#user_name').val())) {
						inval_Arr[3] = true;	
					} else {
						inval_Arr[3] = false;
					}
					// 비밀번호가 같은 경우 && 비밀번호 정규식
					if (($('#user_pw').val() == ($('#user_pw2').val()))
							&& pwJ.test($('#user_pw').val())) {
						inval_Arr[0] = true;
					} else {
						inval_Arr[0] = false;
					}
					// 이메일 정규식
					if (mailJ.test($('#user_email').val())) {
						console.log(mailJ.test($('#user_email').val()));
						inval_Arr[1] = true;
					} else {
						inval_Arr[1] = false;
					}
					// 생년월일 정규식
					if (birthJ) {
						console.log('birthj' + birthJ);
						inval_Arr[2] = true;
					} else {
						inval_Arr[2] = false;
					}
					for (var i = 0; i < inval_Arr.length; i++) {
						if (inval_Arr[i] == false) {
							alert('입력한 정보들을 다시 한번 확인해주세요 :)');
							return false;
						} 
							
					}
					go.submit();
				});
	</script>
	<footer>
		<%@ include file="../Common/footer.jsp"%>
	</footer>
</body>
</html>