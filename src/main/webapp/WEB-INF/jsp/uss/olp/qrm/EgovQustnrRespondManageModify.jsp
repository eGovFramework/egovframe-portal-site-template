<%--
  Class Name : EgovQustnrRespondManageModify.jsp
  Description : 응답자정보 수정 페이지
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
<%pageContext.setAttribute("crlf", "\r\n"); %>
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

	if(confirm("<spring:message code="common.save.msg" />")){
		varFrom.action =  "<c:url value='/uss/olp/qrm/EgovQustnrRespondManageModify.do'/>";

		varFrom.brth.value = fn_egov_SelectBoxValue('brthYYYY') + "" + fn_egov_SelectBoxValue('brthMM') + "" + fn_egov_SelectBoxValue('brthDD');
		
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
 /* ********************************************************
  * 설문지문항정보 팝업창열기
  ******************************************************** */
  function fn_egov_QustnrQestnManageListPopup_QustnrItemManage(){

	var sParam = "";
	sParam = sParam + "searchCondition=QESTNR_ID";
	sParam = sParam + "&searchKeyword=" + document.getElementById("qestnrId").value;

  	window.showModalDialog("<c:url value='/uss/olp/qrm/EgovQustnrQestnManageListPopup.do'/>?" + sParam, self,"dialogWidth=800px;dialogHeight=500px;resizable=yes;center=yes");
  	
  }
/* ********************************************************
 * 설문항목정보 팝업창열기
 ******************************************************** */
function fn_egov_QustnrItemManageListPopup_QustnrItemManage(){

	var sParam = "";
	sParam = sParam + "searchCondition=QUSTNR_QESITM_ID";
	sParam = sParam + "&searchKeyword=" + document.getElementById("qestnrQesitmId").value;

  	window.showModalDialog("<c:url value='/uss/olp/qim/EgovQustnrItemManageListPopup.do'/>?" + sParam, self,"dialogWidth=800px;dialogHeight=500px;resizable=yes;center=yes");
	
}
/************************************************************************
//셀렉트박스 값 컨트롤 함수
************************************************************************/
function fn_egov_SelectBoxValue(sbName)
{
var FValue = "";
for(var i=0; i < document.getElementById(sbName).length; i++)
{
if(document.getElementById(sbName).options[i].selected == true){

FValue=document.getElementById(sbName).options[i].value;
}
}

return  FValue;
}
</script>
</head>
<body onLoad="fn_egov_init_QustnrRespondManage();">

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
                                    <table summary="이 표는 응답자정보를 제공하며, 설문관리정보, 성별, 직업, 생년월일, 응답자명, 전화번호 정보로 구성되어 있습니다 .">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <tr>
                                                <td class="lb">
                                                    <span class="min">설문지정보</span>
                                                </td>
                                                <td>
                                                	<c:out value="${fn:replace(resultList[0].qestnrSj , crlf , '<br/>')}" escapeXml="false" />
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
                                                    <select id="sexdstnCode" name="sexdstnCode" title="성별 선택">
                                                        <option value="">선택</option>
                                                        <c:forEach items="${comCode014}" var="comCodeList" varStatus="status">
                                                        	<option value="${comCodeList.code}" <c:if test="${comCodeList.code eq resultList[0].sexdstnCode}">selected</c:if>>${comCodeList.codeNm}</option>
                                                        </c:forEach>
                                                    </select>
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
                                                    <select id="occpTyCode" name="occpTyCode" title="직업 선택">
                                                        <option value="">선택</option>
                                                        <c:forEach items="${comCode034}" var="comCodeList" varStatus="status">
                                                        	<option value="${comCodeList.code}" <c:if test="${comCodeList.code eq resultList[0].occpTyCode}">selected</c:if>>${comCodeList.codeNm}</option>
                                                        </c:forEach>
                                                    </select>
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
                                                        	<option value="${h}" <c:if test="${fn:substring(resultList[0].brthdy, 0, 4) ==  h}">selected</c:if>>${h}</option>
                                                        </c:forEach>
                                                    </select>
                                                </label>
                                                <span class="f_txt_inner mr10 ml10">년</span>
                                                <label class="f_select" for="brthMM">
                                                    <select id="brthMM" name="brthMM" title="직업">
                                                        <c:forEach var="h" begin="1" end="12" step="1">
                                                        <c:choose>
                                                        	<c:when test="${h < 10}">
                                                        		<c:set var="brthMM" value="0${h}"/>
                                                        	</c:when>
                                                        	<c:otherwise>
                                                        		<c:set var="brthMM" value="${h}"/>
                                                        	</c:otherwise>
                                                        </c:choose>
                                                        <option value="<c:if test="${h < 10}">0</c:if>${h}" <c:if test="${fn:substring(resultList[0].brthdy, 4, 6) ==  brthMM}">selected</c:if>><c:if test="${h < 10}">0</c:if>${h}</option>
                                                    	</c:forEach>
                                                    </select>
                                                </label>
                                                <span class="f_txt_inner mr10 ml10">월</span>
                                                <label class="f_select" for="brthDD">
                                                    <select id="brthDD" name="brthDD" title="직업">
                                                        <c:forEach var="h" begin="1" end="31" step="1">
                                                        <c:choose>
                                                        	<c:when test="${h < 10}">
                                                        		<c:set var="brthDD" value="0${h}"/>
                                                        	</c:when>
                                                        	<c:otherwise>
                                                        		<c:set var="brthDD" value="${h}"/>
                                                        	</c:otherwise>
                                                        </c:choose>
                                                        <option value="<c:if test="${h < 10}">0</c:if>${h}" <c:if test="${fn:substring(resultList[0].brthdy, 6, 8) ==  brthDD}">selected</c:if>><c:if test="${h < 10}">0</c:if>${h}</option>
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
                                                <input id="inp11" class="f_txt w_300" name="respondNm" type="text" title="응답자명 입력" size="73" value="${resultList[0].respondNm}" maxlength="50">
                                                <form:errors path="respondNm" cssClass="error" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="phone">전화번호</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input id="phone" name="areaNo" class="f_txt w_80" type="text" title="지역번호 입력" size="4" value="${resultList[0].areaNo}" maxlength="4">
                                                <span class="f_txt_inner mr5 ml5">-</span>
                                                <input name="middleTelno" class="f_txt w_80" type="text" title="국번 입력" size="4" value="${resultList[0].middleTelno}" maxlength="4">
                                                <span class="f_txt_inner mr5 ml5">-</span>
                                                <input name="endTelno" class="f_txt w_80" type="text" size="4" title="번호 입력" value="${resultList[0].endTelno}" maxlength="4">
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
                                
                                <input name="qestnrRespondId" type="hidden" value="${resultList[0].qestnrRespondId}">
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