<%--
  Class Name : EgovRoleUpdate.jsp
  Description : EgovRoleUpdate 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01    lee.m.j          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 lee.m.j
    since    : 2009.02.01
--%>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<title>배너이미지 배열</title>
<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

<!-- 세로배열 -->
<c:if test="${resultType == 'vertical'}">
<table summary="배너이미지 세로배열">
    <caption>배너이미지 배열</caption>
    <c:forEach var="fileVO" items="${fileList}" varStatus="status">
      <tr>
       <td>
            <a href="<c:out value="${fileVO.linkUrl}"/>" target="_blank"  title="새 창으로 이동" ><img alt="배너 이미지" src='<c:url value='/cmm/fms/getImage.do'/>?atchFileId=<c:out value="${fileVO.bannerImageFile}"/>&fileSn=0'></a>
       </td>
      </tr>
    </c:forEach>
</table>
</c:if>

<!-- 가로배열 -->
<c:if test="${resultType == 'horizontal'}">
<table width="700" height="90" style="table-layout:fixed;" summary="배너이미지 가로배열">
  <caption>배너이미지 배열</caption>
  <tr>
    <c:forEach var="fileVO" items="${fileList}" varStatus="status">
       <td>
            <a href="<c:out value="${fileVO.linkUrl}"/>" target="_blank"  title="새 창으로 이동" ><img alt="배너 이미지" src='<c:url value='/cmm/fms/getImage.do'/>?atchFileId=<c:out value="${fileVO.bannerImageFile}"/>&fileSn=0'></a>
       </td>
    </c:forEach>
  </tr>
</table>
</c:if>