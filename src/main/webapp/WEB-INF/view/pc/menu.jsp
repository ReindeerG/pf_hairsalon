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
/*  			border: 1px dashed red; */
 		}
 		table {
 			background-color: #000000;
 		}
 		table th {
 			text-align: center;
 			border-bottom: 1px dashed #DDDDDD !important;
 		}
 		table td {
  			border-top: 0px !important;
  			border-bottom: 1px dashed #DDDDDD !important;
 		}
 		.borderright {
 			border-right: 1px dashed #DDDDDD !important;
 		}
 		.nomargin {
 			margin: 0px;
 		}
 		.container-fluid {
 			min-width: 1620px;
 		}
 		.col-md-4 {
 			max-width: 800px;
 		}
	</style>
</head>
<body>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="container-fluid">
		<div class="col-md-offset-2 col-md-8 text-center font-nbgb font-white font-2rem">
			<h1>
				시술 메뉴
			</h1>
		</div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 empty-row"></div>
		<div class="col-md-offset-4 col-md-4 font-2rem">
			<table class="table table-hover nomargin">
				<thead>
					<tr>
						<th class="borderright">이름</th>
						<th class="borderright">종류</th>
						<th class="borderright">상세</th>
						<th>가격</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="designDto" items="${list}">
						<tr>
							<td>${designDto.name}</td>
							<td class="text-center">${designDto.type}</td>
							<td>${designDto.memo}</td>
							<td class="text-right">${designDto.price}원</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="col-md-offset-4 col-md-4 font-1.5rem">
			<p class="nomargin">모든 염색/펌에 영양/고급영양 단계 추가 가능합니다.</p>
			<p>(모든 시술은 머리 길이에 따라 추가가격이 책정될 수 있습니다.)</p>
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