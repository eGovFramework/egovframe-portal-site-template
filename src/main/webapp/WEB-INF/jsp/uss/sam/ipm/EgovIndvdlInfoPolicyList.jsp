<%--
  Class Name : EgovIndvdlInfoPolicyList.jsp
  Description : 개인정보보호정책 목록 페이지
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
<c:set var="ImgUrl" value="/images/egovframework/uss/sam/ipm/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>개인정보보호정책 목록</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/css/default.css'/>" type="text/css" >
<script type="text/javaScript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/uss/sam/ipm/listIndvdlInfoPolicy.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_IndvdlInfoPolicy(indvdlInfoId){
	var vFrom = document.listForm; 
	vFrom.indvdlInfoId.value = indvdlInfoId; 
	vFrom.action = "<c:url value='/uss/sam/ipm/detailIndvdlInfoPolicy.do'/>"; 
	vFrom.submit();
}

/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_IndvdlInfoPolicy(){
	var vFrom = document.listForm;

	vFrom.action = "<c:url value='/uss/sam/ipm/listIndvdlInfoPolicy.do'/>";
	vFrom.submit();
}
//-->
</script>
</head>
<body>
<!-- noscript 테그 -->
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

<!-- login status start -->
<div id="login_area"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncTborder" /></div>
<!-- //login status end -->
<!-- wrap start -->
<div id="wrap"> 
    <!-- header start -->
    <div id="subheader"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>  
    <!-- //header end -->
    <!--  타이틀 이미지 시작 -->
    <div id="title_img_div"><img src="<c:url value='/'/>images/title_image/img_title06.gif" alt="" /></div>
    <!--  //타이틀 이미지 끝 -->
    <div id="bodywrap">
        <div id="leftmenu_div"><c:import url="/sym/mms/EgovMainMenuLeft.do" /></div>
        <div id="middle_content">
            <!-- 현재위치 네비게이션 시작 -->
            <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>포털시스템관리</li>
                            <li>&gt;</li>
                            <li>사용자관리</li>
                            <li>&gt;</li>
                            <li><strong>개인정보보호관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
            <form name="listForm" action="<c:url value='/uss/sam/ipm/listIndvdlInfoPolicy.do'/>" method="post">
            <input type="submit" id="invisible" class="invisible"/>

            <!-- sub title start -->
            <div><h2>개인정보보호정책 목록</h2></div>
            <!-- sub title end -->
            
            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >                   
                        <select name="searchCondition" title="검색조건 선택">
                            <option value=''>--선택하세요--</option>
                            <option value='INDVDL_INFO_POLICY_NM' <c:if test="${searchCondition == 'INDVDL_INFO_POLICY_NM'}">selected</c:if>>개인정보보호정책명</option>
                            <option value='INDVDL_INFO_POLICY_CN' <c:if test="${searchCondition == 'INDVDL_INFO_POLICY_CN'}">selected</c:if>>개인정보보호정책설명</option>
                        </select>
                        <input id="searchKeyword" name="searchKeyword" title="검색어" type="text" size="30" maxlength="35" value="${searchVO.searchKeyword}">
                </div>
                        <div class="search_buttons">
                            <a href="<c:url value='/uss/sam/ipm/listIndvdlInfoPolicy.do'/>" onclick="fn_egov_search_IndvdlInfoPolicy(); return false;"><spring:message code="button.inquire" /></a>
                            <a href="<c:url value='/uss/sam/ipm/registIndvdlInfoPolicy.do'/>"><spring:message code="button.create" /></a>
                        </div>
                </div> 
            </div>
            <!-- search area end -->
            
			<input name="indvdlInfoId" type="hidden" value="">
			<input name="searchMode" type="hidden" value="">
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
			</form>

            <!-- search result start -->
            <div class="search_result_div">
            
                <table width="98%" cellpadding="0" cellspacing="0" summary="SUMMARY">
                <caption>개인정보보호정책 목록</caption>
                
                <colgroup>
                    <col width="35px" >
                    <col width="60px" >
                    <col >
                    <col width="70px" >
                    <col width="70px" >
                </colgroup>
                
                <thead>
                <tr>
                    <th>순번</th>
                    <th>동의여부</th>
                    <th>개인정보보호정책명</th>
                    <th>등록자</th>
                    <th>등록일자</th>
                </tr>
                </thead>
                
                <tbody>
                <c:if test="${fn:length(resultList) == 0}">
                <tr> 
                      <td class="lt_text3" colspan="5">
                          <spring:message code="common.nodata.msg" />
                      </td>
                </tr>                                                 
                </c:if>
                <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                <tr>
                        <td class="lt_text3"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
                        <td class="lt_text3">
                            <c:if test="${resultInfo.indvdlInfoYn == 'Y'}">예</c:if>
                            <c:if test="${resultInfo.indvdlInfoYn == 'N'}">아니오</c:if>
                        </td>                    
                        <td class="lt_text3">
                            <form name="subForm" method="post" action="<c:url value='/uss/sam/ipm/detailIndvdlInfoPolicy.do'/>">
                            <input name="indvdlInfoId" type="hidden" value="${resultInfo.indvdlInfoId}">
                            <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
                            <c:out value="${resultInfo.indvdlInfoNm}"/>
                               <input type="submit" value="상세보기" onclick="fn_egov_detail_IndvdlInfoPolicy('<c:out value="${resultInfo.indvdlInfoId}"/>');">
                            </form>
                        </td> 
                        <td><c:out value="${resultInfo.frstRegisterNm}"/></td>
                        <td><c:out value="${fn:substring(resultInfo.frstRegisterPnttm, 0, 10)}"/></td>
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


            </div><!-- contents end -->
        </div>
    </div>
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div>
<!-- //wrap end -->

</body>
</html>