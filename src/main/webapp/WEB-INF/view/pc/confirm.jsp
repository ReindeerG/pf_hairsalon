<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>
<head>
	<style>
		body{
			background-color: #000000;
			color: #DDDDDD;
		}
 		.btn{
			color: #000000;
		}
	</style>
</head>
<body>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="container-fluid">
		<c:choose>
			<c:when test="${result==1}">
				<div class="col-md-offset-3 col-md-6 text-center font-nbgb font-white font-2rem">
					<h1>
						인증완료!
					</h1>
				</div>
				<div class="col-md-offset-3 col-md-6 empty-row"></div>
				<div class="col-md-offset-3 col-md-6 empty-row"></div>
				<div class="col-md-offset-3 col-md-6 font-nbgl font-2rem text-center">
					<p>인증이 완료되었습니다!</p>
					<p>이제 로그인 가능합니다.</p>
				</div>
				<div class="col-md-offset-3 col-md-6 empty-row"></div>
				<div class="col-md-offset-3 col-md-6 font-nbgl text-center">
					<a href="login" class="btn btn-warning font-2rem">로그인</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="col-md-offset-3 col-md-6 text-center font-nbgb font-white font-2rem">
					<h1>
						인증실패..
					</h1>
				</div>
				<div class="col-md-offset-3 col-md-6 empty-row"></div>
				<div class="col-md-offset-3 col-md-6 empty-row"></div>
				<div class="col-md-offset-3 col-md-6 font-nbgl font-2rem text-center">
					<p>다시 로그인 시도 후 인증메일을 요청해주세요.</p>
					<p>계속해서 같은 문제가 발생한다면, 전화로 문의주세요.</p>
				</div>
				<div class="col-md-offset-3 col-md-6 empty-row"></div>
				<div class="col-md-offset-3 col-md-6 font-nbgl text-center">
					<a href="login" class="btn btn-warning font-2rem">로그인</a>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
</body>
<jsp:include page="footer.jsp"/>