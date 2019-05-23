<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="sidebar.jsp"/>
<head>
	<style>
		.container {
			min-width: 800px;
		}
	</style>
</head>
<body>
	<div class="admin_body container">
		<div class="col-md-12 font-nbgb">
			<h1><i class="fas fa-edit"></i> 헤어아트(게시판) 관리</h1>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 empty-row"></div>
		<jsp:include page="hairart_list_source.jsp"/>
	</div>
	<script>
		$(document).ready(function() {
			sidemenuHilight();
		});
		function sidemenuHilight() {
			$('#menu_hairart').addClass('active');
		};
	</script>
</body>
