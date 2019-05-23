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
	</script>
</head>
<body>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="container-fluid">
		<div class="col-md-offset-4 col-md-4 text-center font-nbgb font-white font-2rem">
			<h1>
				나의 예약
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
								<th>날짜</th>
								<th>시간</th>
								<th>내용</th>
								<th>디자이너</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="reservationDto">
								<tr>
									<td>${reservationDto.whatday_str}</td>
									<td>${reservationDto.starttime_str}</td>
									<td>${reservationDto.design_str}</td>
									<td>${reservationDto.designer_str}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<p class="text-center">디자이너의 건강이나 개인사정에 의해 일정이 조정될 수 있습니다.</p>
					<p class="text-center">일정 변경이 필요할 때에는 회원정보의 연락처로 알려드리겠습니다.</p>
					<p class="text-center"><a href="schedule" class="btn btn-warning btn-lg">예약&수정</a></p>
				</c:when>
				<c:otherwise>
					<p class="text-center">아직 예약한 항목이 없습니다.</p>
					<p class="text-center"><a href="schedule" class="btn btn-warning btn-lg">예약하기</a></p>
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