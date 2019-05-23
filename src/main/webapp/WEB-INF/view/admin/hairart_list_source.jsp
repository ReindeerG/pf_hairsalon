<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
	<style>
		th {
			text-align: center;
		}
		.sortable {
			color: orange !important;
		}
	</style>
	<script>
		$(document).ready(function() {
			menuHilight();
			firstSetls();
		});
		function menuHilight() {
			$('#pagenation_${pagenationcurrent}').addClass('active');
		};
		function firstSetls() {
			$('select[name=search]').on('change',function(){
				if($(this).val()=='no') {
					$('input[name=keyword]').prop('type','number');
				} else {
					$('input[name=keyword]').prop('type','text');
				}
			});
		};
	</script>
</head>
	<div class="col-md-offset-2 col-md-8 font-nbgl">
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th><a href="${pageContext.request.contextPath}/admin/hairart/list?page=1&sort=no
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
					" class="sortable">번호<c:if test="${param.sort=='no'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
					<th>제목</th>
					<th><a href="${pageContext.request.contextPath}/admin/hairart/list?page=1&sort=viewcount
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
					" class="sortable">조회수<c:if test="${param.sort=='viewcount'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
					<th><a href="${pageContext.request.contextPath}/admin/hairart/list?page=1&sort=date_new
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
					" class="sortable">작성일<c:if test="${param.sort=='date_new'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
					<th><a href="${pageContext.request.contextPath}/admin/hairart/list?page=1&sort=date_mod
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
					" class="sortable">수정일<c:if test="${param.sort=='date_mod'}"> <i class="fas fa-caret-down"></i></c:if></a></th>
					<th>첨부파일 갯수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="boardDto" items="${list}">
					<tr>
						<td class="text-center">${boardDto.no}</td>
						<td><a href="${pageContext.request.contextPath}/admin/hairart?no=${boardDto.no}
												<c:if test='${not empty param.page}'>&page=${param.page}</c:if>
												<c:if test='${not empty param.sort}'>&sort=${param.sort}</c:if>
												<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
												<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
						">${boardDto.title}</a></td>
						<td class="text-center">${boardDto.viewcount}</td>
						<td class="text-center">${boardDto.date_new_str}</td>
						<td class="text-center">${boardDto.date_mod_str}</td>
						<td class="text-center">${boardDto.files}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="col-md-offset-2 col-md-8 font-nbgl text-right">
		<a href="${pageContext.request.contextPath}/admin/hairart/write" class="btn btn-warning">글쓰기</a>
	</div>
	<div class="col-md-offset-2 col-md-8 font-1.5rem font-nbgl text-center">
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
							<a href="${pageContext.request.contextPath}/admin/hairart/list?page=${pagenationprev}
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
						<a href="${pageContext.request.contextPath}/admin/hairart/list?page=${pagenation}
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
							<a href="${pageContext.request.contextPath}/admin/hairart/list?page=${pagenationnext}
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
	<div class="col-md-offset-2 col-md-8 font-nbgl font-1.5rem text-center">
		<form action="${pageContext.request.contextPath}/admin/hairart/list" method="GET">
			<input type="hidden" name="page" value="1">
			<input type="hidden" name="sort" value="${param.sort}">
			<div class="form-group form-inline">
				<select class="form-control" name="search" style="margin-right: 20px;">
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="no">글 번호</option>
				</select>
				<input type="text" class="form-control" name="keyword" required size="40px" style="margin-right: 20px;">
				<button class="btn btn-warning" style="margin-right: 20px;">검색</button>
				<a href="${pageContext.request.contextPath}/admin/hairart/list" class="btn btn-primary">전체조회</a>
			</div>
		</form>
	</div>
	<div class="col-md-12 empty-row"></div>
