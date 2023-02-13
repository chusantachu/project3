<%@ page    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
   <!-- <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script> -->
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
   <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
   <script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
   <script src="https://accounts.google.com/gsi/client" async defer></script>
   <script src="https://unpkg.com/jwt-decode/build/jwt-decode.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
   <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script> <!-- 추가한 부분 -->
    <link rel="stylesheet"
          href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
          crossorigin="anonymous">
   <style>
.dropdown:hover .dropdown-menu {
    display: block;
    margin-top: 0;
}
   
#divView {
position:absolute;
display:none;
background-color:#ffffff;
border:solid 2px #d0d0d0;
width:350px;
height:150px;
padding:10px;
}
body {
  margin: 25px;
}

.icon-button {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 50px;
  height: 50px;
  color: #333333;
  background: white;
  border: none;
  outline: none;
  border-radius: 50%;
}

.icon-button:hover {
  cursor: pointer;
}

.icon-button:active {
  background: #cccccc;
}

.icon-button__badge {
  position: absolute;
  top: -10px;
  right: -10px;
  width: 25px;
  height: 25px;
  background: red;
  color: #ffffff;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 50%;
}
</style>
    <script>
      function onSignIn() {
        google.accounts.id.initialize({
          client_id: "932637000454-3m003tk3bsj54qae85sr3ue49cp4ajsg.apps.googleusercontent.com",
          callback: handleCredentialResponse
        });
        google.accounts.id.prompt();
      }

      function handleCredentialResponse(response) {
        var profile = jwt_decode(response.credential);
        var userBirth;

        data = new FormData();
        data.append("userName", profile.name);
        data.append("userId", profile.email);
        data.append("socialType", "google");

        $.ajax({
          data : data,
          type : "POST",
          url: "${pageContext.request.contextPath}/Member/checkSignUp.do",
          cache : false,
          contentType : false,
          processData : false,
          success: function(result) {
            if(result === 0) {
              Swal.fire({
                title: '생년월일 입력',
                text: '아이디 찾기에 이용됩니다.',
                input: 'number',
                inputPlaceholder: '형식: 숫자 8자리'
              }).then(function(r) {
                if(r.isConfirmed) {
                  data.append("userBirth", r.value);
                  $.ajax({
                    data : data,
                    type : "POST",
                    url : "${pageContext.request.contextPath}/Member/googleLogin.do",
                    cache : false,
                    contentType : false,
                    processData : false,
                    success: function (url) {
                      location.href = url;
                    },
                    error: function () {
                      alert("실패...");
                    }
                  })
                }
              })
            }
          },
          error: function () {
            alert("회원가입 여부 확인 실패");
          }
        })
      }
    </script>
   </head>

    <header>
        <fmt:requestEncoding value="utf-8"/>
  <ul class="nav mr-auto justify-content-center bg-white" >
  	<li class="nav-item">
  		<a href="${pageContext.request.contextPath}/common/main.do"><img src="${pageContext.request.contextPath}/picture/mainlogo.png" alt="mainlogo" width="120px" height="40px"></a>
  	</li>
    <li class="nav-item">
		<div class="dropdown">
   			<button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
      			온라인
    		</button>
	   		<div class="dropdown-menu">
				<a class="dropdown-item" href="${pageContext.request.contextPath}/lecture/getOnlineLectureList.do?categoryNo=" class="text-dark">전체</a>
	   			<c:forEach var="category" items="${categories }">
	    			<a class="dropdown-item" href="${pageContext.request.contextPath}/lecture/getOnlineLectureList.do?categoryNo=${category.categoryNo }">${category.categoryName }</a>
			    </c:forEach>
	    	</div>    
  		</div>
	</li>
    <li class="nav-item">
		<div class="dropdown">
   			<button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
      			오프라인
    		</button>
	   		<div class="dropdown-menu">
				<a class="dropdown-item" href="${pageContext.request.contextPath}/lecture/getOfflineLectureList.do?categoryNo=" class="text-dark">전체</a>
	   			<c:forEach var="category" items="${categories }">
	    			<a class="dropdown-item" href="${pageContext.request.contextPath}/lecture/getOfflineLectureList.do?categoryNo=${category.categoryNo }">${category.categoryName }</a>
			    </c:forEach>
	    	</div>    
  		</div>
	</li>
    <li class="nav-item">
		<div class="dropdown">
   			<button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
      			로드맵
    		</button>
	   		<div class="dropdown-menu">
				<a class="dropdown-item" href="${pageContext.request.contextPath}/roadmap/getRoadmapList.do?categoryNo=" class="text-dark">전체</a>
	   			<c:forEach var="category" items="${categories }">
	    			<a class="dropdown-item" href="${pageContext.request.contextPath}/roadmap/getRoadmapList.do?categoryNo=${category.categoryNo }">${category.categoryName }</a>
			    </c:forEach>
	    	</div>    
  		</div>
	</li>
    <li class="nav-item">
 <div class="dropdown">
