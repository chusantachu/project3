<%--
  Created by IntelliJ IDEA.
  User: itwill
  Date: 2022-11-21
  Time: 오후 1:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script type="text/javascript">
  var naverLogin = new naver.LoginWithNaverId(
          {
            clientId: "vkx131bLLt6ehxKoqXiH",
            callbackUrl: "http://localhost:8080/learn/Member/naverLogin.jsp",
            isPopup: false,
          }
  );
  naverLogin.init();
  window.addEventListener('load', function () {
    naverLogin.getLoginStatus(function (status) {
      if (status) {
        let vo = {};
        vo.socialType = 'naver';
        vo.userId = naverLogin.user.getEmail();
        vo.userName = naverLogin.user.getName();
        vo.userBirth = naverLogin.user.getBirthyear() + naverLogin.user.getBirthday();
        console.log(vo);
        console.log(JSON.stringify(vo));

        $.ajax("naverLogin.do", {
          type: "post",
          data: JSON.stringify(vo), // 서버쪽으로 JSON 문자열 전달
          contentType: "application/json", //서버로 전송하는 컨텐츠 유형(JSON형식)
          dataType: "json", //서버로부터 응답받는 데이터 형식
          success: function(data){
            console.log(data);
            location.href='${pageContext.request.contextPath }/common/main.do';
          },
          error: function(){
            alert("실패~~");
          }
        });
      } else {
        console.log("callback 처리에 실패하였습니다.");
      }
    });
  });
</script>

