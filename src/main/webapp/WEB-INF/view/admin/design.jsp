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
		.alert {
			font-size: 1.2rem;
			padding:0px;
			text-align: center;
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
			firstBtnSet();
		});
		function sidemenuHilight() {
			$('#menu_design').addClass('active');
		};
		function removeBtns() {
			$('.removable').addClass('hidden');
		};
		function firstBtnSet() {
			setNewCheckFunction();
			$('#btn-new').on('click',function(){
				removeBtns();
				$('#newline').removeClass('hidden');
			});
			$('.btn-info').each(function(i,element){
				$(element).on('click',function(){
					removeBtns();
					var no = $(this).parent().parent().find('.section-no').text().trim();
					var type = $(this).parent().parent().find('.section-type').text().trim();
					var name = $(this).parent().parent().find('.section-name').text().trim();
					var memo = $(this).parent().parent().find('.section-memo').text().trim();
					var price = $(this).parent().parent().find('.section-price').find('span').text().trim();
					var maxtime = $(this).parent().parent().find('.section-maxtime').text().trim();
					if(maxtime.length>10) {
						maxtime = maxtime.substring(0,3)+' 30분';
					};
					var isonoff = $(this).parent().parent().find('.section-isonoff').text().trim();
					$(this).parent().parent().replaceWith(modline);
					$('#mod_no').val(no);
					$('#section-mod_no').text(no);
					switch(type) {
					case '컷': $('#mod_type_cut').prop('selected',true); break;
					case '펌': $('#mod_type_perm').prop('selected',true); break;
					case '염색': $('#mod_type_dye').prop('selected',true); break;
					case '케어': $('#mod_type_care').prop('selected',true); break;
					};
					$('#mod_name').val(name);
					$('#mod_memo').val(memo);
					$('#mod_price').val(price);
					console.log(maxtime);
					switch(maxtime) {
					case '30분': $('#mod_maxtime_30m').prop('selected',true); break;
					case '1시간': $('#mod_maxtime_1h').prop('selected',true); break;
					case '1시간 30분': $('#mod_maxtime_1h30m').prop('selected',true); break;
					case '2시간': $('#mod_maxtime_2h').prop('selected',true); break;
					case '2시간 30분': $('#mod_maxtime_2h30m').prop('selected',true); break;
					case '3시간': $('#mod_maxtime_3h').prop('selected',true); break;
					case '3시간 30분': $('#mod_maxtime_3h30m').prop('selected',true); break;
					case '4시간': $('#mod_maxtime_4h').prop('selected',true); break;
					case '4시간 30분': $('#mod_maxtime_4h30m').prop('selected',true); break;
					case '5시간': $('#mod_maxtime_5h').prop('selected',true); break;
					};
					switch(isonoff) {
					case '사용 중': $('#mod_isonoff_1').prop('selected',true); break;
					case '사용안함': $('#mod_isonoff_0').prop('selected',true); break;
					};
					setModCheckFunction();
				});
			});
			$('.btn-danger').each(function(i,element){
				$(element).on('click',function(){
					var no = parseInt($(this).parent().parent().find('.section-no').text().trim());
					var result = confirm('정말로 이 디자인을 삭제합니까?');
					if(result) {
						if(no<=67) {
							alert('이 항목은 테스트용으로 남겨둬주세요.');
							return;
						}
						window.location.replace('design/del?no='+no);
					}
				});
			});
		};
		function setNewCheckFunction() {
			$('#new_name').on('focusout',function(){
				var regex = /^[가-힣,ㄱ-ㅎ,ㅏ-ㅢ,A-Z,a-z,\d]{2,20}$/;
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
			$('#form-new').on('submit', function(e){
				e.preventDefault();
				if($('#precheck_new_name').val()=='N') {
					$('#new_name').focus();
					return;	
				};
				this.submit();
			});
		};
		function setModCheckFunction() {
			$('#mod_name').on('focusout',function(){
				var regex = /^[가-힣,ㄱ-ㅎ,ㅏ-ㅢ,A-Z,a-z,\d]{2,20}$/;
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
			$('#form-mod').on('submit', function(e){
				e.preventDefault();
				if($('#precheck_mod_name').val()=='N') {
					$('#mod_name').focus();
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
			<h1><i class="fas fa-hands"></i> 시술(메뉴) 관리</h1>
		</div>
		<div class="col-md-12 empty-row removable"></div>
		<div class="col-md-12 text-right">
			<button class="btn btn-warning removable" id="btn-new">신규 메뉴</button>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 font-nbgl font-1.5rem">
			<c:if test="${not empty list}">
				<table class="table table-striped table-bordered table-hover table-condensed">
					<thead>
						<tr>
							<th><a href="design?sort=no
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">번호<c:if test="${param.sort=='no'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th><a href="design?sort=type
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">종류<c:if test="${param.sort=='type'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th>이름</th>
							<th>상세</th>
							<th><a href="design?sort=price
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">가격<c:if test="${param.sort=='price'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th><a href="design?sort=maxtime
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">최대시간<c:if test="${param.sort=='maxtime'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th><a href="design?sort=isonoff
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">사용여부<c:if test="${param.sort=='isonoff'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="design" items="${list}">
							<tr id="tr_${design.no}">
								<td class="text-center section-no">${design.no}</td>
								<td class="text-center section-type">${design.type}</td>
								<td class="section-name">${design.name}</td>
								<td class="section-memo">${design.memo}</td>
								<td class="text-right section-price"><span>${design.price}</span> 원</td>
								<td class="text-right section-maxtime">
									<c:choose>
										<c:when test="${design.maxtime_hour>0}">
											${design.maxtime_hour}시간
											<c:if test="${design.maxtime_min!=0}">
												${design.maxtime_min}분
											</c:if>
										</c:when>
										<c:otherwise>
											${design.maxtime_min}분
										</c:otherwise>
									</c:choose>
								</td>
								<td class="text-center section-isonoff">
									<c:choose>
										<c:when test="${design.isonoff==1}">
											사용 중
										</c:when>
										<c:otherwise>
											사용안함
										</c:otherwise>
									</c:choose>
								</td>
								<td class="text-center">
									<button class="btn btn-info btn-sm removable">수정</button>
									<button class="btn btn-danger btn-sm removable">삭제</button>
								</td>
							</tr>
						</c:forEach>
						<tr class="text-center" id="modline">
							<form action="design/mod" method="POST" id="form-mod">
								<td id="section-mod_no">
									-
								</td>
								<td>
									<input type="hidden" name="no" id="mod_no">
									<select class="form-control" name="type" id="mod_type">
										<option id="mod_type_cut">컷</option>
										<option id="mod_type_perm">펌</option>
										<option id="mod_type_dye">염색</option>
										<option id="mod_type_care">케어</option>
									</select>
								</td>
								<td>
									<input type="text" class="form-control" name="name" id="mod_name" maxlength="10" required>
									<input type="hidden" name="precheck_name" id="precheck_mod_name" value="Y">
									<div class="alert alert-danger hidden" role="alert">한글,영문,숫자 2-20자</div>
								</td>
								<td>
									<input type="text" class="form-control" name="memo" id="mod_memo" maxlength="100">
								</td>
								<td>
									<input type="number" class="form-control" name="price" id="mod_price" required>
								</td>
								<td>
									<select class="form-control" name="maxtime" id="mod_maxtime">
										<option id="mod_maxtime_30m" value="30">30분</option>
										<option id="mod_maxtime_1h" value="60">1시간</option>
										<option id="mod_maxtime_1h30m" value="90">1시간 30분</option>
										<option id="mod_maxtime_2h" value="120">2시간</option>
										<option id="mod_maxtime_2h30m" value="150">2시간 30분</option>
										<option id="mod_maxtime_3h" value="180">3시간</option>
										<option id="mod_maxtime_3h30m" value="210">3시간 30분</option>
										<option id="mod_maxtime_4h" value="240">4시간</option>
										<option id="mod_maxtime_4h30m" value="270">4시간 30분</option>
										<option id="mod_maxtime_5h" value="300">5시간</option>
									</select>
								</td>
								<td>
									<select class="form-control" name="isonoff" id="mod_isonoff">
										<option id="mod_isonoff_1" value="1">사용 중</option>
										<option id="mod_isonoff_0" value="0">사용안함</option>
									</select>
								</td>
								<td>
									<button type="submit" class="btn btn-success btn-sm">완료</button>
									<a href="" class="btn btn-primary btn-sm">취소</a>
								</td>
							</form>
						</tr>
						<tr class="text-center hidden" id="newline">
							<form action="design/new" method="POST" id="form-new">
								<td id="section-new_no">
									-
								</td>
								<td>
									<select class="form-control" name="type" id="new_type">
										<option id="new_type_cut">컷</option>
										<option id="new_type_perm">펌</option>
										<option id="new_type_dye">염색</option>
										<option id="new_type_care">케어</option>
									</select>
								</td>
								<td>
									<input type="text" class="form-control" name="name" id="new_name" maxlength="10" required>
									<input type="hidden" name="precheck_name" id="precheck_new_name" value="N">
									<div class="alert alert-danger hidden" role="alert">한글,영문,숫자 2-20자</div>
								</td>
								<td>
									<input type="text" class="form-control" name="memo" id="new_memo" maxlength="100">
								</td>
								<td>
									<input type="number" class="form-control" name="price" id="new_price" required>
								</td>
								<td>
									<select class="form-control" name="maxtime" id="new_maxtime">
										<option id="new_maxtime_30m" value="30">30분</option>
										<option id="new_maxtime_1h" value="60">1시간</option>
										<option id="new_maxtime_1h30m" value="90">1시간 30분</option>
										<option id="new_maxtime_2h" value="120">2시간</option>
										<option id="new_maxtime_2h30m" value="150">2시간 30분</option>
										<option id="new_maxtime_3h" value="180">3시간</option>
										<option id="new_maxtime_3h30m" value="210">3시간 30분</option>
										<option id="new_maxtime_4h" value="240">4시간</option>
										<option id="new_maxtime_4h30m" value="270">4시간 30분</option>
										<option id="new_maxtime_5h" value="300">5시간</option>
									</select>
								</td>
								<td>
									<select class="form-control" name="isonoff" id="new_isonoff">
										<option id="new_isonoff_1" value="1">사용 중</option>
										<option id="new_isonoff_0" value="0">사용안함</option>
									</select>
								</td>
								<td>
									<button type="submit" class="btn btn-success btn-sm">완료</button>
									<a href="" class="btn btn-primary btn-sm">취소</a>
								</td>
							</form>
						</tr>
					</tbody>
				</table>
			</c:if>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 font-nbgl font-1.5rem text-center">
			<form method="POST">
				<div class="form-group form-inline">
					<input type="hidden" name="sort" value="${param.sort}">
					<select class="form-control" name="search" style="margin-right: 20px;">
						<option value="name">이름</option>
						<option value="type">종류</option>
					</select>
					<input type="text" class="form-control" name="keyword" required size="40px" style="margin-right: 20px;">
					<button class="btn btn-warning" style="margin-right: 20px;">검색</button>
					<a href="" class="btn btn-primary">전체조회</a>
				</div>
			</form>
		</div>
	</div>
</body>
