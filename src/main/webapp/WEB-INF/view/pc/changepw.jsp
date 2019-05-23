<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
 		.form-group{
 			margin-bottom: 20px;
 		}
		.form-control{
			font-size: 2rem;
		}
		.btn-warning{
			color: #000000;
		}
		.help{
			font-size: 1.5rem;
			color: #888888;
			margin: 0px;
		}
		.alert{
			font-size: 1.5rem;
			margin: 0px;
			padding-top: 0px;
			padding-bottom: 0px;
		}
		.border-red{
			border-color: red;
		}
		.border-green{
			border-color: limegreen;
		}
		.bold {
			font-weight: bold;
		}
	</style>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/components/core-min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/components/x64-core-min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/components/sha512-min.js"></script>
	<script>
		$(document).ready(function() {
			setCheckFunction();
		});
		function setCheckFunction(){
			$('#newpw1').on('input',function(){
				var regex = /^[A-Za-z\d]{6,12}$/;
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_pw1').val('N');
				} else if(regex.test($(this).val())) {
					$(this).removeClass('border-red');
					$(this).addClass('border-green');
					$(this).parent().find('.alert-success').removeClass('hidden');
					$(this).parent().find('.alert-danger').addClass('hidden');
					$('#precheck_pw1').val('Y');
				} else {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert-danger').removeClass('hidden');
					$(this).parent().find('.alert-success').addClass('hidden');
					$('#precheck_pw1').val('N');
				};
			});
			$('#newpw2').on('focusout',function(){
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_pw2').val('N');
				} else if($(this).val()==$('#newpw1').val()) {
					$(this).removeClass('border-red');
					$(this).addClass('border-green');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_pw2').val('Y');
				} else {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_pw2').val('N');
				};
			});
			$("form").on("submit", function(e){
				e.preventDefault();
				if($('#precheck_pw1').val()=='N') {
					$('html, body').animate({scrollTop: $('#newpw1').offset().top-350}, 500);
					return;	
				};
				if($('#precheck_pw2').val()=='N') {
					$('html, body').animate({scrollTop: $('#newpw2').offset().top-350}, 500);
					return;	
				};
				$(this).find("#originpw").each(function(i, element){
					var hash = CryptoJS.SHA512($(element).val());
					$(element).val(hash);
				});
				$(this).find("#newpw1").each(function(i, element){
					var hash = CryptoJS.SHA512($(element).val());
					$(element).val(hash);
				});
				this.submit();
			});
		};
	</script>
</head>
<body>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="container-fluid">
		<div class="col-md-offset-4 col-md-4 text-center font-nbgb font-white font-2rem">
			<h1>
				비밀번호 변경
			</h1>
		</div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 font-nbgl font-2rem">
			<form method="POST">
				<input type="hidden" name="no" value="${me.no}">
				<div class="form-group">
					<label for="originpw">기존 비밀번호</label>
					<input type="password" class="form-control" name="originpw" id="originpw" maxlength="12" required placeholder="기존 비밀번호 입력">
				</div>
				<div class="form-group">
					<label for="originpw">새로운 비밀번호</label>
					<input type="password" class="form-control" name="pw" id="newpw1" maxlength="12" required placeholder="영문(대소문자구분),숫자로 6-12자">
					<input type="hidden" id="precheck_pw1" value="N">
					<div class="alert alert-success hidden" role="alert">사용가능한 비밀번호입니다.</div>
					<div class="alert alert-danger hidden" role="alert">비밀번호는 영문(대소문자구분),숫자로 6-12자로 입력해주세요!</div>
				</div>
				<div class="form-group">
					<label for="originpw">새로운 비밀번호 재입력</label>
					<input type="password" class="form-control" id="newpw2" maxlength="12" required placeholder="위와 동일하게 한번 더 입력">
					<input type="hidden" id="precheck_pw2" value="N">
					<div class="alert alert-danger hidden" role="alert">재입력이 불일치합니다! 확인해주세요.</div>
				</div>
				<div class="form-group empty-row"></div>
				<div class="form-group">
					<button type="submit" class="btn btn-warning btn-block font-nbgb font-2rem">비밀번호 변경</button>
					<a href="myinfo" class="btn btn-primary btn-block font-nbgl font-2rem">돌아가기</a>
				</div>
			</form>
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