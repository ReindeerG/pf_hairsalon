<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>와이헤어</title>
<script src="${pageContext.request.contextPath}/js/jquery_1.11.1.js"></script>
<script>
	var isMobile;
	$(document).ready(function() {
		isMobile = isMobileF();
		if(isMobile) {
			
		} else {
			window.location.replace('${pageContext.request.contextPath}/pc/home');
		}
	});
	function isMobileF() {
		try{ document.createEvent("TouchEvent"); return true; }
		catch(e){ return false; }
	};
</script>
</html>