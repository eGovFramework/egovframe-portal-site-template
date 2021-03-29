<%--
  Class Name : EgovStplatListInqire.jsp
  Description : EgovStplatListInqire 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01   박정규          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 박정규
    since    : 2009.02.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>약관목록 조회</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javaScript">

/*********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_initl_stplatlist(){
    // 첫 입력란에 포커스..
    document.getElementById("searchKeyword").focus();
}

/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	document.getElementById("pageIndex").value = pageNo;
	document.getElementById("StplatListForm").action = "<c:url value='/uss/sam/stp/StplatListInqire.do'/>";
	document.getElementById("StplatListForm").submit();
}

/*********************************************************
 * 조회 처리 함수
 ******************************************************** */
function fn_egov_search_stplatcn(){
	document.getElementById("pageIndex").value = 1;
	document.getElementById("StplatListForm").submit();
}

/*********************************************************
 * 등록 처리 함수
 ******************************************************** */
function fn_egov_regist_stplatcn(){
	document.getElementById("StplatListForm").action = "<c:url value='/uss/sam/stp/StplatCnRegistView.do'/>";
	document.getElementById("StplatListForm").submit();    
}

/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_inquire_stplatdetail(useStplatId) {        

    // 사이트 키값(siteId) 셋팅.
    document.getElementById("useStplatId").value = useStplatId;    
    document.getElementById("StplatListForm").action = "<c:url value='/uss/sam/stp/StplatDetailInqire.do'/>";
    document.getElementById("StplatListForm").submit();    
                      
}
</script>
</head>
<body onload="fn_egov_initl_stplatlist();">
<!-- 자바스크립트 경고 태그  -->
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
                            <li><strong>이용약관관리</strong></li>
                        </ul>
                    </div>
            </div>
            
            <div id="content_field"><!--contents start-->
            <form id="StplatListForm" name="StplatListForm" action="<c:url value='/uss/sam/stp/StplatListInqire.do'/>" method="post">
            <input type="submit" id="invisible" class="invisible"/>
            <!-- sub title start -->
            <div><h2>약관목록 조회</h2></div>
            <!-- sub title end -->
            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >                   
                        <select id="searchCondition" name="searchCondition" title="검색조건 선택">
                           <option selected value=''>--선택하세요--</option>
                           <option value="useStplatNm"  <c:if test="${searchVO.searchCondition == 'useStplatNm'}">selected="selected"</c:if> >이용약관명</option>
                           <option value="useStplatCn"  <c:if test="${searchVO.searchCondition == 'useStplatCn'}">selected="selected"</c:if> >이용약관내용</option>              
                        </select>
                        <input id="searchKeyword" name="searchKeyword" type="text" size="35" title="검색어 입력" class="inputText" value='<c:out value="${searchVO.searchKeyword}"/>'  maxlength="35" >
                </div>
                        <div class="search_buttons">
                            <a href="<c:url value='/uss/sam/stp/StplatListInqire.do'/>" onclick="fn_egov_search_stplatcn(); return false;"><spring:message code="button.inquire" /></a>
                            <a href="<c:url value='/uss/sam/stp/StplatCnRegistView.do'/>"><spring:message code="button.create" /></a>
                        </div>
                </div> 
            </div>
            <!-- search area end -->
            
            <!-- search result start -->
            <div class="search_result_div">
            
                <table width="98%" cellpadding="0" cellspacing="0" summary="이 표는 약관내용 대상 정보를 제공하며, 이용약관명, 이용약관내용, 등록일자 내용 정보로 구성되어 있습니다 .">
                <caption>약관목록</caption>
                
                <colgroup>
                    <col width="5%" > 
                    <col width="20%" >  
                    <col width="60%" >
                    <col width="10%" >
                </colgroup>
                
                <thead>
                <tr>      
                    <th>순번</th>        
                    <th>이용약관명</th>    
                    <th>이용약관내용</th>        
                    <th>등록일자</th>               
                </tr>
                </thead>
                
                <tbody>
                <c:if test="${fn:length(resultList) == 0}">
                <tr> 
                      <td class="lt_text3" colspan="4">
                          <spring:message code="common.nodata.msg" />
                      </td>
                </tr>                                                 
                </c:if>
                <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                <tr style="cursor:hand;" onClick="fn_egov_inquire_stplatdetail('<c:out value="${resultInfo.useStplatId}"/>')">
                        <td class="lt_text3"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
                        <td class="lt_text3"><c:out value="${resultInfo.useStplatNm}"/></td>                    
                        <td class="lt_text3"><c:out value='${fn:substring(resultInfo.useStplatCn, 0, 40)}'/></td>        
                        <td class="lt_text3"><c:out value='${fn:substring(resultInfo.lastUpdusrPnttm, 0, 10)}'/></td>            
                </tr>   
                </c:forEach>
                </tbody>
                  
                </table>
            </div>
            <!-- search result end -->

            <!-- pagination start -->
            <div id="paging_div">
                    <ul class="paging_align">
                    <ui:pagination paginationInfo = "${paginationInfo}"
                            type="image"
                            jsFunction="fn_egov_select_linkPage"
                            /></ul>
            </div>
            <!-- pagination end -->

            <input id="useStplatId" name="useStplatId" type="hidden" value="">
            <input id="pageIndex" name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
            </form>
     
            </div><!-- contents end -->
            
            
        </div><!-- middle_content end -->
    </div><!--  bodywrap end -->
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div>
<!-- //wrap end -->

</body>
</html>