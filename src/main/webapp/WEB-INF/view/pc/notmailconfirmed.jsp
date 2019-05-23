<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<script>
		$(document).ready(function() {
			alert('메일함을 확인해주세요!');
			$('.removable').on('click',function(){
				$(this).addClass('hidden');
			});
		});
	</script>
</head>
<body>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="container-fluid">
		<div class="col-md-offset-3 col-md-6 text-center font-nbgb font-white font-2rem">
			<h1>
				로그인 실패..
			</h1>
		</div>
		<div class="col-md-offset-3 col-md-6 empty-row"></div>
		<div class="col-md-offset-3 col-md-6 empty-row"></div>
		<div class="col-md-offset-3 col-md-6 font-nbgl font-2rem text-center">
			<p>${param.email}님! 아직 이메일 인증이 완료되지 않았습니다.</p>
			<p>이메일 인증 후 로그인하실 수 있습니다.</p>
			<p>인증메일은 가입하신 이메일로 발송되어 있습니다.</p>
		</div>
		<div class="col-md-offset-3 col-md-6 empty-row"></div>
		<div class="col-md-offset-3 col-md-6 font-nbgl font-1.5rem text-center">
			<p>가입신청 24~48시간 후에도 인증되지 않는다면,</p>
			<p>신청정보는 말끔하게 파기됩니다.</p>
		</div>
		<div class="col-md-offset-3 col-md-6 empty-row"></div>
		<div class="col-md-offset-3 col-md-6 font-nbgl text-center">
			<a href="sendconfirm?email=${param.email}" class="btn btn-warning font-2rem removable">인증메일 재전송 요청</a>
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