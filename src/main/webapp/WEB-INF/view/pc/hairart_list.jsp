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
/*   			border: 1px dashed red; */
 		}
 		.container {
 			min-width: 1300px;
 		}
 		.col-md-8 {
 			max-width: 800px;
 		}
	</style>
</head>
<body>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="container">
		<div class="col-md-offset-2 col-md-8 text-center font-nbgb font-white font-2rem">
			<h1>헤어아트</h1>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 empty-row"></div>
		<jsp:include page="hairart_list_source.jsp"/>
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