<%--
  Class Name : EgovIndvdlInfoPolicyModify.jsp
  Description : 개인정보보호정책 수정 페이지
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<c:set var="ImgUrl" value="<c:url value='/images/egovframework/uss/sam/ipm/' />"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>개인정보보호정책 수정</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/cmm/utl/htmlarea3.0/htmlarea.js'/>"></script>
<validator:javascript formName="indvdlInfoPolicy" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
//웹에디터설정
_editor_area = "indvdlInfoDc";
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_IndvdlInfoPolicy(){
	
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_IndvdlInfoPolicy(){
	location.href = "/uss/sam/ipm/listIndvdlInfoPolicy.do";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_IndvdlInfoPolicy(){
	var varFrom = document.indvdlInfoPolicy;
	//varFrom.submit();
	if(confirm("<spring:message code='common.save.msg' />")){
		varFrom.action =  "<c:url value='/uss/sam/ipm/updtIndvdlInfoPolicy.do'/>";
		if(!validateIndvdlInfoPolicy(varFrom)){ 			
			return;
		}else{
			varFrom.submit();
		} 
	}
}
</script>
<style TYPE="text/css">
.txaClass2 {width:550px; height:350px;}
.noStyle {background:ButtonFace; BORDER-TOP:0px; BORDER-bottom:0px; BORDER-left:0px; BORDER-right:0px;}
.noStyle th{background:ButtonFace; padding-left:0px;padding-right:0px}
.noStyle td{background:ButtonFace; padding-left:0px;padding-right:0px}
</style>
</head>
<body onLoad="fn_egov_init_IndvdlInfoPolicy();">
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

			<!--  상단타이틀 -->
			<form:form commandName="indvdlInfoPolicy" name="indvdlInfoPolicy" action="/uss/sam/ipm/updtIndvdlInfoPolicy.do" method="post" enctype="multipart/form-data">
            
            <!-- sub title start -->
            <div><h2>개인정보보호정책 수정</h2></div>
            <!-- sub title end -->
            
            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">
					<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="개인정보보호정책 수정을 제공한다.">
					  <tr> 
					    <td class="td_width"><label id="IdIndvdlInfoNm">개인정보보호정책 명</label>
					        <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/>
					    </td>
					    <td class="td_content">
					      <form:input path="indvdlInfoNm" size="73" cssClass="txaIpt" maxlength="255"/>
					      <form:errors path="indvdlInfoNm" cssClass="error"/>
					    </td>
					  </tr>
					  <tr> 
					    <td class="td_width"><label id="IdIndvdlInfoYn">동의여부</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					            <select name="indvdlInfoYn" id="indvdlInfoYn" title="동의여부">
					            <option value="">선택</option>
					            <option value="Y" <c:if test="${indvdlInfoPolicy.indvdlInfoYn == 'Y'}">selected</c:if>>예</option>
					            <option value="N" <c:if test="${indvdlInfoPolicy.indvdlInfoYn == 'N'}">selected</c:if>>아니오</option>
					            </select>
					    </td>
					  </tr> 
					  <tr> 
					    <td class="td_width"><label id="IdIndvdlInfoDc">개인정보보호정책 내용</label>
					        <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/>
					    </td>
					    <td class="td_content">
					           <form:textarea path="indvdlInfoDc" rows="20" cols="100"/>
					           <form:errors path="indvdlInfoDc" cssClass="error"/>
					    </td>
					  </tr>
					</table>
                </div>
            </div>
            <!--detail area end -->
            
            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
                <a href="<c:url value='/uss/sam/ipm/listIndvdlInfoPolicy.do'/>"><spring:message code="button.list" /></a>
                <input type="submit" value="<spring:message code="button.save" />" onclick="fn_egov_save_IndvdlInfoPolicy(); return false;" class="btnNew"  />
            </div>
            </td></tr></table>
            <!-- 목록/저장버튼  끝-->

			<input name="indvdlInfoId" type="hidden" value="${indvdlInfoPolicy.indvdlInfoId}">
			<input name="cmd" type="hidden" value="<c:out value='save'/>">
			</form:form>


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