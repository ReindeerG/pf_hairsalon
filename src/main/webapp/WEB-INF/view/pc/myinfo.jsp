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
		.bold {
			font-weight: bold;
		}
	</style>
	<script>
		$(document).ready(function() {
			setCheckFunction();
			setFirst();
		});
		function setCheckFunction(){
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
			$("form").on("submit", function(e){
				e.preventDefault();
				if($('#precheck_phone').val()=='N') {
					$('html, body').animate({scrollTop: $('#phone').offset().top-350}, 500);
					return;	
				};
				this.submit();
			});
		};
		function setFirst() {
			$('.btn-danger').on('click',function(){
				var no = ${sessionScope.loginno};
				if(no==21) {
					alert('체험용 아이디는 탈퇴시킬 수 없습니다!');
					return;
				}
				var result = confirm('정말로 탈퇴하시겠습니까? 마일리지 및 모든 정보는 폐기됩니다.');
				if(result) {
					if(result) window.location.replace('imout?no='+no);
				}
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
				나의 정보
			</h1>
		</div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 font-nbgl font-2rem">
			<form method="POST">
				<input type="hidden" name="no" value="${me.no}">
				<div class="form-group">
					<span class="bold">이름:</span> ${me.name}
					<p class="help">(개명 후 이름 변경은 매장관리자에게 문의해주세요.)</p>
				</div>
				<div class="form-group">
					<span class="bold">성별:</span> ${me.gender}
					<p class="help">(성별 변경은 매장관리자에게 문의해주세요.)</p>
				</div>
				<div class="form-group">
					<label for="phone">연락처</label>
					<input type="text" class="form-control" name="phone" id="phone" maxlength="15" placeholder="0XX-XXXX-XXXX" required value="${me.phone}">
					<input type="hidden" name="precheck_phone" id="precheck_phone" value="Y">
					<p class="help">동명인 구분 및 본인 확인에 활용됩니다.</p>
					<div class="alert alert-danger hidden" role="alert">-포함하여 0XX-XXXX-XXXX로 입력해주세요.</div>
				</div>
				<div class="form-group">
					<span class="bold">이메일:</span> ${me.email}
					<p class="help">(이메일 변경은 매장관리자에게 문의해주세요.)</p>
				</div>
				<div class="form-group">
					<span class="bold">생년월일:</span> ${me.birth_str}
					<p class="help">(생년월일 변경은 매장관리자에게 문의해주세요.)</p>
				</div>
				<div class="form-group">
					<span class="bold">마일리지:</span> ${me.mileage}원
					<p class="help">(매장에서 사용/충전 가능합니다.)</p>
				</div>
				<div class="form-group">
					<span class="bold">가입일:</span> ${me.reg_str}
				</div>
				<div class="form-group">
					<span class="bold">방문횟수:</span> ${me.visitcount}
				</div>
				<div class="form-group">
					<span class="bold">최근방문일:</span> ${me.latestdate_str}
				</div>
				<div class="form-group help">
					<p class="nomargin">회원정보는 최종 로그인 혹은 방문일로부터 1년이 지나면 삭제됩니다.</p>
					<p class="nomargin">(30일 전 메일 통보)</p>
				</div>
				<div class="form-group empty-row"></div>
				<div class="form-group">
					<button type="submit" class="btn btn-warning btn-block font-nbgb font-2rem">연락처 변경사항 저장</button>
					<a href="changepw" class="btn btn-info btn-block font-nbgb font-2rem">비밀번호 변경하기</a>
				</div>
				<div class="form-group empty-row"></div>
				<div class="form-group">
					<button type="button" class="btn btn-danger btn-block font-nbgb font-2rem">회원 탈퇴하기</button>
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