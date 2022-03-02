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
<c:set var="ImgUrl" value="/images_old/egovframework/uss/sam/ipm/"/>
<%pageContext.setAttribute("crlf", "\r\n"); %>
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
	if(confirm('<spring:message code="common.delete.msg" />')) {
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

                                <h1 class="tit_1">포털시스템관리</h1>

                                <p class="txt_1">포털시스템의 사용자 및 권한에 대한 제반사항을 관리합니다.</p>

                                <h2 class="tit_2">사용자관리</h2>

                                <h3 class="tit_3">개인정보보호관리</h3>

                                <div class="board_view2">
                                
                                	<form name="IndvdlInfoPolicyForm" method="post" action="#LINK">
                                
                                    <table summary="이 표는 개인정보보호정책 상세정보를 제공합니다.">
                                        <colgroup>
                                            <col style="width: 210px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">개인정보보호정책 명</span>
                                            </td>
                                            <td>
                                            	<c:out value="${indvdlInfoPolicy.indvdlInfoNm}" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">동의여부</span>
                                            </td>
                                            <td>
                                            	<c:if test="${indvdlInfoPolicy.indvdlInfoYn == 'Y'}">예</c:if>
                                            	<c:if test="${indvdlInfoPolicy.indvdlInfoYn == 'N'}">아니오</c:if>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="indvdlInfoDc">개인정보보호정책 내용</label>
                                            </td>
                                            <td>
												<textarea id="indvdlInfoDc" class="f_txtar w_full h_400" name="indvdlInfoDc" title="개인정보보호정책 내용" rows="10" cols="30" readonly="readonly" ><c:out value="${indvdlInfoPolicy.indvdlInfoDc}" escapeXml="false" /></textarea>
                                            </td>
                                        </tr>
                                    </table>
                                    
                                    <input name="indvdlInfoId" type="hidden" value="${indvdlInfoPolicy.indvdlInfoId}">
									<input name="cmd" type="hidden" value="<c:out value=''/>"/>
									</form>
                                    
                                </div>

								<!--  목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    	<form name="formDelete" action="<c:url value='/uss/sam/ipm/detailIndvdlInfoPolicy.do'/>" method="post">
                                    		<a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="fn_egov_delete_IndvdlInfoPolicy(); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                    		<input name="indvdlInfoId" type="hidden" value="${indvdlInfoPolicy.indvdlInfoId}">
											<input name="cmd" type="hidden" value="<c:out value='del'/>">
                                    	</form>
                                    </div>

                                    <div class="right_col btn1">
                                    	<form name="formUpdt" action="<c:url value='/uss/sam/ipm/updtIndvdlInfoPolicy.do'/>" method="post" style="display: inline;">
                                    		<a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_modify_IndvdlInfoPolicy(); return false;"><spring:message code="button.update" /></a><!-- 수정 -->
                                    		<input name="indvdlInfoId" type="hidden" value="${indvdlInfoPolicy.indvdlInfoId}">
                                    	</form>
                                    	<form name="formList" action="<c:url value='/uss/sam/ipm/listIndvdlInfoPolicy.do'/>" method="post" style="display: inline; margin-left: 10px;">
                                        	<a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_list_IndvdlInfoPolicy(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                        </form>
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
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