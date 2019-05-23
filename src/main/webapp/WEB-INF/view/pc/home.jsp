<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
 		.nomargin {
 			margin: 0px;
 		}
 		.automargin {
 			margin-left: auto;
 			margin-right: auto;
 		}
 		.container-fluid {
 			min-width: 1620px;
 		}
	</style>
	
</head>
<body>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="container-fluid">
		<div class="col-md-offset-2 col-md-8 text-center font-nbgb font-white font-2rem">
			<h1>
				와이헤어 소개
			</h1>
		</div>
		<div class="col-md-offset-3 col-md-6 empty-row"></div>
		<div class="col-md-offset-3 col-md-6 empty-row"></div>
		<div class="col-md-offset-3 col-md-6 font-2rem">
			<p>와이헤어는 예약제로 운영되는 프리미엄 미용실입니다.</p>
			<p>항상 고객에게 만족을 드리는 최선의 서비스를 제공하겠습니다.</p>
			<p>회원이시면 언제든 원하는 날짜, 시간에 직접 홈페이지에서 예약이 가능합니다.</p>
		</div>
		<div class="col-md-offset-3 col-md-6 empty-row"></div>
		<div class="col-md-offset-3 col-md-6 empty-row"></div>
		<div class="col-md-offset-3 col-md-6 empty-row"></div>
		<div class="col-md-offset-3 col-md-6 empty-row"></div>
		<div class="col-md-offset-3 col-md-6 empty-row"></div>
		<div class="col-md-offset-3 col-md-6 text-center">
			<p class="font-2rem">찾아오시는 길</p>
			<div class="automargin" id="map" style="width:350px;height:350px;"></div>
			<p class="font-1.5rem">(은 없고 광화문)</p>
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
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9888b08c720386ca8c034224dd11fade&libraries=services,clusterer,drawing"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new daum.maps.LatLng(37.576235, 126.976817), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
		
		var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new daum.maps.LatLng(37.576235, 126.976817); 

		// 마커를 생성합니다
		var marker = new daum.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		    
		function setCenter() {             
		    var latitude = parseFloat(document.querySelector('input[name=latitude]').value);
		    var longitude = parseFloat(document.querySelector('input[name=longitude]').value);
		    
		    // 이동할 위도 경도 위치를 생성합니다
		    var moveLatLon = new daum.maps.LatLng(latitude,longitude);
		    
		    // 지도 중심을 이동 시킵니다
		    map.setCenter(moveLatLon);
		}
		
		function panTo() {
		    var latitude = parseFloat(document.querySelector('input[name=latitude]').value);
		    var longitude = parseFloat(document.querySelector('input[name=longitude]').value);
		    
		    // 이동할 위도 경도 위치를 생성합니다 
		    var moveLatLon = new daum.maps.LatLng(latitude,longitude);
		    
		    // 지도 중심을 부드럽게 이동시킵니다
		    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
		    map.panTo(moveLatLon);            
		}        
	</script>
</body>
<jsp:include page="footer.jsp"/>