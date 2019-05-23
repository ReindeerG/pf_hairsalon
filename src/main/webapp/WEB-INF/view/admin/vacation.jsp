<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="sidebar.jsp"/>
<head>
	<style>
		table th{
			text-align: center;
		}
		.nomargin {
			margin: 0px !important;
		}
		input[type=date] {
			width: 160px;
		}
		#th-no {
			width: 60px !important;
		}
		#th-date {
			width: 180px !important;
		}
		#th-btns {
			width: 110px !important;
		}
	</style>
	<script>
		var modline;
		$(document).ready(function() {
			modline = $('#modline').detach();
			sidemenuHilight();
			firstSet();
		});
		function sidemenuHilight() {
			$('#menu_designer').addClass('active');
		};
		function firstSet() {
			$('#btn-new').on('click',function(){
				$('.removable').addClass('hidden');
				$('#newline').removeClass('hidden');
				$('#form-new').on('submit',function(e){
					e.preventDefault();
					if($('#new_vac_str').val()=='') {
						alert('올바른 날짜를 입력해주세요!');
						return;
					}
					if($('#new_vac_str').val()!='') {
						var thislength = $('#new_vac_str').val().length;
						if(thislength!=10) {
							alert('올바른 날짜를 입력해주세요!');
							$('#mod_vac_str').val(null);
							return;
						}
					}
					var isexist = ajaxIsExistNew();
					if(isexist=='N') this.submit();
					if(isexist=='Y') {
						alert('이미 해당날짜에 휴가 일정을 계획하고 있습니다!');
						return;
					}
				});
			});
			$('.btn-info').each(function(i,element){
				$(element).on('click',function(){
					$('.removable').addClass('hidden');
					var no = $(element).parent().parent().find('.section-no').text().trim();
					var vac = $(element).parent().parent().find('.section-vac').text().trim();
					var memo = $(element).parent().parent().find('.section-memo').text().trim();
					$(element).parent().parent().replaceWith(modline);
					$('#mod_no').text(no);
					$('#mod_no_val').val(no);
					$('#mod_vac_str').val(vac);
					$('#mod_memo').val(memo);
					$('#form-mod').on('submit',function(e){
						e.preventDefault();
						if($('#mod_vac_str').val()=='') {
							alert('올바른 날짜를 입력해주세요!');
							return;
						}
						if($('#mod_vac_str').val()!='') {
							var thislength = $('#mod_vac_str').val().length;
							if(thislength!=10) {
								alert('올바른 날짜를 입력해주세요!');
								$('#mod_vac_str').val(null);
								return;
							}
						}
						var isexist = ajaxIsExistMod();
						if(isexist=='N') this.submit();
						if(isexist=='Y') {
							alert('이미 해당날짜에 휴가 일정을 계획하고 있습니다!');
							return;
						}
					});
				});
			});
			$('.btn-del').each(function(i,element){
				$(element).on('click',function(){
					var no = $(element).parent().parent().find('.section-no').text().trim();
					var designer = ${designerDto.no};
					var result = confirm('이 일정을 삭제합니까?');
					if(result) {
						window.location.replace('vacation/del?no='+no+'&designer='+designer);
					}
				});
			});
		};
		function ajaxIsExistMod() {
			var result;
			$.ajax({
                url: "vacation/ajax_isexist",
                data:{
                	no:$('#mod_no').text().trim(),
                	designer:${designerDto.no},
                	vac_str:$('#mod_vac_str').val()
                },
                type:"post",
                async: false,
                success:function(response){
                	result = response;
                }
            });
			return result;
		};
		function ajaxIsExistNew() {
			var result;
			$.ajax({
                url: "vacation/ajax_isexist",
                data:{
                	no:0,
                	designer:${designerDto.no},
                	vac_str:$('#new_vac_str').val()
                },
                type:"post",
                async: false,
                success:function(response){
                	result = response;
                }
            });
			return result;
		};
	</script>
</head>
<body>
	<div class="admin_body container">
		<div class="col-md-12 font-nbgb">
			<h1><i class="fas fa-cloud-moon"></i> 디자이너 휴가 일정 - ${designerDto.name}</h1>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-offset-3 col-md-6 font-nbgl font-1.5rem">
			<table class="table table-bordered table-striped table-hover nomargin">
				<thead>
					<tr>
						<th id="th-no">번호</th>
						<th id="th-date">날짜</th>
						<th>메모</th>
						<th id="th-btns">관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="vacationDto" items="${list}">
						<tr>
							<td class="section-no text-center">
								${vacationDto.no}
							</td>
							<td class="section-vac text-center">
								${vacationDto.vac_str}
							</td>
							<td class="section-memo">
								${vacationDto.memo}
							</td>
							<td class="text-center">
								<button class="btn btn-info btn-sm removable">수정</button>
								<button class="btn btn-danger btn-sm btn-del removable">삭제</button>
							</td>
						</tr>
					</c:forEach>
					<tr class="text-center" id="modline">
						<form action="vacation/mod" method="POST" id="form-mod">
							<td id="mod_no">
							</td>
							<td>
								<input type="hidden" name="no" id="mod_no_val">
								<input type="hidden" name="designer" value="${designerDto.no}">
								<input type="date" class="form-control" name="vac_str" id="mod_vac_str" required>
							</td>
							<td>
								<input type="text" class="form-control" name="memo" id="mod_memo" maxlength="100">
							</td>
							<td>
								<button type="submit" class="btn btn-success btn-sm">완료</button>
								<a href="" class="btn btn-primary btn-sm">취소</a>
							</td>
						</form>
					</tr>
					<tr class="text-center hidden" id="newline">
						<form action="vacation/new" method="POST" id="form-new">
							<td>
								-
								<input type="hidden" name="designer" value="${designerDto.no}">
							</td>
							<td>
								<input type="date" class="form-control" name="vac_str" id="new_vac_str" required>
							</td>
							<td>
								<input type="text" class="form-control" name="memo" maxlength="100">
							</td>
							<td>
								<button type="submit" class="btn btn-success btn-sm">완료</button>
								<a href="" class="btn btn-primary btn-sm">취소</a>
							</td>
						</form>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-md-offset-3 col-md-6 font-nbgl font-1.5rem">
			(지난 일정은 자동으로 삭제됩니다.)
		</div>
		<div class="col-md-offset-3 col-md-6 font-nbgl font-1.5rem text-right">
			<button class="btn btn-warning removable" id="btn-new">신규 일정</button>
			<a href="designer" class="btn btn-primary removable">돌아가기</a>
		</div>
	</div>
</body>