<button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
      커뮤니티
    </button>
    <div class="dropdown-menu">
      <a class="dropdown-item" href="${pageContext.request.contextPath}/board/getQnaBoardList.do?section=qboard">질문 & 답변</a>
      <a class="dropdown-item" href="${pageContext.request.contextPath}/board/getQnaBoardList.do?section=fboard">자유주제</a>
      <a class="dropdown-item" href="${pageContext.request.contextPath}/getNoticeList.do">공지사항</a>
    </div>
    </div>
</li>

 <li>
   <button type="button" class="btn" >
      <form action="${pageContext.request.contextPath}/common/getIndexSearch.do">
         <input id="search" type="text" name="searchKeyword">
      </form>
    </button>
</li>    
<c:if test="${empty user.userId }">
<li>
      <button type="button" class="btn" data-toggle="modal" data-target="#login">로그인</button> &nbsp;
    <div class="modal fade" id="login">
        <div class="modal-dialog modal-dialog-centered" style="width: 400px">
            <div class="modal-content align-items-center pb-3">
                <div class="w-100 pr-2 pb-4" style="float: right">
                    <button type="button" class="close" data-dismiss="modal">x</button>
                </div>
                <img style="width: 120px;" src="https://cdn.inflearn.com/public/files/pages/da35da48-52a5-4ec6-b8d3-0389a47610ec/logo1.png">
                <form action="${pageContext.request.contextPath}/Member/login.do" method="post" class="w-100 pl-4 pr-4 pt-4">
                    <input type="email" class="form-control w-100 mb-3" id="userId" placeholder="이메일" name="userId">
                    <input type="password" class="form-control w-100 mb-4" id="userPwd" placeholder="비밀번호" name="userPwd">
                    <button type="submit" class="btn w-100" style="background-color: #00C471; color: white">로그인</button>
                </form>
                <div class="pt-2">
                    <a style="color: black" href="${pageContext.request.contextPath}/Member/findId.jsp">아이디(이메일) 찾기</a> |
                    <a style="color: black" href="${pageContext.request.contextPath}/Member/findPassword.jsp">비밀번호 찾기</a> |
                    <a style="color: black" href="${pageContext.request.contextPath}/Member/newMember.jsp">회원가입</a>
                </div>
                <hr class="w-100">
                <div class="pb-1 text-center">
                    간편 로그인
                </div>
                <div class="text-center">
            <span id="naverIdLogin">
            </span>
                    <script type="text/javascript">
                      var naverLogin = new naver.LoginWithNaverId(
                          {
                            clientId: "vkx131bLLt6ehxKoqXiH",
                            callbackUrl: "http://localhost:8080/${pageContext.request.contextPath}/Member/naverLogin.jsp",
                            isPopup: false,
                            loginButton: {color: "green", type: 1, height: 40}
                          }
                      );
                      naverLogin.init();
                    </script>
                    <button type="button" class="btn btn-link p-0" onclick="onSignIn()">
                                    <span style="display:inline-block;width: 40px; height: 40px; background-color: #f8f8f8; border-radius: 5px">
                                        <img style="margin:10px; width: 20px; height: 20px;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/24px-Google_%22G%22_Logo.svg.png?20210618182606"/>
                                    </span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</li>
