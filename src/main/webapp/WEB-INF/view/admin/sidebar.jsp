<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>와이헤어 - 매장관리</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
<style>
	@font-face{
		font-family: NanumBarunGothicBold;
		src: url("${pageContext.request.contextPath}/fonts/NANUMBARUNGOTHICBOLD.TTF");
	}
	@font-face{
		font-family: NanumBarunGothicLight;
		src: url("${pageContext.request.contextPath}/fonts/NANUMBARUNGOTHICLIGHT.TTF");
	}
	.font-nbgb{
		font-family: NanumBarunGothicBold !important;
	}
    .font-nbgl{
		font-family: NanumBarunGothicLight !important;
	}
	.font-1rem{
		font-size: 1rem !important;
	}
	.font-1.1rem{
		font-size: 1.1rem !important;
	}
	.font-1.5rem{
		font-size: 1.5rem !important;
	}
	.font-2rem{
		font-size: 2rem !important;
	}
	.font-3rem{
		font-size: 3rem !important;
	}
	.font-white{
		color: #FFFFFF;
	}
	.min1620{
		min-width: 1620px;
	}
	.empty-row{
		height: 20px;
	}
	.nomargin{
		margin: 0px;
	}
	html, body {
		height: 100%;
		min-height: 100%;
		background-color: #000000;
		color: #FFFFFF;
	}
	.main_logo {
		position: fixed;
		top: 0px;
		left: 0px;
		width: 300px;
		height: 50px;
		margin: 0px;
		background-color: #663300;
		color: #FFFFFF;
		font-size: 2rem;
        padding-top: 10px;
        padding-left: 10px;
	}
	.main_sidebar {
	    min-height:100vh;
	    position:fixed;
	    top:50px;
	    left:0;
	    width:300px;
	    transition: all 300ms cubic-bezier(0.65, 0.05, 0.36, 1);
	    will-change: left, width;
	    background-color: #333333;
	    z-index: 100;
	}
	.main_sidebar:after {
	    content: '';
	    background-color: #663300;
	    position: absolute;
	    top: 0;
	    z-index: -1;
	    height: 100%;
	    width: 50px;
	}
	.main_sidebar ul {
	    list-style:none;
	    padding-left:50px;
	}
	.main_sidebar ul li {
	    padding:10px;
	}
	.main_sidebar ul li a {
	    color:#fff;
	    display:block;
	}
	.main_sidebar ul li i {
	    float:left;
	    color:grey;
	    margin-left:-50px;
	    font-size:24px;
	    padding-left:4px;
	}
	.main_sidebar ul li:hover {
	    background:#FF8C00;
	}
	.main_sidebar ul li a:hover {
	    color:#fff;
	    text-decoration:none;
	}
	.main_sidebar ul li:hover i {
	    color:#fff;
	}
	.main_sidebar ul li.active {
	    background:#996600;
	}
	.main_sidebar ul li.active i {
	    color:#fff;
	}
	.main_sidebar ul li.active:hover {
	    background:#FF8C00;
	}
	.main_sidebar ul li.active:hover i {
	    color:#fff;
	}
	.admin_body {
		margin-left: 300px;
		width: auto;
	}
</style>
<script src="${pageContext.request.contextPath}/js/jquery_1.11.1.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script>
	var isMobile;
	$(document).ready(function() {
		isMobile = isMobileF();
		sidemenuUnhilight();
	});
	function isMobileF() {
		try{ document.createEvent("TouchEvent"); return true; }
		catch(e){ return false; }
	};
	function sidemenuUnhilight() {
		$('.sidemenu').each(function(i, element){
			$(element).removeClass('active');
		});
	}
</script>
</head>
<body>
	<aside class="main_logo">
		<img src="${pageContext.request.contextPath}/images/logo.png" border="0" width="25px"> 와이헤어 - 매장관리
	</aside>
    <aside class="main_sidebar">
        <ul>
            <li class="sidemenu" id="menu_reception"><a href="${pageContext.request.contextPath}/admin/reception"><i class="fas fa-calculator"></i>접수&계산</a></li>
            <li class="sidemenu" id="menu_schedule"><a href="${pageContext.request.contextPath}/admin/schedule"><i class="far fa-calendar-alt"></i>스케쥴관리 <span class="badge <c:if test='${num_error==0}'>hidden</c:if>" id="num_error">${num_error}</span></a></li>
            <li class="sidemenu" id="menu_designer"><a href="${pageContext.request.contextPath}/admin/designer"><i class="fas fa-cut"></i>디자이너 관리</a></li>
            <li class="sidemenu" id="menu_customer"><a href="${pageContext.request.contextPath}/admin/customer"><i class="fas fa-address-book"></i>회원 관리</a></li>
            <li class="sidemenu" id="menu_design"><a href="${pageContext.request.contextPath}/admin/design"><i class="fas fa-hands"></i>시술(메뉴) 관리</a></li>
            <li class="sidemenu" id="menu_hairart"><a href="${pageContext.request.contextPath}/admin/hairart/list"><i class="fas fa-edit"></i>헤어아트(게시판) 관리</a></li>
            <li class="sidemenu" id="menu_qna"><a href="${pageContext.request.contextPath}/admin/qna"><i class="fas fa-envelope"></i>문의&건의 답변 <span class="badge <c:if test='${num_qna==0}'>hidden</c:if>">${num_qna}</span></a></li>
<!--             <li class="sidemenu" id="menu_statistic"><a href="#"><i class="fas fa-chart-line"></i>통계</a></li> -->
            <li class="sidemenu" id="menu_exit"><a href="${pageContext.request.contextPath}/pc/home"><i class="fas fa-sign-out-alt"></i>일반페이지로 돌아가기</a></li>
        </ul>
    </aside>
</body>
</html>