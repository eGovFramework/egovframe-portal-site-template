<%--
  Class Name : EgovBoardUseInfInqire.jsp
  Description :  게시판  사용정보  조회화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.02   이삼섭          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.04.02
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardUseInf" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	function fn_egov_updt_bbsUseInf(){
		if (!validateBoardUseInf(document.boardUseInf)){
			return;
		}
		
		document.boardUseInf.action = "<c:url value='/cop/com/updateBBSUseInf.do'/>";
		document.boardUseInf.submit();
	}
	function fn_egov_select_bbsUseInfs(){
		document.boardUseInf.action = "<c:url value='/cop/com/selectBBSUseInfs.do'/>";
		document.boardUseInf.submit();		
	}
	
</script>
<title>게시판 사용정보 상세조회 및 수정</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
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
                            <li><strong>게시판사용관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
			<form name="boardUseInf" method="post" action="<c:url value='/cop/com/updateBBSUseInf.do'/>">
			<div style="visibility:hidden;display:none;"><input name="iptSubmit" type="submit" value="전송" title="전송"></div>
			<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
			<input type="hidden" name="bbsId" value="<c:out value='${bdUseVO.bbsId}'/>" />
			<input type="hidden" name="trgetId" value="<c:out value='${bdUseVO.trgetId}'/>" />
			
			<!-- sub title start -->
            <div><h2>게시판 사용정보 수정</h2></div>
            <!-- sub title end -->
			
			<!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">
                    <table summary="게시판명, 커뮤니티/ 동호회명, 사용여부  입니다" >
				      <tr> 
				        <td class="td_width">게시판명</td>
				        <td class="td_content">
				        <c:out value="${bdUseVO.bbsNm}" />
				        </td>
				      </tr>
				      <tr> 
				        <td class="td_width">커뮤니티/ 동호회명</td>
				        <td class="td_content">
				        <c:choose>
				            <c:when test="${not empty bdUseVO.cmmntyNm}">
				                <c:out value="${bdUseVO.cmmntyNm}" />
				            </c:when>
				            <c:when test="${not empty bdUseVO.clbNm}">
				                <c:out value="${bdUseVO.clbNm}" />
				            </c:when>
				            <c:otherwise>(시스템  활용)</c:otherwise>
				        </c:choose>
				        </td>
				      </tr>
				      <tr> 
				        <td class="td_width">
				            <label for="useAt">
				                사용여부
				            </label>    
				            <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/>
				        </td>
				        <td class="td_content">
				            <spring:message code="button.use" /> : <input type="radio" name="useAt" class="radio2" value="Y" <c:if test="${bdUseVO.useAt == 'Y'}"> checked="checked"</c:if>>&nbsp;
				            <spring:message code="button.notUsed" /> : <input type="radio" name="useAt" class="radio2" value="N" <c:if test="${bdUseVO.useAt == 'N'}"> checked="checked"</c:if>>
				            <br/><form:errors path="useAt" /> 
				        </td>   
				    
				      </tr>
				      <c:choose>
				      <c:when test="${not empty bdUseVO.provdUrl}">
				      <tr> 
				        <td class="td_width">제공 URL</td>
				        <td class="td_content">
				            <a href="<c:url value="${bdUseVO.provdUrl}" />" target="_new">
				                <c:url value="${bdUseVO.provdUrl}" />
				            </a>
				        </td>
				      </tr>
				      </c:when>
				      </c:choose>
				    </table>
                </div>
            </div>
            <!--detail area end -->
            
            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
                <a href="<c:url value='/cop/com/updateBBSUseInf.do'/>" onclick="fn_egov_updt_bbsUseInf(); return false;">저장</a>
                <a href="<c:url value='/cop/com/selectBBSUseInfs.do'/>" onclick="fn_egov_select_bbsUseInfs(); return false;">목록</a>
            </div>
            </td></tr></table>
            <!-- 목록/저장버튼  끝-->

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