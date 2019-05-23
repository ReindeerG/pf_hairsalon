<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="sidebar.jsp"/>
<head>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/summernote/summernote.css">
	<style>
		div {
/*     		border: red dotted 1px; */
		}
		.nomargin {
			margin: 0px !important;
		}
		.container {
			min-width: 800px;
		}
	</style>
	<script src="${pageContext.request.contextPath}/summernote/summernote.js"></script>
	<script src="${pageContext.request.contextPath}/summernote/lang/summernote-ko-KR.js"></script>
	<script>
		var panelfooter;
		$(document).ready(function() {
			panelfooter = $('#forpanerlfooter').detach();
			sidemenuHilight();
			$('#summernote').summernote({
				lang: 'ko-KR',
				height: 600,
				minHeight: null,
				maxHeight: null,
				disableResizeEditor: true,
				toolbar: [
					['font',['fontsize']],
					['style',['bold','italic','underline','strikethrough','superscript','subscript','clear']],
					['color',['forecolor','backcolor']],
					['para',['hr','paragraph','style','ol','ul','height']],
					['work',['undo','redo']],
					['insert',['table','picture','video','link']],
				],
				disableDragAndDrop: true,
				callbacks: {
					onImageUpload: function(files) {
						insertImage(files[0]);
					}
				}
			});
			$('.note-statusbar').hide();
			$('.note-statusbar').addClass('hidden');
			$('#summernote').summernote('code', '${boardDto.content}');
			firstSet();
		});
		function sidemenuHilight() {
			$('#menu_hairart').addClass('active');
		};
		function firstSet() {
			$('.note-status-output').replaceWith(forpanelfooter);
			$('form').on('submit',function(e){
				e.preventDefault();
				if ($('#summernote').summernote('isEmpty')) {
					alert('내용을 입력해주세요!');
					return;
				};
				this.submit();
			});
			$('#delattach1').on('click',function(){
				var result = confirm('이 첨부파일을 삭제하시겠습니까?');
				if(result) {
					delAttach(1);
				}
			});
			$('#delattach2').on('click',function(){
				var result = confirm('이 첨부파일을 삭제하시겠습니까?');
				if(result) {
					delAttach(2);
				}
			});
		};
		function insertImage(file) {
			data = new FormData();
			data.append('uploadFile',file);
			data.append('board_no',$('#boardno').val());
			$.ajax({
				data:data,
				type:'POST',
				url:'ajax_insertimage',
				cache:false,
				contentType:false,
				enctype: 'multipart/form-data',
				processData:false,
				success:function(response){
					$('#summernote').summernote('editor.insertImage','${pageContext.request.contextPath}/uploadimages/'+response);
				}
			});
		};
		function delAttach(file_no) {
			$.ajax({
				data:{
					no:${boardDto.no},
					file_no:file_no
				},
				type:'POST',
				url:'mod/ajax_delattach',
				success:function(response){
					if(response=='0') return;
					else if(response=='1') {
						$('#divattach1').html('');
						$('#divattach1').addClass('hidden');
					} else if(response=='2') {
						$('#divattach2').html('');
						$('#divattach2').addClass('hidden');
					} else if(response=='3') {
						$('#divattach1').html($('#divattach2').html());
						$('#divattach2').html('');
						$('#divattach2').addClass('hidden');
					}
				}
			});
		};
	</script>
</head>
<body>
	<div class="admin_body container">
		<div class="col-md-12 font-nbgb">
			<h1><i class="fas fa-edit"></i> 헤어아트(게시판) 관리</h1>
		</div>
		<div class="col-md-12 empty-row"></div>
		<div class="col-md-offset-2 col-md-8 font-nbgl font-1.5rem">
			<form method="POST" enctype="multipart/form-data">
				<div class="form-group">
					<label class="nomargin" for="title">제목</label>
					<input type="text" class="form-control" name="title" id="title" maxlength="30" required value="${boardDto.title}">
				</div>
				<textarea id="summernote" name="content"></textarea>
			</form>
		</div>
		<div class="col-md-12 empty-row"></div>
	</div>
	<div class="panel-footer container-fluid" id="forpanelfooter">
		<div class="col-md-4 form-group">
			<label class="nomargin" for="file1">첨부파일1</label>
			<input type="file" class="form-control btn btn-primary" name="file1" id="file1">
			<c:if test="${boardDto.file1_size>0}">
				<div id="divattach1">
					기존파일: ${boardDto.file1_name} (${boardDto.file1_size_str}) <button type="button" class="btn btn-danger btn-sm" id="delattach1">삭제</button>
				</div>
			</c:if>
		</div>
		<div class="col-md-4">
		</div>
		<div class="col-md-4 text-right">
			<input type="hidden" name="no" id="boardno" value="${boardDto.no}">
			<button type="submit" class="btn btn-warning">완료</button>
			<a href="list" class="btn btn-default">목록으로</a>
		</div>
		<div class="col-md-12"></div>
		<div class="col-md-4 form-group">
			<label class="nomargin" for="file2">첨부파일2</label>
			<input type="file" class="form-control btn btn-primary" name="file2" id="file2">
			<c:if test="${boardDto.file2_size>0}">
				<div id="divattach2">
					기존파일: ${boardDto.file2_name} (${boardDto.file2_size_str}) <button type="button" class="btn btn-danger btn-sm" id="delattach2">삭제</button>
				</div>
			</c:if>
		</div>
		<div class="col-md-4">
		</div>
		<div class="col-md-12"></div>
		
	</div>
</body>
