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
<c:set var="ImgUrl" value="/images_old/egovframework/uss/sam/ipm/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>샘플 포털 > 포털시스템관리 > 사용자관리 > 개인정보보호관리</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

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

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <!-- header start -->
	    <c:import url="/sym/mms/EgovHeader.do" />
	    <!-- //header end -->

        <div class="container">
            <div class="sub_layout">
                <div class="sub_in">
                    <div class="layout">
                        <!-- Left menu -->
	                    <c:import url="/sym/mms/EgovMenuLeft.do" />
	                    <!--// Left menu -->
        
                        <div class="content_wrap">
                            <div id="contents" class="content">
                                 <!-- Location -->
                                <div class="location">
                                    <ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li><a href="">포털시스템관리</a></li>
                                        <li><a href="">사용자관리</a></li>
                                        <li>개인정보보호관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

                                <h1 class="tit_1">포털시스템관리</h1>

                                <p class="txt_1">포털시스템의 사용자 및 권한에 대한 제반사항을 관리합니다.</p>

                                <h2 class="tit_2">사용자관리</h2>

                                <h3 class="tit_3">개인정보보호관리</h3>

                                <!-- 검색조건 -->
                                <div class="condition2">
                                	
                                	<form name="listForm" action="<c:url value='/uss/sam/ipm/listIndvdlInfoPolicy.do'/>" method="post">
                                	
                                    <label class="item f_select" for="sel1">
                                        <select id="sel1" name="searchCondition" title="검색조건 선택">
                                            <option value=''>선택하세요</option>
                                            <option value='INDVDL_INFO_POLICY_NM' <c:if test="${searchCondition == 'INDVDL_INFO_POLICY_NM'}">selected</c:if>>개인정보보호정책명</option>
                                            <option value='INDVDL_INFO_POLICY_CN' <c:if test="${searchCondition == 'INDVDL_INFO_POLICY_CN'}">selected</c:if>>개인정보보호정책설명</option>
                                        </select>
                                    </label>

                                    <span class="item f_search">
                                        <input id="searchKeyword" class="f_input w_500" name="searchKeyword" title="검색어" type="text" maxlength="35" value="${searchVO.searchKeyword}">
                                        <button class="btn" type="submit" onclick="fn_egov_search_IndvdlInfoPolicy(); return false;"><spring:message code="button.inquire" /></button><!-- 조회 -->
                                    </span>

                                    <a href="<c:url value='/uss/sam/ipm/registIndvdlInfoPolicy.do'/>" class="item btn btn_blue_46 w_100"><spring:message code="button.create" /></a><!-- 등록 -->
                                    
                                    <input name="indvdlInfoId" type="hidden" value="">
									<input name="searchMode" type="hidden" value="">
									<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
									</form>
                                    
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="SUMMARY">
                                    	<caption>개인정보보호정책 목록</caption>
                                        <colgroup>
                                            <col style="width: 70px;">
                                            <col style="width: 120px;">
                                            <col style="width: auto;">
                                            <col style="width: 120px;">
                                            <col style="width: 120px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">순번</th>
                                                <th scope="col">동의여부</th>
                                                <th scope="col">개인정보보호정책명</th>
                                                <th scope="col">등록자</th>
                                                <th scope="col">등록일자</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	
                                        	<c:if test="${fn:length(resultList) == 0}">
                                        	<tr>
                                        		<td colspan="5"><spring:message code="common.nodata.msg" /></td>
                                        	</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                                            <tr>
                                                <td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
                                                <td>
                                                	<c:if test="${resultInfo.indvdlInfoYn == 'Y'}">예</c:if>
                                                	<c:if test="${resultInfo.indvdlInfoYn == 'N'}">아니오</c:if>
                                                </td>
                                                <td>
                                                	<form name="subForm" method="post" action="<c:url value='/uss/sam/ipm/detailIndvdlInfoPolicy.do'/>">
                                                		<c:out value="${resultInfo.indvdlInfoNm}"/>
                                                		<a href="#LINK" class="btn btn_blue_30 w_80" onclick="fn_egov_detail_IndvdlInfoPolicy('<c:out value="${resultInfo.indvdlInfoId}"/>');">상세보기</a>
                                                		<input name="indvdlInfoId" type="hidden" value="${resultInfo.indvdlInfoId}">
                                                		<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
                                                	</form>
                                                </td>
                                                <td><c:out value="${resultInfo.frstRegisterNm}"/></td>
                                                <td><c:out value="${fn:substring(resultInfo.frstRegistPnttm, 0, 10)}"/></td>
                                            </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                </div>

								<!-- 페이징 -->
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo = "${paginationInfo}" type="renew" jsFunction="linkPage" />
                                        </ul>
                                    </div>
                                </div>
                                <!-- // 페이징 끝 -->
                                <!--// 게시판 -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- footer 시작 -->
	    <c:import url="/sym/mms/EgovFooter.do" />
	    <!-- //footer 끝 -->
    </div>
    
</body>
</html>