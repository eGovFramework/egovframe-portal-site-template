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
<c:set var="ImgUrl" value="<c:url value='/images_old/egovframework/uss/sam/ipm/' />"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>샘플 포털 > 포털시스템관리 > 사용자관리 > 개인정보보호관리</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

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

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <!-- header start -->
	    <c:import url="/sym/mms/EgovHeader.do" />
	    <!-- //header end -->

        <div class="container">
            <div class="sub_layout">
                <div class="sub_in">
                    <div class="layout">
                        <!-- Left menu -->
	                    <c:import url="/sym/mms/EgovMenuLeft.do" />
	                    <!--// Left menu -->
        
                        <div class="content_wrap">
                            <div id="contents" class="content">
                                 <!-- Location -->
                                <div class="location">
                                    <ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li><a href="">포털시스템관리</a></li>
                                        <li><a href="">사용자관리</a></li>
                                        <li>개인정보보호관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="indvdlInfoPolicy" name="indvdlInfoPolicy" action="/uss/sam/ipm/updtIndvdlInfoPolicy.do" method="post" enctype="multipart/form-data">

                                <h1 class="tit_1">포털시스템관리</h1>

                                <p class="txt_1">포털시스템의 사용자 및 권한에 대한 제반사항을 관리합니다.</p>

                                <h2 class="tit_2">사용자관리</h2>

                                <h3 class="tit_3">개인정보보호관리</h3>

                                <div class="board_view2">
                                    <table summary="개인정보보호정책 수정을 제공한다.">
                                        <colgroup>
                                            <col style="width: 210px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="indvdlInfoNm">개인정보보호정책 명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input id="indvdlInfoNm" class="f_txt w_full" path="indvdlInfoNm" maxlength="255"/>
                                                <form:errors path="indvdlInfoNm" cssClass="error"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label id="IdIndvdlInfoYn">동의여부</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select" for="indvdlInfoYn">
                                                    <select name="indvdlInfoYn" id="indvdlInfoYn" title="동의여부">
                                                        <option value="">선택</option>
                                                        <option value="Y" <c:if test="${indvdlInfoPolicy.indvdlInfoYn == 'Y'}">selected</c:if>>예</option>
                                                        <option value="N" <c:if test="${indvdlInfoPolicy.indvdlInfoYn == 'N'}">selected</c:if>>아니오</option>
                                                    </select>
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="indvdlInfoDc">개인정보보호정책 내용</label>
                                            </td>
                                            <td>
												<form:textarea id="indvdlInfoDc" class="f_txtar w_full h_400" path="indvdlInfoDc" rows="10" cols="30"/>
												<form:errors path="indvdlInfoDc" cssClass="error"/>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  시작-->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_save_IndvdlInfoPolicy(); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value='/uss/sam/ipm/listIndvdlInfoPolicy.do'/>" class="btn btn_blue_46 w_100"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- 목록/저장버튼  끝-->
                                
                                <input name="indvdlInfoId" type="hidden" value="<c:out value='${indvdlInfoPolicy.indvdlInfoId}'/>">
								<input name="cmd" type="hidden" value="<c:out value='save'/>">
								</form:form>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- footer 시작 -->
	    <c:import url="/sym/mms/EgovFooter.do" />
	    <!-- //footer 끝 -->
    </div>
    
</body>
</html>