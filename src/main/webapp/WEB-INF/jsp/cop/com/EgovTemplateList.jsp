<%--
  Class Name : EgovTemplateList.jsp
  Description : 템플릿 목록화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.18   이삼섭          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.18
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
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_tmplatInfo('1');
		}
	}

	function fn_egov_insert_addTmplatInfo(){	
		document.frm.action = "<c:url value='/cop/com/addTemplateInf.do'/>";
		document.frm.submit();
	}
	
	function fn_egov_select_tmplatInfo(pageNo){
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/cop/com/selectTemplateInfs.do'/>";
		document.frm.submit();	
	}
	
	function fn_egov_inqire_tmplatInfor(tmplatId){
		document.frm.tmplatId.value = tmplatId;
		document.frm.action = "<c:url value='/cop/com/selectTemplateInf.do'/>";
		document.frm.submit();			
	}
</script>
<title>템플릿 목록</title>

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
                            <li><strong>게시판템플릿관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
            <form name="frm" action ="<c:url value='/cop/com/selectTemplateInfs.do'/>" method="post">
            <input type="hidden" name="tmplatId" value="" />
            <input type="submit" id="invisible" class="invisible"/>
            
            <!-- sub title start -->
            <div><h2>템플릿 목록</h2></div>
            <!-- sub title end -->

            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >
                    <select name="searchCnd" title="검색조건" class="select">
		                <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >템플릿명</option>
		                <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >템플릿구분</option>   
		            </select>
		            <input name="searchWrd" title="검색어" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>'  maxlength="35" onkeypress="press(event);">
                </div>
                    <div class="search_buttons">
			          <a href="<c:url value='/cop/com/selectTemplateInfs.do'/>" onclick="javascript:fn_egov_select_tmplatInfo('1'); return false;">조회</a> 
			          <a href="<c:url value='/cop/com/addTemplateInf.do'/>" onclick="javascript:fn_egov_insert_addTmplatInfo(); return false;">등록</a> 
                    </div>
                </div> 
            </div>
            <!-- search area end -->
            
            <!-- search result start -->
            <div class="search_result_div">
            
                <table width="98%" cellpadding="0" cellspacing="0" summary="SUMMARY">
                <caption>게시판템플릿 목록</caption>
                
                <colgroup>
                    <col width="5%" > 
                    <col width="15%" >
                    <col width="10%" >
                    <col >
                    <col width="10%" >
                    <col width="15%" >
                </colgroup>
                
                <thead>
                <tr>      
                    <th>번호</th>
			        <th>템플릿명</th>
			        <th>템플릿구분</th>
			        <th>템플릿경로</th>
			        <th>사용여부</th>   
			        <th>등록일자</th>              
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
		            <td class="lt_text3" ><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>      
		            <td class="lt_text3" >
		                <a href="<c:url value='/cop/com/selectTemplateInf.do'/>?tmplatId=<c:out value='${result.tmplatId}'/>">
		                    <c:out value="${result.tmplatNm}"/>
		                </a>
		            </td>
		            <td class="lt_text3" ><c:out value="${result.tmplatSeCodeNm}"/></td>
		            <td class="lt_text3" ><c:out value="${result.tmplatCours}"/></td>
		            <td class="lt_text3" >
		                <c:if test="${result.useAt == 'N'}"><spring:message code="button.notUsed" /></c:if>
		                <c:if test="${result.useAt == 'Y'}"><spring:message code="button.use" /></c:if>
		            </td>  
		            <td class="lt_text3" ><c:out value="${result.frstRegisterPnttm}"/></td>       
		        </tr>
		        </c:forEach>
                </tbody>
                  
                </table>
            </div>
            <!-- search result end -->

        	<div id="paging_div"><ul class="paging_align">
		        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_tmplatInfo" />
		        </ul>
	        </div>
	        
	        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
            </form>

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