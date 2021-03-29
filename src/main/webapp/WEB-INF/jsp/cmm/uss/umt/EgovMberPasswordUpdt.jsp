<%--
  Class Name : EgovMberPasswordUpdt.jsp
  Description : 일반회원암호수정 JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.02  JJY          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 JJY
    since    : 2009.04.02
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<title>암호 수정</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="passwordChgVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnListPage(){
    document.passwordChgVO.action = "<c:url value='/uss/umt/mber/EgovMberManage.do'/>";
    document.passwordChgVO.submit();
}
function fnUpdate(){
    if(validatePasswordChgVO(document.passwordChgVO)){
        if(document.passwordChgVO.newPassword.value != document.passwordChgVO.newPassword2.value){
            alert("<spring:message code='fail.user.passwordUpdate2' />");
            return;
        }
        document.passwordChgVO.submit();
    }
}
<c:if test="${!empty resultMsg}">alert("<spring:message code='${resultMsg}' />");</c:if>
//-->
</script>
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
                            <li><strong>회원관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
            
	        <form name="passwordChgVO" method="post" action="<c:url value="${'/uss/umt/mber/EgovMberPasswordUpdt.do'}"/>" >
	        <!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
	        <input name="checkedIdForDel" type="hidden" />
	        <!-- 검색조건 유지 -->
	        <input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
	        <input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
	        <input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
	        <input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
	        <!-- 우편번호검색 -->
	        <input type="hidden" name="url" value="<c:url value='/sym/ccm/zip/EgovCcmZipSearchPopup.do'/>" />
        
            <!-- sub title start -->
            <div><h2>암호변경</h2></div>
            <!-- sub title end -->
            
            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">                  
                    <table summary="SUMMARY">
                        <tr>
			                <td class="td_width"><label for="mberId">일반회원아이디</label>
			                    <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/>
			                </td>
			                <td class="td_content">
			                    <input name="mberId" id="mberId" type="text" size="20" value="<c:out value='${mberManageVO.mberId}'/>"  maxlength="20" readonly />
			                    <input name="uniqId" id="uniqId" type="hidden" size="20" value="<c:out value='${mberManageVO.uniqId}'/>" />
			                    <input name="userTy" id="userTy" type="hidden" size="20" value="<c:out value='${mberManageVO.userTy}'/>" />
			                </td>
			            </tr>
			            <tr> 
			                <td class="td_width"><label for="oldPassword">기존 비밀번호</label>
			                    <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/>
			                </td>
			                <td class="td_content"><input name="oldPassword" id="oldPassword" type="password" size="20" value=""  maxlength="100" /></td>
			            </tr>
			            <tr> 
			                <td class="td_width"><label for="newPassword">비밀번호</label>
			                    <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/>
			                </td>
			                <td class="td_content"><input name="newPassword" id="newPassword" type="password" size="20" value=""  maxlength="100" /></td>
			            </tr>
			            <tr>
			                <td class="td_width"><label for="newPassword2">비밀번호확인</label>
			                    <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/>
			                </td>
			                <td class="td_content"><input name="newPassword2" id="newPassword2" type="password" size="20" value=""  maxlength="100" /></td>
			            </tr>
                    </table>
                </div>
            </div>
            <!--detail area end -->
            
            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
                <!-- 수정 -->
                <input type="submit" value="<spring:message code="button.save" />" onclick="fnUpdate(); return false;" />
                <!-- 목록 -->
                <a href="<c:url value='/uss/umt/mber/EgovMberManage.do'/>" onclick="fnListPage(); return false;"><spring:message code="button.list" /></a>
                <!-- 취소 -->
                <a href="#LINK" onclick="javascript:document.passwordChgVO.reset();"><spring:message code="button.reset" /></a>
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