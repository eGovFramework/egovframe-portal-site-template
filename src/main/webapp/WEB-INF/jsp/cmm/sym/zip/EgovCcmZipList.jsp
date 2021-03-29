<%--
  Class Name : EgovCcmZipList.jsp
  Description : EgovCcmZipList 화면(system)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.01   이중호              최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스팀  이중호
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
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<title>우편번호 목록</title>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_pageview(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>";
    document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
function fn_egov_search_Zip(){
    sC = document.listForm.searchCondition.value;
    sK = document.listForm.searchKeyword.value; 
    if (sC == "1") {
        document.listForm.searchKeyword.value = sK.replace(/\-/, "");
    }
    document.listForm.pageIndex.value = 1;
    document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_Zip(){
    location.href = "<c:url value='/sym/ccm/zip/EgovCcmZipRegist.do'/>";
}
/* ********************************************************
 * 엑셀등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_ExcelZip(){
    location.href = "<c:url value='/sym/ccm/zip/EgovCcmExcelZipRegist.do'/>";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_modify_Zip(){
    location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_Zip(zip,sn){
    var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/sym/ccm/zip/EgovCcmZipDetail.do'/>";
    varForm.zip.value        = zip;
    varForm.sn.value         = sn;
    varForm.submit();
}
-->
</script>
</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->
<div id="wrap">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <div id="topnavi"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>        
    <!-- //header 끝 --> 
    <!-- container 시작 -->
    <div id="container">
        <!-- 좌측메뉴 시작 -->
        <div id="leftmenu"><c:import url="/sym/mms/EgovMainMenuLeft.do" /></div>
        <!-- //좌측메뉴 끝 -->
            <!-- 현재위치 네비게이션 시작 -->
            <div id="content">
            <form name="listForm" action="<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>" method="post">
            <input type="submit" id="invisible" class="invisible"/>
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>사용자관리</li>
                            <li>&gt;</li>
                            <li><strong>우편번호 목록</strong></li>
                        </ul>
                    </div>
                </div>

                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>우편번호 목록</strong></h2></div>
                        
                        <fieldset><legend>조건정보 영역</legend>    
                        <div class="sf_start">
                            <ul id="search_first_ul">
                                <li>
                                    <label for="search_select"></label>
    							    <select name="searchCondition" class="select" title="searchCondition">
							           <option selected value=''>--선택하세요--</option>
							           <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>><label for="searchKeyword">우편번호</label></option>
							           <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>><label for="searchKeyword">시도명</label></option>
							           <option value='3' <c:if test="${searchVO.searchCondition == '3'}">selected="selected"</c:if>><label for="searchKeyword">시군구명</label></option>
							           <option value='4' <c:if test="${searchVO.searchCondition == '4'}">selected="selected"</c:if>><label for="searchKeyword">읍면동명</label></option>
							           <option value='5' <c:if test="${searchVO.searchCondition == '5'}">selected="selected"</c:if>><label for="searchKeyword">리건물명</label></option>
							       </select>
                                </li>
                                <li>
                                    <input name="searchKeyword" type="text" size="35" value="${searchVO.searchKeyword}"  maxlength="35" id="searchKeyword">
                                </li>
                            </ul>
                            <ul id="search_second_ul">
                                <li>
                                    <div class="buttons" style="float:right;">
                                        <a href="#noscript" onclick="fn_egov_search_Zip(); return false;"><img src="<c:url value='/'/>images/img_search.gif" alt="search" />조회 </a>
                                        <a href="#noscript" onclick="fn_egov_regist_Zip(); return false;">등록</a>
                                        <a href="#noscript" onclick="fn_egov_regist_ExcelZip(); return false;">엑셀등록</a> 
                                    </div>                              
                                </li>
                            </ul>           
                        </div>          
                        </fieldset>
                </div>
                <!-- //검색 필드 박스 끝 -->
                <div id="page_info"><div id="page_info_align"></div></div>                    
                <!-- table add start -->
                <div class="default_tablestyle">
                    <table summary="우편번호와 주소를 출력하는 우편번호 목록 테이블이다." cellpadding="0" cellspacing="0">
                    <caption>공통코드 목록</caption>
                    <colgroup>
                    <col width="10%" >
                    <col width="20%" >  
                    <col width="70%" >
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col" class="f_field" nowrap="nowrap">순번</th>
                        <th scope="col" nowrap="nowrap">우편번호</th>
                        <th scope="col" nowrap="nowrap">주소</th>
                    </tr>
                    </thead>
                    <tbody>                 

                    <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                    <!-- loop 시작 -->                                
						<tr style="cursor:pointer;cursor:hand;" onclick="javascript:fn_egov_detail_Zip('${resultInfo.zip}','${resultInfo.sn}');">
						    <td class="lt_text3" nowrap="nowrap"><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
						    <td class="lt_text3" nowrap="nowrap"><c:out value='${fn:substring(resultInfo.zip, 0,3)}'/>-<c:out value='${fn:substring(resultInfo.zip, 3,6)}'/></td>
						    <td class="lt_text"  nowrap="nowrap">${resultInfo.ctprvnNm} ${resultInfo.signguNm} ${resultInfo.emdNm} ${resultInfo.liBuldNm} ${resultInfo.lnbrDongHo}</td>
						</tr>   
                    </c:forEach>     
                    <c:if test="${fn:length(resultList) == 0}">
                        <tr> 
                            <td colspan=3>
                                <spring:message code="common.nodata.msg" />
                            </td>
                        </tr>                                              
                    </c:if>
                    </tbody>
                    </table>
                </div>

                <!-- 페이지 네비게이션 시작 -->
                <div id="paging_div">
                    <ul class="paging_align">
				        <ui:pagination paginationInfo = "${paginationInfo}"
				                type="image"
				                jsFunction="fn_egov_pageview"
				                />
                    </ul>
                </div>                          
                <!-- //페이지 네비게이션 끝 -->  
                
                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
            </form>

			<form name="Form" method="post">
			    <input type=hidden name="zip">
			    <input type=hidden name="sn">
			    <input type="submit" id="invisible" class="invisible"/>
			</form>

            </div>
            <!-- //content 끝 -->    
        </div>  
        <!-- //container 끝 -->
        <!-- footer 시작 -->
        <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
        <!-- //footer 끝 -->
    </div>
    <!-- //전체 레이어 끝 -->
 </body>
</html>