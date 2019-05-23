<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>와이헤어</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css">
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
	.swiper-container {
      width: 100%;
      height: 100%;
    }
    .swiper-slide {
      text-align: center;
      font-size: 18px;
      background: #fff;
      /* Center slide text vertically */
      display: -webkit-box;
      display: -ms-flexbox;
      display: -webkit-flex;
      display: flex;
      -webkit-box-pack: center;
      -ms-flex-pack: center;
      -webkit-justify-content: center;
      justify-content: center;
      -webkit-box-align: center;
      -ms-flex-align: center;
      -webkit-align-items: center;
      align-items: center;
    }
	header{
		position: absolute;
		left: 0px;
		top: 0px;
		width: 100%;
		z-index: 90;
		background-color: #000000;
		color: #FFFFFF;
		min-width: 1620px;
	}
	.min1620{
		min-width: 1620px;
	}
	.pc-header{
		background-color: #AAAAAA;
		color: #FFFFFF;
	}
	.pc-header-slide{
		background-size: cover;
		height: 280px;
	}
	.pc-header-empty{
		height: 260px;
	}
	.pc-header-invis{
		position: absolute;
		left: 0px;
		top: 0px;
		width: 100%;
		z-index: 100;
		background-color: transparent;
		
		color: #000000;
		font-family: NanumBarunGothicBold;
		text-align: right;
		font-size: 2rem;
	}
	.pc-menu{
		position: absolute;
		left: 0px;
		top: 238px;
		width: 100%;
		z-index: 100;
		min-width: 1620px;
		background-color: transparent;
	
		color: #000000;
		font-family: NanumBarunGothicBold;
		text-align: center;
		font-size: 3rem;
		letter-spacing: 10px;
	}
	.whiteshadow {
		text-shadow: -1px -1px white, 1px -1px white, -1px 1px white, 1px 1px white;
	}
	.pc-menu a{
		text-shadow: -2px 0 black, 0 2px black, 2px 0 black, 0 -2px black;
	}
	.pc-menu a:hover{
		text-decoration:none !important;
		text-shadow: -2px 0 white, 0 2px white, 2px 0 white, 0 -2px white;
		color:black;
	}
	.pc-menu a:hover .impact{
		text-shadow: -2px 0 black, 0 2px black, 2px 0 black, 0 -2px black;
		color:orange;
	}
	.pc-header-invis a{
		text-shadow: -1px -1px black, 1px -1px black, -1px 1px black, 1px 1px black;
	}
	.pc-header-invis a:hover{
		text-decoration:none !important;
		color: orange;
	}
	.pc-header-padding{
		height: 280px;
	}
	.empty-row{
		height: 20px;
	}
	.nomargin{
		margin: 0px;
	}
</style>
<script src="${pageContext.request.contextPath}/js/jquery_1.11.1.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script>
	var isMobile;
	$(document).ready(function() {
		isMobile = isMobileF();
	});
	function isMobileF() {
		try{ document.createEvent("TouchEvent"); return true; }
		catch(e){ return false; }
	};
</script>
</head>
<body>
	<header>
		<div class="swiper-container">
			<div class="pc-header swiper-wrapper">
				<div class="swiper-slide pc-header-slide" style="background-image: url(${pageContext.request.contextPath}/images/header_bg_01.png);"></div>
				<div class="swiper-slide pc-header-slide" style="background-image: url(${pageContext.request.contextPath}/images/header_bg_02.png);"></div>
				<div class="swiper-slide pc-header-slide" style="background-image: url(${pageContext.request.contextPath}/images/header_bg_03.png);"></div>
				<div class="swiper-slide pc-header-slide" style="background-image: url(${pageContext.request.contextPath}/images/header_bg_04.png);"></div>
				<div class="swiper-slide pc-header-slide" style="background-image: url(${pageContext.request.contextPath}/images/header_bg_05.png);"></div>
				<div class="swiper-slide pc-header-slide" style="background-image: url(${pageContext.request.contextPath}/images/header_bg_06.png);"></div>
			</div>
		</div>
		<div class="pc-header-invis">
			<c:choose>
				<c:when test="${sessionScope.loginauth=='admin'}">
					<a href="${pageContext.request.contextPath}/admin/reception">관리자 화면으로</a>
					|
					<a href="${pageContext.request.contextPath}/pc/logout">로그아웃</a>
				</c:when>
				<c:when test="${sessionScope.loginauth=='customer'}">
					<span class="whiteshadow">${sessionScope.loginname}님 환영합니다!</span>
					-
					<a href="${pageContext.request.contextPath}/pc/myreservations">나의예약</a>
					|
					<a href="${pageContext.request.contextPath}/pc/myinfo">정보수정</a>
					|
					<a href="${pageContext.request.contextPath}/pc/qna">문의&건의</a>
					|
					<a href="${pageContext.request.contextPath}/pc/logout">로그아웃</a>
				</c:when>
				<c:otherwise>
					<a href="${pageContext.request.contextPath}/pc/login">로그인</a>
					|
					<a href="${pageContext.request.contextPath}/pc/signin">회원가입</a>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="pc-menu">
			<span><a href="${pageContext.request.contextPath}/pc/home"><img src="${pageContext.request.contextPath}/images/logo.png" border="0" width="30px"> <span class="impact">Y</span>hair</a></span>
			|
			<span><a href="${pageContext.request.contextPath}/pc/designer"><span class="impact">D</span>esigner</a></span>
			|
			<span><a href="${pageContext.request.contextPath}/pc/hairart/list"><span class="impact">H</span>air<span class="impact">A</span>rt</a></span>
			|
			<span><a href="${pageContext.request.contextPath}/pc/menu"><span class="impact">M</span>enu</a></span>
			|
			<span><a href="${pageContext.request.contextPath}/pc/schedule"><span class="impact">S</span>chedule</a></span>
			|
			<span><a href="${pageContext.request.contextPath}/pc/event"><span class="impact">E</span>vent</a></span>
		</div>
	</header>
	<div class="pc-header-padding"></div>
	<script src="${pageContext.request.contextPath}/js/swiper.min.js"></script>
	<script>
		var swiper = new Swiper('.swiper-container', {
			slidesPerView: 1,
			loop: true,
			effect: 'fade',			
			spaceBetween: 30,
			centeredSlides: true,
			simulateTouch: false,
			autoplay: {
				delay: 2500,
				disableOnInteraction: false,
			},
		});
	</script>
</body>
</html>