<%@ page    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>footer.jsp</title>

<style>
html, body {
  margin: 0;
  padding: 0;
}

#wrap {
/*   min-height: 20vh; */
  position: relative;
  width: 100%; 
  
}

section {
  padding-bottom: 105px;
}

footer {
  width: 100%;
  height: 90px;
  bottom: 0px;
  <%-- position: absolute; --%>
  border-top: 1px solid #c4c4c4;
  padding-top: 15px;
  font-size: 14px;
}

footer a {
  display: inline-block;
  margin: 0 20px 10px 20px;
  color: #808080; font-size: 11px;
}

footer a:visited {
  color: #808080;
}

footer p {
  margin-top: 0; margin-bottom: 0;   
}

footer p span {
  display: inline-block;
  margin-left: 20px;
}

</style>


</head>


<body>
     <div id='wrap'>
    	<section>
        	<!-- 대충 뭐 요소들이 가득차있음 -->
        </section>
<footer>
<div class="container ws-grey padding"  style="display:none;position:relative">
</div>

	
	
	
	


 


 <nav>
              <a href='#' target='_blank'>로고</a> |
              <a href='#' target='_blank'>개인정보취급방침</a>|
              <a href='#' target='_blank'>이용약관</a>
          </nav>
          <p>
              <span>(주)인프랩 | 대표자: 이형주 | 사업자번호: 499-81-00612 사업자 정보 확인</span><br/>
              <span>통신판매업: 2018-성남분당B-0062 | 개인정보보호책임자: 이동욱 | 이메일: info@inflearn.com</span><br/>
              <span>주소: 경기도 성남시 분당구 대왕판교로 660 유스페이스 1A동 405호</span><br/><br>
              <span>©INFLAB. ALL RIGHTS RESERVED</span><br/>
              
          </p>
  </footer> 
 </div>
</body>
</html>