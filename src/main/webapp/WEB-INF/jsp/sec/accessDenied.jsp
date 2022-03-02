<%--
  Class Name : accessDenied.jsp
  Description : 접근불가 메시지 화면(system)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01    lee.m.j          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 lee.m.j
    since    : 2009.02.01
--%>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.web.access.AccessDeniedHandlerImpl" %> 

<%@ page isErrorPage="true"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ page import="org.egovframe.rte.fdl.string.EgovStringUtil" %>
<%@ page import="java.lang.String" %>
<%
  	boolean authenticateFail = false;
  	if(request.getAttribute("authenticateFail")!=null && !request.getAttribute("authenticateFail").toString().equals("")){
		authenticateFail = true;
  	}
  
  	boolean authFail = false;
  	if(request.getAttribute("authFail")!=null && !request.getAttribute("authFail").toString().equals("")){
		authFail = true;
  	}  

  	String target = EgovStringUtil.null2void((String)request.getAttribute("target"));
  	target = target.equals("") ? "_top" : target;  	
%>
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
	
<title>Access is denied</title>
<script type="text/javascript">
function fncGoAfterErrorPage(){
	if('<%=authenticateFail%>' == 'true' ){
		document.dummyForm.target="_top";
		document.dummyForm.action = "<c:url value='/empaftererrorpage.do'/>";
		document.dummyForm.submit();
	}else if('<%=authFail%>' == 'true'){
		document.dummyForm.target="<%=target%>";
		document.dummyForm.action = "<c:url value='/empaftererrorpage.do'/>";
		document.dummyForm.submit();
	}else{
		//document.location.href = "<c:url value='/empaftererrorpage.do'/>";
		history.back(-2);
	}
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
<!-- 				<p>수행중 오류가 발생하였습니다.</p> -->
<!-- 				<p>알 수 없는 오류가 발생하였습니다.</p> -->
				<%= request.getAttribute(org.springframework.security.web.WebAttributes.AUTHENTICATION_EXCEPTION) %>
				<%	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
					if (auth != null) { 
						
					}
				%>
				<p>${exception.message}</p>
                <br>
                <a href="#LINK" class="btn btn_blue_46 w_130" onclick="javascript:fncGoAfterErrorPage(); return false;">이전페이지</a>
            </div>
        </div>
    </div>
    
</body>
</html>