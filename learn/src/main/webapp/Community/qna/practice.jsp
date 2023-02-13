<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문게시판리스트</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Community/css/jyStyle.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>


<script type="text/javascript">
	function alertDap(num){
		alert(num);
	}

</script>


</head>
<body>
	
	<%@include file="/Common/header.jsp" %>
	<%@include file="/Community/qna/qnaTape.jsp" %>

	<div class="container-fluid">
		
		<ul>
			<li>
				<a class="dap" href="javascript:alertDap('1111')">11</a>
			</li>
			<li>
				<a class="dap" href="javascript:alertDap('2222')">22</a>
			</li>
			<li>
				<a class="dap" href="javascript:alertDap('3333')">33</a>
			</li>
			<li>
				<a class="dap" href="javascript:alertDap('4444')">44</a>
			</li>
		
		</ul>
		
		
	</div>	
	
	<%@include file="/Common/footer.jsp" %>




</body>
</html>