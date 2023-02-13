<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저정보</title>
<style>
.tape {
	height: 100px;
	margin: 50px auto;
	padding-top: 15px;
	color: white;
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script>



</script>

<style type="text/css">
	#sideNavCon{
		border-top: solid 1px #dddddd;
		border-bottom: solid 1px #dddddd;
	}
</style>
</head>
<body>
	<%@ include file="../../Common/header.jsp"%>

	<div class="container-fluid mt-5 pb-3 d-flex justify-content-center">
		<div class="row w-100 pb-4 justify-content-center">
			<!-- 왼쪽 사이드바 -->
			<div class="col-2" style="width: 500px;">
					
					<ul class="nav flex-column">
					    <li class="nav-item">
					      <a class="nav-link disabled" href="#">${userDetail.userName }</a>
					    </li>
					    <li class="nav-item">
					      <a class="nav-link disabled" href="#">수강생수 / 평균별점</a>
					    </li>
				    </ul>
				    					
					<ul class="nav flex-column">
					    <li class="nav-item">
					      <a class="nav-link" href="#">홈</a>
					    </li>
					    <li class="nav-item">
					      <a class="nav-link" href="#">강의</a>
					    </li>
					    <li class="nav-item">
					      <a class="nav-link" href="#">수강후기</a>
					    </li>
					    <li class="nav-item">
					      <a class="nav-link" href="#">게시글</a>
					    </li>
					    
					    <!-- 채팅을 누르면 채팅 -->
					    <li class="nav-item">
					      <a class="nav-link disabled" href="#">채팅${userDetail.userName } ${userDetail.userId} 과  ${user.userName } ${user.userId }</a>
					    </li>
					    <c:if test="${user.userId != null}">
					    <li class="nav-item">
					      <a class="nav-link" href="${pageContext.request.contextPath}/memberChat/memberChatRoom.do?senderId=${user.userId }&receiverId=${userDetail.userId }">채팅하기</a>
					    </li>
					    </c:if>
					    
				    </ul>									
				
			</div>
			
			<div class="col-6 pl-3 gray-line">
				<h2>내용 불러온 것</h2>
				<div class="row">
					소개
				</div>
				<div class="row">
					강의
				</div>
				<div class="row">
					수강후기
				</div>
				<div class="row">
					게시글
				</div>
			</div>
		
		</div>
	
	</div>
	

	

	<script>
		// 비밀번호 정규식
		var pwJ = /^(?!((?:[A-Za-z]+)|(?:[~!@#$%^&*()_+=]+)|(?:[0-9]+))$)[A-Za-z\d~!@#$%^&*()_+=]{8,32}$/;
		// 비밀번호 체크 확인
		$('#user_pw')
				.keyup(
						function() {
							if (pwJ.test($('#user_pw').val())) {
								console.log('true');
								$('#pw_check').text('비밀번호 통과');
								$('#pw_check').css('color', 'blue');
							} else {
								console.log('false');
								$('#pw_check')
										.text('영문/숫자/특수문자 2가지 이상 포함+8자 이상 32자 이하 입력 (공백 제외)');
								$('#pw_check').css('color', 'red');
							}
						});
		$('#user_pw2').keyup(function() {
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
	</script>
	<script>
		var inval_Arr = new Array(2).fill(false);
		let go = $("#firstForms");
		$('#reg_submit').click(
				function() {
					var userPwd2 = $('#password').val();
					var userId2 = $('#email_ch').val();
					var typeVl = {
						userPwd : userPwd2,
						userId : userId2
					};
					$.ajax({
						url : "pwdCheck.do",
						data : typeVl,
						type : "post",
						async : false,

						success : function(data) {
							console.log("1 = 일치o / 0 = 불일치x : " + data);
							if (data == 1) {
								inval_Arr[1] = true;
							} else {
								inval_Arr[1] = false;
								$('#checkPwd').text('현재 비밀번호가 틀렸습니다');
								$('#checkPwd').css('color', 'red');
							}
						},
						error : function() {
							console.log("실패");
						}
					});
					// 비밀번호가 같은 경우 && 비밀번호 정규식
					if (($('#user_pw').val() == ($('#user_pw2').val()))
							&& pwJ.test($('#user_pw').val())) {
						inval_Arr[0] = true;
					} else {
						inval_Arr[0] = false;
					}
					for (var i = 0; i < inval_Arr.length; i++) {
						if (inval_Arr[i] == false) {
							alert('입력한 정보들을 다시 한번 확인해주세요 :)');
							return false;
						}
					}
					alert('수정요청이 완료 되었습니다.');
					go.submit();
				});
	</script>

	<footer>
		<%@ include file="../../Common/footer.jsp"%>
	</footer>
</body>
</html>