<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/css/base.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/layout.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/component.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/page.css'/>">
	<script src="<c:url value='/js/jquery-1.11.2.min.js'/>"></script>
	<script src="<c:url value='/js/ui.js'/>"></script>
	<title>접근 권한 없음</title>
	<script type="text/javascript">
		function fncGoAfterErrorPage() {
			history.back();
		}
	</script>
</head>
<body>
	<a href="#contents" class="skip_navi">본문 바로가기</a>
	<div class="wrap">
		<div class="error_page">
			<h1>접근 권한 없음</h1>
			<div class="inner" id="contents">
				<c:choose>
					<c:when test="${not empty exception.message}">
						<p><c:out value="${exception.message}"/></p>
					</c:when>
					<c:otherwise>
						<p>요청하신 기능을 사용할 권한이 없습니다.</p>
					</c:otherwise>
				</c:choose>
				<br>
				<a href="javascript:fncGoAfterErrorPage();" class="btn btn_blue_46 w_130">이전페이지</a>
			</div>
		</div>
	</div>
</body>
</html>
