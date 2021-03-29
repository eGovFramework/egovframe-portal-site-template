<%--
  Class Name : EgovCcmZipSearchPopup.jsp
  Description : EgovCcmZipSearchPopup 화면(system)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.01   이중호              최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이중호
    since    : 2009.04.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>우편번호 찾기</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/zip.css'/>"/>
<link rel="stylesheet" href="<c:url value='/css/default.css'/>" type="text/css" >
</head>
<body>
<form name="pForm" action="<c:url value='sym/cmm/EgovCcmZipSearchPopup.do'/>">
<input type="submit" id="invisible" class="invisible"/>
<input type="hidden" name="init" value="">
</form>
<!-- IE
<iframe name="ifcal" src="<c:url value='/sym/cmm/EgovCcmZipSearchList.do'/>" style="width:500px; height:325px;" frameborder=0></iframe>
-->
<!-- FIREFOX -->
<iframe name="ifcal" title="우편번호 찾기" src="<c:url value='/sym/cmm/EgovCcmZipSearchList.do'/>" style="width:560px; height:340px;" frameborder="0"></iframe>
</body>
</html>