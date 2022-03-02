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
<title>샘플 포털 > 포털시스템관리 > 사용자관리 > 이용약관관리</title>
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
                                        <li>이용약관관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="stplatManageVO" name="stplatManageVO" action="" method="post">

                                <h1 class="tit_1">포털시스템관리</h1>

                                <p class="txt_1">포털시스템의 사용자 및 권한에 대한 제반사항을 관리합니다.</p>

                                <h2 class="tit_2">사용자관리</h2>

                                <h3 class="tit_3">이용약관관리</h3>

                                <div class="board_view2">
                                    <table summary="이 표는 약관내용 대상 정보를 제공하며, 이용약관명, 이용약관내용, 정보제공동의내용 정보로 구성되어 있습니다 .">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="useStplatNm">이용약관명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="useStplatNm" id="useStplatNm" class="f_txt w_full" type="text" title="이용약관명" value="<c:out value='${result.useStplatNm}'/>" maxlength="70">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="useStplatCn">이용약관내용</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
												<textarea name="useStplatCn" id="useStplatCn" class="f_txtar w_full h_200" title="이용약관내용" cols="30" rows="10"><c:out value="${result.useStplatCn}"/></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="infoProvdAgreCn">정보제공동의내용</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <textarea name="infoProvdAgreCn" id="infoProvdAgreCn" class="f_txtar w_full h_200" title="정보제공동의내용" cols="30" rows="10"><c:out value="${result.infoProvdAgreCn}"/></textarea>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  시작-->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_updt_stplatcn(document.getElementById('stplatManageVO'),'<c:out value="${result.useStplatId}"/>'); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value='/uss/sam/stp/StplatListInqire.do'/>" class="btn btn_blue_46 w_100" onclick="fn_egov_inqire_recomendsitelist(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- 목록/저장버튼  끝-->
                                
                                <input name="useStplatId" id="useStplatId" type="hidden" >
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