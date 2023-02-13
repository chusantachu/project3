<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>공지사항 상세보기</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">
  <style>
	 .tape {
		height: 100px;
		margin: 50px auto;
		padding-top: 15px;
		color: white;
	}
	.inner {
		width: 900px;
		display: inline-block;
		text-align: left;
	}
	.outer {
		text-align: center;
	}
	.date { text-align: right; }
	.content, .date {
		font-family: 'Gamja Flower', cursive;
	    font-size: 20px;
	    font-weight: 400;
	}
	.container{
		text-align: right;
	}
	.btn{
		display :inline-block;
	}
  </style>
</head>
<body>
<%@ include file="/Common/header.jsp" %>
 <div class="container-fluid bg-dark">
	<div class="container tape">
		<section class="tapeContent">		
			<h2>NEW</h2>
			<p>아웃풋런의 새소식</p>
		</section>
	</div>
</div>
<br>

<div class="outer">
	<div class="inner">
		<h2>${vo.boardTitle }</h2>
	</div>
</div>
<hr>
<div class="outer">
	<div class="inner">
		<p class="date">${vo.boardRegdate.substring(0,10) }</p><br>
		<span class="content">
			${vo.boardContent }
		</span>
		<br><br>
		<div class="container">
	 		<button type="submit" class="btn btn-success" onclick="location.href='getNoticeList.do'">목록으로</button>
		</div>
	</div>
</div>
<br><br>
<br><br><br>
<%@ include file="/Common/footer.jsp" %>
</body>
</html>
