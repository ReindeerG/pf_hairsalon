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
 		.container {
 			min-width: 1300px;
 		}
		.nomargin {
			margin: 0px !important;
		}
		.nopadding {
			padding: 0px !important;
		}
		.panel-body {
			color: black;
			background-color: white;
		}
		.dashbottom {
			border-bottom: dashed white 1px;
		}
		.dashright {
			border-right: dashed white 1px;
		}
		.title {
			margin-bottom: 5px;
		}
		.titleinfo {
			padding: 5px 20px 0px 20px;
			margin: 20px 0px 20px 0px;
		}
		img {
			max-width: 100% !important;
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
		<div class="col-md-offset-2 col-md-8 font-nbgl font-1.5rem">
			<div class="panel">
				<div class="panel-heading font-nbgl container-fluid">
					<div class="col-md-12 nopadding font-nbgb font-2rem dashbottom title">
						<label>${board.title}</label>
						<hr class="nomargin">
					</div>
					<div class="col-md-12">
						<span class="dashright titleinfo">번호: ${board.no}</span>
						<span class="dashright titleinfo">조회수: ${board.viewcount}</span>
						<span class="dashright titleinfo">작성일: ${board.date_new_str}</span>
						<span class="titleinfo">수정일: ${board.date_mod_str}</span>
					</div>
					<c:if test="${board.file1_size>0}">
						<div class="col-md-12 text-right">
							<i class="fas fa-paperclip"></i> <a href="${pageContext.request.contextPath}/download?no=${board.no}&fileno=1">${board.file1_name}</a> (${board.file1_size_str})
						</div>
					</c:if>
					<c:if test="${board.file2_size>0}">
						<div class="col-md-12 text-right">
							<i class="fas fa-paperclip"></i> <a href="${pageContext.request.contextPath}/download?no=${board.no}&fileno=2">${board.file2_name}</a> (${board.file2_size_str})
						</div>
					</c:if>
				</div>
				<div class="panel-body font-nbgl" id="contentdiv">
				</div>
				<div class="panel-footer font-nbgl container-fluid">
					<div class="col-md-12 nopadding text-right">
						<a href="hairart/list?
								<c:if test='${not empty param.page}'>&page=${param.page}</c:if>
								<c:if test='${not empty param.sort}'>&sort=${param.sort}</c:if>
								<c:if test='${not empty param.search}'>&search=${param.search}</c:if>
								<c:if test='${not empty param.keyword}'>&keyword=${param.keyword}</c:if>
						" class="btn btn-primary">목록으로</a>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 empty-row"></div>
		<jsp:include page="hairart_list_source.jsp"/>
	</div>
	<script>
		var boardcontent = '${board.content}';
		$(document).ready(function() {
			firstSet();
		});
		function firstSet() {
			$('#contentdiv').html(boardcontent);
		};
	</script>
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