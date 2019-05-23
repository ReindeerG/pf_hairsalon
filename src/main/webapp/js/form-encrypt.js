$(document).ready(function(){
// 		폼이 전송될 때 자동으로 password 항목이 암호화 되도록 구현
	$("form").on("submit", function(e){
		//전송 중지
		e.preventDefault();
		
		//비밀번호 항목들을 전부 암호화하여 재설정
		$(this).find("input[type=password]").each(function(i, element){
			var hash = CryptoJS.SHA512($(element).val());
			$(element).val(hash);
		});
		
		//폼 전송
		this.submit();
	});
});