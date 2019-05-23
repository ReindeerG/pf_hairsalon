<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>
<head>
	<style>
		body{
			background-color: #000000;
			color: #DDDDDD;
		}
		div, span {
/*    			border: 1px dashed red; */
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
			margin-bottom:0px;
		}
		.panel-footer {
			padding-top:0px;
		}
 		.nomargin {
 			margin: 0px;
 		}
 		.automargin {
 			margin-left: auto;
 			margin-right: auto;
 		}
 		.container-fluid {
 			min-width: 1620px;
 		}
 		.panel {
 			max-width: 600px;
 		}
	</style>
	<script>
		$(document).ready(function() {
			menuHilight();
			firstSet();
			$('.pb').hide();
		});
		function menuHilight() {
			$('#pagenation_${pagenationcurrent}').addClass('active');
		};
		function firstSet() {
			$('.ph').each(function(i,element){
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
		}
	</script>
</head>
<body>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="container-fluid">
		<div class="col-md-offset-2 col-md-8 text-center font-nbgb font-white font-2rem">
			<h1>
				문의 & 건의
			</h1>
		</div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 font-2rem">
			<p>문의나 건의사항을 적어주시면 답변드리겠습니다.</p>
			<p>(답변에는 최대 1-2일의 시간이 걸릴 수 있습니다.)</p>
		</div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4">
			<div class="panel panel-info font-1.5rem">
				<div class="panel-heading">
					<h3 class="panel-title">새로운 문의/건의</h3>
				</div>
				<div class="panel-body">
					<div class="text-right">
						<form action="" method="POST">
							<input type="hidden" name="customer" value="${sessionScope.loginno}">
							<textarea class="form-control text-question" name="question" rows="6" placeholder="질문내용 입력" maxlength="1000" required></textarea>
							<button type="submit" class="btn btn-info btn-sm">등록</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4">
			<c:forEach var="qna" items="${list}">
				<c:choose>
					<c:when test="${qna.time_a==null}">
							<div class="panel panel-warning font-1.5rem">
								<div class="panel-heading ph">
									<h3 class="panel-title">${qna.title} (${qna.time_q_str}) - no.${qna.no} (미답변) <i class="arrow fas fa-caret-down"></i></h3>
								</div>
								<div class="panel-body pb">
									<div>
										<textarea class="form-control text-question" rows="6" readonly>${qna.question}</textarea>
										<textarea class="form-control text-answer" rows="1" placeholder="(답변이 아직 등록되지 않았습니다.)" readonly></textarea>
									</div>
								</div>
							</div>
					</c:when>
					<c:otherwise>
							<div class="panel panel-success font-1.5rem">
								<div class="panel-heading ph">
									<h3 class="panel-title">${qna.title} (${qna.time_q_str}) - no.${qna.no} (답변완료) <i class="arrow fas fa-caret-down"></i></h3>
								</div>
								<div class="panel-body pb">
									<div>
										<textarea class="form-control text-question" rows="6" readonly>${qna.question}</textarea>
									</div>
									<div class="text-right">
										<textarea class="form-control text-answer" rows="5" readonly>${qna.answer}</textarea>
										(최종 수정시간: ${qna.time_a_str})
									</div>
								</div>
							</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<div class="col-md-offset-3 col-md-6 font-1.5rem font-nbgl text-center">
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
		<div class="col-md-offset-3 col-md-6 font-nbgl font-1.5rem text-center">
			<form action="qna" method="GET">
				<div class="form-group form-inline">
					<input type="hidden" name="page" value="1">
					<select class="form-control" name="search" style="margin-right: 10px;">
						<option value="question">질문내용</option>
						<option value="answer">답변내용</option>
					</select>
					<input type="text" class="form-control" name="keyword" required size="40px" style="margin-right: 10px;">
					<button class="btn btn-warning" style="margin-right: 10px;">검색</button>
					<a href="${pageContext.request.contextPath}/admin/qna" class="btn btn-primary">전체조회</a>
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