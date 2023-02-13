<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
	<title>강의자  - 강의 관리 - 새소식 상세보기</title>
</head>
<style>
	.active-menu {
	  color: #1dc078;
	  font-weight: bold;
	}
	.norm-menu {
	  color: black;
	}
	.active-btn {
	  color: #fff;
	  background-color: #00C471;
	  border-style: none;
	  padding: 5px;
	  border-radius: 5px;
	  margin-right: 5px;
	}
  .tape {
    height: 70px;
    margin: 50px auto;
    padding-top: 15px;
    color: white;
  }

</style>
<body>
<%@include file="/Common/header.jsp" %>
<div class="container-fluid bg-dark">
    <div class="container tape">
        <section class="tapeContent">
            <h2>새소식 관리</h2>
        </section>
    </div>
</div>
<div class="container-fluid mt-5 pb-3 d-flex justify-content-center">
    <div class="row w-100 pb-4 justify-content-center">
        <!-- 왼쪽 네비 -->
        <div class="col-2 d-flex justify-content-center">
            <%@ include file="sidebar.jspf"%>
            <script>
              var menu = $('#lectureManager');
              console.log(menu);
              menu.removeClass('norm-menu');
              menu.addClass('active-menu');
            </script>
        </div>

        <!-- 중앙 위 내용 - 글내용 -->
        <div class="col-8 pl-3 gray-line">
            <h2>새소식 상세보기</h2>
            <button class="active-btn mt-2" onclick="location.href='${pageContext.request.contextPath}/getLectureNewsList.do?lectureNo=${vo.lectureNo }'">목록으로 돌아가기</button>
            <table class="table mt-4">
                <thead>
                    <tr>
                        <th><h2>${vo.newsTitle }</h2></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${vo.newsContent }</td>
                    </tr>
                </tbody>
                <tfoot>
                	<tr>
                		<td style="text-align: right;">
       				 		<button type="submit" class="btn btn-success" onclick="location.href='${pageContext.request.contextPath }/getLectureNewsUpdateView.do?boardNo=${vo.boardNo }&lectureNo=${vo.lectureNo }'">수정</button>
	 						<button type="submit" class="btn btn-dark" onclick="delete_go()">삭제</button>
                		</td>
                	</tr>
                </tfoot>
            </table>
        </div>
        <div class="col-2 d-flex justify-content-center">
        </div>
    </div>
</div>
<%@include file="/Common/footer.jsp" %>
</body>
<script>
	function delete_go() {
		var con_test = confirm("게시글을 삭제하시겠습니까?");
		if (con_test == true) {
			alert("게시글이 삭제 되었습니다.");
			location.href = '${pageContext.request.contextPath }/deleteLectureNews.do?boardNo=${vo.boardNo }&lectureNo=${vo.lectureNo}';
		}
		//else if (con_test == false) {
		//}
	}
</script>
</html>
