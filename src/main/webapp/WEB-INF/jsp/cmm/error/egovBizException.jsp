<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	
<title>eGovFrame 템플릿</title>

<script type="text/javascript">
	function fncGoAfterErrorPage() {
		history.back(-2);
	}
</script>

</head>

<body>

    <!-- skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <div class="error_page">
            <h1>Error</h1>
            <div class="inner">
<!--				<p>세션이 만료되었습니다.</p> -->
<!--				<p>데이터 처리 중 오류가 발생하였습니다.</p> -->
				<p>수행중 오류가 발생하였습니다.</p>
<!--				<p>알 수 없는 오류가 발생하였습니다.</p> -->
<!--				<p>오류발생알림화면<br>(허용되지 않는 요청을 하셨습니다.)</p> -->
                <br>
                <a href="javascript:fncGoAfterErrorPage();" class="btn btn_blue_46 w_130">이전페이지</a>
            </div>
        </div>
    </div>
    
</body>
</html>