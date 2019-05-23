<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="sidebar.jsp"/>
<head>
	<style>
		.nomargin {
			margin: 0px !important;
		}
		.container {
			min-width: 340px;
		}
	</style>
	<script>
		$(document).ready(function() {
			sidemenuHilight();
			firstSet();
		});
		function sidemenuHilight() {
			$('#menu_customer').addClass('active');
		};
		function firstSet() {
			$('#plus').on('input',function(){
				if(parseInt($(this).val())<0) $(this).val(0);
				if(parseInt($(this).val())>99999999) $(this).val(parseInt(parseInt($(this).val())/10));
				var plus = $(this).val();
				if(plus=='') plus=0;
				$('#final').val(parseInt($('#origin').val())+parseInt(plus));
			});
			$('#plus').on('focusout',function(){
				if($(this).val()=='') $(this).val(0);
			});
			$('form').on('submit',function(e){
				e.preventDefault();
				if(parseInt($('#plus').val())==0) {
					alert('충전할 금액을 입력해주세요!');
					return;
				}
				this.submit();
			});
		};
	</script>
</head>
<body>
	<div class="admin_body container">
		<div class="col-md-12 font-nbgb">
			<h1><i class="fas fa-coins"></i> 마일리지 충전</h1>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 font-nbgl font-1.5rem">
			<form action="mileage" method="POST">
				<div class="panel panel-warning nomargin">
					<div class="panel-heading font-nbgb">
						<h3 class="panel-title">${customerDto.name}님의 마일리지 충전</h3>
					</div>
					<div class="panel-body">
						<input type="hidden" name="no" value="${customerDto.no}">
						<div class="form-group nomargin">
							<label>기존 마일리지</label>
							<input type="number" class="form-control text-right" id="origin" value="${customerDto.mileage}" readonly required>
						</div>
						<div class="text-center nomargin">
							<i class="fas fa-plus-circle fa-3x"></i>
						</div>
						<div class="form-group nomargin">
							<label for="plus">충전할 마일리지</label>
							<input type="number" class="form-control text-right" name="mileage" id="plus" value="0" required>
						</div>
						<div class="text-center nomargin">
							<i class="fas fa-arrow-alt-circle-down fa-3x"></i>
						</div>
						<div class="form-group">
							<label>충전 후 마일리지</label>
							<input type="number" class="form-control text-right" id="final" value="${customerDto.mileage}" readonly required>
						</div>
					</div>
					<div class="panel-footer text-right">
						<button type="submit" class="btn btn-warning">충전</button>
						<a href="customer" class="btn btn-primary">취소</a>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
