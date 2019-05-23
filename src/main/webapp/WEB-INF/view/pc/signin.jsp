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
		.btn{
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
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/components/core-min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/components/x64-core-min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/components/sha512-min.js"></script>
	<script>
		$(document).ready(function() {
			setCheckFunction();
		});
		function setCheckFunction(){
			$('#email').on('input',function(){
				$(this).removeClass('border-red');
				$(this).removeClass('border-green');
				$(this).parent().find('.alert').addClass('hidden');
				$('#precheck_email').val('N');
			});
			$('#email').on('focusout',function(){
				if($(this).val()!='') {
					var regex = /^[A-Za-z\d]*@[A-Za-z\d\.]*$/;
					if(regex.test($(this).val())) {
						$.ajax({
		                    url: "${pageContext.request.contextPath}/ajax/signin/emailcheck",
		                    data:{
		                    	email:$(this).val(),
		                    },
		                    type:"post",
		                    success:function(response){
		                    	if(response.trim()=='N'){
		                    		$('#email').removeClass('border-red');
		                    		$('#email').addClass('border-green');
		            				$('#email').parent().find('.alert-success').removeClass('hidden');
		            				$('#email').parent().find('.prealert-email1').addClass('hidden');
		            				$('#precheck_email').val('Y');
		                    	} else {
		            				$('#email').removeClass('border-green');
		                    		$('#email').addClass('border-red');
		            				$('#email').parent().find('.prealert-email1').removeClass('hidden');
		            				$('#email').parent().find('.alert-success').addClass('hidden');
		            				$('#precheck_email').val('N');
		                    	}
		                    }
		                });
					} else {
						$('#email').removeClass('border-green');
                		$('#email').addClass('border-red');
        				$('#email').parent().find('.prealert-email2').removeClass('hidden');
        				$('#email').parent().find('.alert-success').addClass('hidden');
        				$('#precheck_email').val('N');
					};
				};
			});
			$('#pw').on('input',function(){
				var regex = /^[A-Za-z\d]{6,12}$/;
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_pw').val('N');
				} else if(regex.test($(this).val())) {
					$(this).removeClass('border-red');
					$(this).addClass('border-green');
					$(this).parent().find('.alert-success').removeClass('hidden');
					$(this).parent().find('.alert-danger').addClass('hidden');
					$('#precheck_pw').val('Y');
				} else {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert-danger').removeClass('hidden');
					$(this).parent().find('.alert-success').addClass('hidden');
					$('#precheck_pw').val('N');
				};
			});
			$('#pw2').on('focusout',function(){
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_pw2').val('N');
				} else if($(this).val()==$('#pw').val()) {
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
				if($('#precheck_email').val()=='N') {
					$('html, body').animate({scrollTop: $('#email').offset().top-350}, 500);
					return;	
				};
				if($('#precheck_pw').val()=='N') {
					$('html, body').animate({scrollTop: $('#pw').offset().top-350}, 500);
					return;	
				};
				if($('#precheck_pw2').val()=='N') {
					$('html, body').animate({scrollTop: $('#pw2').offset().top-350}, 500);
					return;	
				};
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
				$(this).find("input[type=password]").each(function(i, element){
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
				회원가입
			</h1>
		</div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 font-nbgl font-2rem">
			<form method="POST">
				<div class="form-group">
					<label for="email">이메일</label>
					<input type="email" class="form-control" name="email" id="email" maxlength="50" required>
					<input type="hidden" name="precheck_email" id="precheck_email" value="N">
					<p class="help">사용 중인 이메일을 입력해주세요. 로그인 및 비밀번호 찾기에 사용됩니다.</p>
					<div class="alert alert-success hidden" role="alert">사용가능한 이메일입니다.</div>
					<div class="alert alert-danger hidden prealert-email1" role="alert">이미 가입된 이메일입니다!</div>
					<div class="alert alert-danger hidden prealert-email2" role="alert">이메일 양식(@포함)을 지켜주세요!</div>
				</div>
				<div class="form-group">
					<label for="pw">비밀번호</label>
					<input type="password" class="form-control" name="pw" id="pw" maxlength="12" required placeholder="영문(대소문자구분),숫자로 6-12자">
					<input type="hidden" name="precheck_pw" id="precheck_pw" value="N">
					<div class="alert alert-success hidden" role="alert">사용가능한 비밀번호입니다.</div>
					<div class="alert alert-danger hidden" role="alert">비밀번호는 영문(대소문자구분),숫자로 6-12자로 입력해주세요!</div>
				</div>
				<div class="form-group">
					<label for="pw2">비밀번호 재입력</label>
					<input type="password" class="form-control" name="pw2" id="pw2" maxlength="12" required placeholder="위와 동일하게 한번 더 입력">
					<input type="hidden" name="precheck_pw2" id="precheck_pw2" value="N">
					<div class="alert alert-danger hidden" role="alert">재입력이 불일치합니다! 확인해주세요.</div>
				</div>
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
					<p class="help">면도/두피/모발관리 등 고객맞춤 서비스에 활용됩니다.</p>
					<div class="alert alert-danger hidden" role="alert">성별을 선택해주세요!</div>
				</div>
				<div class="form-group">
					<label for="phone">연락처</label>
					<input type="text" class="form-control" name="phone" id="phone" maxlength="15" placeholder="0XX-XXXX-XXXX" required>
					<input type="hidden" name="precheck_phone" id="precheck_phone" value="N">
					<p class="help">동명인 구분 및 본인 확인에 활용됩니다.</p>
					<div class="alert alert-danger hidden" role="alert">-포함하여 0XX-XXXX-XXXX로 입력해주세요.</div>
				</div>
				<div class="form-group">
					<label for="birth_str">생년월일</label>
					<input type="date" class="form-control" name="birth_str" id="birth_str" required>
					<input type="hidden" name="precheck_birth" id="precheck_birth" value="N">
					<p class="help">동명인 구분 및 생일이벤트에 활용됩니다.</p>
					<div class="alert alert-danger hidden" role="alert">네자리 연도와 올바른 월/일을 선택해주세요.</div>
				</div>
				<div class="form-group help">
					<p class="nomargin">회원정보는 최종 로그인 혹은 방문일로부터 1년이 지나면 삭제됩니다.</p>
					<p class="nomargin">(30일 전 메일 통보)</p>
				</div>
				
				
				<div class="form-group empty-row"></div>
				<div class="form-group">
					<button type="submit" class="btn btn-warning btn-block font-nbgb font-2rem">회원가입</button>
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