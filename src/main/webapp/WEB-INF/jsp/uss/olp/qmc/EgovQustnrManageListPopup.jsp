<%--
  Class Name : EgovQustnrManageList.jsp
  Description : 설문관리 목록 페이지
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.09
   
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images/egovframework/com/uss/olp/qmc/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>설문관리 목록 팝업</title>
<base target="_self">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javascript" src="<c:url value='/js/showModalDialogCallee.js'/>" ></script>
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/uss/olp/qmc/EgovQustnrManageListPopup.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_QustnrManage(){
	var vFrom = document.listForm;

	vFrom.action = "<c:url value='/uss/olp/qmc/EgovQustnrManageListPopup.do'/>";
	vFrom.submit();
}
/* ********************************************************
 * 선택 처리 함수
 ******************************************************** */
function fn_egov_open_QustnrManage(qestnrId, qestnrTmplatId, cnt){
	getDialogArguments();
	var opener = window.dialogArguments;

	opener.document.getElementById("qestnrId").value = qestnrId;
	opener.document.getElementById("qestnrTmplatId").value = qestnrTmplatId;
	opener.document.getElementById("qestnrCn").value = document.getElementById("iptText_"+ cnt).value;
	window.returnValue=true;
	window.close();
	
}
</script>
</head>
<body>
	<!-- 자바스크립트 경고 태그  -->
	<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
        <div id="middle_content">
            <div id="content_field"><!--contents start-->
            
	       <form name="listForm" id="listForm" action="<c:url value='/uss/olp/qmc/EgovQustnrManageListPopup.do'/>" method="post">

            <!-- sub title start -->
            <div><h3>설문관리 목록(팝업)</h3></div>
            <!-- sub title end -->

            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >
                    <select name="searchCondition" title="검색조건 선택">
			           <option value=''>--선택하세요--</option>
			           <option value='QUSTNR_SJ' <c:if test="${searchCondition == 'QUSTNR_SJ'}">selected</c:if>>설문제목</option>
			           <option value='QUSTNR_PURPS' <c:if test="${searchCondition == 'QUSTNR_PURPS'}">selected</c:if>>설문목적</option>
			       </select>
			       <input name="searchKeyword" type="text" size="30" value="${searchKeyword}" title="검색어 입력" maxlength="35" >
                </div>
                    <div class="search_buttons">
                         <input type="submit" value="<spring:message code="button.inquire" />" onclick="fn_egov_search_QustnrManage(); return false;" />
                    </div>
                </div> 
            </div>
            <!-- search area end -->
            
            <!-- search result start -->
            <div class="search_result_div">
            
                <table width="98%" cellpadding="0" cellspacing="0" summary="SUMMARY">
                <caption>약관목록</caption>
                
                <colgroup>
                    <col width="35px" > 
                    <col >
                    <col width="150px" >
                    <col width="80px" >
                    <col width="80px" >
                    <col width="30px" >
                </colgroup>
                
                <thead>
                <tr>      
                    <th>번호</th>
				    <th>설문제목</th>
				    <th>설문기간</th>
				    <th>등록자</th>   
				    <th>등록일자</th>   
				    <th>선택</th>
                </tr>
                </thead>
                
                <tbody>
                <c:if test="${fn:length(resultList) == 0}">
                <tr> 
                      <td class="lt_text3" colspan="6">
                          <spring:message code="common.nodata.msg" />
                      </td>
                </tr>                                                 
                </c:if>
				<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
				<tr>
				    <td class="lt_text3" >${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}</td>
				    <td class="lt_text3L" >
				     <div class="divDotText" style="width:330px; border:solid 0px;"><a href="#LINK" onClick="fn_egov_open_QustnrManage('${resultInfo.qestnrId}', '${resultInfo.qestnrTmplatId}', '${status.count}')">${resultInfo.qestnrSj}</a></div>
				     </td>
				    <td class="lt_text3" >${resultInfo.qestnrBeginDe}~${resultInfo.qestnrEndDe}</td>
				    <td class="lt_text3" >${resultInfo.frstRegisterNm}</td>
				    <td class="lt_text3" >${fn:substring(resultInfo.frstRegisterPnttm, 0, 10)}</td>
				    <td class="lt_text3">
				    <a href="#LINK" onClick="fn_egov_open_QustnrManage('${resultInfo.qestnrId}', '${resultInfo.qestnrTmplatId}', '${status.count}')">선택</a>
				    <input name="iptText_${status.count}" id="iptText_${status.count}" type="hidden" value="${resultInfo.qestnrSj}">
				    </td> 
				</tr>
				</c:forEach>
                </tbody>
                  
                </table>
            </div>
            <!-- search result end -->
            
			<div id="paging_div">
				<ul class="paging_align">
					<ui:pagination paginationInfo = "${paginationInfo}"
							type="image"
							jsFunction="linkPage"
							/></ul>
			</div>
			
			<input name="qestnrId" type="hidden" value="">
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
        </form>
        
        </div>
    </div>
</body>
</html>