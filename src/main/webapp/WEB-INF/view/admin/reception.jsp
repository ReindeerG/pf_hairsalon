<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="sidebar.jsp"/>
<head>
	<style>
		table th {
			text-align: center;
			background-color: #AAAAAA;
			color: black;
		}
		table td {
			vertical-align: middle !important;
		}
		.nopadding {
			padding: 0px !important;
		}
		.noleftpadding {
			padding-left: 0px !important;
		}
		.namargin {
			margin: 0px !important;
		}
		#plzresize1 {
		}
		.verticalmid {
			margin-top: 50%;
		}
		.gender-m {
			color: skyblue !important;
		}
		.gender-f {
			color: pink !important;
		}
		#mileagerefresh {
			cursor: pointer;
		}
	</style>
	<script>
		var height1
		$(document).ready(function() {
			sidemenuHilight();
			compareHeight1();
			firstButtonSet();
		});
		window.addEventListener('resize', function() {
			compareHeight1();
		});
		function sidemenuHilight() {
			$('#menu_reception').addClass('active');
		};
		function compareHeight1() {
			var height_success = $('.panel-success').height()+2;
			var height_warning = $('.panel-warning').height()+2;
			if(height_success>=height_warning) height1 = height_success;
			else height1 = height_warning;
			$('.panel-success').parent().css('cssText', 'height:'+height1+'px !important;');
			$('.panel-warning').parent().css('cssText', 'height:'+height1+'px !important;');
			$('#plzresize1').css('cssText', 'height:'+height1+'px !important;');
		}
		function firstButtonSet() {
			$('.forcalplusminus').on('input',function(){
				if(parseInt($('#cal_plus').val())<0) $('#cal_plus').val(0);
				if(parseInt($('#cal_minus').val())<0) $('#cal_minus').val(0);
				if(parseInt($('#cal_minus').val())>parseInt($('#cal_price').val())+parseInt($('#cal_plus').val())) $('#cal_minus').val(0);
				if(parseInt($('#cal_plus').val())>99999999) $('#cal_plus').val(parseInt(parseInt($('#cal_plus').val())/10));
				if(parseInt($('#cal_minus').val())>99999999) $('#cal_minus').val(parseInt(parseInt($('#cal_minus').val())/10));
				var plus = $('#cal_plus').val();
				var minus = $('#cal_minus').val();
				if(plus=='') plus=0;
				if(minus=='') minus=0;
				$('#cal_finalprice').val(parseInt($('#cal_price').val())+parseInt(plus)-parseInt(minus));
			});
			$('.forcalplusminus').on('focusout',function(){
				if($('#cal_plus').val()=='') $('#cal_plus').val(0);
				if($('#cal_minus').val()=='') $('#cal_minus').val(0);
			});
			$('#mileagerefresh').on('click',function(){
				if($('#cal_customer').val()!=null) {
					ajax_mileage($('#cal_customer').val());
				}
			});
			$('.btn-tocal').each(function(i,element){
				$(this).on('click',function(){
					var whatday_str = $(this).parent().parent().find('.reservation1_whatday').val().substring(0,10);
					var reservation = $(this).parent().parent().find('.form-receptionto0').find('.reservationno').val();
					var customer = $(this).parent().parent().find('.reservation1_customer').val();
					var starttime_str = $(this).parent().parent().parent().find('.section-starttime_str').text().trim();
					var starttime = $(this).parent().parent().find('.reservation1_starttime').val();
					var totalname = $(this).parent().parent().parent().find('.section-totalname').text().trim();
					var name = totalname.substring(0,totalname.indexOf('('));
					var ismember = totalname.substring(totalname.indexOf('(')+1,totalname.indexOf(')'));
					var gender = $(this).parent().parent().parent().find('.section-gender').text().trim();
					var phone = $(this).parent().parent().parent().find('.section-phone').text().trim();
					var birth_str = $(this).parent().parent().find('.reservation1_birth_str').val();
					var designer_str = $(this).parent().parent().parent().find('.section-designer').text().trim();
					var designer = $(this).parent().parent().find('.reservation1_designer').val();
					var design = $(this).parent().parent().find('.reservation1_design').val();
					var design_str = $(this).parent().parent().parent().find('.section-design').text().trim();
					var endtime = $(this).parent().parent().parent().find('.section-endtime').text().trim();
					var price = $(this).parent().parent().find('.reservation1_price').val();
					$('#cal_whatday_str').val(whatday_str);
					$('#cal_customer').val(customer);
					if(customer==0) {
						$('.formileage').addClass('hidden');
						$('#paytype_mileage').prop('disabled',true);
					} else {
						$('.formileage').removeClass('hidden');
						$('#paytype_mileage').prop('disabled',false);
					};
					$('#cal_reservation').val(reservation);
					$('#cal_customer_fake').val(ismember);
					$('#cal_name').val(name);
					$('#cal_gender').val(gender);
					$('#cal_phone').val(phone);
					$('#cal_birth_str').val(birth_str);
					$('#cal_price').val(price);
					$('#cal_plus').val(0);
					$('#cal_minus').val(0);
					$('#cal_finalprice').val(price);
					if(customer==0) {
						$('#cal_mileage').val('(비회원)');
					}
					else {
						ajax_mileage(customer);
					}
					$('#cal_design').val(design);
					$('#cal_designer').val(designer);
					$('#cal_time').val(starttime_str+' - '+endtime);
					$('#cal_starttime').val(starttime);
					$('#cal_paytype').val('X');
					$('#cal_memo').val(null);
					$('html, body').animate({scrollTop: $('.panel-info').offset().top}, 500);
					$('#btn-charge').off();
					$('#btn-charge').on('click',function(){
						window.open('mileage?no='+customer,'_blank');
					});
				});
			});
			$('.form-receptionto0').each(function(i,element){
				$(this).on('submit',function(e){
					e.preventDefault();
					var result = confirm('다시 접수 전으로 돌리시겠습니까?');
					if(result) this.submit();
				});
			});
			$('.form-receptionto1').each(function(i,element){
				$(this).on('submit',function(e){
					e.preventDefault();
					var result = confirm('접수하시겠습니까?');
					if(result) this.submit();
				});
			});
			$('#form-pay').on('submit',function(e){
				e.preventDefault();
				if(!$('#cal_reservation').val()) {
					alert('위에서 계산할 접수 건을 선택해주세요!');
					return;
				}
				if(!$('#cal_paytype').val()) {
					alert('계산방식을 선택해주세요!');
					return;
				}
				if($('#cal_paytype').val()=='마일리지') {
					if(parseInt($('#cal_mileage').val())<parseInt($('#cal_finalprice').val())) {
						alert('마일리지가 부족합니다! 다시 확인해주세요.');
						return;
					}
				}
				this.submit();
			});
		};
		function ajax_mileage(no) {
			$.ajax({
                url: "reception/ajax_mileage",
                data:{
                	no:no
                },
                type:"post",
                success:function(response){
                	$('#cal_mileage').val(response);
                }
            });
		};
	</script>
