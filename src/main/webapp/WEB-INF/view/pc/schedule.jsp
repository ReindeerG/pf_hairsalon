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
		table th {
			text-align: center;
			background-color: #AAAAAA;
			color: black;
			min-width: 100px;
		}
		.th_z {
			width: 40px !important;
			min-width: 40px !important;
		}
		table td {
			vertical-align: middle !important;
		}
		.td_new:hover {
			background-color: #5bc0de; !important;
			cursor: pointer;
		}
		.font-sun {
			color: red !important;
		}
		.font-sat {
			color: blue !important;
		}
		.gender-m {
			color: skyblue !important;
		}
		.gender-f {
			color: pink !important;
		}
		.nohover {
			outline: none !important;
			cursor: default !important;
		}
		.today {
			color: orange !important;
			font-weight: bold;
		}
		.nopadding {
			padding: 0px !important;
		}
		.nomargin {
			margin: 0px !important;
		}
		.table-search th,td {
			text-align: center;
			padding: 0px !important;
		}
		.panel-danger {
			width: 600px;
			margin: 0px;
		}
		.panel-success {
			margin: 0px;
		}
		.td_time {
			height: 70px;
		}
		.btn-case {
			position: absolute;
			width: 0px;
			height: 0px;
			top: 0px;
			left: 0px;
			z-index: 10;
			padding: 0px;
			color: black;
			cursor: not-allowed;
		}
		.btn-case > p {
			white-space: pre-line;
			padding: 0px;
			margin: 0px;
		}
		.form-group {
			margin: 0px;
		}
		#helpth {
			position: fixed;
			margin: 0px;
			z-index: 20;
		}
		.myrsv {
			font-weight: bold;
			font-size: 1.5rem;
		}
		.canpointer {
			cursor: pointer !important;
		}
		.cursordefault {
			cursor: default;
		}
	</style>
	<script>
		var settoday = '${setToday}';
		var thisyear = ${currentdate.year};
		var nextyear = ${currentdate.year}+1;
		var thismonth = ${currentdate.month};
		var nextmonth = ${currentdate.month}+1;
		var thisdate = ${currentdate.date};
		var next = false;
		var nextday = 0;
		var date_thissun;
		var date_thismon;
		var date_thistue;
		var date_thiswed;
		var date_thisthu;
		var date_thisfri;
		var date_thissat;
		var date_nextsun;
		var date_nextmon;
		var date_nexttue;
		var date_nextwed;
		var date_nextthu;
		var date_nextfri;
		var date_nextsat;
		var selecteddate = '';
		var totimetable = false;
		var ajaxhandle;
		var ajaxcurrentdate;
		var ajaxcurrenttime;
		window.addEventListener('resize', function() {
			if(totimetable) {
				forBtnCases();
				$('#helpth').css('width',$('#tabletimetable').width()+2);
				$('#helpth').css('left',$('#tabletimetable').offset().left);
			}
		});
		window.addEventListener('scroll', function() {
			if(totimetable) {
				var height = $(window).scrollTop();
				if(height>$('#timetable').find('table').find('th:first').offset().top) {
					$('#helpth').removeClass('hidden');
					$('#helpth').css('top',0);
					$('#helpth').css('width',$('#tabletimetable').width()+2);
					$('#helpth').css('left',$('#tabletimetable').offset().left);
				} else {
					$('#helpth').addClass('hidden');
				};
			};
		});
		$(document).ready(function() {
			firstButtonSet();
			firstSet();
			$('.notfocus').each(function(i, element){
				$(this).on('click', function() {
					$(this).focusout();					
				});
			});
			forCalendarClick();
		});
		function firstButtonSet() {
			$('#mod_btn-ok').on('click',function(){
				if($('#precheck_whatday').val()!='Y') {
					alert('이전 날짜로는 예약할 수 없습니다!');
					return;
				}
				if($('#mod_whatday').val()==ajaxcurrentdate && parseInt($('#mod_starttime').val())<parseInt(ajaxcurrenttime)+50) {
					alert('30분 전에는 예약해주세요!');
					return;
				}
				forModAjax();
			});
			$('#mod_btn-del').on('click',function(){
				var result = confirm('정말로 이 예약을 삭제합니까?');
				if(result) forDelAjax();
			});
			$('#mod_btn-cancel').on('click',function(){
				$(this).parent().parent().parent().addClass('hidden');
				initMod();
			});
			$('#new_btn-ok').on('click',function(){
				if(parseInt($('#new_starttime').val())<parseInt(ajaxcurrenttime)+50) {
					alert('30분 전에는 예약해주세요!');
					return;
				}
				forNewAjax();
			});
			$('#new_btn-cancel').on('click',function(){
				$(this).parent().parent().parent().addClass('hidden');
				initNew();
			});
			$('.td_new').each(function(i, element){
				$(this).on('click', function() {
					$('.panel-warning').addClass('hidden');
					initMod();
					$('.panel-info').removeClass('hidden');
					tdToNew($(this).attr('id'));
					$('html, body').animate({scrollTop: $('.panel-info').offset().top}, 500);
				});
			});
			$('#mod_whatday').on('focusout',function(){
				if($(this).val()!='') {
					var thislength = $(this).val().length;
					if(thislength!=10) {
						alert('올바른 날짜를 입력해주세요!');
						$(this).val(null);
						$('#precheck_whatday').val('N');
						return;
					}
					var cal_year = parseInt($(this).val().substring(0,$(this).val().indexOf('-')));
					var cal_month = parseInt($(this).val().substring($(this).val().indexOf('-')+1,$(this).val().indexOf('-')+3));
					var cal_date = parseInt($(this).val().substring($(this).val().indexOf('-')+4,$(this).val().indexOf('-')+6));
					if(cal_year<thisyear) {
						$('#precheck_whatday').val('N');
						return;
					}
					if(cal_year==thisyear && cal_month<thismonth) {
						$('#precheck_whatday').val('N');
						return;
					}
					if(cal_year==thisyear && cal_month==thismonth && cal_date<thisdate) {
						$('#precheck_whatday').val('N');
						return;
					}
					$('#precheck_whatday').val('Y');
				}
			});
		};
		function forBtnAjax() {
			if(selecteddate!='') {
				$.ajax({
	                url: "schedule/ajax_list",
	                data:{
	                	selecteddate:selecteddate
	                },
	                type:"post",
	                success:function(response){
		                $('#divforajax').html(response);
	                	forBtnCasesOnce();
	                }
	            });
			};
			intervalStart();
		};
		function intervalStart(){
			if(!ajaxhandle){
				intervalFunction();
				ajaxhandle = setInterval(intervalFunction,60000);
			}
		};
		function intervalFunction() {
			var result = ajaxCurrentTime();
			ajaxcurrentdate = result.substring(result.indexOf('date_')+5,result.indexOf('time_'));
			ajaxcurrenttime = result.substring(result.indexOf('time_')+5,result.indexOf('end_'));
			//forRemoveBtnCases();
			//forBtnAjax();
		};
		function websocketInitialize() {
			var uri = "ws://${host}${pageContext.request.contextPath}/wsrvns"
			if(!window.websocket){
				window.websocket = new WebSocket(uri);			
				window.websocket.onopen = function(){};
				window.websocket.onclose = function(){};
				window.websocket.onerror = function(){};
				window.websocket.onmessage = function(e){
					forRemoveBtnCases();
					forBtnAjax();
				};
			};
		};
		function websocketSend() {
			if(window.websocket) {
				window.websocket.send('websocketQuery');
			};
		};
		function forOffdaysAjax() {
			$.ajax({
                url: "schedule/ajax_offdays",
                data:{
                	selecteddate:selecteddate
                },
                type:"post",
                success:function(response){
                	offdaysResult(response);
                }
            });
		};
		function offdaysResult(str) {
			if(str!='') {
				var arr = str.trim().split('/');
				for(var i=0; i<arr.length-1; i++) {
					$('.td_designer_'+arr[i]).text('휴무');
					$('.td_designer_'+arr[i]).removeClass('td_new');
					$('.td_designer_'+arr[i]).off();
					//$('#new_designer_'+arr[i]).remove();
				};
			};
		};
		function forNewAjax() {
			$.ajax({
                url: "schedule/ajax_new",
                data:{
                	whatday_str:selecteddate.substring(0,10),
                	customer_str:${sessionScope.loginno},
                	designer:$('#new_designer').val(),
                	design:$('#new_design').val(),
                	starttime:$('#new_starttime').val(),
                	force:0
                },
                type:"post",
                success:function(response){
                	if(response=='1') {
	                	//forBtnAjax();
	                	websocketSend();
	                	$('.panel-info').addClass('hidden');
	                	initNew();
                	} else {
                    	switch(response){
    					case '0': alert('DB 내부 에러입니다. 페이지 새로고침 후 다시 시도해주세요.'); break;
    					case '2': alert('영업 종료 시간을 넘어갑니다! 다른 시간에 예약해주세요.'); break;
    					case '3': alert('해당 시간에 이미 다른 예약이 있습니다!'); break;
    					case '4': alert('해당 디자이너가 휴무입니다!'); break;
    					default: alert('예외 에러입니다. 페이지 새로고침 후 다시 시도해주세요.'); break;
    					}
                	};
                },
                error:function() {
                	alert('DB 내부 에러입니다. 페이지 새로고침 후 다시 시도해주세요.');
                	window.location.reload();
                }
            });
		};
		function forDelAjax() {
			$.ajax({
                url: "schedule/ajax_del",
                data:{
                	no:$('#mod_no').val(),
                },
                type:"post",
                success:function(response){
                	//forBtnAjax();
                	websocketSend();
                	$('.panel-warning').addClass('hidden');
					initMod();
                }
            });
		};
		function forModAjax() {
			$.ajax({
                url: "schedule/ajax_mod",
                data:{
                	no:$('#mod_no').val(),
                	whatday_str:$('#mod_whatday').val(),
                	designer:$('#mod_designer').val(),
                	design:$('#mod_design').val(),
                	starttime:$('#mod_starttime').val(),
                	force:0
                },
                type:"post",
                success:function(response){
                	if(response=='1') {
	                	//forBtnAjax();
	                	websocketSend();
	                	$('.panel-warning').addClass('hidden');
	                	initMod();
                	} else {
                    	switch(response){
    					case '0': alert('DB 내부 에러입니다. 페이지 새로고침 후 다시 시도해주세요.'); break;
    					case '2': alert('영업 종료 시간을 넘어갑니다! 다른 시간에 예약해주세요.'); break;
    					case '3': alert('해당 시간에 이미 다른 예약이 있습니다!'); break;
    					case '4': alert('해당 디자이너가 휴무입니다!'); break;
    					default: alert('예외 에러입니다. 페이지 새로고침 후 다시 시도해주세요.'); break;
    					}
                	};
                },
                error:function() {
                	alert('DB 내부 에러입니다. 페이지 새로고침 후 다시 시도해주세요.');
                	window.location.reload();
                }
            });
		};
		function forGetAjax(no) {
			$.ajax({
                url: "schedule/ajax_get",
                data:{
                	no:no
                },
                type:"post",
                success:function(response){
                	ajaxResultToMod(response);
                }
            });
		};
		function initMod() {
			$('#mod_no').val('');
			$('.mod_designers').prop('selected',false);
			$('.mod_designs').prop('selected',false);
			$('#mod_customer_name').prop('disabled',true);
			$('#mod_customer_phone').prop('disabled',true);
			$('#mod_customer_gender').prop('disabled',true);
			$('#mod_whatday').val(selecteddate.substring(0,10));
		};
		function initNew() {
			$('.new_designs').prop('selected',false);
			$('#new_customer_name').prop('disabled',false);
			$('#new_customer_phone').prop('disabled',false);
			$('#new_customer_gender').prop('disabled',false);
		};
		function ajaxResultToMod(str) {
			initMod();
			var no = str.substring(str.indexOf('_no')+3,str.indexOf('_designer'));
			var designer = str.substring(str.indexOf('_designer')+9,str.indexOf('_menu'));
			var menu = str.substring(str.indexOf('_menu')+5,str.indexOf('_start'));
			var starttime = str.substring(str.indexOf('_start')+6,str.indexOf('_period'));
			var starttime_str
			if(starttime<1000) starttime_str = '0'+starttime;
			else starttime_str = starttime;
			var period = str.substring(str.indexOf('_period')+7,str.indexOf('_end'));
			var note;
			$('#mod_no').val(no);
			if(designer!=null) $('#mod_designer_'+designer).prop('selected',true);
			if(menu!=null) $('#mod_design_'+menu).prop('selected',true);
			$('#mod_starttime_'+starttime_str).prop('selected',true);
		};
		function tdToNew(str) {
			initNew();
			var designer = str.substring(str.indexOf('_')+1,str.indexOf('_',str.indexOf('_')+1));
			var starttime = str.substring(str.indexOf('_',str.indexOf(designer))+1,str.indexOf('_',str.indexOf(designer))+5);
			$('#new_designer_'+designer).prop('selected',true);
			$('#new_starttime_'+starttime).prop('selected',true);
		};
		function forRemoveBtnCases(){
			$('.btn-case').each(function(i, element){
				$(element).remove();
			});
		}
		function afterCalendarClick() {
			forOffdaysAjax();
			$('#calendar').slideUp('slow');
			totimetable = true;
			$('#selecteddatediv').html('<h4>'+selecteddate.substring(0,4)+'년 '+selecteddate.substring(5,7)+'월 '+selecteddate.substring(8,10)+'일 '+forTempDay(selecteddate.substring(11,12))+'요일</h4>');
			$('.fortimetable').fadeIn('slow',function(){
				$('.fortimetable').removeClass('hidden');
				forBtnAjax();
			});
			websocketInitialize();
		};
		function forCalendarClick() {
			$('#this-sun').on('click', function() {
				selecteddate=date_thissun;
				afterCalendarClick();
			});
			$('#this-mon').on('click', function() {
				selecteddate=date_thismon;
				afterCalendarClick();
			});
			$('#this-tue').on('click', function() {
				selecteddate=date_thistue;
				afterCalendarClick();
			});
			$('#this-wed').on('click', function() {
				selecteddate=date_thiswed;
				afterCalendarClick();
			});
			$('#this-thu').on('click', function() {
				selecteddate=date_thisthu;
				afterCalendarClick();
			});
			$('#this-fri').on('click', function() {
				selecteddate=date_thisfri;
				afterCalendarClick();
			});
			$('#this-sat').on('click', function() {
				selecteddate=date_thissat;
				afterCalendarClick();
			});
			$('#next-sun').on('click', function() {
				selecteddate=date_nextsun;
				afterCalendarClick();
			});
			$('#next-mon').on('click', function() {
				selecteddate=date_nextmon;
				afterCalendarClick();
			});
			$('#next-tue').on('click', function() {
				selecteddate=date_nexttue;
				afterCalendarClick();
			});
			$('#next-wed').on('click', function() {
				selecteddate=date_nextwed;
				afterCalendarClick();
			});
			$('#next-thu').on('click', function() {
				selecteddate=date_nextthu;
				afterCalendarClick();
			});
			$('#next-fri').on('click', function() {
				selecteddate=date_nextfri;
				afterCalendarClick();
			});
			$('#next-sat').on('click', function() {
				selecteddate=date_nextsat;
				afterCalendarClick();
			});
		};
		function forBtnCasesOnce() {
			$('.btn-case').each(function(i, element){
				var id = $(this).attr('id');
				if(id.substring(id.indexOf('_t')+2,id.indexOf('_t')+3)==1) {
					$(element).addClass('btn-success');
// 					if($(element).hasClass('myrsv')) {
// 						$(element).on('click',function(){
// 							$('.panel-info').addClass('hidden');
// 							initNew();
// 							$('.panel-warning').removeClass('hidden');
// 							$('html, body').animate({scrollTop: $('.panel-warning').offset().top}, 500);
// 							forGetAjax(id.substring(id.indexOf('_n')+2,id.indexOf('_d')));
// 						});
// 					};
				} else {
					$(element).addClass('btn-warning');
					if($(element).hasClass('myrsv')) {
						$(element).addClass('canpointer');
						$(element).on('click',function(){
							$('.panel-info').addClass('hidden');
							initNew();
							$('.panel-warning').removeClass('hidden');
							$('html, body').animate({scrollTop: $('.panel-warning').offset().top}, 500);
							forGetAjax(id.substring(id.indexOf('_n')+2,id.indexOf('_d')));
						});
					};
				};
				if($(element).hasClass('modplz')) {
					$(element).addClass('btn-danger');
					$(element).removeClass('btn-sucess');
					$(element).removeClass('btn-warning');
				};
			});
			forBtnCases();
		};
		function forBtnCases() {
			$('.btn-case').each(function(i, element){
				var id = $(this).attr('id');
				var starttime = id.substring(id.indexOf('_s')+2,id.indexOf('_s')+6);
				var period = id.substring(id.indexOf('_p')+2,id.indexOf('_p')+3);
				var designer = id.substring(id.indexOf('_d')+2,id.indexOf('_s'));
				try {
					$(element).css('top',$('#td_'+designer+'_'+starttime).offset().top);
					$(element).css('left',$('#td_'+designer+'_'+starttime).offset().left);
					$(element).css('width',$('#td_'+designer+'_'+starttime).width()+3);
				} catch(e) {
					$(element).css('top',$('#td_z_'+starttime).offset().top);
					$(element).css('left',$('#td_z_'+starttime).offset().left);
					$(element).css('width',$('#td_z_'+starttime).width()+3);
				}
				$(element).css('height',70*period);
			});
		};
		function ajaxCurrentTime() {
			var result;
			$.ajax({
                url: "schedule/ajax_time",
                type:"post",
                async: false,
                success:function(response){
                	result = response;
                }
            });
			return result;
		};
		function isEndDay() {
			nextday = nextday + 1;
			if(next==false) {
				if(nextday>${currentdate.endday}) {
					nextday = 1;
					next = true;
				}
			}
		};
		function forWhatDay() {
			if(next==true) {
				if(nextmonth==1) {
					if(nextday<10) {
						return nextyear+'-0'+nextmonth+'-0'+nextday;
					} else {
						return nextyear+'-0'+nextmonth+'-'+nextday;
					}
				} else {
					if(nextmonth<10) {
						if(nextday<10) {
							return thisyear+'-0'+nextmonth+'-0'+nextday;
						} else {
							return thisyear+'-0'+nextmonth+'-'+nextday;
						}
					} else {
						if(nextday<10) {
							return thisyear+'-'+nextmonth+'-0'+nextday;
						} else {
							return thisyear+'-'+nextmonth+'-'+nextday;
						}
					}
				}
			} else {
				if(thismonth<10) {
					if(nextday<10) {
						return thisyear+'-0'+thismonth+'-0'+nextday;
					} else {
						return thisyear+'-0'+thismonth+'-'+nextday;
					}
				} else {
					if(nextday<10) {
						return thisyear+'-'+thismonth+'-0'+nextday;
					} else {
						return thisyear+'-'+thismonth+'-'+nextday;
					}
				}
			};
		};
		function forTempDay(str) {
			var result;
			switch(str) {
				case '1': result='일'; break;
				case '2': result='월'; break;
				case '3': result='화'; break;
				case '4': result='수'; break;
				case '5': result='목'; break;
				case '6': result='금'; break;
				case '7': result='토'; break;
			}
			return result;
		};
		function setVarDate(btn) {
			switch($(btn).attr('id')) {
				case 'this-mon': date_thismon = forWhatDay()+'-2'; break;
				case 'this-tue': date_thistue = forWhatDay()+'-3'; break;
				case 'this-wed': date_thiswed = forWhatDay()+'-4'; break;
				case 'this-thu': date_thisthu = forWhatDay()+'-5'; break;
				case 'this-fri': date_thisfri = forWhatDay()+'-6'; break;
				case 'this-sat': date_thissat = forWhatDay()+'-7'; break;
				case 'next-sun': date_nextsun = forWhatDay()+'-1'; break;
				case 'next-mon': date_nextmon = forWhatDay()+'-2'; break;
				case 'next-tue': date_nexttue = forWhatDay()+'-3'; break;
				case 'next-wed': date_nextwed = forWhatDay()+'-4'; break;
				case 'next-thu': date_nextthu = forWhatDay()+'-5'; break;
				case 'next-fri': date_nextfri = forWhatDay()+'-6'; break;
				case 'next-sat': date_nextsat = forWhatDay()+'-7'; break;
			};
		}
		function firstSet() {
			$('.fortimetable').hide();
			if (nextmonth = 13) nextmonth = 1;
			nextday = ${currentdate.date};
			switch(${currentdate.day}) {
				case 1:	$('#this-sun').text(${currentdate.date}+'(오늘)'); $('#this-sun').addClass('today'); date_thissun=forWhatDay()+'-'+${currentdate.day}; break;
				case 2:	$('#this-mon').text(${currentdate.date}+'(오늘)'); $('#this-mon').addClass('today'); date_thismon=forWhatDay()+'-'+${currentdate.day}; break;
				case 3:	$('#this-tue').text(${currentdate.date}+'(오늘)'); $('#this-tue').addClass('today'); date_thistue=forWhatDay()+'-'+${currentdate.day}; break;
				case 4:	$('#this-wed').text(${currentdate.date}+'(오늘)'); $('#this-wed').addClass('today'); date_thiswed=forWhatDay()+'-'+${currentdate.day}; break;
				case 5:	$('#this-thu').text(${currentdate.date}+'(오늘)'); $('#this-thu').addClass('today'); date_thisthu=forWhatDay()+'-'+${currentdate.day}; break;
				case 6:	$('#this-fri').text(${currentdate.date}+'(오늘)'); $('#this-fri').addClass('today'); date_thisfri=forWhatDay()+'-'+${currentdate.day}; break;
				case 7:	$('#this-sat').text(${currentdate.date}+'(오늘)'); $('#this-sat').addClass('today'); date_thissat=forWhatDay()+'-'+${currentdate.day}; break;
			};
			$('.today').prop('disabled',false);
			var thisweeks = $('.today').parent().next().find('.btn');
			while(thisweeks.hasClass('thisweek')) {
				isEndDay();
				if(nextday==1) {
					thisweeks.text(nextmonth+'월 '+nextday+'일');					
				} else {
					thisweeks.text(nextday);
				}
				setVarDate(thisweeks);
				thisweeks.prop('disabled',false);
				thisweeks = thisweeks.parent().next().find('.btn');
			}
			var nextweeks = $('#next-sun');
			while(nextweeks.hasClass('nextweek')) {
				isEndDay();
				if(nextday==1) {
					nextweeks.text(nextmonth+'월 '+nextday+'일');					
				} else {
					nextweeks.text(nextday);
				}
				setVarDate(nextweeks);
				nextweeks.prop('disabled',false);
				nextweeks = nextweeks.parent().next().find('.btn');
			}
			
			//if($('.today').parent().prev().find('.btn').hasClass('.thisweek')) {
			//	$(this).text('으아아');
			//};
// 			console.log($('.today').parent().next().find('.btn').attr('id'));
			
		};
	</script>
