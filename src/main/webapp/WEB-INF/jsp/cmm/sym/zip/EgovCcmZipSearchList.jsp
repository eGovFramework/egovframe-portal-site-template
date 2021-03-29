<%--
  Class Name : EgovCcmZipSearchList.jsp
  Description : EgovCcmZipSearchList 화면(system)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.01   이중호              최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 
    since    : 
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/zip.css'/>" />
<link rel="stylesheet" href="<c:url value='/css/default.css'/>" type="text/css" >
<title>우편번호 찾기</title>
<script type="text/javascript" src="<c:url value='/js/showModalDialogCallee.js'/>" ></script>
<script type="text/javaScript" language="JavaScript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_pageview(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/sym/cmm/EgovCcmZipSearchList.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
function fn_egov_search_Zip(){
	document.listForm.pageIndex.value = 1;
   	document.listForm.submit();
}
/* ********************************************************
 * 결과 우편번호,주소 반환 
 ******************************************************** */
function fn_egov_return_Zip(zip,addr){
	var retVal   = new Object();
	var sZip     = zip;
	var vZip     = zip.substring(0,3)+"-"+zip.substring(3,6);
	var sAddr    = addr.replace("/^\s+|\s+$/g","");
	retVal.sZip  = sZip;
	retVal.vZip  = vZip;
	retVal.sAddr = sAddr;
	
    setReturnValue(retVal);
	   
	parent.window.returnValue = retVal;
	parent.window.close();
}	
//-->
</script>
</head>

<body>
<a name="noscript" id="noscript">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
</a>
<form name="listForm" action="<c:url value='/sym/cmm/EgovCcmZipSearchList.do'/>" method="post">
    <input name="searchCondition" type="hidden" size="35" value="4" /> 
<table style="width:550px" cellpadding="8" class="table-search" border="0">
 <tr>
  <td style="width:35%" class="title_left">
		<img src="<c:url value='/images/tit_icon.gif'/>" width="16" height="16" hspace="3" align="middle" alt="제목"/> 우편번호 찾기
  </td>
  <td style="width:60%" class="title_right">
    	동명을 입력하시오. <input name="searchKeyword" type="text" size="20" value="${searchVO.searchKeyword}"  maxlength="20" title="동명"/> 
  </td>
  <th style="width:5%">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><img src="<c:url value='/images/bu2_left.gif'/>" alt="조회" width="8" height="20" /></td>
      <td class="btnBackground" nowrap="nowrap"><input type="submit" value="조회" onclick="javascript:fn_egov_search_Zip();" class="btnNew" style="height:20px;width:26px;padding:0px 0px 0px 0px;" ></td>
      <td><img src="<c:url value='/images/bu2_right.gif'/>" alt="조회" width="8" height="20" /></td>
      <td width="10"></td>
    </tr>
   </table>
  </th>  
 </tr>
</table>

<table style="width:550px" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>

<table style="width:550px" cellpadding="0" class="table-line" border="0" summary="우편번호 건색 결과를 알려주는 테이블입니다.우편번호 및 주소 내용을 담고 있습니다">
<thead>
<tr>  
	<th class="title" style="width:25%" scope="col" nowrap="nowrap">우편번호</th>
	<th class="title" style="width:75%" scope="col" nowrap="nowrap">주소</th>
</tr>
</thead>    
<tbody>
<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
<tr style="cursor:pointer;cursor:hand;" onclick="javascript:fn_egov_return_Zip( '${resultInfo.zip}', '${resultInfo.ctprvnNm} ${resultInfo.signguNm} ${resultInfo.emdNm} ${resultInfo.liBuldNm}');">
	<td class="lt_text3" nowrap="nowrap" ><c:out value='${fn:substring(resultInfo.zip, 0,3)}'/>-<c:out value='${fn:substring(resultInfo.zip, 3,6)}'/></td>
	<td class="lt_text" nowrap="nowrap" >${resultInfo.ctprvnNm} ${resultInfo.signguNm} ${resultInfo.emdNm} ${resultInfo.liBuldNm} ${resultInfo.lnbrDongHo}</td>
</tr>   
</c:forEach>
    	
</tbody>  
</table>

<table style="width:550px" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>

<div id="paging_div">
	<ul class="paging_align">
		<ui:pagination paginationInfo = "${paginationInfo}"
				type="image"
				jsFunction="fn_egov_pageview"
				/></ul>
</div>

<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>

</form>
</body>
</html>


