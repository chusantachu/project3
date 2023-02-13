<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정 페이지</title>
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
   <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

<style>
	html, body {
		height: 100%;
	}
</style>

</head>
<body>
	<div class="container h-100 text-center">
		<div class="d-flex align-items-center mx-auto text-center h-100" style="width: 40%;">
			<div class="mx-auto">
				<p class="title">비밀번호 변경 안내</p>
				<p>비밀번호 변경이 완료되었습니다.</p>
				<p>
					<input type="button" class="btn-block btn btn-success my-2" value="확인"
						onclick="location.href='${pageContext.request.contextPath }/Common/index.jsp'">
				</p>
			</div>
		</div>
	</div>

</body>
</html>