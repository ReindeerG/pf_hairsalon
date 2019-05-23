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
		.mancard{
			display: inline-block;
			text-align: left;
 			align-self: center;
			width: 330px;
			height: 120px;
			margin: 20px;
			font-size: 2rem;
			font-family: NanumBarunGothicLight;
			cursor: default !important;
		}
		.divpic {
			width: 100px;
			height: 100px;
			vertical-align: middle;
			display: inline-block;
		}
		.divname {
			text-align: right;
			width: 200px;
			height: 100px;
			vertical-align: middle;
			display: inline-block;
			font-weight: bold;
		}
		.container-fluid {
			min-width: 1560px;
		}
		.col-md-6 {
			min-width: 800px;
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
				헤어 디자이너
			</h1>
		</div>
		<div class="col-md-offset-3 col-md-6 empty-row"></div>
		<div class="col-md-offset-3 col-md-6 empty-row"></div>
		<div class="col-md-offset-3 col-md-6">
			<c:forEach var="designerDto" items="${list}">
				<div class="mancard btn btn-primary">
					<div class="divpic">
						<c:choose>
							<c:when test="${designerDto.picture==null}">
								<img src="${pageContext.request.contextPath}/images/logo.png" border="0" width="100px" height="100px">
							</c:when>
							<c:otherwise>
								<img src="${pageContext.request.contextPath}/designerpics/${designerDto.picture}" border="0" width="100px" height="100px">
							</c:otherwise>
						</c:choose>
						
					</div>
					<div class="divname">
						<p>${designerDto.name} ${designerDto.grade_str} (${designerDto.gender})</p>
						<c:if test="${designerDto.offdays!=null}">
							<p>휴무일: ${designerDto.offdays}</p>
						</c:if>
					</div>
				</div>			
			</c:forEach>
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