<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
  <title>관리자 페이지 - 강의자관리</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <style>
	/* 페이징처리 css */
	.page_wrap {
		text-align:center;
		font-size:0;
	 }
	.page_nation {
		display:inline-block;
	}
	.page_nation .none {
		display:none;
	}
	.page_nation a {
		display:block;
		margin:0 3px;
		float:left;
		border:1px solid #e6e6e6;
		width:28px;
		height:28px;
		line-height:28px;
		text-align:center;
		background-color:#fff;
		font-size:13px;
		color:#999999;
		text-decoration:none;
	}
	.page_nation .arrow {
		border:1px solid #ccc;
	}
	.page_nation .prev {
		background:#f8f8f8
		margin-right:7px;
	}
	.page_nation .next {
		background:#f8f8f8
		margin-left:7px;
	}
	.page_nation a.active {
		background-color : #00C471;
		color:white;
		border:1px solid #00C471;
	}
	
	/* 버튼 css */
	.button {
	  background-color: gray;
	  border: 1px solid white;
	  color: white;
	  padding: 10px 20px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 16px;
	  cursor: pointer;
	}
	
	#active {
		background-color: #00C471;
	}
  	.inner2 {
		width: 1100px;
		display: inline-block;
		text-align: left;
		margin-left: 0%;
	}
	.outer2 {
		text-align: center;
	}
	.button2:hover {
	  box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
	}
	.tabla {
		width: 1100px;
	}
	.table th, .table td {
		text-align: center;
	}
	
	.detail {
	  background-color: #00C471; 
	  border: none;
	  color: white;
 	  padding: 1px 10px 1px 10px; 
	  text-decoration: none;
	  display: inline-block;
 	  font-size: 15px; 
	  cursor: pointer;
	  border-radius: 12px;
	}

  </style>
<script>
function getTrueResume() {
	//alert("getTrueResume() 실행");
	
	$.ajax("getTrueResume.do", {
		type: "get",
		dataType: "json", 
		success: function(data){ 
			//alert("성공");
			let list = "";		
			
			//데이터 리스트 출력
			for (let resume of data.list) {				
				console.log("list : " + resume.userId);
				list += '<tr>';
				list += '<td>' + resume.userId + '</td>';
				list += '<td>' + resume.userName + '</td>';
				if (resume.resumeStatus == 'true') {
					list += '<td>승인</td>';
				}
				list += '<td>' + resume.regdate.substring(0,10) + '</td>';
				list += '<td>' + resume.categoryName + '</td>';
				list += '<td><button type="button" class="detail" onclick="openPopUp(' + "'" + resume.userId + "'" + ')">상세보기</button></td>';
				list += '</tr>';
			}
			
			//페이지 출력
	        console.log("page : " + data.pvo.beginPage);  
            let page = "";
            page += '<div class="page_wrap">';
            page += '<div class="page_nation">';
            if (data.pvo.beginPage != 1) {
            	page += '<a class="arrow prev" href="${pageContext.request.contextPath}/Admin/getTrueResume.do?cPage=' + data.pvo.beginPage + '- 1 ">&lt</a>';
			}
            for (let i = data.pvo.beginPage; i <= data.pvo.endPage; i++) {
				if (i == data.pvo.nowPage) {
					page += '<a class="active">' + i + '</a>';
				} else if (i != data.pvo.nowPage) {
					page += '<a href="${pageContext.request.contextPath}/Admin/getTrueResume.do?cPage=${pageNo }">' + i + '</a>';
				}
			}
            if (data.pvo.endPage < data.pvo.totalPage) {
            	 page += '   <a class="arrow next" href="${pageContext.request.contextPath}/Admin/getTrueResume.do?cPage=' + data.pvo.endPage + ' + 1">&gt</a>';    
            }
            page += '</div>';
            page += '</div>';
            
            //버튼 active 변경
            let button = "";
            button += '<button class="button button2" onclick="getFalseResume()">승인대기</button>';
            button += '<button class="button button2" id="active" onclick="getTrueResume()">승인완료</button>';
	            
			$("#dispBody").html(list);
			$("#dispBody2").html(page);
			$("#dispBody3").html(button);
		},
		error: function(){
			alert("[ERROR]오류");
		}
	});
}

function getFalseResume() {
	location.href="${pageContext.request.contextPath}/Admin/getFalseResume.do";
}

function openPopUp(userId) {
	window.open("getResumeDetail.do?userId=" + userId, "상세보기", "width=570, height=580, top=150, left=600");
}

</script>
</head>
<body>
<%@ include file="/Admin/common/adminHeader.jspf" %>
<br><br>

<br><br>
<div class="outer2">
	<div class="inner2">
		<div class="btn-group" id="dispBody3">
			<button class="button button2" id="active" onclick="getFalseResume()">승인대기</button>
			<button class="button button2" onclick="getTrueResume()">승인완료</button>
		</div>
	</div>
</div>
<div class="outer2">
	<div class="inner2">
		<table class="table">
			<thead>
				<tr>
					<th width="20%">아이디</th>
					<th width="15%">이름</th>
					<th width="15%">상태</th>
					<th width="20%">신청일</th>
					<th width="20%">희망분야</th>
					<th>상세보기</th>
				</tr>
			</thead>
			<tbody id="dispBody">
				<c:if test="${not empty resumeFalseList }">
					<c:forEach var="resume" items="${resumeFalseList }">
						<tr>
							<td>${resume.userId }</td>
							<td>${resume.userName }</td>
							<c:if test="${resume.resumeStatus eq 'false' }">
								<td>대기</td>
							</c:if>
							<td>${resume.regdate.substring(0,10) }</td>
							<td>${resume.categoryName }</td>
							<td><button type="button" class="detail" onclick="openPopUp('${resume.userId }')">상세보기</button></td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty resumeFalseList }">
					<tr>
						<td colspan="6">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
<br><br>

<!-- 페이징처리-->
<div id="dispBody2">
	<div class="page_wrap">
	   <div class="page_nation">
		<c:if test="${pvo.beginPage != 1}">	
			<a class="arrow prev" href="${pageContext.request.contextPath}/Admin/getFalseResume.do?cPage=${pvo.beginPage - 1 }">&lt</a>
		</c:if>
		
		<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
			<c:if test="${pageNo == pvo.nowPage }">
				<a class="active">${pageNo}</a>
			</c:if>
			<c:if test="${pageNo != pvo.nowPage }">
				<a href="${pageContext.request.contextPath}/Admin/getFalseResume.do?cPage=${pageNo }">${pageNo}</a>
			</c:if>
		</c:forEach>	
		
		<c:if test="${pvo.endPage < pvo.totalPage}">
			<a class="arrow next" href="${pageContext.request.contextPath}/Admin/getFalseResume.do?cPage=${pvo.endPage + 1 }">&gt</a>
		</c:if>
	   </div>
	</div> 	
</div>	

<br><br>
<%@ include file="/Common/footer.jsp" %>
</body>
</html>
