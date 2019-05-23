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
/*  		div, span{
 			border: 1px dashed red;
 		} */
 		table th {
 			text-align: center !important;
 		}
	</style>
	<script>
		$(document).ready(function() {
			$('form').each(function(i,element){
				$(element).on('submit',function(e){
					e.preventDefault();
					$('.removable').addClass('hidden');
					this.submit();
				});
			});
		});
	</script>
</head>
<body>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="container-fluid">
		<div class="col-md-offset-4 col-md-4 text-center font-nbgb font-white font-2rem">
			<h1>
				아이디 찾기
			</h1>
		</div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 font-nbgl font-2rem">
			<c:choose>
				<c:when test="${not empty list}">
					<table class="table table-bordered table-striped table-hover text-center">
						<thead>
							<tr>
								<th>이메일</th>
								<th>임시암호 발급</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="customerDto">
								<tr>
									<form action="temppw" method="POST">
										<input type="hidden" name="no" value="${customerDto.no}">
										<td>${customerDto.email}</td>
										<td><button type="submit" class="btn btn-info removable">발급</button></td>
									</form>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<p class="text-center"><a href="login" class="btn btn-warning btn-lg">로그인하러 가기</a></p>
				</c:when>
				<c:otherwise>
					<p class="text-center">가입된 정보가 없습니다.</p>
					<p class="text-center"><a href="signin" class="btn btn-warning btn-lg">회원가입</a></p>
					<p class="text-center"><a href="" class="btn btn-primary btn-lg">다시하기</a></p>
				</c:otherwise>
			</c:choose>
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