<li>
    <button type="button" class="btn btn-outline-danger" onclick="location.href='${pageContext.request.contextPath}/Member/newMember.jsp'">회원가입</button>&nbsp;
    </li>
</c:if>
<c:if test="${not empty user.userId }">

<li>
	<button type="button" class="btn"
		onclick="location.href='${pageContext.request.contextPath}/order/myCartGo.do?userId=${user.userId }'">
		<i class="fas fa-cart-plus fa-lg"></i>
	</button> &nbsp;
</li>
				
<li>
	<button class="btn" type="button" onclick="location.href='${pageContext.request.contextPath}/memberChat/memberChatListGo.do?userId=${user.userId }'">
		<i class='fab fa-rocketchat' style='font-size:24px'></i>
	</button>
</li>					
<li>
    <div class="dropdown">
        <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/Member/myPage.jsp'"><i class="far fa-user fa-lg"></i></button>
        <div id="socketAlert"></div>
        <div class="dropdown-menu">
            <a class="dropdown-item">${user.userName }</a>
            <a class="dropdown-item"><small>${user.grade }</small></a>
            <a class="dropdown-item" href="${pageContext.request.contextPath}/Member/viewPoints.do"><small>포인트:
                <fmt:formatNumber type="number" maxFractionDigits="3" value="${user.points }" />점
            </small></a>
            <a class="dropdown-item"><hr></a>
            <a class="dropdown-item" href="#">내 학습</a>
            <a class="dropdown-item" href="${pageContext.request.contextPath}/memberBoard/callCenterBoardList.do?userId=${user.userId }">작성한 게시글</a>
            <a class="dropdown-item" href="${pageContext.request.contextPath}/Member/likeGo.do?userId=${user.userId }">좋아요</a>
            <a class="dropdown-item" href="${pageContext.request.contextPath}/Order/orderDetailGo.do?userId=${user.userId }">구매내역</a>
            <a class="dropdown-item" href="${pageContext.request.contextPath}/memberBoard/getMyQBoardList.do">고객센터<hr></a>
            <a class="dropdown-item" href="${pageContext.request.contextPath}/Admin/chatTest.jsp">실시간 접속자와 채팅</a>
			<a class="dropdown-item" href="${pageContext.request.contextPath}/Admin/chatTest2.do?bang_id=${user.userId}&userId=${user.userId}">실시간 상담2(09:00 ~ 18:00)</a>
			<c:if test="${user.grade == '관리자' }">
				<a class="dropdown-item" href="${pageContext.request.contextPath}/Admin/chatGoAdmin.do">관리자 상담 확인하기</a>
			</c:if>
            <a class="dropdown-item" href="${pageContext.request.contextPath}/Member/logout.do"><hr>로그아웃</a>
        </div>
    </div>
    </li>

</c:if>
      <c:if test="${user.grade != '강의자' }">
          <li>
              <button type="button" class="btn" onclick = "location.href='${pageContext.request.contextPath}/Member/Belecture/beLecture.jsp'">지식 공유 참여</button>
          </li>
      </c:if>
      <c:if test="${user.grade == '강의자' }">
          <li>
              <button type="button" class="btn" onclick = "location.href='${pageContext.request.contextPath}/Teacher/dashboard.do'">강의자 페이지</button>
          </li>
      </c:if>


</ul>






    </header>
    
    	<div class="fixed box" id="inquiry"
	style="position: fixed; right: 50px; bottom: 30px; z-index: 100;">
		<!--  #FBF4FA    #1dc078 #D9F2D9-->
		<div id="alramList" class="" 
		style="background-color: #D9F2D9; display: none; z-index: 90; border: 1px solid gold; border-radius: 20px;
		width: 250px; position: fixed; right: 50px; bottom: 80px; text-align : center;">
		</div>
		<button id="jong" type="button" class="icon-button" onclick="alramList()" style="position: fixed; right: 50px; bottom: 30px; z-index: 95;">
		    <span class="material-icons">notifications</span>
		    <span id="alramCount" class="icon-button__badge" style="display: none;">0</span>
		</button>
		

	<!-- <button type="button" class="btn" onclick=""><i class="fas fa-cart-plus fa-lg"></i></button> -->
	<%-- <a class="dropdown-item" href="${pageContext.request.contextPath}/Admin/chatTest.jsp">1:1채팅하러 가기</a> --%>
