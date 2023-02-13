<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>아웃풋런 이용약관</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <style>
  	.inner {
		width: 840px;
		display: inline-block;
		text-align: left;
	}
	.inner2 {
		width: 800px;
		display: inline-block;
		text-align: left;
	}
	.outer {
		text-align: center;
	}
	.menuborder {
	    list-style-type: none;
	    margin: 0;
	    padding: 0;
	    overflow: hidden;
 	    border-bottom: 1px solid #e7e7e7; 
	}
	.menu {
	    float: left;
	}
	.menu a {
	    display: block;
		color: black;
	    text-align: center;
	    padding: 14px 16px;
	    text-decoration: none;
	}
	.menu a:hover:not(.active) {
		text-decoration: none;
		color: black;
	}
	.menu a.active {
	    color: white;
	    background-color: #00C471;
	}
	a:hover {
		text-decoration: none;
	}
  </style>
</head>
<body>
	<%@ include file="/Common/header.jsp" %>
	<br><br>
	
	<div class="outer">
		<div class="inner">
			<ul class="menuborder">
			  <li class="menu"><a href="${pageContext.request.contextPath }/getFaqList.do">자주 묻는 질문</a></li>
			  <li class="menu"><a href="${pageContext.request.contextPath}/memberBoard/getMyQBoardList.do">고객센터 문의하기</a></li>
			  <li class="menu"><a href="${pageContext.request.contextPath }/Member/MemberBoard/serviceIntegrationPolicy.jsp">통합서비스 이용약관</a></li>
			  <li class="menu"><a class="active" href="${pageContext.request.contextPath }/Member/MemberBoard/generalPolicy.jsp">아웃풋런 이용약관</a></li>
			  <li class="menu"><a href="${pageContext.request.contextPath }/Member/MemberBoard/privacyPolicy.jsp">개인정보 취급방침</a></li>
			</ul>
		</div>
	</div>
	<br>
	<div class="outer">
		<div class="inner2">
			<b>제 1 조. 목적</b><br>
			이 이용약관(이하 ‘약관’)은 아웃풋랩(이하 ‘회사’)가 제공하는 아웃풋런(outputlearn.com) 및 아웃풋런 관련 제반 서비스(이하 ‘서비스’)를 이용고객(이하 ‘회원’)이 이용함에 있어 회사와 회원과의 권리, 의무 및 책임사항, 기타 필요한 사항을 구체적으로 규정함을 목적으로 합니다.<br>
			<bt><br>
			<b>제 2 조. 용어의 정의</b><br>
			이 약관에서 사용하는 용어의 정의는 다음과 같습니다.<br>
			<ol>
				<li>"사이트"라 함은 회사가 회원에게 서비스를 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 설정한 가상의 영업장 또는 회사가 운영하는 아래의 웹사이트를 말합니다. 
					<ol type="a">
						<li>“서비스”라 함은 구현되는 단말기와 상관없이 “회원” 혹은 웹사이트 방문자가 이용할 수 있는 인프런 서비스를 의미합니다.</li>
						<li>“회원”이란 “회사”의 서비스에 접속하여 본 약관에 따라 회사와 이용계약을 체결하고 “회사”가 제공하는 “서비스”를 이용하는 고객을 말합니다.</li>
						<li>“이용계약”이란 이 약관을 포함하여 서비스 이용과 관련하여 회사와 회원 간에 체결하는 모든 계약을 말합니다.</li>
						<li>“아이디(ID)”라 함은 회원의 식별 및 서비스 이용을 위하여 회원의 신청에 따라 회사가 회원 별로 부여하는 고유한 문자와 숫자의 조합을 말합니다.</li>
						<li>“이메일”은 회원가입이나 로그인 등에 사용되는 단일한 이메일 주소를 말합니다.</li>
						<li>“비밀번호(Password)”란 아이디(ID)로 식별되는 회원의 본인 여부를 검증하기 위하여 회원이 설정하여 회사에 등록한 고유의 문자와 숫자의 조합을 말합니다.</li>
						<li>“유료서비스”라 함은 회사가 유료로 제공하는 각종 온라인디지털콘텐츠(동영상 강의 열람, 프리미엄 교육 정보, 기타 유료 콘텐츠를 포함.) 및 제반 서비스를 의미합니다.</li>
						<li>“해지”라 함은 회사 또는 회원이 이용계약을 해약하는 것을 말합니다.</li>
						<li>“강의”라 함은 “회사”가 제공하는 “서비스”내에 제공하는 공간으로서, 동영상 업로드, 동영상 스트리밍, 관리, 과제 및 퀴즈, 설문 등의 교육 활동 전반과 “수강생” 관리를 할 수 있는 공간을 말합니다.</li>
						<li>“멘토링”이라 함은 “회사”가 제공하는 “서비스”를 통하여 강사와 회원 간 독립적으로 학습 상담 및 지도가 가능하도록 중개하는 것을 의미합니다.</li>
						<li>“강사”라 함은 “서비스”에 교육용 동영상 강의, 과제, 퀴즈 등을 올리고 강의를 개설하는 회원입니다.</li>
						<li>"수강생"이란 "서비스"에 접속하여 본 "약관"에 동의함으로써 "회사"와 이용계약을 체결하고 "회사"가 제공하는 정보와 "서비스"를 지속적으로 이용할 수 있는 자로 “강의” 혹은 제반 서비스를 이용하는 회원을 의미합니다.</li>
						<li>“게시물”이라 함은 “회원”이 “서비스”를 이용함에 있어 “서비스” 상에 게시한 글, 사진, 동영상 및 각종 파일과 링크를 의미합니다.</li>
					</ol>
				</li>
				<li>이 약관에서 사용하는 용어 중 제1항에서 정하지 아니한 것은 관계 법령 및 서비스 별 안내에서 정하는 바에 따르며, 그 외에는 일반 관례에 따릅니다.</li>
			</ol>
			<br>
			
			<b>제 3 조. 약관 효력 및 변경</b><br>
			<ol>
				<li>"회사”는 이 약관의 내용을 "회원"이 쉽게 알 수 있도록 서비스 초기 화면 또는 링크로 연결된 화면에 게시합니다.</li>
				<li>“회사”는 “약관의규제에관한법률”, “정보통신망이용촉진및정보보호등에관한법률(이하 “정보통신망법”)” 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.</li>
				<li>"회사"가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 제1항의 방식에 따라 그 개정약관의 적용일자 7일 전부터 적용일자 전일까지 공지합니다. 다만, 회원에게 불리한 약관의 개정의 경우에는 최소 30일 전에 공지 하고, 서비스 내 전자우편, 전자쪽지, 로그인시 동의창 등의 전자적 수단을 통해 개별적으로 명확히 통지하도록 합니다.</li>
				<li>“회사”가 전 항에 따라 개정약관을 공지 또는 통지하면서 회원에게 위 기간 내에 의사표시를 하지 않으면 의사표시가 표명된 것으로 본다는 뜻을 명확하게 공지 또는 통지 하였음에도 회원이 명시적으로 거부의 의사표시를 하지 아니한 경우 회원이 개정약관에 동의한 것으로 봅니다.</li>
				<li>“회원”이 개정약관의 적용에 동의하지 않는 경우 “회사”는 개정 약관의 내용을 적용할 수 없으며, 이 경우 “회사” 또는 “회원”은 이용계약을 해지할 수 있습니다.</li>
			</ol>
			<br>
			
			<b>제 4 조 (약관의 해석)</b><br>
			<ol>
				<li>본 약관에 명시되지 않은 사항에 대해서는 정보통신망 이용촉진 및 정보보호 등에 관한 법률 및 약관의 규제에 관한 법률 등 관계법령을 적용합니다.</li>
				<li>본 약관은 통합 계정으로 이용 가능한 개별서비스에 모두 적용됩니다. 다만 본 약관의 내용과 개별 서비스 약관의 내용이 서로 다른 경우, 개별 서비스 약관이 우선 적용되며 본 약관은 보충적으로 적용됩니다. 다만, 통합 계정과 관련한 고유의 사항에 관하여는 본 약관이 개별 서비스 약관보다 우선하여 적용됩니다.</li>
			</ol>
			<br>
			
			<b>제 5 조 (이용계약의 성립)</b><br>
			<ol>
				<li>통합 계정 이용계약은 통합 계정 회원이 되고자(이하 “가입신청자”) 하는 자가 본 약관 및 개인정보처리방침을 읽고 그 내용에 대하여 동의를 한 다음 회사에 대하여 회원가입 신청을 하고 "회사"가 이러한 신청에 승낙함으로써 성립합니다.  다만 회사가 제공하는 개별 서비스의 기존 회원은 명시적 거부 의사 표시가 없는 한 통합 계정 회원으로 전환되어 이용계약이 성립됩니다.</li>
				<li>회사는 본인 확인을 위하여 필요시 가입신청자에게 본인 인증을 요구할 수 있습니다. 이 경우 가입신청자는 휴대폰인증 등 회사가 제공하는 본인인증방식 중 하나를 선택하여 본인인증 절차를 거쳐야 하며, 가입신청자가 자신의 실명으로 본인 인증절차를 거치지 않은 경우, 회사에 대하여 일체의 권리를 주장할 수 없습니다.</li>
			</ol>
			<br>
		
		</div>
	</div>
	<br><br><br>
	 <%@ include file="/Common/footer.jsp" %>
</body>
</html>