</head>
<body>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="container-fluid">
		<div class="col-md-offset-2 col-md-8 text-center font-nbgb font-white font-2rem">
			<h1>
				예약하기
			</h1>
		</div>
		<div class="col-12 empty-row"></div>
		<div class="col-12 empty-row"></div>
		<div class="col-md-offset-2 col-md-8" id="selecteddatediv">
			<h4>${currentdate.year}년 ${currentdate.month}월 ${currentdate.date}일
				<c:choose>
					<c:when test="${currentdate.day==1}">일요일</c:when>
					<c:when test="${currentdate.day==2}">월요일</c:when>
					<c:when test="${currentdate.day==3}">화요일</c:when>
					<c:when test="${currentdate.day==4}">수요일</c:when>
					<c:when test="${currentdate.day==5}">목요일</c:when>
					<c:when test="${currentdate.day==6}">금요일</c:when>
					<c:otherwise>토요일</c:otherwise>
				</c:choose>
			</h4>
		</div>
		<div class="col-md-offset-2 col-md-8 font-2rem text-right fortimetable">
			<a href="schedule" class="btn btn-primary">날짜 선택으로 돌아가기</a>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-offset-2 col-md-8 font-2rem" id="calendar">
			<div class="btn-group btn-group-justified font-nbgb" role="group">
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-primary btn-sm font-sun nohover">일(SUN)</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-primary btn-sm nohover">월(MON)</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-primary btn-sm nohover">화(TUE)</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-primary btn-sm nohover">수(WED)</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-primary btn-sm nohover">목(THU)</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-primary btn-sm nohover">금(FRI)</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-primary btn-sm font-sat nohover">토(SAT)</button>
				</div>
			</div>
			<div class="btn-group btn-group-justified font-nbgl" id="thisweekgroup" role="group">
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default btn-lg thisweek" id="this-sun" disabled>-</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default btn-lg thisweek" id="this-mon" disabled>-</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default btn-lg thisweek" id="this-tue" disabled>-</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default btn-lg thisweek" id="this-wed" disabled>-</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default btn-lg thisweek" id="this-thu" disabled>-</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default btn-lg thisweek" id="this-fri" disabled>-</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default btn-lg thisweek" id="this-sat" disabled>-</button>
				</div>
			</div>
			<div class="btn-group btn-group-justified font-nbgl" id="nextweekgroup" role="group">
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default btn-lg nextweek" id="next-sun" disabled>-</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default btn-lg nextweek" id="next-mon" disabled>-</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default btn-lg nextweek" id="next-tue" disabled>-</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default btn-lg nextweek" id="next-wed" disabled>-</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default btn-lg nextweek" id="next-thu" disabled>-</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default btn-lg nextweek" id="next-fri" disabled>-</button>
				</div>
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-default btn-lg nextweek" id="next-sat" disabled>-</button>
				</div>
			</div>
		</div>
		<div class="nopadding font-1.5rem hidden" id="helpth">
			<c:if test="${not empty designerlist}">
				<table class="table table-striped table-bordered table-hover table-condensed nomargin">
					<thead>
						<tr class="font-nbgb">
							<th style="width: 130px;">시간</th>
							<c:forEach var="designer" items="${designerlist}">
								<th>${designer.name} D</th>
							</c:forEach>
							<th class="th_z">!</th>
						</tr>
					</thead>
				</table>
			</c:if>
		</div>
		<div class="col-md-offset-2 col-md-8 font-1.5rem fortimetable" id="timetable">
			<c:if test="${not empty designerlist}">
				<table class="table table-striped table-bordered table-hover table-condensed" id="tabletimetable">
					<thead>
						<tr class="font-nbgb">
							<th style="width: 130px;">시간</th>
							<c:forEach var="designer" items="${designerlist}">
								<th id="th_${designer.no}">${designer.name} D</th>
							</c:forEach>
							<th class="th_z" id="th_z">!</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach begin="1000" end="2150" step="50" var="i">
							<tr class="font-nbgl">
								<td class="td_time text-center">
									<c:choose>
										<c:when test="${i==1000}">오전 10:00-10:30</c:when>
										<c:when test="${i==1050}">오전 10:30-11:00</c:when>
										<c:when test="${i==1100}">오전 11:00-11:30</c:when>
										<c:when test="${i==1150}">오전 11:30-12:00</c:when>
										<c:when test="${i==1200}">오후 12:00-12:30</c:when>
										<c:when test="${i==1250}">오후 12:30-01:00</c:when>
										<c:when test="${i==1300}">오후 01:00-01:30</c:when>
										<c:when test="${i==1350}">오후 01:30-02:00</c:when>
										<c:when test="${i==1400}">오후 02:00-02:30</c:when>
										<c:when test="${i==1450}">오후 02:30-03:00</c:when>
										<c:when test="${i==1500}">오후 03:00-03:30</c:when>
										<c:when test="${i==1550}">오후 03:30-04:00</c:when>
										<c:when test="${i==1600}">오후 04:00-04:30</c:when>
										<c:when test="${i==1650}">오후 04:30-05:00</c:when>
										<c:when test="${i==1700}">오후 05:00-05:30</c:when>
										<c:when test="${i==1750}">오후 05:30-06:00</c:when>
										<c:when test="${i==1800}">오후 06:00-06:30</c:when>
										<c:when test="${i==1850}">오후 06:30-07:00</c:when>
										<c:when test="${i==1900}">오후 07:00-07:30</c:when>
										<c:when test="${i==1950}">오후 07:30-08:00</c:when>
										<c:when test="${i==2000}">오후 08:00-08:30</c:when>
										<c:when test="${i==2050}">오후 08:30-09:00</c:when>
										<c:when test="${i==2100}">오후 09:00-09:30</c:when>
										<c:when test="${i==2150}">오후 09:30-10:00</c:when>
									</c:choose>
								</td>
								<%-- <c:if test="${i==1000}">
									<td rowspan="24">
										-
									</td>
								</c:if> --%>
								<c:forEach var="designer" items="${designerlist}">
									<td class="td_new td_designer_${designer.no}" id="td_${designer.no}_${i}"></td>
								</c:forEach>
									<td id="td_z_${i}"></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
		<div class="col-md-offset-2 col-md-8 font-nbgl fortimetable hidden">
			시간표 안내 -  
			<button class="btn btn-warning cursordefault">예약된 항목</button>
			<button class="btn btn-success cursordefault">시술 중인 항목</button>
		</div>
		<div class="col-md-12 empty-row fortimetable hidden"></div>
		<div class="col-md-offset-2 col-md-4 font-nbgl fortimetable hidden">
			<div class="panel panel-info hidden">
				<div class="panel-heading">
					<h3 class="panel-title">신규 예약</h3>
				</div>
				<div class="panel-body">
					<div class="form-group">
						<label for="new_designer">디자이너</label>
						<select class="form-control" name="designer" id="new_designer">
							<c:forEach var="designer" items="${designerlist}">
								<option value="${designer.no}" class="new_designers" id="new_designer_${designer.no}">${designer.name}</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label for="">시술(메뉴)</label>
						<select class="form-control" name="design" id="new_design">
							<c:forEach var="design" items="${designlist}">
								<option value="${design.no}" class="new_designs" id="new_design_${design.no}">
									${design.name}
									<c:choose>
										<c:when test="${design.maxtime_hour>0 && design.maxtime_min==0}">
											(${design.maxtime_hour}시간)
										</c:when>
										<c:when test="${design.maxtime_hour>0 && design.maxtime_min>0}">
											(${design.maxtime_hour}시간 ${design.maxtime_min}분)
										</c:when>
										<c:otherwise>
											(${design.maxtime_min}분)
										</c:otherwise>
									</c:choose>
								</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label for="new_starttime">시작시간 선택</label>
						<select class="form-control" name="starttime" id="new_starttime">
							<option id="new_starttime_1000" value="1000">오전 10:00</option>
							<option id="new_starttime_1050" value="1050">오전 10:30</option>
							<option id="new_starttime_1100" value="1100">오전 11:00</option>
							<option id="new_starttime_1150" value="1150">오전 11:30</option>
							<option id="new_starttime_1200" value="1200">오후 12:00</option>
							<option id="new_starttime_1250" value="1250">오후 12:30</option>
							<option id="new_starttime_1300" value="1300">오후 01:00</option>
							<option id="new_starttime_1350" value="1350">오후 01:30</option>
							<option id="new_starttime_1400" value="1400">오후 02:00</option>
							<option id="new_starttime_1450" value="1450">오후 02:30</option>
							<option id="new_starttime_1500" value="1500">오후 03:00</option>
							<option id="new_starttime_1550" value="1550">오후 03:30</option>
							<option id="new_starttime_1600" value="1600">오후 04:00</option>
							<option id="new_starttime_1650" value="1650">오후 04:30</option>
							<option id="new_starttime_1700" value="1700">오후 05:00</option>
							<option id="new_starttime_1750" value="1750">오후 05:30</option>
							<option id="new_starttime_1800" value="1800">오후 06:00</option>
							<option id="new_starttime_1850" value="1850">오후 06:30</option>
							<option id="new_starttime_1900" value="1900">오후 07:00</option>
							<option id="new_starttime_1950" value="1950">오후 07:30</option>
							<option id="new_starttime_2000" value="2000">오후 08:00</option>
							<option id="new_starttime_2050" value="2050">오후 08:30</option>
							<option id="new_starttime_2100" value="2100">오후 09:00</option>
							<option id="new_starttime_2150" value="2150">오후 09:30</option>
						</select>
					</div>
					<div class="form-group text-right">
						<button class="btn btn-info" id="new_btn-ok">등록</button>
						<button class="btn btn-default" id="new_btn-cancel">취소</button>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-4 font-nbgl fortimetable hidden">
			<div class="panel panel-warning hidden">
				<div class="panel-heading">
					<h3 class="panel-title">기존 예약 수정</h3>
				</div>
				<div class="panel-body">
						<input type="hidden" name="mod_no" id="mod_no">
					<div class="form-group">
						<label for="mod_designer">디자이너</label>
						<select class="form-control" name="designer" id="mod_designer">
							<c:forEach var="designer" items="${designerlist}">
								<option value="${designer.no}" class="mod_designers" id="mod_designer_${designer.no}">${designer.name}</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label for="mod_design">시술(메뉴)</label>
						<select class="form-control" name="design" id="mod_design">
							<c:forEach var="design" items="${designlist}">
								<option value="${design.no}" class="mod_designs" id="mod_design_${design.no}">
									${design.name}
									<c:choose>
										<c:when test="${design.maxtime_hour>0 && design.maxtime_min==0}">
											(${design.maxtime_hour}시간)
										</c:when>
										<c:when test="${design.maxtime_hour>0 && design.maxtime_min>0}">
											(${design.maxtime_hour}시간 ${design.maxtime_min}분)
										</c:when>
										<c:otherwise>
											(${design.maxtime_min}분)
										</c:otherwise>
									</c:choose>
								</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label for="mod_whatday">날짜</label>
						<input type="date" class="form-control" name="whatday_str" id="mod_whatday" required>
						<input type="hidden" name="precheck_whatday" id="precheck_whatday" value="Y">
					</div>
					<div class="form-group">
						<label for="mod_starttime">시작시간 선택</label>
						<select class="form-control" name="starttime" id="mod_starttime">
							<option id="mod_starttime_1000" value="1000">오전 10:00</option>
							<option id="mod_starttime_1050" value="1050">오전 10:30</option>
							<option id="mod_starttime_1100" value="1100">오전 11:00</option>
							<option id="mod_starttime_1150" value="1150">오전 11:30</option>
							<option id="mod_starttime_1200" value="1200">오후 12:00</option>
							<option id="mod_starttime_1250" value="1250">오후 12:30</option>
							<option id="mod_starttime_1300" value="1300">오후 01:00</option>
							<option id="mod_starttime_1350" value="1350">오후 01:30</option>
							<option id="mod_starttime_1400" value="1400">오후 02:00</option>
							<option id="mod_starttime_1450" value="1450">오후 02:30</option>
							<option id="mod_starttime_1500" value="1500">오후 03:00</option>
							<option id="mod_starttime_1550" value="1550">오후 03:30</option>
							<option id="mod_starttime_1600" value="1600">오후 04:00</option>
							<option id="mod_starttime_1650" value="1650">오후 04:30</option>
							<option id="mod_starttime_1700" value="1700">오후 05:00</option>
							<option id="mod_starttime_1750" value="1750">오후 05:30</option>
							<option id="mod_starttime_1800" value="1800">오후 06:00</option>
							<option id="mod_starttime_1850" value="1850">오후 06:30</option>
							<option id="mod_starttime_1900" value="1900">오후 07:00</option>
							<option id="mod_starttime_1950" value="1950">오후 07:30</option>
							<option id="mod_starttime_2000" value="2000">오후 08:00</option>
							<option id="mod_starttime_2050" value="2050">오후 08:30</option>
							<option id="mod_starttime_2100" value="2100">오후 09:00</option>
							<option id="mod_starttime_2150" value="2150">오후 09:30</option>
						</select>
					</div>
					<div class="form-group text-right">
						<button class="btn btn-warning" id="mod_btn-ok">수정</button>
						<button class="btn btn-danger" id="mod_btn-del">삭제</button>
						<button class="btn btn-default" id="mod_btn-cancel">취소</button>
					</div>
				</div>
			</div>
		</div>
		<div class="" id="divforajax">
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