<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="sidebar.jsp"/>
<head>
	<style>
		div {
/*      		border: red dotted 1px; */
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
						<a href="hairart/mod?no=${board.no}" class="btn btn-warning">수정</a>
						<button type="button" class="btn btn-danger" id="btn-del">삭제</button>
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
			sidemenuHilight();
			firstSetv();
		});
		function sidemenuHilight() {
			$('#menu_hairart').addClass('active');
		};
		function firstSetv() {
			$('#contentdiv').html(boardcontent);
			$('#btn-del').on('click',function(){
				var result = confirm('정말로 이 글을 삭제합니까?');
				if(result) window.location.replace('hairart/del?no='+${board.no});
			});
		};
	</script>
</body>
