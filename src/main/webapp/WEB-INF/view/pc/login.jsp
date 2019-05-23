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
/*  		div, span{
 			border: 1px dashed red;
 		} */
		.form-control{
			font-size: 2rem;
		}
		.btn{
			color: #000000;
		}
		.nomargin{
			margin: 0px;
		}
	</style>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/components/core-min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/components/x64-core-min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/components/sha512-min.js"></script>
	<script>
		$(document).ready(function(){
			$("form").on("submit", function(e){
				e.preventDefault();
				$(this).find("input[type=password]").each(function(i, element){
					var hash = CryptoJS.SHA512($(element).val());
					$(element).val(hash);
				});
				this.submit();
			});
		});
	</script>
</head>
<body>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="container-fluid">
		<div class="col-md-offset-4 col-md-4 text-center font-nbgb font-white font-2rem">
			<h1>
				로그인
			</h1>
		</div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 font-nbgl">
			<form method="POST">
				<div class="form-group font-2rem">
					<label for="email">이메일</label>
					<input type="email" class="form-control" name="email" id="email" <c:if test='${cookie.rememberemail!=null}'>value='${cookie.rememberemail.value}'</c:if> required>
				</div>
				<div class="form-group font-2rem">
					<label for="pw">비밀번호</label>
					<input type="password" class="form-control" name="pw" id="pw" required>
				</div>
				<div class="form-group form-inline font-1.5rem nomargin">
					<input type="checkbox" class="form-control" name="remember" <c:if test='${cookie.rememberemail!=null}'>checked</c:if> id="remember">
					<label for="remember">아이디 기억하기</label>
				</div>
				<div class="form-group form-inline font-1.5rem">
					<input type="checkbox" class="form-control" name="isadmin" id="isadmin">
					<label for="isadmin">매장관리자</label>
				</div>
				<div class="form-group">
					<button type="submit" class="btn btn-warning btn-block font-nbgb font-2rem">로그인</button>
				</div>
			</form>
				<div class="form-group">
					<a href="signin" class="btn btn-primary btn-block font-nbgb font-2rem">회원가입</a>
				</div>
				
		</div>
		<div class="col-md-offset-4 col-md-4 font-nbgl font-1.5rem text-center">
			<a href="findid">아이디찾기 & 임시비밀번호 발급</a>
		</div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 font-nbgl font-1.5rem text-center">
			<a href="expr_customer" class="btn btn-info btn-block font-nbgb font-2rem">회원 체험하기(회원 자동로그인)</a>
			<a href="expr_admin" class="btn btn-success btn-block font-nbgb font-2rem">관리자 체험하기(관리자 자동로그인)</a>
		</div>
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