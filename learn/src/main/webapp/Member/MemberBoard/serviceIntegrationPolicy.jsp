<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>통합서비스 이용약관</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
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
			  <li class="menu"><a class="active" href="/learn/Member/MemberBoard/serviceIntegrationPolicy.jsp">통합서비스 이용약관</a></li>
			  <li class="menu"><a href="${pageContext.request.contextPath }/Member/MemberBoard/generalPolicy.jsp">아웃풋런 이용약관</a></li>
			  <li class="menu"><a href="${pageContext.request.contextPath }/Member/MemberBoard/privacyPolicy.jsp">개인정보 취급방침</a></li>
			</ul>
		</div>
	</div>
	<br>
	<div class="outer">
		<div class="inner2">
			<b>제 1 조 (목적)</b><br>
			본 약관은 주식회사 아웃풋랩(이하 “회사”)가 운영하는 사이트를 통하여 제공하는 개별 서비스를 하나의 ID로 이용하는 통합 계정 회원과 회사 간의 권리, 의무 및 책임사항, 이용조건 및 절차 등 기본적인 사항을 규정함을 목적으로 합니다.<br>
			<br>
			
			<b>제 2 조 (용어의 정의)</b><br>
			본 약관에서 사용하는 주요 용어의 정의는 다음과 같습니다.<br>
			<ol>
				<li>"사이트"라 함은 회사가 회원에게 서비스를 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 설정한 가상의 영업장 또는 회사가 운영하는 아래의 웹사이트를 말합니다. 
					<ol type="a">
						<li>https://www.outputlearn.com</li>
						<li>https://www.rallit.com</li>
						<li>추후 인프랩에서 개발 또는 운영하는 기타 웹사이트</li>
					</ol>
				</li>
				<li>통합 계정 : 회사가 제공하는 개별 서비스를 하나의 아이디(ID)과 비밀번호(PASSWORD)로 이용할 수 있도록 회사가 회원에게 배정한 계정을 말합니다.</li>
				<li>통합 계정 회원 : 본 약관에 동의하고 통합 계정 가입 화면에서 이용신청을 하여 ID와 비밀번호를 발급 받은 고객을 말합니다.</li>
				<li>개별 서비스 : 회사가 운영하는 사이트를 통하여 회원에게 제공하는 정보통신서비스로  통합 계정을 이용하여 접속이 가능한 각각의 서비스를 말합니다. 개별 서비스는 추가 ∙ 변동될 수 있으며, 이 경우 본 약관 제15조에서 정한 방식으로 회원에게 공지합니다.</li>
				<li>아이디 (ID) : 회원의 식별 및 서비스 이용을 위하여 회원의 신청에 따라 회사가 회원 별로 부여하는 고유한 문자와 숫자의 조합을 말합니다.</li>
				<li>이메일 (E-MAIL) : 회원가입이나 로그인 등에 사용되는 단일한 이메일 주소를 말합니다.</li>
				<li>비밀번호 (PASSWORD) : 아이디(ID)로 식별되는 회원의 본인 여부를 검증하기 위하여 회원이 설정하여 회사에 등록한 고유의 문자와 숫자의 조합을 말합니다.</li>
				<li>본 약관에서 사용하는 용어의 정의는 본 조항에서 정하는 것을 제외하고는 관계 법령에서 정하는 바에 의합니다.</li>
			</ol>
			<br>
			
			<b>제 3 조 (약관의 명시 및 개정)</b><br>
			<ol>
				<li>본 약관의 내용은 회원이 쉽게 알 수 있도록 회사가 운영하는 사이트 내 초기화면 또는 링크로 화면에 게시합니다.</li>
				<li>"회사"는 "약관의 규제에 관한 법률", "정보통신망 이용 촉진 및 정보 보호 등에 관한 법률(이하 "정보통신망법")", "전기통신기본법", "전기통신사업법" 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.</li>
				<li>회사가 약관을 변경할 경우에는 적용일자 및 변경사유를 명시하여 제1항과 같은 방법으로 그 적용일자 7일 전부터 공지합니다. 다만, 회원에게 불리한 약관의 변경인 경우에는 그 적용일자 30일 전부터 공지하며, E-mail 등으로 회원에게 개별 통지합니다. 단, 회원의 연락처 미기재, 변경 후 미수정 등으로 인하여 개별 통지가 어려운 경우에 한하여 본 항의 공지를 함으로써 개별 통지한 것으로 간주합니다.</li>
				<li>회사가 제3항에 따라 변경 약관을 공지 또는 통지하면서, 회원에게 약관 변경 적용일까지 거부의사를 표시하지 아니할 경우, 약관의 변경에 동의한 것으로 간주한다는 내용을 공지 또는 통지 하였음에도 회원이 명시적으로 약관 변경에 대한 거부의사를 표시하지 아니하면, 회원이 변경 약관에 동의한 것으로 간주합니다. 회원은 변경된 약관 사항에 동의하지 않으면 통합 계정 이용을 중단하고 이용 계약을 해지할 수 있습니다.</li>
				<li>회원은 회사가 운영하는 홈페이지를 정기적으로 방문하여 약관의 변경사항을 확인해야 합니다. 변경된 약관에 대한 정보를 알지 못해 발생하는 회원의 피해에 대해 회사는 귀책사유가 없는 한 책임을 지지 않습니다.</li>
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
