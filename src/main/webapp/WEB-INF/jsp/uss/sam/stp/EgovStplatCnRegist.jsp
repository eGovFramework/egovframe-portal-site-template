<%--
  Class Name : EgovStplatCnRegist.jsp
  Description : EgovStplatCnRegist 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01   박정규          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 박정규
    since    : 2009.02.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>약관 등록</title>
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
function fn_egov_regist_stplatcn(form){
	// 서버사이드 테스트용
	if (!validateStplatManageVO(form)) {
	    return;
	} else {
		form.action = "<c:url value='/uss/sam/stp/StplatCnRegist.do'/>";
		form.submit();
	} 
}

/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_inqire_stplatlist() {
	document.getElementById('stplatManageVO').action = "<c:url value='/uss/sam/stp/StplatListInqire.do'/>";
	document.getElementById('stplatManageVO').submit();
}

</script>

</head>
<body onLoad="fn_egov_initl_stplatcn();">
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
            
            <!-- 상단타이틀 -->
            <form:form commandName="stplatManageVO" name="stplatManageVO" method="post"> 

            <!-- sub title start -->
            <div><h2>약관내용 등록</h2></div>
            <!-- sub title end -->

            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">                  
                    <table>
                        <tr>
                            <td class="td_width">이용약관명
                                <img src="<c:url value='/images/required.gif' />" alt="필수항목" title="필수항목" width="15" height="15">
                            </td>
                            <td class="td_content">
                                <form:input path="useStplatNm" title="이용약관명 입력" size="70" maxlength="70" />
                                 <form:errors path="useStplatNm"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_width">이용약관내용
                                <img src="<c:url value='/images/required.gif' />" alt="필수항목" title="필수항목" width="15" height="15">
                            </td>
                            <td class="td_content">
                                <form:textarea path="useStplatCn" title="이용약관내용 입력" cols="100" rows="15" />   
                                <form:errors path="useStplatCn"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_width">정보제공동의내용
                                <img src="<c:url value='/images/required.gif' />" alt="필수항목" title="필수항목" width="15" height="15">
                            </td>
                            <td class="td_content">
                                <form:textarea path="infoProvdAgreCn" title="정보제공동의내용 입력" cols="100" rows="15" />   
                                <form:errors path="infoProvdAgreCn"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!--detail area end -->
                
            <!-- fucntion button start -->
            <div class="buttons" align="center" style="margin-bottom:100px">
                <a href="#LINK" onclick="javascript:fn_egov_regist_stplatcn(document.stplatManageVO); return false;">저장</a>
                <a href="<c:url value='/uss/sam/stp/StplatListInqire.do'/>">목록</a>
            </div>
            <!-- function button end -->

			<input id="cmd" name="cmd" type="hidden" value="<c:out value='save'/>">
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