<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="sidebar.jsp"/>
<head>
	<style>
		table th{
			text-align: center;
		}
		.form-control {
			padding:0px;
		}
		.alert {
			font-size: 1.2rem;
			padding:0px;
			text-align: center;
		}
		.gender-m {
			color: skyblue;
		}
		.gender-f {
			color: pink;
		}
		.sortable {
			color: orange !important;
		}
		.nopadding {
			padding: 0px 2px 0px 2px;
		}
		.nomargin {
			margin: 0px;
		}
		.container {
			min-width: 800px;
		}
	</style>
	<script>
		var modline
		var originemail;
		$(document).ready(function() {
			modline = $('#modline').detach();
			menuHilight();
			firstBtnSet();
		});
		function menuHilight() {
			$('#menu_customer').addClass('active');
			$('#pagenation_${pagenationcurrent}').addClass('active');
		};
		function removeBtns() {
			$('.removable').addClass('hidden');
		};
		function firstBtnSet() {
			setNewCheckFunction();
			$('#btn-new').on('click',function(){
				removeBtns();
				$('#newline').removeClass('hidden');
				$('#helpfornew').removeClass('hidden');
			});
			$('.btn-info').each(function(i,element){
				$(element).on('click',function(){
					removeBtns();
					var no = $(this).parent().parent().find('.section-no').text().trim();
					var name = $(this).parent().parent().find('.section-name').text().trim();
					var gender = $(this).parent().parent().find('.section-gender').text().trim();
					var phone = $(this).parent().parent().find('.section-phone').text().trim();
					var mileague = $(this).parent().parent().find('.section-mileague').text().trim();
					mileague = mileague.substring(0,mileague.indexOf('원')+1);
					var email = $(this).parent().parent().find('.section-email').text().trim();
					originemail = email;
					var birth = $(this).parent().parent().find('.section-birth').text().trim();
					var designer = $(this).parent().parent().find('.section-designer').find('span').text().trim();
					var reg = $(this).parent().parent().find('.section-reg').text().trim();
					var visitcount = $(this).parent().parent().find('.section-visitcount').text().trim();
					var latestdate = $(this).parent().parent().find('.section-latestdate').text().trim();
					var deletedate = $(this).parent().parent().find('.section-deletedate').text().trim();
					$(this).parent().parent().replaceWith(modline);
					$('#section-mod_no').text(no);
					$('#mod_no').val(no);
					$('#mod_name').val(name);
					switch(gender) {
					case '남': $('#mod_gender_m').prop('selected',true); break;
					case '여': $('#mod_gender_f').prop('selected',true); break;
					};
					$('#mod_phone').val(phone);
					$('#section-mod_mileague').text(mileague);
					$('#mod_email').val(email);
					$('#mod_birth_str').val(birth);
					$('#mod_designer').val(designer);
					$('#section-mod_reg').text(reg);
					$('#section-mod_visitcount').text(visitcount);
					$('#section-mod_latestdate').text(latestdate);
					$('#section-mod_deletedate').text(deletedate);
					setModCheckFunction();
				});
			});
			$('.btn-danger').each(function(i,element){
				$(element).on('click',function(){
					var no = $(this).parent().parent().find('.section-no').text().trim();
					if(no==21) {
						alert('회원 체험용 아이디는 삭제하실 수 없습니다!');
						return;
					}
					var result = confirm('정말로 이 회원을 삭제합니까?');
					if(result) window.location.replace('customer/del?no='+no);
				});
			});
			$('select[name=search]').on('change',function(){
				if($(this).val()=='no') {
					$('input[name=keyword]').prop('type','number');
				} else if($(this).val()=='phone') {
					$('input[name=keyword]').prop('type','number');
				}
				else {
					$('input[name=keyword]').prop('type','text');
				}
			});
			$('.btn-mailconfirm').each(function(i,element){
				$(element).on('click',function(){
					var result = confirm('이 회원의 메일인증을 강제완료 시킵니까?');
					if(result) {
						var no = $(element).parent().parent().find('.section-no').text().trim();
						var page = '${param.page}';
						var sort = '${param.sort}';
						var search = '${param.search}';
						var keyword = '${param.keyword}';
						var params = '';
						if(page!='') params = params + '&page='+page;
						if(sort!='') params = params + '&sort='+sort;
						if(search!='') params = params + '&search='+search;
						if(keyword!='') params = params + '&keyword='+keyword;
						window.location.replace('customer/mailconfirm?no='+no+params);
					}
				});
			});
		};
		function setNewCheckFunction() {
			$('#new_name').on('focusout',function(){
				var regex = /^[가-힣,ㄱ-ㅎ,ㅏ-ㅢ,A-Z,a-z,\d]{2,10}$/;
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_new_name').val('N');
				} else if(regex.test($(this).val())) {
					$(this).removeClass('border-red');
					$(this).addClass('border-green');
					$(this).parent().find('.alert-danger').addClass('hidden');
					$('#precheck_new_name').val('Y');
				} else {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert-danger').removeClass('hidden');
					$('#precheck_new_name').val('N');
				};
			});
			$('#new_gender').on('focusout',function(){
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_new_gender').val('N');
				};
			});
			$('#new_gender').on('change',function(){
				$(this).removeClass('border-red');
				$(this).addClass('border-green');
				$(this).parent().find('.alert').addClass('hidden');
				$('#precheck_new_gender').val('Y');
			});
			$('#new_phone').on('focusout',function(){
				var regex = /^0[\d]{1,2}-[\d]{3,4}-[\d]{4}$/;
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_new_phone').val('N');
				} else if(regex.test($(this).val())) {
					$(this).removeClass('border-red');
					$(this).addClass('border-green');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_new_phone').val('Y');
				} else {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_new_phone').val('N');
				};
			});
			$('#new_email').on('input',function(){
				$(this).removeClass('border-red');
				$(this).removeClass('border-green');
				$(this).parent().find('.alert').addClass('hidden');
				$('#precheck_new_email').val('N');
			});
			$('#new_email').on('focusout',function(){
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
		                    		$('#new_email').removeClass('border-red');
		                    		$('#new_email').addClass('border-green');
		            				$('#new_email').parent().find('.alert-success').removeClass('hidden');
		            				$('#new_email').parent().find('.prealert-email1').addClass('hidden');
		            				$('#precheck_new_email').val('Y');
		                    	} else {
		            				$('#new_email').removeClass('border-green');
		                    		$('#new_email').addClass('border-red');
		            				$('#new_email').parent().find('.prealert-email1').removeClass('hidden');
		            				$('#new_email').parent().find('.alert-success').addClass('hidden');
		            				$('#precheck_new_email').val('N');
		                    	}
		                    }
		                });
					} else {
						$('#new_email').removeClass('border-green');
                		$('#new_email').addClass('border-red');
        				$('#new_email').parent().find('.prealert-email2').removeClass('hidden');
        				$('#new_email').parent().find('.alert-success').addClass('hidden');
        				$('#precheck_new_email').val('N');
					};
				};
			});
			$('#new_birth_str').on('focusout',function(){
				var regex = /^[\d]{4}-[\d]{2}-[\d]{2}$/;
				if(!$(this).val()) {
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_new_birth').val('N');
				} else if(regex.test($(this).val())) {
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_new_birth').val('Y');
				} else {
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_new_birth').val('N');
				};
			});
			$('.form-temppw').each(function(i,element){
				$(element).on('submit', function(e){
					e.preventDefault();
					var result = confirm('해당 이메일로 임시암호를 발급하여 메일로 전송합니다.');
					if(result) {
						$('.removable').addClass('hidden');
						this.submit();
					} else {
						return;
					};
				});
			});
			$('#form-new').on('submit', function(e){
				e.preventDefault();
				if($('#precheck_new_name').val()=='N') {
					$('#new_name').focus();
					return;	
				};
				if($('#precheck_new_gender').val()=='N') {
					$('#new_gender').focus();
					return;	
				};
				if($('#precheck_new_phone').val()=='N') {
					$('#new_phone').focus();
					return;
				};
				if($('#precheck_new_email').val()=='N') {
					$('#new_email').focus();
					return;
				};
				if($('#precheck_new_birth').val()=='N') {
					$('#new_birth_str').focus();
					return;
				};
				this.submit();
			});
		};
		function setModCheckFunction() {
			$('#mod_name').on('focusout',function(){
				var regex = /^[가-힣,ㄱ-ㅎ,ㅏ-ㅢ,A-Z,a-z,\d]{2,10}$/;
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_mod_name').val('N');
				} else if(regex.test($(this).val())) {
					$(this).removeClass('border-red');
					$(this).addClass('border-green');
					$(this).parent().find('.alert-danger').addClass('hidden');
					$('#precheck_mod_name').val('Y');
				} else {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert-danger').removeClass('hidden');
					$('#precheck_mod_name').val('N');
				};
			});
			$('#mod_gender').on('focusout',function(){
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_mod_gender').val('N');
				};
			});
			$('#mod_gender').on('change',function(){
				$(this).removeClass('border-red');
				$(this).addClass('border-green');
				$(this).parent().find('.alert').addClass('hidden');
				$('#precheck_mod_gender').val('Y');
			});
			$('#mod_phone').on('focusout',function(){
				var regex = /^0[\d]{1,2}-[\d]{3,4}-[\d]{4}$/;
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_mod_phone').val('N');
				} else if(regex.test($(this).val())) {
					$(this).removeClass('border-red');
					$(this).addClass('border-green');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_mod_phone').val('Y');
				} else {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_mod_phone').val('N');
				};
			});
			$('#mod_email').on('input',function(){
				$(this).removeClass('border-red');
				$(this).removeClass('border-green');
				$(this).parent().find('.alert').addClass('hidden');
				$('#precheck_mod_email').val('N');
			});
			$('#mod_email').on('focusout',function(){
				if($(this).val()==originemail) {
					$('#precheck_mod_email').val('Y');
					return;
				}
				else if($(this).val()!='') {
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
		                    		$('#mod_email').removeClass('border-red');
		                    		$('#mod_email').addClass('border-green');
		            				$('#mod_email').parent().find('.alert-success').removeClass('hidden');
		            				$('#mod_email').parent().find('.prealert-email1').addClass('hidden');
		            				$('#precheck_mod_email').val('Y');
		                    	} else {
		            				$('#mod_email').removeClass('border-green');
		                    		$('#mod_email').addClass('border-red');
		            				$('#mod_email').parent().find('.prealert-email1').removeClass('hidden');
		            				$('#mod_email').parent().find('.alert-success').addClass('hidden');
		            				$('#precheck_mod_email').val('N');
		                    	}
		                    }
		                });
					} else {
						$('#mod_email').removeClass('border-green');
                		$('#mod_email').addClass('border-red');
        				$('#mod_email').parent().find('.prealert-email2').removeClass('hidden');
        				$('#mod_email').parent().find('.alert-success').addClass('hidden');
        				$('#precheck_mod_email').val('N');
					};
				};
			});
			$('#mod_birth_str').on('focusout',function(){
				var regex = /^[\d]{4}-[\d]{2}-[\d]{2}$/;
				if(!$(this).val()) {
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_mod_birth').val('N');
				} else if(regex.test($(this).val())) {
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_mod_birth').val('Y');
				} else {
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_mod_birth').val('N');
				};
			});
			$('#form-mod').on('submit', function(e){
				e.preventDefault();
				if($('#precheck_mod_name').val()=='N') {
					$('#mod_name').focus();
					return;	
				};
				if($('#precheck_mod_gender').val()=='N') {
					$('#mod_gender').focus();
					return;	
				};
				if($('#precheck_mod_phone').val()=='N') {
					$('#mod_phone').focus();
					return;
				};
				if($('#precheck_mod_email').val()=='N') {
					$('#mod_email').focus();
					return;
				};
				if($('#precheck_mod_birth').val()=='N') {
					$('#new_birth_str').focus();
					return;
				};
				this.submit();
			});
		};
	</script>
