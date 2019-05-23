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
	</style>
	<script>
		$(document).ready(function() {
			setCheckFunction();
		});
		function setCheckFunction(){
			$('#name').on('focusout',function(){
				var regex = /^[가-힣,ㄱ-ㅎ,ㅏ-ㅢ,A-Z,a-z,\d]{2,10}$/;
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_name').val('N');
				} else if(regex.test($(this).val())) {
					$(this).removeClass('border-red');
					$(this).addClass('border-green');
					$(this).parent().find('.alert-danger').addClass('hidden');
					$('#precheck_name').val('Y');
				} else {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert-danger').removeClass('hidden');
					$('#precheck_name').val('N');
				};
			});
			$('#gender').on('focusout',function(){
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_gender').val('N');
				};
			});
			$('#gender').on('change',function(){
				$(this).removeClass('border-red');
				$(this).addClass('border-green');
				$(this).parent().find('.alert').addClass('hidden');
				$('#precheck_gender').val('Y');
			});
			$('#phone').on('focusout',function(){
				var regex = /^0[\d]{1,2}-[\d]{3,4}-[\d]{4}$/;
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_phone').val('N');
				} else if(regex.test($(this).val())) {
					$(this).removeClass('border-red');
					$(this).addClass('border-green');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_phone').val('Y');
				} else {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_phone').val('N');
				};
			});
			$('#birth_str').on('focusout',function(){
				var regex = /^[\d]{4}-[\d]{2}-[\d]{2}$/;
				if(!$(this).val()) {
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_birth').val('N');
				} else if(regex.test($(this).val())) {
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_birth').val('Y');
				} else {
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_birth').val('N');
				};
			});
			$("form").on("submit", function(e){
				e.preventDefault();
				if($('#precheck_name').val()=='N') {
					$('html, body').animate({scrollTop: $('#name').offset().top-350}, 500);
					return;	
				};
				if($('#precheck_gender').val()=='N') {
					$('html, body').animate({scrollTop: $('#gender').offset().top-350}, 500);
					return;	
				};
				if($('#precheck_phone').val()=='N') {
					$('html, body').animate({scrollTop: $('#phone').offset().top-350}, 500);
					return;	
				};
				if($('#precheck_birth').val()=='N') {
					$('html, body').animate({scrollTop: $('#birth_str').offset().top-350}, 500);
					return;	
				};
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
				아이디 찾기
			</h1>
		</div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 font-nbgl font-2rem">
			<form method="POST">
				<div class="form-group">
					<label for="name">이름</label>
					<input type="text" class="form-control" name="name" id="name" maxlength="10" required>
					<input type="hidden" name="precheck_name" id="precheck_name" value="N">
					<div class="alert alert-danger hidden" role="alert">한글,영문,숫자로 2-10자를 입력해주세요!</div>
				</div>
				<div class="form-group">
					<label for="gender">성별</label>
					<select class="form-control" name="gender" id="gender" required>
						<option disabled selected>- 성별 선택 -</option>
						<option value="남">남</option>
						<option value="여">여</option>
					</select>
					<input type="hidden" name="precheck_gender" id="precheck_gender" value="N">
					<div class="alert alert-danger hidden" role="alert">성별을 선택해주세요!</div>
				</div>
				<div class="form-group">
					<label for="phone">연락처</label>
					<input type="text" class="form-control" name="phone" id="phone" maxlength="15" placeholder="0XX-XXXX-XXXX" required>
					<input type="hidden" name="precheck_phone" id="precheck_phone" value="N">
					<div class="alert alert-danger hidden" role="alert">-포함하여 0XX-XXXX-XXXX로 입력해주세요.</div>
				</div>
				<div class="form-group">
					<label for="birth_str">생년월일</label>
					<input type="date" class="form-control" name="birth_str" id="birth_str" required>
					<input type="hidden" name="precheck_birth" id="precheck_birth" value="N">
					<div class="alert alert-danger hidden" role="alert">네자리 연도와 올바른 월/일을 선택해주세요.</div>
				</div>
				<div class="form-group empty-row"></div>
				<div class="form-group">
					<button type="submit" class="btn btn-warning btn-block font-nbgb font-2rem">아이디 찾기</button>
				</div>
				<div class="form-group">
					<a href="login" class="btn btn-primary btn-block font-nbgl font-2rem">돌아가기</a>
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