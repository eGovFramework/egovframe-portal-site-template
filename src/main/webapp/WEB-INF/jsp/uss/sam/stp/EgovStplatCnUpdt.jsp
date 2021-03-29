<%--
  Class Name : EgovStplatCnUpdt.jsp
  Description : EgovStplatCnUpdt 화면
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>약관수정</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="stplatManageVO" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javaScript" language="javascript">

/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_initl_stplatcn(){
	// 첫 입력란에 포커스..
	document.getElementById("useStplatNm").focus();
}

/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_updt_stplatcn(form, useStplatId){
	// 서버사이드 테스트용
	/*	
		form.action = "<c:url value='/uss/sam/stp/StplatCnUpdt.do'/>";
		form.submit(); 
		return;
	*/
	if (!validateStplatManageVO(form)) {
		return;
	} else {
		
		form.useStplatId.value = useStplatId;
		form.action = "<c:url value='/uss/sam/stp/StplatCnUpdt.do'/>";
		form.submit();	
	}	
}

/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_inqire_recomendsitelist() {
	document.getElementById('stplatManageVO').action = "<c:url value='/uss/sam/stp/StplatListInqire.do'/>";
	document.getElementById('stplatManageVO').submit();
}


</script>
</head>
<body onLoad="fn_egov_initl_stplatcn();">
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
            
            <form:form commandName="stplatManageVO" name="stplatManageVO" action="" method="post"> 
	  
            <!-- sub title start -->
            <div><h2>약관내용수정</h2></div>
            <!-- sub title end -->

            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">                  
                    <table summary="이 표는 약관내용 대상 정보를 제공하며, 이용약관명, 이용약관내용, 정보제공동의내용 정보로 구성되어 있습니다 .">
                        <tr>
                            <td class="td_width">이용약관명
                                <img src="<c:url value='/images/required.gif' />" alt="필수항목" title="필수항목" width="15" height="15">
                            </td>
                            <td class="td_content">
                                <input name="useStplatNm" id="useStplatNm" type="text" title="이용약관명" size="70" value="<c:out value='${result.useStplatNm}'/>" maxlength="70">
                            </td>
                        </tr>
                        <tr>
                            <td class="td_width">이용약관내용
                                <img src="<c:url value='/images/required.gif' />" alt="필수항목" title="필수항목" width="15" height="15">
                            </td>
                            <td class="td_content">
                            <textarea name="useStplatCn" id="useStplatCn" class="textarea" title="이용약관내용" cols="100" rows="20"><c:out value="${result.useStplatCn}"/></textarea>            
                            </td>
                        </tr>
                        <tr>
                            <td class="td_width">정보제공동의내용
                                <img src="<c:url value='/images/required.gif' />" alt="필수항목" title="필수항목" width="15" height="15">
                            </td>
                            <td class="td_content">
                            <textarea name="infoProvdAgreCn" id="infoProvdAgreCn" class="textarea" title="정보제공동의내용" cols="100" rows="20"><c:out value="${result.infoProvdAgreCn}"/></textarea>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!--detail area end -->
           
            <!-- fucntion button start -->
            <div class="buttons" align="center" style="margin-bottom:100px">
                <a href="#LINK" onclick="fn_egov_updt_stplatcn(document.getElementById('stplatManageVO'),'<c:out value="${result.useStplatId}"/>'); return false;"><spring:message code="button.save" /></a>
                <a href="<c:url value='/uss/sam/stp/StplatListInqire.do'/>" onclick="fn_egov_inqire_recomendsitelist(); return false;"><spring:message code="button.list" /></a>
            </div>
            <!-- function button end -->
                        
            <input name="useStplatId" id="useStplatId" type="hidden" >
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