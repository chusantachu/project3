<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
		<div class="col-1 d-flex justify-content-center">
				<%@ include file="../Member/sideNav.jspf"%>
			</div>
			<div class="col-8" style="padding: 0px;">
				<h3 class="" style="height: 50px;">수강장바구니</h3>
				<div class=""
					style="height: 40px; border-bottom: 2px solid black; padding: 0px;">
					<input class="" type="checkbox" id="cbx_chkAll" value="" checked="checked"> <label
						class="left"><span class="">전체선택&nbsp;</span><span class=""><span id="Count"
							class="">${fn:length(cartList2)  }</span>/<span class="">${fn:length(cartList2)  }전체수량</span></span>
							 </label> <input class="float-right" type="button" value="선택삭제"
						onclick="cartDelete_go()">
				</div>
				<br>
				<c:if test="${empty cartList2 }">
					<tr><td colspan="9">장바구니가 비어 있습니다</td></tr>
				</c:if>
				<c:if test="${not empty cartList2}">
					<c:forEach var="cartList2" items="${cartList2 }">
						<div class="row m-0" style="height: 100px">
							<div class="col-3" style="padding: 0px;">
								<input class="blankCheckbox" type="checkbox" id="${cartList2.cartNo }" style="float: top;"
									name="zzim" value="${cartList2.cartNo }" checked="checked"> <img
									src="${cartList2.lectureCoverimg }"
									style="width: 70%; height: 50%">
							</div>

							<div class="col-7">
								<p><a href="#">${cartList2.lectureTitle }</a></p>
								<p>
									<small style="color: gray;">${cartList2.lectureWriter }</small>
									| <small style="color: green;">${fn:substring(cartList2.timetableStart,0,16) }
										~ ${fn:substring(cartList2.timeTableEnd,0,16) }</small>
								</p>
							</div>
							<div class="col-2" style="border-left: 1px solid lightgray">
								<c:if test="${cartList2.lectureSalerate != 0}">
									<p style="color: red;">
										<B><small>${cartList2.lectureSalerate }% &nbsp;</small></B> 
										<STRIKE><small style="color: gray;">${cartList2.lecturePrice }원</small></STRIKE>
									</p>
									<p>${cartList2.lectureSalePrice }원</p>
								</c:if>
								<c:if test="${cartList2.lectureSalerate == 0}">
									<p>
										<small>&nbsp;</small>
									</p>
									<p>${cartList2.lecturePrice }원</p>
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
							<small>${cartList2[0].userName }</small>
						</div>
						<div class="col-3" style="color: gray; padding-right: 0px;">
							<small>이메일</small>
						</div>
						<div id="userId" class="col-9" style="color: gray; word-break: break-all;">
							<small>${cartList2[0].userId }</small>
						</div>
					</div>
				</div>
				<br>
				<div
					style="border-radius: 10px 10px 10px 10px; border: 1px solid lightgray; padding: 16px 20px;">
					<p style="float: right">
						사용가능: <span style="color: green">${cartList2[0].points }</span>
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
						<div class="col-5" style="color: gray; text-align: right;" id="realPrice">${cartList2[0].realPrice }원</div>
						<div class="col-6" style="color: red;" id="realSalePrice2">할인된 금액</div>
						<c:set var = "total" value = "0" />
						<c:if test="${not empty cartList2}">
						<c:forEach var="cartList2" items="${cartList2 }" varStatus="status">
							<c:set var= "total" value="${total + cartList2.realSalePrice}"/>
						</c:forEach>
						</c:if>
						<div class="col-6" style="color: red; text-align: right;" id="realSalePrice">-${total}</div>
						<div class="col-7" style="color: red; padding: 0px 0px 0px 15px;" id="realUsePoint2"></div>
						<div id="realUsePoint" class="col-5"
							style="color: red; text-align: right; padding: 0px 15px 0px 0px;"></div>
						<div class="col-6" style="">
							<B>총 결제금액</B>
						</div>
						<div class="col-6" style="text-align: right;" id="my_div">
							<B>${cartList2[0].realPrice - cartList2[0].realSalePrice }원</B>
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