</div>
<script type="text/javascript">
var socket = null;
	$(document).ready(function(){
		if("${user.userId}" != null){
		connectWs();
	}
})


//소켓


function connectWs(){
	console.log("tttttt")
	var ws = new SockJS("http://192.168.18.10:8080/learn/alram");
	socket = ws;
	
	ws.onopen = function() {
		console.log('open');
	 
	};
	
	ws.onmessage = function(event) {
		console.log("onmessage"+event.data);
		let $socketAlert = $('div#socketAlert');
		alramCount();
/* 		$socketAlert.html(event.data)
		$socketAlert.css('display', 'block'); */
		
		setTimeout(function(){
			$socketAlert.css('display','none');
			
		}, 5000);
	};
	
		ws.onclose = function() {
		    console.log('close');
	 };
 
 
 

};

//소켓끝
</script>
<script>
var userId = "${user.userId}";

//알람목록
function alramList(){
	console.log("alramList")
	var userId = "${user.userId}";
	var a = document.getElementById("alramList");
	if(a.style.display == 'none')  {
	   a.style.display = 'block';
	}else {
	   a.style.display = 'none';
	}
	
		$.ajax({
	        url : '${pageContext.request.contextPath }/alram/getAlramList.do',
	        type : 'get',
	        data : {'toId' : userId },
	        
	        success : function(data){
	        	console.log(data);
	         	var a='';
	         	if(data.length == 0){
	         		a += '<br><div class="small" style="">새로운 알림이 없습니다.</div><br>';
	         	}else{
					a += '<br><div class="small" style="">새로운 알림</div><br>';
	         	}
	         	$.each(data, function(key, value){ 
	         	var categori = value.categori;
	         	a += '<div class="small">';
				if(categori == "lectureLike"){
					/* a += '<div style="float: right;"></div>'; */
					a += '<a style="color: black;" href="#" onclick="alramClick(\''+value.bNo+'\',\''+value.categori+'\',\''+value.aNo+'\',\''+value.toId+'\');"> 강의에 좋아요가 추가됬습니다.</a>';
					a += '<button id="delete" type="button" class="btn" onclick="alramListDelete(\''+value.aNo+'\',\''+value.toId+'\' )">x</button>';
				}else if(categori == "Notice"){
					a += '<a style="color: black;" href="#" onclick="alramClick(\''+value.bNo+'\',\''+value.categori+'\',\''+value.aNo+'\',\''+value.toId+'\');"> 새로운 공지글이 달렸습니다.</a>';
					a += '<button id="delete" type="button" class="btn" onclick="alramListDelete(\''+value.aNo+'\',\''+value.toId+'\' )">x</button>';
				}else if(categori == "lectureLikeCancle"){
					a += '<a style="color: black;" href="#" onclick="alramClick(\''+value.bNo+'\',\''+value.categori+'\',\''+value.aNo+'\',\''+value.toId+'\');"> 강의에 좋아요가 취소됬습니다.</a>';
					a += '<button id="delete" type="button" class="btn" onclick="alramListDelete(\''+value.aNo+'\',\''+value.toId+'\' )">x</button>';
				}
				a += '</div><hr>';	
				        		 
	         	});
	         	
	         	$("#alramList").html(a);
	         	$('#alramCount').text(0);
	         	$('#alramCount').css('display', 'none');
	        }
	        
	    });	
		
	}
//목록끝

