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
<%@ page import="egovframework.rte.fdl.string.EgovStringUtil" %>
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
<title>Access is denied</title>
<link rel="stylesheet" href="<c:url value='/css/admin.css'/>" type="text/css">
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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top"><br />
    <br />
    <br />
    <table width="600" border="0" cellpadding="0" cellspacing="0" background="er_images/blue_bg.jpg">
      <tr>
        <td align="center"><table width="100%" border="0" cellspacing="9" cellpadding="0">
          <tr>
            <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="center"><table width="520" border="0" cellspacing="2" cellpadding="2">
                  <tr>
                    <td width="74" rowspan="2" align="center"><img alt="오류메시지 표시" src="<c:url value='/images/danger.jpg'/>" width="74" height="74" /></td>
                    <td width="399" align="left" class="lt_text2">
                   <%= request.getAttribute(org.springframework.security.web.WebAttributes.AUTHENTICATION_EXCEPTION) %>
                    <%      Authentication auth = SecurityContextHolder.getContext().getAuthentication();
                            if (auth != null) { 
                          } %>
                    </td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="lt_text5">${exception.message}</td>
                  </tr>
                </table>
                  <table width="500" border="0" cellspacing="2" cellpadding="2">
                                  </table></td>
              </tr>
              <tr>
                <td><br />
                  <br /></td>
              </tr>
              <tr>
                <td align="center"><a href="#LINK" onclick="javascript:fncGoAfterErrorPage(); return false;"><img title="이전페이지로 이동" src="<c:url value='/images/go_history.jpg'/>" width="90" height="29" border="0" /></a></td>
              </tr>
            </table>
              <br /></td>
          </tr>
        </table></td>
      </tr>
    </table>
    </td>
  </tr>
</table>
</body>
</html>
