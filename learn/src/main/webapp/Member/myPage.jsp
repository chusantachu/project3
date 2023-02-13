<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
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
	//delect function
	$(function() {

		$(".toggleBtn")
				.click(
						function() {
							var dispHTML = '';

							if ($("#toggleImg").hasClass("before") === true) {
								$("#toggleImg").removeClass("before");
								dispHTML += '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16">';
								dispHTML += '<path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>';
								dispHTML += '</svg>';
								$("#toggleImg").html(dispHTML);
							} else {
								$("#toggleImg").addClass("before");
								dispHTML += '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">';
								dispHTML += '<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>';
								dispHTML += '</svg>';
								$("#toggleImg").html(dispHTML);
							}

							$("#deleteFrm").toggleClass("d-none");
						});

		$("#insertPassword").keyup(function() {
			console.log($("#insertPassword").val());

			if ($("#insertPassword").val().length == 0) {
				$("#caption").addClass("onError text-danger");
				$("#caption").text("비밀번호를 입력해 주세요.");
				$("#deleteBtn").attr("disabled", true);
			} else {
				$("#caption").removeClass("onError text-danger");
				$("#caption").text("");
				//공란 아닐시 disabled 속성 지워주기
				$("#deleteBtn").attr("disabled", false);
			}
		});

	});

	function check_password(frm) {
		var password = "${user.userPwd}";
		if ($("#insertPassword").val() == password) {
			$("#deleteUser").modal();
		} else {
			$("#caption").addClass("onError text-danger");
			$("#caption").text("비밀번호를 확인해주세요.");
		}
		;

	}

	function go_delete(frm) {
		frm.submit();
	}
</script>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<div class="container-fluid bg-dark">
		<div class="container tape">
			<section class="tapeContent">
				<h2>계정 정보</h2>
			</section>
		</div>
	</div>
	<div class="container-fluid mt-5 pb-3 d-flex justify-content-center">

		<div class="row w-100 pb-4 justify-content-center">
			<div class="col-2 d-flex justify-content-center">
				<%@ include file="sidebar.jspf"%>
			</div>
			<div class="col-6 pl-3 gray-line">
				<div class="text-center">
					<div class="mx-auto" style="width: 50%;">
						<form id="firstForms" action="modifyUser.do" method="post">
							<div class="">
								<img alt="낙엽"
									src="${pageContext.request.contextPath }/picture/myPageMark.png"
									width="200px"> <br> <label> <span>이메일</span>
								</label>
								<div class="">
									<input id="email_ch" type="email" class="w-75" name="userId"
										value="${user.userId }" readonly="readonly">
								</div>
								<label> <span>이름</span>
								</label>
								<div class="">
									<input id="name_ch" type="text" class="w-75" name="userName"
										value="${user.userName }" readonly="readonly">
								</div>
							</div>
							<c:if test="${empty user.socialType}">
								<div class="">
									<label class=""><span>비밀번호</span></label>
									<button class="btn" onclick="location.href='findPassword.jsp'">
										<small>비밀번호를 모르신다면?</small>
									</button>
								</div>

								<input id="password" name="password" type="password"
									class="w-75" placeholder="현재 비밀번호">

								<div class="" id="checkPwd"></div>
								<p>
									<small> </small><p>
								 <input id="user_pw" name="userPwd" type="password" class="w-75"
										placeholder="새 비밀번호">
								<div class="" id="pw_check"></div>
								<p>
									<small> </small>
								
								<p>
									<input id="user_pw2" type="password" class="w-75"
										placeholder="새 비밀번호 확인">
								
								<div class="" id="pw2_check"></div>
								<br>
								<div class="">
									<button id="reg_submit" class="btn btn-success w-75"
										type="button">저장하기</button>
								</div>
								<br>
							</c:if>
						</form>
							<c:if test="${not empty user.socialType}">
								<p>${user.socialType} 로그인 이용자 입니다.</p>
							</c:if>
					</div>
				</div>
	<c:choose>
		<c:when test="${empty user.socialType}">
			<!-- 탈퇴 영역 -->
						<div class="secession w-75 mx-auto border">
				<div class="mx-auto overflow-hidden">
					<label class="label p-3">
						<span class="h5 font-weight-bold">탈퇴</span>
					</label>
					<span class="toggleBtn float-right p-3">
						<i id="toggleImg" class="before">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
											fill="currentColor" class="bi bi-chevron-right"
											viewBox="0 0 16 16">
							 	<path fill-rule="evenodd"
												d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z" />
							</svg>
						</i>
					</span>
					<p class="float-clear">
				
							</div>
				<div id="deleteFrm" class="d-none">
					<div id="UserDelete" class="w-75 mx-auto p-3">
						<h5 class="font-weight-bold">탈퇴 안내 사항</h5>
						<p>
							서비스에 만족하지 못하셨나요? 탈퇴하기 전에 먼저 개선 요청을 해보시는 건 어떨까요?
							<br>
							그래도 탈퇴하시겠다면 탈퇴 전에 아래 유의사항을 꼭 읽어주세요!
						</p>
						<p>🙇🏻‍♂️ 감사합니다 🙇🏻‍♀️</p>
						<br>
						<p>1. 계정 탈퇴 시, 인프런과 랠릿 서비스에서 모두 탈퇴됩니다.</p>
						<p>2. 탈퇴 시 계정과 관련된 모든 권한이 사라지며 복구할 수 없습니다.</p>
						<p>3. 직접 작성한 콘텐츠(동영상, 게시물, 댓글 등)는 자동으로 삭제되지 않으며, 만일 삭제를 원하시면 탈퇴 이전에 삭제가 필요합니다.</p>
						<p>4. 탈퇴 후 동일한 메일로 재가입이 가능하나, 탈퇴한 계정과 연동되지 않습니다.</p>
						<p>5. 탈퇴 후 연동된 소셜 계정 정보도 사라지며 소셜 로그인으로 기존 계정 이용이 불가능합니다.</p>
						<p>6. 현재 비밀번호를 입력하고 탈퇴하기를 누르시면 위 내용에 동의하는 것으로 간주됩니다.</p>
					</div>
					<form
									action="${pageContext.request.contextPath }/member/deleteUser.do"
									method="post">
						<div class="m-5">
							<input id="insertPassword" name="userPwd" class="input form-control"
											type="password" placeholder="현재 비밀번호">
							<small id="caption" class="invalid"></small>
						</div>
						<div class="mx-auto w-25 m-3">
							<input type="button" id="deleteBtn"
											class="button btn-block btn btn btn-secondary"
											onclick="check_password(this.form)" value="탈퇴하기" disabled>
						</div>
						
						<div class="modal fade" id="deleteUser">
							<div class="modal-dialog modal-dialog-centered">
							  <div class="modal-content">
							    <div class="modal-body text-center">
							      <p><img src="${pageContext.request.contextPath }/picture/inflearn.png" width="100">
													</p>
							      <h4>회원탈퇴 안내</h4>
							      <p>지금까지 이용해 주셔서 감사했습니다.<br>
							    	  더 좋은 서비스로 성장해 다시 만나뵐 수 있으면<br>
							      	  좋겠습니다.
							      </p>
							      <button type="button" class="mx-auto m-3 btn btn-success"
														data-dismiss="modal" aria-label="Close"
														onclick="go_delete(this.form)">
							      	확인
							      </button>
							    </div>
							  </div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<!-- 탈퇴 영역 -->
		</c:when>
		<c:otherwise>
			<div class="secession w-75 mx-auto"></div>
		</c:otherwise>
	</c:choose>

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
		<%@ include file="../Common/footer.jsp"%>
	</footer>
</body>
</html>