<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="sidebar.jsp"/>
<head>
	<style>
		table th {
			text-align: center;
		}
		.form-control {
			padding:0px;
		}
		input[type=date] {
			width:140px !important;
		}
		.alert {
			font-size: 1.2rem;
			padding:0px;
			text-align: center;
		}
		input[type='file'] {
			font-size: 1.2rem;
			color: #000000;
			padding: 5px 0px 5px 0px;
			margin: 0px;
			width: 150px;
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
		.container {
			min-width: 800px;
		}
	</style>
	<script>
		var modline;
		$(document).ready(function() {
			sidemenuHilight();
			modline = $('#modline').detach();
			$('#registbtn').on('click',function(){
				removeBtns();
				$('#newline').removeClass('hidden');
			});
			setModBtn();
			setSearch();
			setNewCheckFunction();
		});
		function removeBtns() {
			$('.removable').addClass('hidden');
		};
		function setSearch() {
			$('select[name=search]').on('change',function(){
				if($(this).val()=='grade') {
					$('#search_text').prop('disabled',true);
					$('#search_select').prop('disabled',false);
					$('#search_text').addClass('hidden');
					$('#search_select').removeClass('hidden');
				}
				else {
					$('#search_select').prop('disabled',true);
					$('#search_text').prop('disabled',false);
					$('#search_select').addClass('hidden');
					$('#search_text').removeClass('hidden');
				}
			});
		};
		function setModBtn() {
			$('.btn-mod').each(function(i,element){
				$(element).on('click',function(){
					removeBtns();
					var no = $(this).parent().parent().find('.listno').text().trim();
					var name = $(this).parent().parent().find('.listname').text().trim();
					var gender = $(this).parent().parent().find('.listgender').text().trim();
					var grade = $(this).parent().parent().find('.listgrade').text().trim();
					var offdays = $(this).parent().parent().find('.listoffdays').text().trim();
					var isvacation = $(this).parent().parent().find('.listisvacation').text().trim();
					var isonoff = $(this).parent().parent().find('.listisonoff').text().trim();
					var phone = $(this).parent().parent().find('.listphone').text().trim();
					var email = $(this).parent().parent().find('.listemail').text().trim();
					var birth = $(this).parent().parent().find('.listbirth').text().trim();
					var signindate = $(this).parent().parent().find('.listsignindate').text().trim();
					var designcount = $(this).parent().parent().find('.listdesigncount').text().trim();
					$('#tr_'+no).replaceWith(modline);
					$('.section-no').text(no);
					$('#mod_no').val(no);
					$('#mod_name').val(name);
					if(gender=='남') $('#mod_gender_m').prop('selected',true);
					else $('#mod_gender_f').prop('selected',true);
					switch(grade){
					case '실장': $('#mod_grade_0').prop('selected',true); break;
					case '팀장': $('#mod_grade_1').prop('selected',true); break;
					case '사원': $('#mod_grade_2').prop('selected',true); break;
					case '견습': $('#mod_grade_3').prop('selected',true); break;
					case '아르바이트': $('#mod_grade_4').prop('selected',true); break;
					}
					if(offdays.indexOf('월')!=-1) $('#mod_offday_mon').prop('checked',true);
					if(offdays.indexOf('화')!=-1) $('#mod_offday_tue').prop('checked',true);
					if(offdays.indexOf('수')!=-1) $('#mod_offday_wed').prop('checked',true);
					if(offdays.indexOf('목')!=-1) $('#mod_offday_thu').prop('checked',true);
					if(offdays.indexOf('금')!=-1) $('#mod_offday_fri').prop('checked',true);
					if(offdays.indexOf('토')!=-1) $('#mod_offday_sat').prop('checked',true);
					if(offdays.indexOf('일')!=-1) $('#mod_offday_sun').prop('checked',true);
					$('.section-isvacation').text(isvacation);
					if(isonoff=='가능') $('#mod_isonoff_1').prop('selected',true);
					else $('#mod_isonoff_0').prop('selected',true);
					$('#mod_phone').val(phone);
					$('#mod_email').val(email);
					$('#mod_birth_str').val(birth);
					$('#mod_signindate_str').val(signindate);
					$('.section-designcount').text(designcount);
					setModCheckFunction();
				});
			});
			$('.btn-danger').each(function(i,element){
				$(element).on('click',function(){
					var no = parseInt($(this).parent().parent().find('.listno').text().trim());
					var result = confirm('정말로 이 예약을 삭제합니까?');
					if(result) {
						if(no<=41) {
							alert('이 항목은 테스트용으로 남겨둬주세요.');
							return;
						}
						window.location.replace('designer/del?no='+$(this).parent().parent().find('.listno').text().trim());
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
			$('#new_grade').on('focusout',function(){
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_new_grade').val('N');
				};
			});
			$('#new_grade').on('change',function(){
				$(this).removeClass('border-red');
				$(this).addClass('border-green');
				$(this).parent().find('.alert').addClass('hidden');
				$('#precheck_new_grade').val('Y');
			});
			$('#new_isonoff').on('focusout',function(){
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_new_isonoff').val('N');
				};
			});
			$('#new_isonoff').on('change',function(){
				$(this).removeClass('border-red');
				$(this).addClass('border-green');
				$(this).parent().find('.alert').addClass('hidden');
				$('#precheck_new_isonoff').val('Y');
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
			$('#new_signindate_str').on('focusout',function(){
				var regex = /^[\d]{4}-[\d]{2}-[\d]{2}$/;
				if(!$(this).val()) {
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_new_signindate').val('N');
				} else if(regex.test($(this).val())) {
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_new_signindate').val('Y');
				} else {
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_new_signindate').val('N');
				};
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
				if($('#precheck_new_grade').val()=='N') {
					$('#new_gender').focus();
					return;	
				};
				if($('#precheck_new_isonoff').val()=='N') {
					$('#new_isonoff').focus();
					return;
				};
				if($('#precheck_new_phone').val()=='N') {
					$('#new_phone').focus();
					return;
				};
				if($('#precheck_new_birth').val()=='N') {
					$('#new_birth_str').focus();
					return;
				};
				if($('#precheck_new_signindate').val()=='N') {
					$('#new_signindate_str').focus();
					return;
				};
				$('#new_offdays').val(forNewOffdays());
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
			$('#mod_grade').on('focusout',function(){
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_mod_grade').val('N');
				};
			});
			$('#mod_grade').on('change',function(){
				$(this).removeClass('border-red');
				$(this).addClass('border-green');
				$(this).parent().find('.alert').addClass('hidden');
				$('#precheck_mod_grade').val('Y');
			});
			$('#mod_isonoff').on('focusout',function(){
				if(!$(this).val()) {
					$(this).removeClass('border-green');
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_mod_isonoff').val('N');
				};
			});
			$('#mod_isonoff').on('change',function(){
				$(this).removeClass('border-red');
				$(this).addClass('border-green');
				$(this).parent().find('.alert').addClass('hidden');
				$('#precheck_mod_isonoff').val('Y');
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
			$('#mod_signindate_str').on('focusout',function(){
				var regex = /^[\d]{4}-[\d]{2}-[\d]{2}$/;
				if(!$(this).val()) {
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_mod_signindate').val('N');
				} else if(regex.test($(this).val())) {
					$(this).removeClass('border-red');
					$(this).parent().find('.alert').addClass('hidden');
					$('#precheck_mod_signindate').val('Y');
				} else {
					$(this).addClass('border-red');
					$(this).parent().find('.alert').removeClass('hidden');
					$('#precheck_mod_signindate').val('N');
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
				if($('#precheck_mod_grade').val()=='N') {
					$('#mod_gender').focus();
					return;	
				};
				if($('#precheck_mod_isonoff').val()=='N') {
					$('#mod_isonoff').focus();
					return;
				};
				if($('#precheck_mod_phone').val()=='N') {
					$('#mod_phone').focus();
					return;
				};
				if($('#precheck_mod_birth').val()=='N') {
					$('#mod_birth_str').focus();
					return;
				};
				if($('#precheck_mod_signindate').val()=='N') {
					$('#mod_signindate_str').focus();
					return;
				};
				$('#mod_offdays').val(forModOffdays());
				this.submit();
			});
		};
		function forNewOffdays() {
			var result = '';
			if($('#new_offday_mon').prop('checked')) {
				if(result=='') { result = '월'; }
				else { result = result + '/월'; }
			}
			if($('#new_offday_tue').prop('checked')) {
				if(result=='') { result = '화'; }
				else { result = result + '/화'; }
			}
			if($('#new_offday_wed').prop('checked')) {
				if(result=='') { result = '수'; }
				else { result = result + '/수'; }
			}
			if($('#new_offday_thu').prop('checked')) {
				if(result=='') { result = '목'; }
				else { result = result + '/목'; }
			}
			if($('#new_offday_fri').prop('checked')) {
				if(result=='') { result = '금'; }
				else { result = result + '/금'; }
			}
			if($('#new_offday_sat').prop('checked')) {
				if(result=='') { result = '토'; }
				else { result = result + '/토'; }
			}
			if($('#new_offday_sun').prop('checked')) {
				if(result=='') { result = '일'; }
				else { result = result + '/일'; }
			}
			return result;
		};
		function forModOffdays() {
			var result = '';
			if($('#mod_offday_mon').prop('checked')) {
				if(result=='') { result = '월'; }
				else { result = result + '/월'; }
			}
			if($('#mod_offday_tue').prop('checked')) {
				if(result=='') { result = '화'; }
				else { result = result + '/화'; }
			}
			if($('#mod_offday_wed').prop('checked')) {
				if(result=='') { result = '수'; }
				else { result = result + '/수'; }
			}
			if($('#mod_offday_thu').prop('checked')) {
				if(result=='') { result = '목'; }
				else { result = result + '/목'; }
			}
			if($('#mod_offday_fri').prop('checked')) {
				if(result=='') { result = '금'; }
				else { result = result + '/금'; }
			}
			if($('#mod_offday_sat').prop('checked')) {
				if(result=='') { result = '토'; }
				else { result = result + '/토'; }
			}
			if($('#mod_offday_sun').prop('checked')) {
				if(result=='') { result = '일'; }
				else { result = result + '/일'; }
			}
			return result;
		};
		function sidemenuHilight() {
			$('#menu_designer').addClass('active');
		};
	</script>
</head>
<body>
	<div class="admin_body container">
		<div class="col-md-12 font-nbgb">
			<h1><i class="fas fa-cut"></i> 디자이너 관리</h1>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 text-right">
			<button class="btn btn-warning removable" id="registbtn">신규 디자이너</button>
		</div>
		<div class="col-md-12 empty-row removable"></div>
		<div class="col-md-12 font-nbgl font-1.5rem">
			<table class="table table-striped table-bordered table-hover table-condensed">
				<thead>
					<tr>
						<th><a href="designer?sort=no
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
							" class="sortable">번호<c:if test="${param.sort=='no'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
						<th><a href="designer?sort=name
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
							" class="sortable">이름<c:if test="${param.sort=='name'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
						<th><a href="designer?sort=gender
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
							" class="sortable">성별<c:if test="${param.sort=='gender'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
						<th><a href="designer?sort=grade
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
							" class="sortable">직급<c:if test="${param.sort=='grade'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
						<th>휴무일</th>
						<th><a href="designer?sort=isvacation
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
							" class="sortable">휴가상태<c:if test="${param.sort=='isvacation'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
						<th><a href="designer?sort=isonoff
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
							" class="sortable">예약가능<c:if test="${param.sort=='isonoff'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
						<th>연락처</th>
						<th>E-mail</th>
						<th>생년월일</th>
						<th><a href="designer?sort=signindate
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
							" class="sortable">입사일<c:if test="${param.sort=='signindate'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
						<th><a href="designer?sort=designcount
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
							" class="sortable">시술횟수<c:if test="${param.sort=='designcount'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
						<th>사진</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="designer" items="${list}">
						<tr id="tr_${designer.no}">
							<td class="text-center listno">${designer.no}</td>
							<td class="listname">${designer.name}</td>
							<c:choose>
								<c:when test="${designer.gender=='남'}">
									<td class="text-center gender-m listgender">
										남
									</td>
								</c:when>
								<c:otherwise>
									<td class="text-center gender-f listgender">
										여
									</td>
								</c:otherwise>
							</c:choose>
							<td class="text-center listgrade">
								${designer.grade_str}							
							</td>
							<td class="text-center listoffdays">${designer.offdays}</td>
							<td class="text-center listisvacation">
								<c:choose>
									<c:when test="${designer.isvacation==1}">
										휴가중
									</c:when>
									<c:otherwise>
										근무
									</c:otherwise>
								</c:choose>
							</td>
							<td class="text-center listisonoff">
								<c:choose>
									<c:when test="${designer.isonoff==1}">
										가능
									</c:when>
									<c:otherwise>
										불가능
									</c:otherwise>
								</c:choose>
							</td>
							<td class="text-center listphone">${designer.phone}</td>
							<td class="text-center listemail">${designer.email}</td>
							<td class="text-center listbirth">${designer.birth_str}</td>
							<td class="text-center listsignindate">${designer.signindate_str}</td>
							<td class="text-center listdesigncount">${designer.designcount}</td>
							<td class="text-center listpicture"><a href="${pageContext.request.contextPath}/designerpics/${designer.picture}" border="0" target="_blank"><img src="${pageContext.request.contextPath}/designerpics/${designer.picture}" border="0" width="25px" height="25px"></a></td>
							<td class="text-center">
								<a href="vacation?no=${designer.no}" class="btn btn-warning btn-sm removable">휴가</a>
								<button class="btn btn-info btn-sm removable btn-mod">수정</button>
								<button class="btn btn-danger btn-sm removable">삭제</button>
							</td>
						</tr>
					</c:forEach>
					<tr class="text-center" id="modline">
						<form id="form-mod" action="designer/mod" method="POST" enctype="multipart/form-data">
							<td class="form-group section section-no">
								-
							</td>
							<td class="form-group section section-name">
								<input type="hidden" name="no" id="mod_no">
								<input type="text" class="form-control" name="name" id="mod_name" maxlength="10" size="10px" required>
								<input type="hidden" name="precheck_name" id="precheck_mod_name" value="Y">
								<div class="alert alert-danger hidden" role="alert">한글,영문,숫자 2-10자</div>
							</td>
							<td class="form-group section section-gender">
								<select class="form-control" name="gender" id="mod_gender" required style="width:40px;">
									<option disabled selected>-</option>
									<option value="남" id="mod_gender_m">남</option>
									<option value="여" id="mod_gender_f">여</option>
								</select>
								<input type="hidden" name="precheck_gender" id="precheck_mod_gender" value="Y">
								<div class="alert alert-danger hidden" role="alert">선택필수!</div>
							</td>
							<td class="form-group section section-grade">
								<select class="form-control" name="grade" id="mod_grade" required style="width:90px;">
									<option disabled selected>-</option>
									<option value="0" id="mod_grade_0">실장</option>
									<option value="1" id="mod_grade_1">팀장</option>
									<option value="2" id="mod_grade_2">사원</option>
									<option value="3" id="mod_grade_3">견습</option>
									<option value="4" id="mod_grade_4">아르바이트</option>
								</select>
								<input type="hidden" name="precheck_grade" id="precheck_mod_grade" value="Y">
								<div class="alert alert-danger hidden" role="alert">선택필수!</div>
							</td>
							<td class="form-group section section-offdays">
								<input type="checkbox" name="offday_mon" id="mod_offday_mon" value="mon">월&nbsp;
								<input type="checkbox" name="offday_tue" id="mod_offday_tue" value="tue">화&nbsp;
								<input type="checkbox" name="offday_wed" id="mod_offday_wed" value="wed">수&nbsp;
								<input type="checkbox" name="offday_thu" id="mod_offday_thu" value="thu">목&nbsp;
								<input type="checkbox" name="offday_fri" id="mod_offday_fri" value="fri">금&nbsp;
								<input type="checkbox" name="offday_sat" id="mod_offday_sat" value="sat">토&nbsp;
								<input type="checkbox" name="offday_sun" id="mod_offday_sun" value="sun">일
								<input type="hidden" name="offdays" id="mod_offdays">
							</td>
							<td class="form-group section section-isvacation">
								-
							</td>
							<td class="form-group section section-isonoff">
								<select class="form-control" name="isonoff" id="mod_isonoff" required style="width:80px;">
									<option disabled selected>-</option>
									<option value="0" id="mod_isonoff_0">예약불가</option>
									<option value="1" id="mod_isonoff_1">예약가능</option>
								</select>
								<input type="hidden" name="precheck_isonoff" id="precheck_mod_isonoff" value="Y">
								<div class="alert alert-danger hidden" role="alert">선택필수!</div>
							</td>
							<td class="form-group section section-phone">
								<input type="text" class="form-control" name="phone" id="mod_phone" size="10px" maxlength="15" placeholder="0XX-XXXX-XXXX" required>
								<input type="hidden" name="precheck_phone" id="precheck_mod_phone" value="Y">
								<div class="alert alert-danger hidden" role="alert">0XX-XXXX-XXXX</div>
							</td>
							<td class="form-group section section-email">
								<input type="email" class="form-control" name="email" id="mod_email" maxlength="50" size="10px">
							</td>
							<td class="form-group section section-birth">
								<input type="date" class="form-control" name="birth_str" id="mod_birth_str" required>
								<input type="hidden" name="precheck_birth" id="precheck_mod_birth" value="Y">
								<div class="alert alert-danger hidden" role="alert">올바른 날짜로!</div>
							</td>
							<td class="form-group section section-signindate">
								<input type="date" class="form-control" name="signindate_str" id="mod_signindate_str" required>
								<input type="hidden" name="precheck_signindate" id="precheck_mod_signindate" value="Y">
								<div class="alert alert-danger hidden" role="alert">올바른 날짜로!</div>
							</td>
							<td class="form-group section section-designcount">
								-
							</td>
							<td class="form-group section section-picture">
								<input type="file" class="btn btn-primary" name="picture" id="mod_picture" accept="image/*">
								<div class="alert alert-warning" role="alert">250KB이하 100x100<br>jpg/png</div>
							</td>
							<td class="form-group section section-ok">
								<button type="submit" class="btn btn-success btn-sm">완료</button>
								<a href="" class="btn btn-primary btn-sm">취소</a>
							</td>
						</form>
					</tr>
					<tr class="text-center hidden" id="newline">
						<form id="form-new" action="designer/new" method="POST" enctype="multipart/form-data">
							<td class="form-group section section-no">
								-
							</td>
							<td class="form-group section section-name">
								<input type="text" class="form-control" name="name" id="new_name" maxlength="10" size="10px" required>
								<input type="hidden" name="precheck_name" id="precheck_new_name" value="N">
								<div class="alert alert-danger hidden" role="alert">한글,영문,숫자 2-10자</div>
							</td>
							<td class="form-group section section-gender">
								<select class="form-control" name="gender" id="new_gender" required style="width:40px;">
									<option disabled selected>-</option>
									<option value="남">남</option>
									<option value="여">여</option>
								</select>
								<input type="hidden" name="precheck_gender" id="precheck_new_gender" value="N">
								<div class="alert alert-danger hidden" role="alert">선택필수!</div>
							</td>
							<td class="form-group section section-grade">
								<select class="form-control" name="grade" id="new_grade" required style="width:90px;">
									<option disabled selected>-</option>
									<option value="0">실장</option>
									<option value="1">팀장</option>
									<option value="2">사원</option>
									<option value="3">견습</option>
									<option value="4">아르바이트</option>
								</select>
								<input type="hidden" name="precheck_grade" id="precheck_new_grade" value="N">
								<div class="alert alert-danger hidden" role="alert">선택필수!</div>
							</td>
							<td class="form-group section section-offdays">
								<input type="checkbox" name="offday_mon" id="new_offday_mon" value="mon">월&nbsp;
								<input type="checkbox" name="offday_tue" id="new_offday_tue" value="tue">화&nbsp;
								<input type="checkbox" name="offday_wed" id="new_offday_wed" value="wed">수&nbsp;
								<input type="checkbox" name="offday_thu" id="new_offday_thu" value="thu">목&nbsp;
								<input type="checkbox" name="offday_fri" id="new_offday_fri" value="fri">금&nbsp;
								<input type="checkbox" name="offday_sat" id="new_offday_sat" value="sat">토&nbsp;
								<input type="checkbox" name="offday_sun" id="new_offday_sun" value="sun">일
								<input type="hidden" name="offdays" id="new_offdays">
							</td>
							<td class="form-group section section-isvacation">
								-
							</td>
							<td class="form-group section section-isonoff">
								<select class="form-control" name="isonoff" id="new_isonoff" required style="width:80px;">
									<option disabled selected>-</option>
									<option value="0">예약불가</option>
									<option value="1">예약가능</option>
								</select>
								<input type="hidden" name="precheck_isonoff" id="precheck_new_isonoff" value="N">
								<div class="alert alert-danger hidden" role="alert">선택필수!</div>
							</td>
							<td class="form-group section section-phone">
								<input type="text" class="form-control" name="phone" id="new_phone" size="10px" maxlength="15" placeholder="0XX-XXXX-XXXX" required>
								<input type="hidden" name="precheck_phone" id="precheck_new_phone" value="N">
								<div class="alert alert-danger hidden" role="alert">0XX-XXXX-XXXX</div>
							</td>
							<td class="form-group section section-email">
								<input type="email" class="form-control" name="email" id="new_email" maxlength="50" size="10px">
							</td>
							<td class="form-group section section-birth">
								<input type="date" class="form-control" name="birth_str" id="new_birth_str" required>
								<input type="hidden" name="precheck_birth" id="precheck_new_birth" value="N">
								<div class="alert alert-danger hidden" role="alert">올바른 날짜로!</div>
							</td>
							<td class="form-group section section-signindate">
								<input type="date" class="form-control" name="signindate_str" id="new_signindate_str" required>
								<input type="hidden" name="precheck_signindate" id="precheck_new_signindate" value="N">
								<div class="alert alert-danger hidden" role="alert">올바른 날짜로!</div>
							</td>
							<td class="form-group section section-designcount">
								-
							</td>
							<td class="form-group section section-picture">
								<input type="file" class="btn btn-primary" name="picture" id="new_picture" accept="image/*">
								<div class="alert alert-warning" role="alert">250KB이하 100x100<br>jpg/png</div>
							</td>
							<td class="form-group section section-ok">
								<button type="submit" class="btn btn-success btn-sm">완료</button>
								<a href="" class="btn btn-primary btn-sm">취소</a>
							</td>
						</form>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 font-nbgl font-1.5rem text-center">
			<form method="GET">
				<div class="form-group form-inline">
					<input type="hidden" name="sort" value="${param.sort}">
					<select class="form-control" name="search" style="margin-right: 20px;">
						<option value="name">이름</option>
						<option value="grade">직급</option>
						<option value="offdays">휴무일</option>
					</select>
					<input type="text" class="form-control" id="search_text" name="keyword" required size="40px" style="margin-right: 20px;">
					<select class="form-control hidden" id="search_select" name="keyword" required style="margin-right: 20px;" disabled>
						<option value="0">실장</option>
						<option value="1">팀장</option>
						<option value="2">사원</option>
						<option value="3">견습</option>
						<option value="4">아르바이트</option>
					</select>
					<button class="btn btn-warning" style="margin-right: 20px;">검색</button>
					<a href="designer" class="btn btn-primary">전체조회</a>
				</div>
			</form>
		</div>
	</div>
</body>
