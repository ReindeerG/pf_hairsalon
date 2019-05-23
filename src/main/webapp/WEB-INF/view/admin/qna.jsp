<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="sidebar.jsp"/>
<head>
	<style>
		div {
/*   			border: red dotted 1px; */
		}
		textarea {
			background-color:white !important;
		}
		.text-question {
			resize:none;
			margin-bottom:10px;
		}
		.text-answer {
			resize:none;
			height:100px !important;
		}
		.panel-footer {
			padding-top:0px;
		}
		.container {
			min-width: 800px;
		}
	</style>
	<script>
		$(document).ready(function() {
			menuHilight();
			firstSet();
			$('.panel-body').hide();
		});
		function menuHilight() {
			$('#menu_qna').addClass('active');
			$('#pagenation_${pagenationcurrent}').addClass('active');
		};
		function firstSet() {
			$('.panel-heading').each(function(i,element){
				$(element).on('click',function(){
					$(this).parent().find('.panel-body').slideToggle();
					if($(this).find('.arrow').hasClass('fa-caret-down')) {
						$(this).find('.arrow').removeClass('fa-caret-down');
						$(this).find('.arrow').addClass('fa-caret-up');
					} else {
						$(this).find('.arrow').removeClass('fa-caret-up');
						$(this).find('.arrow').addClass('fa-caret-down');
					};
				});
			});
			$('.form-answer').each(function(i,element){
				$(element).on('submit',function(e){
					e.preventDefault();
					if(!$(this).find('.text-answer').val()) {
						alert('답변 내용을 입력해주세요!');
						return;
					}
					this.submit();
				});
			});
			
			$('select[name=search]').on('change',function(){
				if($(this).val()=='customer_no'||$(this).val()=='no') {
					$('input[name=keyword]').prop('type','number');
				} else {
					$('input[name=keyword]').prop('type','text');
				}
			});
		}
	</script>
</head>
<body>
	<div class="admin_body container">
		<div class="col-md-12 font-nbgb">
			<h1><i class="fas fa-envelope"></i> 문의&건의 답변</h1>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 empty-row"></div>
		<c:forEach var="qna" items="${list}">
			<c:choose>
				<c:when test="${qna.time_a==null}">
					<div class="col-md-12 font-nbgl font-1.5rem">
						<div class="panel panel-warning">
							<div class="panel-heading">
								<h3 class="panel-title">${qna.title} (${qna.time_q_str}) - no.${qna.no} (미답변) <i class="arrow fas fa-caret-down"></i></h3>
							</div>
							<div class="panel-body">
								<div>
									<a href="customer?page=1&search=no&keyword=${qna.customer}" target="_blank">회원번호: ${qna.customer} | 고객명: ${qna.customer_name} | 성별: ${qna.customer_gender}</a>
									<textarea class="form-control text-question" rows="6" readonly>${qna.question}</textarea>
								</div>
								<div class="text-right">
									<form class="form-answer" action="qna" method="POST">
										<input type="hidden" name="no" value="${qna.no}">
										<input type="hidden" name="page" value="${pagenationcurrent}">
										<input type="hidden" name="search" value="${param.search}">
										<input type="hidden" name="keyword" value="${param.keyword}">
										<textarea name="answer" class="form-control text-answer" placeholder="답변입력" maxlength="1000"></textarea>
										<button type="submit" class="btn btn-warning btn-sm btn-answer">답변</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="col-md-12 font-nbgl font-1.5rem">
						<div class="panel panel-success">
							<div class="panel-heading">
								<h3 class="panel-title">${qna.title} (${qna.time_q_str}) - no.${qna.no} (답변완료) <i class="arrow fas fa-caret-down"></i></h3>
							</div>
							<div class="panel-body">
								<div>
									<a href="qna?page=1&search=customer_no&keyword=${qna.no}" target="_blank">회원번호: ${qna.customer} | 고객명: ${qna.customer_name} | 성별: ${qna.customer_gender}</a>
									<textarea class="form-control text-question" rows="6" readonly>${qna.question}</textarea>
								</div>
								<div class="text-right">
									<form class="form-answer" action="qna" method="POST">
										<input type="hidden" name="no" value="${qna.no}">
										<input type="hidden" name="page" value="${pagenationcurrent}">
										<input type="hidden" name="search" value="${param.search}">
										<input type="hidden" name="keyword" value="${param.keyword}">
										<textarea name="answer" class="form-control text-answer" placeholder="답변수정" maxlength="1000">${qna.answer}</textarea>
										(최종 수정시간: ${qna.time_a_str})
										<button type="submit" class="btn btn-success btn-sm btn-answer">수정</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
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
							<a href="qna?page=${pagenationprev}
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
						<a href="qna?page=${pagenation}
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
							<a href="qna?page=${pagenationnext}
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
			<form action="qna" method="GET">
				<div class="form-group form-inline">
					<input type="hidden" name="page" value="1">
					<select class="form-control" name="search" style="margin-right: 20px;">
						<option value="question">질문내용</option>
						<option value="customer_name">회원이름</option>
						<option value="customer_no">회원번호</option>
						<option value="answer">답변내용</option>
						<option value="no">질문번호</option>
					</select>
					<input type="text" class="form-control" name="keyword" required size="40px" style="margin-right: 20px;">
					<button class="btn btn-warning" style="margin-right: 20px;">검색</button>
					<a href="${pageContext.request.contextPath}/admin/qna" class="btn btn-primary">전체조회</a>
				</div>
			</form>
		</div>
		<div class="col-md-12 empty-row"></div>
	</div>
</body>
