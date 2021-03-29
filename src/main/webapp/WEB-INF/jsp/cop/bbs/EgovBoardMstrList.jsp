<%--
  Class Name : EgovBoardMstrList.jsp
  Description : 게시판 속성 목록화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.12   이삼섭          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.12
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link href="<c:url value='/'/>css/default.css" rel="stylesheet" type="text/css" >

<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_brdMstr('1');
		}
	}
	
	function fn_egov_insert_addBrdMstr(){	
		document.frm.action = "<c:url value='/cop/bbs/addBBSMaster.do'/>";
		document.frm.submit();
	}
	
	function fn_egov_select_brdMstr(pageNo){
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/cop/bbs/SelectBBSMasterInfs.do'/>";
		document.frm.submit();	
	}
	
	function fn_egov_inqire_brdMstr(bbsId){
		document.frm.bbsId.value = bbsId;
		document.frm.action = "<c:url value='/cop/bbs/SelectBBSMasterInf.do'/>";
		document.frm.submit();			
	}
</script>
<title>게시판 목록조회</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
	
	A:link    { color: #000000; text-decoration:none; }
	A:visited { color: #000000; text-decoration:none; }
	A:active  { color: #000000; text-decoration:none; }
	A:hover   { color: #fa2e2e; text-decoration:none; }	
</style>

</head>
<body>
<!-- login status start -->
<div id="login_area"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncTborder" /></div>
<!-- //login status end -->
<!-- wrap start -->
<div id="wrap"> 
    <!-- header start -->
    <div id="subheader"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>  
    <!-- //header end -->
    <!--  타이틀 이미지 시작 -->
    <div id="title_img_div"><img src="<c:url value='/'/>images/title_image/img_title05.gif" alt="" /></div>
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
                            <li>포털서비스관리</li>
                            <li>&gt;</li>
                            <li>서비스관리</li>
                            <li>&gt;</li>
                            <li><strong>게시판생성관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
			<form name="frm" action="<c:url value='/cop/bbs/SelectBBSMasterInfs.do'/>" method="post">
			<input type="hidden" name="bbsId">
			<input type="hidden" name="trgetId">
			
			<!-- sub title start -->
            <div><h2>게시판 정보</h2></div>
            <!-- sub title end -->

            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >
                <label for="searchCnd" >검색유형선택</label>
                    <select name="searchCnd" class="select" title="검색유형선력">
	                    <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >게시판명</option>
	                    <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >게시판유형</option>   
	                </select>
	                <label for="searchWrd" >검색어</label>
	                <input title="검색값입력" name="searchWrd" type="text" size="35" value='<c:out value="${searchVO.searchWrd}" />' maxlength="35" onkeypress="press(event);">
                </div>
                    <div class="search_buttons">
	                    <input type="submit" value="<spring:message code="button.inquire" />" onclick="fn_egov_select_brdMstr('1'); return false;" />
	                    <a href="<c:url value='/cop/bbs/addBBSMaster.do'/>" onclick="fn_egov_insert_addBrdMstr(); return false;"><spring:message code="button.create"/></a>
                    </div>
                </div> 
            </div>
            <!-- search area end -->
            
	       </form>
	       
	       <!-- search result start -->
            <div class="search_result_div">
            
                <table width="98%" cellpadding="0" cellspacing="0" summary="번호,게시판명,게시판유형,게시판속성,생성일,사용여부  목록입니다">
                <caption>게시판목록</caption>
                
                <colgroup>
                    <col width="10%" > 
                    <col width="44%" >
                    <col width="10%" >
                    <col width="10%" >
                    <col width="15%" >
                    <col width="8%" >
                </colgroup>
                
                <thead>
                <tr>      
                    <th>번호</th>
			        <th>게시판명</th>
			        <th>게시판유형</th>
			        <th>게시판속성</th>
			        <th>생성일</th>   
			        <th>사용여부</th>          
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
                <c:forEach var="result" items="${resultList}" varStatus="status">
		        <tr>
		            <td class="lt_text3" nowrap="nowrap"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>          
		            <td class="lt_text3" nowrap="nowrap">
		                <a href="<c:url value='/cop/bbs/SelectBBSMasterInf.do'/>?bbsId=<c:out value='${result.bbsId}'/>">
		                    <c:out value="${result.bbsNm}"/>
		                </a>
		            </td>
		            <td class="lt_text3" nowrap="nowrap"><c:out value="${result.bbsTyCodeNm}"/></td>
		            <td class="lt_text3" nowrap="nowrap"><c:out value="${result.bbsAttrbCodeNm}"/></td>
		            <td class="lt_text3" nowrap="nowrap"><c:out value="${result.frstRegisterPnttm}"/></td>
		            <td class="lt_text3" nowrap="nowrap">
		                <c:if test="${result.useAt == 'N'}"><spring:message code="button.notUsed" /></c:if>
		                <c:if test="${result.useAt == 'Y'}"><spring:message code="button.use" /></c:if>
		            </td>  
		        </tr>
		        </c:forEach>
                </tbody>
                  
                </table>
            </div>
            <!-- search result end -->
            
			<div id="paging_div"><ul class="paging_align">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_brdMstr" />
				</ul>
			</div>
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>

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