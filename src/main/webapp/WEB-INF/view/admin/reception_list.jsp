<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="sidebar.jsp"/>
<head>
	<style>
		table th {
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
		.container {
			min-width: 1200px;
		}
	</style>
	<script>
		$(document).ready(function() {
			firstSetForSource();
			firstSet();
			menuHilight();
		});
		function firstSetForSource() {
			$('.section-memo').each(function(i,element){
				$(element).text($(element).find('.originmemo').val());
			});
		};
		function menuHilight() {
			$('#menu_reception').addClass('active');
			$('#pagenation_${pagenationcurrent}').addClass('active');
		};
		function firstSet() {
			$('select[name=search]').on('change',function(){
				$('#keyword_date').prop('disabled',true);
				$('#keyword_text').prop('disabled',true);
				$('#keyword_number').prop('disabled',true);
				$('#keyword_select_paytype').prop('disabled',true);
				$('#keyword_select_gender').prop('disabled',true);
				$('#keyword_date').addClass('hidden');
				$('#keyword_text').addClass('hidden');
				$('#keyword_number').addClass('hidden');
				$('#keyword_select_paytype').addClass('hidden');
				$('#keyword_select_gender').addClass('hidden');
				$('#keyword_date').val(null);
				$('#keyword_text').val(null);
				$('#keyword_number').val(null);
				$('#keyword_select_paytype').val(null);
				$('#keyword_select_gender').val(null);
				if($(this).val()=='whatday') {
					$('#keyword_date').prop('disabled',false);
					$('#keyword_date').removeClass('hidden');
				} else if($(this).val()=='customer_phone'||$(this).val()=='customer'||$(this).val()=='no') {
					$('#keyword_number').prop('disabled',false);
					$('#keyword_number').removeClass('hidden');
				} else if($(this).val()=='paytype') {
					$('#keyword_select_paytype').prop('disabled',false);
					$('#keyword_select_paytype').removeClass('hidden');
				} else if($(this).val()=='customer_gender') {
					$('#keyword_select_gender').prop('disabled',false);
					$('#keyword_select_gender').removeClass('hidden');
				}
				else {
					$('#keyword_text').prop('disabled',false);
					$('#keyword_text').removeClass('hidden');
				}
			});
			$('form').on('submit',function(e){
				e.preventDefault();
				if($('#keyword_date').val()!='') {
					var thislength = $('#keyword_date').val().length;
					if(thislength!=10) {
						alert('올바른 날짜를 입력해주세요!');
						$('#keyword_date').val(null);
						return;
					}
				}
				this.submit();
			});
		};
	</script>
</head>
<body>
	<div class="admin_body container">
		<div class="col-md-12 font-nbgb">
			<h1><i class="fas fa-calculator"></i> 지난 계산 보기</h1>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 font-1.5rem font-nbgl text-right">
			<a href="${pageContext.request.contextPath}/admin/reception" class="btn btn-primary">접수&계산으로 돌아가기</a>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 font-1.5rem">
			<c:if test="${not empty list}">
				<table class="table table-striped table-bordered table-hover table-condensed">
					<thead>
						<tr class="font-nbgl">
							<th><a href="list?page=1&sort=no
									<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
									<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">번호<c:if test="${param.sort=='no'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th><a href="list?page=1&sort=whatday
									<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
									<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">날짜<c:if test="${param.sort=='whatday'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th>시간</th>
							<th><a href="list?page=1&sort=customer
									<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
									<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">회원여부<c:if test="${param.sort=='customer'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th>고객명</th>
							<th><a href="list?page=1&sort=customer_gender
									<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
									<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">성별<c:if test="${param.sort=='customer_gender'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th>연락처</th>
							<th><a href="list?page=1&sort=designer
									<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
									<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">디자이너<c:if test="${param.sort=='designer'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th><a href="list?page=1&sort=design
									<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
									<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">시술내용<c:if test="${param.sort=='design'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th><a href="list?page=1&sort=price
									<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
									<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">가격<c:if test="${param.sort=='price'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th>추가요금(+)</th>
							<th>할인액(-)</th>
							<th><a href="list?page=1&sort=finalprice
									<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
									<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">최종금액<c:if test="${param.sort=='finalprice'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th><a href="list?page=1&sort=paytype
									<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
									<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
								" class="sortable">결제방법<c:if test="${param.sort=='paytype'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
							<th>메모</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="hairorder" items="${list}">
							<tr class="font-nbgl">
								<td class="text-center">${hairorder.no}</td>
								<td class="text-center">${hairorder.whatday_str}</td>
								<td class="text-center">${hairorder.time}</td>
								<td class="text-center">
									<c:choose>
										<c:when test="${hairorder.customer!=0}">
											회원번호:${hairorder.customer}
										</c:when>
										<c:otherwise>(비회원)</c:otherwise>
									</c:choose>
								</td>
								<td>${hairorder.customer_name}</td>
								<c:choose>
									<c:when test="${hairorder.customer_gender=='남'}">
										<td class="text-center gender-m">
											남
										</td>
									</c:when>
									<c:otherwise>
										<td class="text-center gender-f">
											여
										</td>
									</c:otherwise>
								</c:choose>
								<td class="text-center">${hairorder.customer_phone}</td>
								<td class="text-center">${hairorder.designer_str}</td>
								<td class="text-center">${hairorder.design_str}</td>
								<td class="text-right">${hairorder.price}</td>
								<td class="text-right"><c:if test="${hairorder.plus!=0}">+ </c:if>${hairorder.plus}</td>
								<td class="text-right"><c:if test="${hairorder.dc!=0}">- </c:if>${hairorder.dc}</td>
								<td class="text-right">${hairorder.finalprice}원</td>
								<td class="text-center">${hairorder.paytype}</td>
								<td class="section-memo"><input type="hidden" class="originmemo" value="${hairorder.memo}"></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
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
								<a href="list?page=${pagenationprev}
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
							<a href="list?page=${pagenation}
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
								<a href="list?page=${pagenationnext}
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
			<form action="list" method="GET">
				<div class="form-group form-inline">
					<input type="hidden" name="page" value="1">
					<input type="hidden" name="sort" value="${param.sort}">
					<select class="form-control" name="search" style="margin-right: 20px;">
						<option value="whatday">날짜</option>
						<option value="customer_name">고객명</option>
						<option value="customer_phone">연락처 일부분</option>
						<option value="designer">디자이너</option>
						<option value="paytype">결제방법</option>
						<option value="memo">메모</option>
						<option value="design">시술내용</option>
						<option value="customer_gender">성별</option>
						<option value="customer">회원번호</option>
						<option value="no">번호</option>
					</select>
					<input type="date" class="form-control" name="keyword" id="keyword_date" required style="margin-right: 20px;">
					<input type="text" class="form-control hidden" name="keyword" id="keyword_text" disabled required size="40px" style="margin-right: 20px;">
					<input type="number" class="form-control hidden" name="keyword" id="keyword_number" disabled required style="margin-right: 20px;">
					<select class="form-control hidden" name="keyword" id="keyword_select_paytype" disabled required style="margin-right: 20px;">
						<option>카드</option>
						<option>현금</option>
						<option>마일리지</option>
					</select>
					<select class="form-control hidden" name="keyword" id="keyword_select_gender" disabled required style="margin-right: 20px;">
						<option>남</option>
						<option>여</option>
					</select>
					<button class="btn btn-warning" style="margin-right: 20px;">검색</button>
					<a href="list" class="btn btn-primary">전체조회</a>
				</div>
			</form>
		</div>
		<div class="col-md-12 empty-row"></div>
	</div>
</body>
