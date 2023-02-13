<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
input::placeholder {
	font-size: 12px;
	text-align: right;
}

.tape {
	height: 100px;
	margin: 50px auto;
	padding-top: 15px;
	color: white;
}

.active-menu {
        color: #1dc078;
        font-weight: bold;
      }
      .norm-menu {
        color: black;
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
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<div class="container-fluid bg-dark">
		<div class="container tape">
			<section>
				<h2>수강장바구니</h2>
			</section>
		</div>
	</div>
	<div class="container">
		<div id="reload" class="row">
		<div class="col-2 d-flex justify-content-center">
				<%@ include file="../Member/sidebar.jspf"%>
				<script>
	              var menu = $('#cart');
	              console.log(menu);
	              menu.removeClass('norm-menu');
	              menu.addClass('active-menu');
	            </script>
			</div>
			<div class="col-7" style="padding: 0px;">
				<h3 class="" style="height: 50px;">수강장바구니</h3>
				<div class=""
					style="height: 40px; border-bottom: 2px solid black; padding: 0px;">
					<input class="" type="checkbox" id="cbx_chkAll" value="" checked="checked"> <label
						class="left"><span class="">전체선택&nbsp;</span><span class=""><span id="Count"
							class="">${fn:length(cartList)  }</span>/<span class="">${fn:length(cartList)  }전체수량</span></span>
							 </label> <input class="float-right" type="button" value="선택삭제"
						onclick="cartDelete_go()">
				</div>
				<br>
				<c:if test="${empty cartList }">
					<tr><td colspan="9">장바구니가 비어 있습니다</td></tr>
				</c:if>
				<c:if test="${not empty cartList}">
					<c:forEach var="cartList" items="${cartList }">
						<div class="row m-0" style="height: 100px">
							<div class="col-3" style="padding: 0px;">
								<input class="blankCheckbox" type="checkbox" id="${cartList.cartNo }" style="float: top;"
									name="zzim" value="${cartList.cartNo }" checked="checked"> <img
									src="${pageContext.request.contextPath}/filepath/${cartList.lectureCoverimg }"
									style="width: 70%; height: 50%">
							</div>

							<div class="col-7">
								<p><a href="#">${cartList.lectureTitle }</a></p>
								<p>
									<small style="color: gray;">${cartList.lectureWriter }</small>
									| <small style="color: green;">${fn:substring(cartList.timetableStart,0,16) }
										~ ${fn:substring(cartList.timeTableEnd,0,16) }</small>
								</p>
							</div>
							<div class="col-2" style="border-left: 1px solid lightgray">
								<c:if test="${cartList.lectureSalerate != 0}">
									<p style="color: red;">
										<B><small>${cartList.lectureSalerate }% &nbsp;</small></B> 
										<STRIKE><small style="color: gray;">${cartList.lecturePrice }원</small></STRIKE>
									</p>
									<p>${cartList.lectureSalePrice }원</p>
								</c:if>
								<c:if test="${cartList.lectureSalerate == 0}">
									<p>
										<small>&nbsp;</small>
									</p>
									<p>${cartList.lecturePrice }원</p>
								</c:if>
							</div>
						</div>
						<div style="border-bottom: 1px solid lightgray;">
							<p></p>
						</div>
						<br>
					</c:forEach>
				</c:if>
			</div>
			<div class="col-3" style="padding: 0px 0px 0px 15px;">
				<div
					style="border-radius: 10px 10px 10px 10px; border: 1px solid lightgray; padding: 16px 20px;">
					<p style="border-bottom: 1px solid lightgray">
						<B>구매자 정보</B>
					</p>
					<div class="row">
						<div class="col-3" style="color: gray;">
							<small>이름</small>
						</div>
						<div class="col-9" style="color: gray;">
							<small>${cartList[0].userName }</small>
						</div>
						<div class="col-3" style="color: gray; padding-right: 0px;">
							<small>이메일</small>
						</div>
						<div id="userId" class="col-9" style="color: gray; word-break: break-all;">
							<small>${cartList[0].userId }</small>
						</div>
					</div>
				</div>
				<br>
				<div
					style="border-radius: 10px 10px 10px 10px; border: 1px solid lightgray; padding: 16px 20px;">
					<p style="float: right">
						사용가능: <span style="color: green">${cartList[0].points }</span>
					</p>
					<p>
						<B>포인트</B>
					</p>
					<div class="row">
						<div class="col-7" style="color: gray; padding: 0px;">
							<input type="text" id="usePoint" name="points" class="w-100"
								placeholder="포인트를 입력해 주세요.">
						</div>
						<div class="col-5"
							style="color: gray; padding: 0px 5px; text-align: center;">
							<button class="btn-sm btn btn-outline-dark"
								onclick="allUsePoint()">전액사용</button>
						</div>
						<div class="col-12" id="checkPoint"></div>
						
						<div class="col-7" style="color: gray;">선택상품 금액</div>
						<div class="col-5" style="color: gray; text-align: right;" id="realPrice">${cartList[0].realPrice }원</div>
						<div class="col-6" style="color: red;" id="realSalePrice2">할인된 금액</div>
						<c:set var = "total" value = "0" />
						<c:if test="${not empty cartList}">
						<c:forEach var="cartList" items="${cartList }" varStatus="status">
							<c:set var= "total" value="${total + cartList.realSalePrice}"/>
						</c:forEach>
						</c:if>
						<div class="col-6" style="color: red; text-align: right;" id="realSalePrice"></div>
						<div class="col-7" style="color: red; padding: 0px 0px 0px 15px;" id="realUsePoint2"></div>
						<div id="realUsePoint" class="col-5"
							style="color: red; text-align: right; padding: 0px 15px 0px 0px;"></div>
						<div class="col-6" style="">
							<B>총 결제금액</B>
						</div>
						<div class="col-6" style="text-align: right;" id="my_div">
							<B>${cartList[0].realPrice - cartList[0].realSalePrice }원</B>
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-12">
							<button class="btn btn-success w-100" id="requestPay">
								<small>카드로 결제하기</small>
							</button>
						</div>
						<br> <br>
						<div class="col-12">
							<button class="btn btn-success w-100" id="charge_kakao">
								<small>카카오 페이로 결제하기</small>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<script>
//포인트 입력시 구현

$(document).on("keyup", "#usePoint", function () {
	console.log("포인트 입력 시작");
	var usePoint = $('#usePoint').val();
	var myPoint = 0;
	var limitPoint = "${cartList[0].points }";
	var SaPrice = 0;
	var totalPrice = 0;
	var typeVl = null;
	var cnt = $("input[name=zzim]:checked").length;
	console.log(";;;;;;;;;;;;cnt = " + cnt);
	var userId2 = "${user.userId}";
	//var cartNo2 = $("input[name='zzim']:checked").val();
	var cartNo2 = "";
		$("input[name='zzim']:checked").each(function(){
			cartNo2 = $(this).val();		
			console.log("cartNo2>>>>>>>>>>>>>"+cartNo2);
			typeVl = {
					cartNo : cartNo2,
					userId : userId2
				};
					$.ajax({
						url : "${pageContext.request.contextPath }/order/getRealPrice.do",
						data : typeVl,
						type : "post",
						async : false,

						success : function(data) {
							myPoint = data.points;
							console.log("data : " + data);
								if(data.lectureSalerate > 0){
									SaPrice = SaPrice + data.realSalePrice;
									console.log("SaPrice : " + SaPrice);
									console.log("usePint : " + usePoint);
									totalPrice = totalPrice + data.lecturePrice - data.realSalePrice;
									console.log("totalPrice : " + totalPrice);
								} else {
									totalPrice = totalPrice + data.lecturePrice;
									console.log("totalPrice : " + totalPrice);
								}
								
								//$("#reload").load(window.location.href + " #reload");
//								$("#reload").load("${pageContext.request.contextPath }/Order/myCart.jsp #reload");
							
						},
						error : function() {
							console.log("실패");
						}
					});
				}); // 첫번쨰 아작스 끝 현재 할인된 금액과 총 금액만 추출해서 사용 해야됨
		if(usePoint >= myPoint){
			//document.getElementById("usePoint").innerHTML = "myPoint";
			/* var Myelement = document.getElementById("usePoint");
			Myelement.value = myPoint;
			console.log("???????" + Myelement.value); */
			document.getElementById("usePoint").value = myPoint;
			console.log("???????" + myPoint);
			//$('#usePoint').text(myPoint);
			usePoint = myPoint;
		} 				
		if(usePoint >= totalPrice){ 		
			$('#usePoint').val(totalPrice);
			$('#realUsePoint').text('-'+totalPrice+'원');
			$('#my_div').text("0원");
		} else{
			$('#realUsePoint').text('-'+usePoint+'원');
			$('#realUsePoint2').text('포인트 사용 금액');
			$('#my_div').text(totalPrice-usePoint+"원");
		}
		if (usePoint.length == 0){
			$('#checkPoint').text('');
			$('#realUsePoint').text('');
			$('#realUsePoint2').text('');
			$('#my_div').text(totalPrice+'원');
		}
		if(usePoint == 0){
			$('#checkPoint').text('');
			$('#realUsePoint').text('');
			$('#realUsePoint2').text('');
		}
		
	});

	
	/////////////////////////////////////////
</script>
<script>
//전체 포인트 사용 버튼 클릭
	function allUsePoint(){
		////////////
		var usePoint = $('#usePoint').val();
		var myPoint = 0;
		var limitPoint = "${cartList[0].points }";
		var SaPrice = 0;
		var totalPrice = 0;
		var typeVl = null;
		var cnt = $("input[name=zzim]:checked").length;
		console.log(";;;;;;;;;;;;cnt = " + cnt);
		var userId2 = "${user.userId}";
		var cartNo2 = "";
			$("input[name='zzim']:checked").each(function(){
				cartNo2 = $(this).val();
				console.log("cartNo2>>>>>>>>>>>>>"+cartNo2);
				typeVl = {
						cartNo : cartNo2,
						userId : userId2
					};
						$.ajax({
							url : "${pageContext.request.contextPath }/order/getRealPrice.do",
							data : typeVl,
							type : "post",
							async : false,

							success : function(data) {
								myPoint = data.points;
								console.log("data : " + data);
									if(data.lectureSalerate > 0){
										SaPrice = SaPrice + data.realSalePrice;
										console.log("SaPrice : " + SaPrice);
										console.log("usePint : " + usePoint);
										totalPrice = totalPrice + data.lecturePrice - data.realSalePrice;
										console.log("totalPrice : " + totalPrice);
									} else {
										totalPrice = totalPrice + data.lecturePrice;
										console.log("totalPrice : " + totalPrice);
									}
									
									//$("#reload").load(window.location.href + " #reload");
//									$("#reload").load("${pageContext.request.contextPath }/Order/myCart.jsp #reload");
								
							},
							error : function() {
								console.log("실패");
							}
						});
					}); // 첫번쨰 아작스 끝 현재 할인된 금액과 총 금액만 추출해서 사용 해야됨
			usePoint = myPoint;
			if(usePoint >= myPoint){
				//document.getElementById("usePoint").innerHTML = "myPoint";
				/* var Myelement = document.getElementById("usePoint");
				Myelement.value = myPoint;
				console.log("???????" + Myelement.value); */
				document.getElementById("usePoint").value = myPoint;
				console.log("???????" + myPoint);
				//$('#usePoint').text(myPoint);
				usePoint = myPoint;
			} 				
			if(usePoint >= totalPrice){ 		
				$('#usePoint').val(totalPrice);
				$('#realUsePoint').text('-'+totalPrice+'원');
				$('#my_div').text("0원");
			} else{
				$('#realUsePoint').text('-'+usePoint+'원');
				$('#realUsePoint2').text('포인트 사용 금액');
				$('#my_div').text(totalPrice-usePoint+"원");
			}
			if (usePoint.length == 0){
				$('#checkPoint').text('');
				$('#realUsePoint').text('');
				$('#realUsePoint2').text('');
				$('#my_div').text(totalPrice+'원');
			}
	};
</script>
<script>
	//선택 삭제 구형
		function cartDelete_go(){
			var checkBoxArr = []; 
			var typeVl = null;
			$("input[name='zzim']:checked").each(function() {
				  checkBoxArr.push($(this).val());
			var cartNo2 = $("input[name='zzim']:checked").val();
			var userId2 = "${user.userId}";
			typeVl = {
					checkBoxArr : checkBoxArr,
					userId : userId2
				};
			});
			if($("input[name='zzim']:checked").val() != null){
				if(confirm("정말 삭제하시겠습니까?")) {
					$.ajax({
						url : "${pageContext.request.contextPath }/order/cartDeleteGo.do",
						data : typeVl,
						type : "post",
						async : false,

						success : function(data) {
							console.log(data);
							$("#reload").html(data);
							
						},
						error : function() {
							console.log("실패");
						}
					});
				}
			} else {
				alert("선택된 게시물이 없습니다.");
				return;
			}
			
		
	};
		
	</script>
	<script>
		//전체 선택 구현
		
		$(document).ready(function() {
			var c = "${total}";
			if(c > 0){
				$('#realSalePrice2').text('할인된 금액');
				$('#realSalePrice').text('-'+'${total}'+'원');
			} else {
				$('#realSalePrice2').text('');
				$('#realSalePrice').text('');
			}
			
			$(document).on("click", "#cbx_chkAll", function () {
				c = "${total}";
				if ($("#cbx_chkAll").is(":checked")){
					$("input[name=zzim]").prop("checked", true);
					$('#realPrice').text("${cartList[0].realPrice}"+'원'	);
					if(c > 0){
						$('#realSalePrice2').text('할인된 금액');
						$('#realSalePrice').text(''+'${total}'+'원');
					} else {
						$('#realSalePrice2').text('');
						$('#realSalePrice').text('');
					}
					$('#my_div').text('${cartList[0].realPrice - total}'+'원');
					$("#usePoint").attr("disabled",false);
				}
				else{
					$("input[name=zzim]").prop("checked", false);
					$('#realPrice').text('0원');
					$('#checkPoint').text('');
					$('#realUsePoint').text('');
					$('#realUsePoint2').text('');
					$('#realSalePrice2').text('');
					$('#realSalePrice').text('');
					$('#my_div').text('0원');
					$("#usePoint").attr("disabled",true);
				}
				var checked = $("input[name=zzim]:checked").length;
				$('#Count').text(checked);	
			});
			$(document).on("click", "input[name=zzim]", function () {
				var checked = $(".blankCheckbox").val();
				console.log(">>>>>checked:"+checked);
				var total = $("input[name=zzim]").length;
				var checked = $("input[name=zzim]:checked").length;
				$('#Count').text(checked);
				if (total != checked)
					$("#cbx_chkAll").prop("checked", false);
				else
					$("#cbx_chkAll").prop("checked", true);
			});

		});
	</script>
	<script>
	//진짜 결재 금액 변동/
	$(document).on("click", "input[name=zzim]", function () {
				var SaPrice = 0;
				var totalPrice = 0;
				var typeVl = null;
				
				var cnt = $("input[name=zzim]:checked").length;
				console.log(";;;;;;;;;;;;cnt = " + cnt);
				var userId2 = "${user.userId}";
				//var cartNo2 = $("input[name='zzim']:checked").val();
				var cartNo2 = "";
				if(cnt == 0){
					$('#realPrice').text('0원');
					$('#checkPoint').text('');
					$('#realUsePoint').text('');
					$('#realUsePoint2').text('');
					$('#realSalePrice2').text('');
					$('#realSalePrice').text('');
					$('#my_div').text('0원');
					$("#usePoint").attr("disabled",true);
				} else{
					$("#usePoint").attr("disabled",false);
					$("input[name='zzim']:checked").each(function(){
						
						cartNo2 = $(this).val();
						console.log("cartNo2>>>>>>>>>>>>>"+cartNo2);
						typeVl = {
								cartNo : cartNo2,
								userId : userId2
							};
								$.ajax({
									url : "${pageContext.request.contextPath }/order/getRealPrice.do",
									data : typeVl,
									type : "post",
									async : false,

									success : function(data) {
										console.log("data : " + data);
											if(data.lectureSalerate > 0){
												SaPrice = SaPrice + data.realSalePrice;
												console.log("SaPrice : " + SaPrice);
												totalPrice = totalPrice + data.lecturePrice - data.realSalePrice;
												console.log("totalPrice : " + totalPrice);
											} else {
												totalPrice = totalPrice + data.lecturePrice;
												console.log("totalPrice : " + totalPrice);
											}
											console.log("성공");
												$('#realPrice').text(totalPrice+SaPrice+'원');
												if(SaPrice > 0){
													$('#realSalePrice2').text('할인된 금액');
													$('#realSalePrice').text('-'+SaPrice+'원');	
												}else{
													$('#realSalePrice').text('');
												}
												
												$('#my_div').text(totalPrice+"원");
											//$("#reload").load(window.location.href + " #reload");
//											$("#reload").load("${pageContext.request.contextPath }/Order/myCart.jsp #reload");
										
									},
									error : function() {
										console.log("실패");
									}
								});
					});
				}
				
				
			});
	</script>
	<script>
		//카드로 계산하기
		$(document).on("click", "#requestPay", function () {
			var ch = "ok";
			var orderPrice = 0;
			// getter
			var IMP = window.IMP;
			IMP.init('imp55622653');//자신의 가맹점  식별 코드
			//window.IMP.init('TC0ONETIME');
			//window.IMP.init('imp55622653');
			var money = document.getElementById('my_div').innerHTML;
			console.log(money);
			//
			
			//
			IMP.request_pay({
				pg : "kcp",
				pay_method : "card",
				merchant_uid : 'merchant_' + new Date().getTime(),

				name : '인프런 강의', //결제창에서 보여질 이름
				amount : money, //실제 결제되는 가격
				buyer_email : "${user.userId}",
				buyer_name : "${user.userName}",
				buyer_tel : '010-1234-5678',
				buyer_addr : '서울 강남구 도곡동',
				buyer_postcode : '123-456'
			}, function(rsp) {
				console.log(rsp);
				
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					msg += '고유ID : ' + rsp.imp_uid;
					msg += '상점 거래ID : ' + rsp.merchant_uid;
					msg += '결제 금액 : ' + rsp.paid_amount;
					msg += '카드 승인번호 : ' + rsp.apply_num;
					orderPrice = rsp.paid_amount;
					
					
					// 디비 업데이트 용 
					var checkBoxArr = []; 
					var typeVl = null;
					$("input[name='zzim']:checked").each(function() {
						  checkBoxArr.push($(this).val());
					});
					var userId2 = "${user.userId}";
					var userName = "${user.userName}";
					var usePoint2 = $('#usePoint').val();
					if(usePoint2 > 0){
						console.log(usePoint2);
					} else{
						usePoint2 = 0;
					}
					var orderPayment2 = "카드";
					typeVl = {
							checkBoxArr : checkBoxArr,
							userId : userId2,
							points : usePoint2,
							point : usePoint2,
							orderPayment : orderPayment2
						};
					console.log(typeVl);
					$.ajax({
						url : "${pageContext.request.contextPath }/order/orderFinish.do",
						data : typeVl,
						type : "post",
						async : true,
						
						success : function(data) {
							console.log("data : " + data);
							console.log("성공 : ");
							//현재는 리로드 결재확인 페이지 만들어지면 결재 확인 페이지로 이동	
							$("#reload").load(window.location.href + " #reload");
						},
						error : function() {
							console.log("실패");
						}
					});
					
				} else {
					ch = "no";
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
					
				}
				alert(msg);
				if(ch == "no"){
					location.href="${pageContext.request.contextPath }/order/myCartGo.do?userId=${user.userId}";
				}else {					
					location.href="${pageContext.request.contextPath }/order/orderDetailGo.do?userId=${user.userId}";
				}
			});
			
		});
		//카카오로 결재하기
		$(document).on("click", "#charge_kakao", function () {
			var ch = "ok";
			var orderPrice = 0;
			var IMP = window.IMP;
			IMP.init('imp55622653');//자신의 가맹점  식별 코드
			//window.IMP.init('TC0ONETIME');
			//window.IMP.init('imp55622653');
			var money = document.getElementById('my_div').innerHTML;
			console.log(money);

			IMP.request_pay({
				pg : "kakaopay.TC0ONETIME",
				pay_method : "card",
				merchant_uid : 'merchant_' + new Date().getTime(),

				name : '주문명 : 주문명 설정',
				amount : money,
				buyer_email : 'iamport@siot.do',
				buyer_name : '구매자이름',
				buyer_tel : '010-1234-5678',
				buyer_addr : '인천광역시 부평구',
				buyer_postcode : '123-456'
			}, function(rsp) {
				console.log(rsp);
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					msg += '고유ID : ' + rsp.imp_uid;
					msg += '상점 거래ID : ' + rsp.merchant_uid;
					msg += '결제 금액 : ' + rsp.paid_amount;
					msg += '카드 승인번호 : ' + rsp.apply_num;
					
					// 디비 업데이트 용 
					var checkBoxArr = []; 
					var typeVl = null;
					$("input[name='zzim']:checked").each(function() {
						  checkBoxArr.push($(this).val());
					});
					var userId2 = "${user.userId}";
					var userName = "${user.userName}";
					var usePoint2 = $('#usePoint').val();
					if(usePoint2 > 0){
						console.log(usePoint2);
					} else{
						usePoint2 = 0;
					}
					var orderPayment2 = "카카오";
					typeVl = {
							checkBoxArr : checkBoxArr,
							userId : userId2,
							points : usePoint2,
							point : usePoint2,
							orderPayment : orderPayment2
						};
					console.log(typeVl);
					$.ajax({
						url : "${pageContext.request.contextPath }/order/orderFinish.do",
						data : typeVl,
						type : "post",
						async : true,
						
						success : function(data) {
							console.log("data : " + data);
							console.log("성공 : ");
						},
						error : function() {
							console.log("실패");
						}
					});
					
					
				} else {
					ch = "no";
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
				}
				alert(msg);
				if(ch == "no"){
					location.href="${pageContext.request.contextPath }/order/myCartGo.do?userId=${user.userId}";
				}else {					
					location.href="${pageContext.request.contextPath }/order/orderDetailGo.do?userId=${user.userId}";
				}
			});
		});
	</script>
	<footer>
		<%@ include file="../Common/footer.jsp"%>
	</footer>
</body>
</html>