//알람목록
function alramList2(){
	console.log("alramList2")
	var userId = "${user.userId}";
	var a = document.getElementById("alramList");
		$.ajax({
	        url : '${pageContext.request.contextPath }/alram/getAlramList.do',
	        type : 'get',
	        data : {'toId' : userId },
	        
	        success : function(data){
	        	console.log(data);
	         	var a='';
	         	if(data.length == 0){
	         		a += '<br><div class="small" style="">새로운 알림이 없습니다.</div><br>';
	         	}else{
					a += '<br><div class="small" style="">새로운 알림</div><br>';
	         	}
	         	$.each(data, function(key, value){ 
	         	var categori = value.categori;
	         	a += '<div class="small">';
				if(categori == "lectureLike"){
					/* a += '<div style="float: right;"></div>'; */
					a += '<a style="color: black;" href="#" onclick="alramClick(\''+value.bNo+'\',\''+value.categori+'\',\''+value.aNo+'\',\''+value.toId+'\');"> 강의에 좋아요가 추가됬습니다.</a>';
					a += '<button id="delete" type="button" class="btn" onclick="alramListDelete(\''+value.aNo+'\',\''+value.toId+'\' )">x</button>';
				}else if(categori == "Notice"){
					a += '<a style="color: black;" href="#" onclick="alramClick(\''+value.bNo+'\',\''+value.categori+'\',\''+value.aNo+'\',\''+value.toId+'\');"> 새로운 공지글이 달렸습니다.</a>';
					a += '<button id="delete" type="button" class="btn" onclick="alramListDelete(\''+value.aNo+'\',\''+value.toId+'\' )">x</button>';
				}else if(categori == "lectureLikeCancle"){
					a += '<a style="color: black;" href="#" onclick="alramClick(\''+value.bNo+'\',\''+value.categori+'\',\''+value.aNo+'\',\''+value.toId+'\');"> 강의에 좋아요가 취소됬습니다.</a>';
					a += '<button id="delete" type="button" class="btn" onclick="alramListDelete(\''+value.aNo+'\',\''+value.toId+'\' )">x</button>';
				}
				a += '</div><hr>';	
				        		 
	         	});
	         	
	         	$("#alramList").html(a);
	         	$('#alramCount').text(0);
	         	$('#alramCount').css('display', 'none');
	        }
	        
	    });	
		
	}

//목록클릭
function alramClick(bNo,categori,aNo,toId){
	console.log("alramClick")
	 $.ajax({
	        url : '${pageContext.request.contextPath }/alram/alramDelete.do',
	        type : 'post',
	        async : false,
	        data : {'toId' : toId , 'aNo':aNo},
	        success : function(){
	        	console.log("삭제완료");
				if(categori == 'lectureLike' || categori == 'lectureLikeCancle'){
					location.href="${pageContext.request.contextPath }/Common/getLecture.do?lectureNo="+bNo;	
				} else if(categori == 'Notice'){
					location.href="${pageContext.request.contextPath }/getAdminNotice.do?boardNo="+bNo;
				}
	        }
	        
	    
	    });
	
}

function alramListDelete(aNo,toId){
	console.log("alramListDelete")
	 $.ajax({
	        url : '${pageContext.request.contextPath }/alram/alramDelete.do',
	        type : 'post',
	        async : false,
	        data : {'toId' : toId , 'aNo':aNo},
	        success : function(){
	        	console.log("삭제완료");
	        	alramList2();
	        }
	        
	    
	    });
	
}

//알람
$(window).on('load',function() {
	alramCount()
});
function alramCount(){
	console.log("alram")
	var userId = "${user.userId}";
	 $.ajax({
	        url : '${pageContext.request.contextPath }/alram/alramCount.do',
	        type : 'get',
	        data : {'toId' : userId },
	        
	        success : function(alram){
	         	console.log(alram);
	         	console.log("알람성공");
 		        $('#alramCount').text(alram);//빨간표시등이 뜨면서 숫자값을 입력해야한다
 		        let $socketAlert = $('#alramCount');
 		        if(alram > 0){
					$socketAlert.css('display', 'block');
 		        } else {
 		        	$socketAlert.css('display', 'none');
 		        }
	        }
	    
	    });
}
</script>