</head>
<body>
	<div class="admin_body container">
		<div class="col-md-12 font-nbgb">
			<h1><i class="fas fa-address-book"></i> 회원 관리</h1>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 text-right">
			<button class="btn btn-warning removable" id="btn-new">신규회원 추가</button>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 font-nbgl font-1.5rem">
				<table class="table table-striped table-bordered table-hover table-condensed nomargin">
					<thead>
						<tr>
							<th><a href="customer?page=1&sort=no
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">번호<c:if test="${param.sort=='no'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th>이름</th>
							<th>성별</th>
							<th>연락처</th>
							<th>마일리지</th>
							<th>E-mail</th>
							<th>생년월일</th>
							<th><a href="customer?page=1&sort=designer
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">담당<c:if test="${param.sort=='designer'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th><a href="customer?page=1&sort=reg
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">가입일<c:if test="${param.sort=='reg'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th><a href="customer?page=1&sort=visitcount
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">방문횟수<c:if test="${param.sort=='visitcount'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th><a href="customer?page=1&sort=latestdate
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">최근방문일<c:if test="${param.sort=='latestdate'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th><a href="customer?page=1&sort=deletedate
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">삭제예정일<c:if test="${param.sort=='deletedate'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th>가입인증메일여부</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="customer" items="${list}">
							<tr>
								<td class="text-center section-no">${customer.no}</td>
								<td class="section-name">${customer.name}</td>
								<c:choose>
									<c:when test="${customer.gender=='남'}">
										<td class="text-center gender-m section-gender">
											남
										</td>
									</c:when>
									<c:otherwise>
										<td class="text-center gender-f section-gender">
											여
										</td>
									</c:otherwise>
								</c:choose>
								<td class="text-center section-phone">${customer.phone}</td>
								<td class="text-right section-mileague">${customer.mileage}원 <a href="mileage?no=${customer.no}" class="btn btn-warning btn-sm nopadding removable">충전</a></td>
								<td class="text-center section-email">${customer.email}</td>
								<td class="text-center section-birth">${customer.birth_str}</td>
								<td class="text-center section-designer"><span class="hidden">${customer.designer}</span>${customer.designer_str}</td>
								<td class="text-center section-reg">${customer.reg_str}</td>
								<td class="text-center section-visitcount">${customer.visitcount}</td>
								<td class="text-center section-latestdate">${customer.latestdate_str}</td>
								<td class="text-center section-deletedate">${customer.deletedate_str}</td>
								<td class="text-center">
									<c:choose>
										<c:when test="${customer.confirmed==1}">
											완료
										</c:when>
										<c:otherwise>
											아직.. <button class="btn btn-primary btn-sm nopadding removable btn-mailconfirm">강제승인</button>
										</c:otherwise>
									</c:choose>
								</td>
								<td class="text-center">
									<button class="btn btn-info btn-sm removable">수정</button>
									<button class="btn btn-danger btn-sm removable">삭제</button>
									<form action="temppw" class="form-temppw" method="POST">
										<input type="hidden" name="no" value="${customer.no}">
										<button type="submit" class="btn btn-primary btn-sm nopadding removable">임시 암호 발급</button>
									</form>
								</td>
							</tr>
						</c:forEach>
						<tr class="text-center" id="modline">
							<form id="form-mod" action="customer/mod" method="POST">
								<td id="section-mod_no">-</td>
								<td>
									<input type="hidden" name="no" id="mod_no">
									<input type="text" class="form-control" name="name" id="mod_name" maxlength="10" required>
									<input type="hidden" name="precheck_name" id="precheck_mod_name" value="Y">
									<div class="alert alert-danger hidden" role="alert">한글,영문,숫자 2-10자</div>
								</td>
								<td>
									<select class="form-control" name="gender" id="mod_gender">
										<option value="X" disabled selected>선택</option>
										<option value="남" id="mod_gender_m">남</option>
										<option value="여" id="mod_gender_f">여</option>
									</select>
									<input type="hidden" name="precheck_gender" id="precheck_mod_gender" value="Y">
									<div class="alert alert-danger hidden" role="alert">선택필수!</div>
								</td>
								<td>
									<input type="text" class="form-control" name="phone" id="mod_phone" maxlength="15" required>
									<input type="hidden" name="precheck_phone" id="precheck_mod_phone" value="Y">
									<div class="alert alert-danger hidden" role="alert">0XX-XXXX-XXXX</div>
								</td>
								<td id="section-mod_mileague">-</td>
								<td>
									<input type="email" class="form-control" name="email" id="mod_email" maxlength="50" required>
									<input type="hidden" name="precheck_email" id="precheck_mod_email" value="Y">
									<div class="alert alert-danger hidden prealert-email1" role="alert">중복!</div>
									<div class="alert alert-danger hidden prealert-email2" role="alert">영문,숫자,@,.</div>
								</td>
								<td>
									<input type="date" class="form-control form-date" name="birth_str" id="mod_birth_str" required>
									<input type="hidden" name="precheck_birth" id="precheck_mod_birth" value="Y">
									<div class="alert alert-danger hidden" role="alert">올바른 날짜로!</div>
								</td>
								<td>
									<select class="form-control" name="designer" id="mod_designer">
										<option value="0">-</option>
										<c:forEach items="${ondesignerlist}" var="ondesigner">
											<option value="${ondesigner.no}">${ondesigner.name}</option>
										</c:forEach>
									</select>
								</td>
								<td id="section-mod_reg">-</td>
								<td id="section-mod_visitcount">-</td>
								<td id="section-mod_latestdate">-</td>
								<td id="section-mod_deletedate">-</td>
								<td>-</td>
								<td>
									<button type="submit" class="btn btn-success btn-sm">완료</button>
									<a href="" class="btn btn-primary btn-sm">취소</a>
								</td>
							</form>
						</tr>
						<tr class="text-center hidden" id="newline">
							<form id="form-new" action="customer/new" method="POST">
								<td>-</td>
								<td>
									<input type="text" class="form-control" name="name" id="new_name" maxlength="10" required>
									<input type="hidden" name="precheck_name" id="precheck_new_name" value="N">
									<div class="alert alert-danger hidden" role="alert">한글,영문,숫자 2-10자</div>
								</td>
								<td>
									<select class="form-control" name="gender" id="new_gender">
										<option value="X" disabled selected>선택</option>
										<option value="남" id="new_gender_m">남</option>
										<option value="여" id="new_gender_f">여</option>
									</select>
									<input type="hidden" name="precheck_gender" id="precheck_new_gender" value="N">
									<div class="alert alert-danger hidden" role="alert">선택필수!</div>
								</td>
								<td>
									<input type="text" class="form-control" name="phone" id="new_phone" maxlength="15" required>
									<input type="hidden" name="precheck_phone" id="precheck_new_phone" value="N">
									<div class="alert alert-danger hidden" role="alert">0XX-XXXX-XXXX</div>
								</td>
								<td>-</td>
								<td>
									<input type="email" class="form-control" name="email" id="new_email" maxlength="50" required>
									<input type="hidden" name="precheck_email" id="precheck_new_email" value="N">
									<div class="alert alert-danger hidden prealert-email1" role="alert">중복!</div>
									<div class="alert alert-danger hidden prealert-email2" role="alert">영문,숫자,@,.</div>
								</td>
								<td>
									<input type="date" class="form-control" name="birth_str" id="new_birth_str" required>
									<input type="hidden" name="precheck_birth" id="precheck_new_birth" value="N">
									<div class="alert alert-danger hidden" role="alert">올바른 날짜로!</div>
								</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>
									<button type="submit" class="btn btn-success btn-sm">완료</button>
									<a href="" class="btn btn-primary btn-sm">취소</a>
								</td>
							</form>
						</tr>
					</tbody>
				</table>
		</div>
		<div class="col-md-12 font-1.5rem font-nbgl hidden" id="helpfornew">
			신규회원의 로그인 초기암호는 생년월일 숫자 6자리가 됩니다.
		</div>
		<div class="col-md-12 font-1.5rem font-nbgl text-center">
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<c:choose>
						<c:when test="${pagenationprev==0}">
							<li class="disabled">
								<span aria-hidden="true">&laquo;</span>
							</li>
						</c:when>
						<c:otherwise>
							<li>
								<a href="customer?page=${pagenationprev}
									<c:if test='${not empty param.sort}'>&sort=${param.sort}</c:if>
									<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
									<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
									" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
						</c:otherwise>
					</c:choose>
					<c:forEach var="pagenation" begin="${pagenationmin}" end="${pagenationmax}" step="1">
						<li id="pagenation_${pagenation}">
							<a href="customer?page=${pagenation}
											<c:if test='${not empty param.sort}'>&sort=${param.sort}</c:if>
											<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
											<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
							">${pagenation}</a>
						</li>
					</c:forEach>
					<c:choose>
						<c:when test="${pagenationnext==0}">
							<li class="disabled">
								<span aria-hidden="true">&raquo;</span>
							</li>
						</c:when>
						<c:otherwise>
							<li>
								<a href="customer?page=${pagenationnext}
										<c:if test='${not empty param.sort}'>&sort=${param.sort}</c:if>
										<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
										<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" aria-label="Next">
									<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
						</c:otherwise>
					</c:choose>
				</ul>
			</nav>
		</div>
		<div class="col-md-12 font-nbgl font-1.5rem text-center">
			<form method="GET">
				<div class="form-group form-inline">
					<input type="hidden" name="page" value="1">
					<input type="hidden" name="sort" value="${param.sort}">
					<select class="form-control" name="search" style="margin-right: 20px;">
						<option value="name">이름</option>
						<option value="phone">연락처끝번호</option>
						<option value="email">메일앞자리</option>
						<option value="designer">담당 디자이너</option>
						<option value="no">회원번호</option>
					</select>
					<input type="text" class="form-control" name="keyword" required size="40px" style="margin-right: 20px;">
					<button class="btn btn-warning" style="margin-right: 20px;">검색</button>
					<a href="customer" class="btn btn-primary">전체조회</a>
				</div>
			</form>
		</div>
	</div>
</body>