</head>
<body>
	<div class="admin_body container">
		<div class="col-md-12 font-nbgb">
			<h1><i class="fas fa-calculator"></i> 접수&계산</h1>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12">
			<h4>${todayinfo}</h4>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-6 font-1.5rem">
			<div class="panel panel-success nomargin">
				<div class="panel-heading font-nbgb">
					<h3 class="panel-title">시술 중</h3>
				</div>
				<div class="panel-body font-nbgl nopadding">
					<c:if test="${not empty reservationList1}">
						<table class="table table-striped table-bordered table-hover table-condensed nomargin">
							<thead>
								<tr id="reservation1th font-nbgl">
									<th>시작시간</th>
									<th>고객명</th>
									<th>성별</th>
									<th>연락처</th>
									<th>디자이너</th>
									<th>시술명</th>
									<th>종료예상</th>
									<th>접수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="reservation1" items="${reservationList1}">
									<tr class="reservation1tds font-nbgl text-center">
										<td class="section-starttime_str">${reservation1.starttime_str}</td>
										<td class="section-totalname"><c:choose><c:when test="${reservation1.customer!=0}"><a href="customer?page=1&search=no&keyword=${reservation1.customer}"  target="_blank">${reservation1.customer_name}(회원번호:${reservation1.customer})</a></c:when><c:otherwise>${reservation1.customer_name}(비회원)</c:otherwise></c:choose></td>
										<c:choose><c:when test="${reservation1.customer_gender=='남'}"><td class="section-gender gender-m">남</td></c:when><c:otherwise><td class="section-gender gender-f">여</td></c:otherwise></c:choose>
										<td class="section-phone">${reservation1.customer_phone}</td>
										<td class="section-designer">${reservation1.designer_str}</td>
										<td class="section-design">${reservation1.design_str}</td>
										<td class="section-endtime">${reservation1.endtime_str}</td>
										<td width="130px">
											<input type="hidden" class="reservation1_whatday" value="${reservation1.whatday_str}">
											<input type="hidden" class="reservation1_customer" value="${reservation1.customer}">
											<input type="hidden" class="reservation1_designer" value="${reservation1.designer}">
											<input type="hidden" class="reservation1_design" value="${reservation1.design}">
											<input type="hidden" class="reservation1_price" value="${reservation1.price}">
											<input type="hidden" class="reservation1_starttime" value="${reservation1.starttime}">
											<input type="hidden" class="reservation1_birth_str" value="${reservation1.customer_birth_str}">
											<form class="form-receptionto0" action="reception/to0" method="POST">
												<button type="button" class="btn btn-info btn-sm btn-tocal"><i class="fas fa-angle-double-down"></i> 계산</button>
												<input type="hidden" class="reservationno" name="no" value="${reservation1.no}">
												<button type="submit" class="btn btn-warning btn-sm">취소 <i class="fas fa-angle-double-right"></i></button>
											</form>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
				</div>
			</div>
		</div>
		<div class="col-md-1 text-center nopadding" id="plzresize1">
			<i class="fas fa-angle-double-left fa-5x verticalmid"></i>
		</div>
		<div class="col-md-5 font-1.5rem">
			<div class="panel panel-warning nomargin">
				<div class="panel-heading font-nbgb">
					<h3 class="panel-title">남은 예약(접수 전)</h3>
				</div>
				<div class="panel-body font-nbgl nopadding">
					<c:if test="${not empty reservationList0}">
						<table class="table table-striped table-bordered table-hover table-condensed nomargin">
							<thead>
								<tr id="reservation0th font-nbgl">
									<th>시작시간</th>
									<th>고객명</th>
									<th>성별</th>
									<th>연락처</th>
									<th>디자이너</th>
									<th>시술명</th>
									<th>종료예상</th>
									<th>접수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="reservation0" items="${reservationList0}">
									<tr class="reservation0tds font-nbgl text-center">
										<td>${reservation0.starttime_str}</td>
										<td><c:choose><c:when test="${reservation0.customer!=0}"><a href="customer?page=1&search=no&keyword=${reservation0.customer}" target="_blank">${reservation0.customer_name}(회원번호:${reservation0.customer})</a></c:when><c:otherwise>${reservation0.customer_name}(비회원)</c:otherwise></c:choose></td>
										<c:choose><c:when test="${reservation0.customer_gender=='남'}"><td class="gender-m">남</td></c:when><c:otherwise><td class="gender-f">여</td></c:otherwise></c:choose>
										<td>${reservation0.customer_phone}</td>
										<td>${reservation0.designer_str}</td>
										<td>${reservation0.design_str}</td>
										<td>${reservation0.endtime_str}</td>
										<td>
											<form class="form-receptionto1" action="reception/to1" method="POST">
												<input type="hidden" class="reservationno" name="no" value="${reservation0.no}">
												<button type="submit" class="btn btn-success btn-sm"><i class="fas fa-angle-double-left"></i> 접수</button>
											</form>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
				</div>
				<div class="panel-footer font-nbgl text-right nopadding">
					<a href="schedule?set=today" class="btn btn-warning">새 예약 & 수정</a>
				</div>
			</div>
		</div>
		<div class="col-md-6 text-center">
			<i class="fas fa-angle-double-down fa-5x"></i>
		</div>
		<div class="col-md-12"></div>
		<div class="col-md-6 font-1.5rem">
			<div class="panel panel-info">
				<div class="panel-heading font-nbgb">
					<h3 class="panel-title">계산하기</h3>
				</div>
				<div class="panel-body font-nbgl">
					<form action="reception/pay" method="POST" id="form-pay">
						<div class="col-md-4 noleftpadding">
							<div class="form-group nomargin">
								<label>회원여부</label>
								<input type="text" class="form-control" id="cal_customer_fake" disabled>
								<input type="hidden" name="whatday_str" id="cal_whatday_str" required>
								<input type="hidden" name="customer" id="cal_customer">
								<input type="hidden" name="reservation" id="cal_reservation" required>
							</div>
							<div class="form-group nomargin">
								<label>이름</label>
								<input type="text" class="form-control" name="customer_name" id="cal_name" readonly required>
							</div>
							<div class="form-group nomargin">
								<label>성별</label>
								<input type="text" class="form-control" name="customer_gender" id="cal_gender" readonly required>
							</div>
							<div class="form-group nomargin">
								<label>연락처</label>
								<input type="text" class="form-control" name="customer_phone" id="cal_phone" readonly>
							</div>
							<div class="form-group">
								<label>생년월일</label>
								<input type="text" class="form-control" name="customer_birth" id="cal_birth_str" readonly>
							</div>
						</div>
						<div class="col-md-4 noleftpadding">
							<div class="form-group nomargin">
								<label>가격</label>
								<input type="number" class="form-control" name="price" id="cal_price" readonly required>
							</div>
							<div class="form-group nomargin">
								<label for="cal_plus">추가요금(+)</label>
								<input type="number" class="form-control forcalplusminus" name="plus" maxlength="8" id="cal_plus">
							</div>
							<div class="form-group nomargin">
								<label for="cal_minus">할인액(-)</label>
								<input type="number" class="form-control forcalplusminus" name="dc" maxlength="8" id="cal_minus">
							</div>
							<div class="form-group nomargin">
								<label>최종금액</label>
								<input type="number" class="form-control" name="finalprice" id="cal_finalprice" readonly required>
							</div>
							<div class="form-group">
								<label>회원 보유 마일리지</label> <button type="button" class="btn btn-warning btn-xs formileage hidden" id="btn-charge">충전</button> <i class="fas fa-sync-alt formileage hidden" id="mileagerefresh"></i>
								<input type="text" class="form-control" name="mileage" id="cal_mileage" disabled>
							</div>
						</div>
						<div class="col-md-4 nopadding">
							<div class="form-group nomargin">
								<label for="cal_design">시술명</label>
								<select class="form-control" name="design" id="cal_design" required>
									<c:forEach var="design" items="${designlist}">
										<option value="${design.no}">${design.name}</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group nomargin">
								<label for="cal_designer">디자이너</label>
								<select class="form-control" name="designer" id="cal_designer" required>
									<c:forEach var="designer" items="${designerlist}">
										<option value="${designer.no}">${designer.name}</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group nomargin">
								<label>시술시간</label>
								<input type="text" class="form-control" name="time" id="cal_time" readonly>
								<input type="hidden" class="form-control" name="starttime" id="cal_starttime" required>
							</div>
							<div class="form-group nomargin">
								<label for="cal_paytype">결제방법</label>
								<select class="form-control" name="paytype" id="cal_paytype" required>
									<option value="X" selected disabled>- 선택 -</option>
									<option>카드</option>
									<option>현금</option>
									<option id="paytype_mileage">마일리지</option>
								</select>
							</div>
							<div class="form-group">
								<label for="cal_memo">메모</label>
								<input type="text" class="form-control" name="memo" id="cal_memo" maxlength="300">
							</div>
						</div>
						<div class="col-md-12 nopadding">
							<div class="form-group nomargin text-right">
								<button class="btn btn-info">계산</button>
								<button type="button" class="btn btn-primary">취소</button>
							</div>
						</div>
					</form>
				</div>
			</div>
			<a href="reception/list" class="btn btn-info">이전 계산 찾아보기</a>
		</div>
		<div class="col-md-12"></div>
		<div class="col-md-12 empty-row"></div>
	</div>
</body>
