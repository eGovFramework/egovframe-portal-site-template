<%--
  Class Name : EgovIndvdlInfoPolicyDetail.jsp
  Description : 개인정보보호정책 상세보기
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
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images/egovframework/uss/sam/ipm/"/>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>개인정보보호정책 상세</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javaScript" language="javascript">


/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_IndvdlInfoPolicy(){

}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_IndvdlInfoPolicy(){
	location.href = "<c:url value='/uss/sam/ipm/listIndvdlInfoPolicy.do'/>";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_modify_IndvdlInfoPolicy(){
	var vFrom = document.IndvdlInfoPolicyForm;
	vFrom.cmd.value = '';
	vFrom.action = "<c:url value='/uss/sam/ipm/updtIndvdlInfoPolicy.do'/>";;
	vFrom.submit();

}
/* ********************************************************
 * 삭제처리
 ******************************************************** */
function fn_egov_delete_IndvdlInfoPolicy(){
	var vFrom = document.IndvdlInfoPolicyForm;
	if(confirm("삭제 하시겠습니까?")){
		vFrom.cmd.value = 'del';
		vFrom.action = "<c:url value='/uss/sam/ipm/detailIndvdlInfoPolicy.do'/>";
		vFrom.submit();
	}else{
		vFrom.cmd.value = '';
	}
}
</script>
</head>
<body>
<%-- noscript 테그 --%>
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
            
            <form name="IndvdlInfoPolicyForm" method="post" action="#LINK">
            <input type="submit" id="invisible" class="invisible"/>
            <!-- sub title start -->
            <div><h2>개인정보보호정책 상세보기</h2></div>
            <!-- sub title end -->
            
            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">                  
                    <table summary="이 표는 개인정보보호정책 상세정보를 제공합니다.">
                        <tr>
                            <td class="td_width">개인정보보호정책 명</td>
                            <td class="td_content">
                                <c:out value="${indvdlInfoPolicy.indvdlInfoNm}" />
                            </td>
                        </tr>
                        <tr>
                            <td class="td_width">동의여부</td>
                            <td class="td_content">
                                <c:if test="${indvdlInfoPolicy.indvdlInfoYn == 'Y'}">예</c:if>
                                <c:if test="${indvdlInfoPolicy.indvdlInfoYn == 'N'}">아니오</c:if>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_width">개인정보보호정책 내용</td>
                            <td class="td_content">
                                <textarea id="indvdlInfoDc" name="indvdlInfoDc" title="개인정보보호정책 내용" rows="20" cols="100" readonly="readonly" ><c:out value="${indvdlInfoPolicy.indvdlInfoDc}" escapeXml="false" /></textarea>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!--detail area end -->
            
			<input name="indvdlInfoId" type="hidden" value="${indvdlInfoPolicy.indvdlInfoId}">
			<input name="cmd" type="hidden" value="<c:out value=''/>"/>
			</form>

			<!--  목록/저장버튼  -->
			<table border="0" cellspacing="0" cellpadding="0" align="center">
			<tr>
				<td>
					<form name="formUpdt" action="<c:url value='/uss/sam/ipm/updtIndvdlInfoPolicy.do'/>" method="post"> 
					<div class="buttons"><input type="submit" value="<spring:message code="button.update" />" onclick="fn_egov_modify_IndvdlInfoPolicy(); return false;"></div>
					<input name="indvdlInfoId" type="hidden" value="${indvdlInfoPolicy.indvdlInfoId}">
					</form>
				</td>
				<td width="3"></td>
				<td>
					<form name="formDelete" action="<c:url value='/uss/sam/ipm/detailIndvdlInfoPolicy.do'/>" method="post"> 
					<span class="buttons"><input type="submit" value="<spring:message code="button.delete" />" onclick="fn_egov_delete_IndvdlInfoPolicy(); return false;"></span>
					<input name="indvdlInfoId" type="hidden" value="${indvdlInfoPolicy.indvdlInfoId}">
					<input name="cmd" type="hidden" value="<c:out value='del'/>">
					</form>
				</td>
				<td width="3"></td>
				<td> 
					<form name="formList" action="<c:url value='/uss/sam/ipm/listIndvdlInfoPolicy.do'/>" method="post">
					<span class="buttons"><input type="submit" value="<spring:message code="button.list" />" onclick="fn_egov_list_IndvdlInfoPolicy(); return false;"></span>
					</form>
				</td>
			</tr>
			</table>

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