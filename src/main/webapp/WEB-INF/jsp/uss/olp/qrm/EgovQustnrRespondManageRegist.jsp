<%--
  Class Name : EgovQustnrRespondManageRegist.jsp
  Description : 응답자정보 등록 페이지
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
<c:set var="ImgUrl" value="/images_old/egovframework/com/uss/olp/qrm/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>샘플 포털 > 포털서비스관리 > 설문관리 > 설문응답결과</title>
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
<validator:javascript formName="qustnrRespondManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/showModalDialog.js'/>" ></script>
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrRespondManage(){

}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_QustnrRespondManage(){
	location.href = "<c:url value='/uss/olp/qrm/EgovQustnrRespondManageList.do'/>";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_QustnrRespondManage(){
	var varFrom = document.qustnrRespondManageVO;

	if(confirm("<spring:message code='common.save.msg' />")){
		varFrom.action =  "<c:url value='/uss/olp/qrm/EgovQustnrRespondManageRegist.do'/>";
		varFrom.brth.value = fn_egov_SelectBoxValue('brthYYYY') + "" + fn_egov_SelectBoxValue('brthMM') + "" + fn_egov_SelectBoxValue('brthDD');
		
		if(varFrom.qestnrCn.value == "" ||
				varFrom.qestnrTmplatId.value == "" ||
				varFrom.qestnrId.value == ""  
				){
			alert("설문지정보를  입력해주세요!");
			varFrom.qestnrCn.focus();
			return;
		}
		
		if(!validateQustnrRespondManageVO(varFrom)){ 			
			return;
		}else{
			varFrom.submit();
		} 
	}
}

/* ********************************************************
 * 설문지정보 팝업창열기
 ******************************************************** */
 function fn_egov_QustnrManageListPopup_QustnrItemManage(){

 	window.showModalDialog("<c:url value='/uss/olp/qmc/EgovQustnrManageListPopup.do'/>", self,"dialogWidth=800px;dialogHeight=500px;resizable=yes;center=yes");
 	
 }
/************************************************************************
//셀렉트박스 값 컨트롤 함수
************************************************************************/

	function fn_egov_SelectBoxValue(sbName) {
		var FValue = "";
		for (var i = 0; i < document.getElementById(sbName).length; i++) {
			if (document.getElementById(sbName).options[i].selected == true) {

				FValue = document.getElementById(sbName).options[i].value;
			}
		}

		return FValue;
	}
</script>
</head>
<body onLoad="fn_egov_init_QustnrRespondManage()">
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
                                        <li><a href="">포털서비스관리</a></li>
                                        <li><a href="">설문관리</a></li>
                                        <li>설문응답결과</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="qustnrRespondManageVO" name="qustnrRespondManageVO" action="" method="post">

                                <h1 class="tit_1">포털서비스관리</h1>

                                <p class="txt_1">포털시스템에서 제공되는 서비스들에 대한 컨텐츠를 관리합니다.</p>

                                <h2 class="tit_2">설문관리</h2>

                                <h3 class="tit_3">설문응답결과</h3>

                                <div class="board_view2">
                                    <table>
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <tr>
                                                <td class="lb">
                                                    <label for="qestnrCn">설문지정보</label>
                                                    <span class="req">필수</span>
                                                </td>
                                                <td>
                                                    <span class="f_search2 w_350">
                                                        <input name="qestnrCn" id="qestnrCn" type="text" title="설문지정보 입력" size="73" value="" maxlength="4000">
                                                        <button type="button" class="btn" onClick="fn_egov_QustnrManageListPopup_QustnrItemManage()"></button>
                                                    </span>
                                                    <input name="qestnrId" id="qestnrId" type="hidden" value="">
                                                    <input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="">
                                                </td>
                                            </tr>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	성별
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select" for="sexdstnCode">
                                                    <form:select id="sexdstnCode" name="sexdstnCode" path="sexdstnCode" title="성별 선택">
                                                    	<option value="">선택</option>
                                                    	<form:options items="${comCode014}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                    <form:errors path="sexdstnCode"/>
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	직업
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select" for="occpTyCode">
                                                    <form:select id="occpTyCode" name="occpTyCode" path="occpTyCode" title="직업 선택">
                                                    	<option value="">선택</option>
                                                    	<form:options items="${comCode034}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                    <form:errors path="occpTyCode"/>
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="brthYYYY">생년월일</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_130" for="brthYYYY">
                                                    <select id="brthYYYY" name="brthYYYY" title="생년 선택">
                                                        <c:forEach var="h" begin="1960" end="2009" step="1">
                                                        	<option value="${h}">${h}</option>
                                                        </c:forEach>
                                                    </select>
                                                </label>
                                                <span class="f_txt_inner mr10 ml10">년</span>
                                                <label class="f_select" for="brthMM">
                                                    <select id="brthMM" name="brthMM" title="직업">
                                                        <c:forEach var="h" begin="1" end="12" step="1">
                                                        	<option value="<c:if test="${h < 10}">0</c:if>${h}"><c:if test="${h < 10}">0</c:if>${h}</option>
                                                        </c:forEach>
                                                    </select>
                                                </label>
                                                <span class="f_txt_inner mr10 ml10">월</span>
                                                <label class="f_select" for="brthDD">
                                                    <select id="brthDD" name="brthDD" title="직업">
                                                        <c:forEach var="h" begin="1" end="31" step="1">
                                                        	<option value="<c:if test="${h < 10}">0</c:if>${h}"><c:if test="${h < 10}">0</c:if>${h}</option>
                                                        </c:forEach>
                                                    </select>
                                                </label>
                                                <span class="f_txt_inner ml10">일</span>
                                                <input name="brth" id="brth" type="hidden" value="">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="inp11">응답자명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input id="inp11" class="f_txt w_300" name="respondNm" type="text" title="응답자명 입력" size="73" value="" maxlength="50">
                                                <form:errors path="respondNm" cssClass="error" />
                                            </td>
                                        </tr>
                                       <tr>
                                            <td class="lb">
                                                <label for="phone">전화번호</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input id="phone" class="f_txt w_80" name="areaNo" type="text" title="지역번호 입력" size="4" value="" maxlength="4">
                                                <span class="f_txt_inner mr5 ml5">-</span>
                                                <input class="f_txt w_80" name="middleTelno" type="text" title="국번 입력" size="4" value="" maxlength="4">
                                                <span class="f_txt_inner mr5 ml5">-</span>
                                                <input class="f_txt w_80" name="endTelno" type="text" title="전화번호 입력" size="4" value="" maxlength="4">
                                                <form:errors path="areaNo" cssClass="error" />
                                                <form:errors path="middleTelno" cssClass="error" />
                                                <form:errors path="endTelno" cssClass="error" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  시작-->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_save_QustnrRespondManage(document.forms[0]); return false;">저장</a><!-- 저장 -->
                                        <a href="<c:url value='/uss/olp/qrm/EgovQustnrRespondManageList.do'/>" class="btn btn_blue_46 w_100">목록</a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- 목록/저장버튼  끝-->
                                
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