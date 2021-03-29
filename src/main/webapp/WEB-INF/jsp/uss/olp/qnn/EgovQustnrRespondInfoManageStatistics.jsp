<%--
  Class Name : EgovQustnrRespondInfoManageStatistics.jsp
  Description : 설문지 통계
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
<c:set var="ImgUrl" value="/images/egovframework/com/uss/olp/qnn/"/>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>설문조사 통계</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrRespondInfo(){
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_QustnrRespondInfo(){
    location.href = "<c:url value='${returnUrl}'/>";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_QustnrRespondInfo(){
    
}

/************************************************************************
//셀렉트 박스 선택했는 찾는 함수
************************************************************************/

function fn_egov_selectBoxChecking(sbName){

    var FLength= document.getElementsByName(sbName).length;

    var reuslt = false;
    for(var i=0; i < FLength; i++)
    {
        if(document.getElementsByName(sbName)[i].checked == true){
            reuslt=true;
        }
    }
    
    return reuslt;
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
<body onLoad="fn_egov_init_QustnrRespondInfo()">
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
    <div id="title_img_div"><img src="<c:url value='/'/>images/title_image/img_title04.gif" alt="" /></div>
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
                            <li>정보마당</li>
                            <li>&gt;</li>
                            <li><strong>설문조사</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->

            <!-- 상단타이틀 -->
            <form name="qustnrRespondInfoManage" action="#LINK" method="post">
            
            <!-- sub title start -->
            <div><h2>설문 통계</h2></div>
            <!-- sub title end -->
            
            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="이 표는 설문제목 정보를 제공하며, 성별, 직업, 생년월일, 응답자명, 설문정보 , 설문제목, 설문작성 안내내용, 설문대상, 설문기간 정보로 구성되어 있습니다 .">
<tr> 
    <td class="td_width">설문제목 :</td>
    <td class="td_content">
    <c:out value="${fn:replace(Comtnqestnrinfo[0].qestnrSj , crlf , '<br/>')}" escapeXml="false" />
    </td>
</tr>
<tr> 
    <td class="td_width">설문목적 :</td>
    <td class="td_content">
    <c:out value="${fn:replace(Comtnqestnrinfo[0].qestnrPurps , crlf , '<br/>')}" escapeXml="false" />
    </td>
</tr>
<tr> 
    <td class="td_width"> 설문작성 안내내용 :</td>
    
    <td class="td_content">
    <c:out value="${fn:replace(Comtnqestnrinfo[0].qestnrWritngGuidanceCn , crlf , '<br/>')}" escapeXml="false" />
    </td>
</tr>
<tr> 
    <td class="td_width">
        설문대상  :
            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '1'}">학생</c:if>
            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '2'}">대학생</c:if>
            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '3'}">직장인</c:if>
            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '4'}">군인</c:if>
            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '5'}">교사</c:if>
            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '6'}">기타</c:if>
    </td>
    <td class="td_content">
        설문기간 :
        ${Comtnqestnrinfo[0].qestnrBeginDe}~${Comtnqestnrinfo[0].qestnrEndDe}
    </td>
</tr> 
</table>
<%-- 
객
qestnrStatistic1
주
qestnrStatistic1
--%>
<ul>
<c:forEach items="${Comtnqustnrqesitm}" var="QestmInfo" varStatus="status1">
<li>
        <table width="95%" border="1" cellpadding="2" cellspacing="0">
        <tr>
            <td style="background-color:#E3E3E3;"><img alt="설문문항" src="<c:url value='/images/required.gif'/>" width="15" height="15">${status1.count}. <c:out value="${fn:replace(QestmInfo.qestnCn , crlf , '<br/>')}" escapeXml="false" /></td>
        </tr>
        <tr>
        <td style="padding:0px 0px 0px 0px;margin:0px 0px 0px 0px;background-color:#E3E3E3;">
                            
            <table width="90%" border="0" cellpadding="0" cellspacing="0">
            
                <%-- 객관식 일때  --%>
                <c:if test="${QestmInfo.qestnTyCode ==  '1'}">
                <%-- 설문항목 LOOP --%>
                <c:set var="chartCount" value="1" />
                <c:forEach items="${Comtnqustnriem}" var="QestmItem" varStatus="status2">
                <c:set var="chartCheck" value="0" />
                <%-- 해당 설문문항 AND 설문문항  체크 --%>
                <c:if test="${QestmInfo.qestnrTmplatId eq QestmItem.qestnrTmplatId && QestmInfo.qestnrId eq QestmItem.qestnrId && QestmInfo.qestnrQesitmId eq QestmItem.qestnrQesitmId}">
                <tr>
                    <td style="background-color:#E3E3E3;" width="10px" height="28px"></td>
                    <td style="background-color:#E3E3E3;" width="100px"><c:out value="${fn:replace(QestmItem.iemCn , crlf , '<br/>')}" escapeXml="false" /></td>
                    <td style="background-color:#E3E3E3;">
                    <%-- 설문통계(객관식) LOOP --%>
                    <c:forEach items="${qestnrStatistic1}" var="QestmStatistic1" varStatus="status3">
                        <c:if test="${QestmInfo.qestnrTmplatId eq QestmStatistic1.qestnrTmplatId && QestmInfo.qestnrId eq QestmStatistic1.qestnrId && QestmStatistic1.qestnrQesitmId eq QestmItem.qestnrQesitmId && QestmStatistic1.qustnrIemId eq QestmItem.qustnrIemId}">
                        <img alt="항목별 그래프 이미지" src="${ImgUrl}chart/chart${chartCount}.JPG" width="${QestmStatistic1.qustnrPercent}px" height="8"> ${QestmStatistic1.qustnrPercent}%
                        <c:set var="chartCheck" value="${chartCheck+1}" />
                    </c:if>
                    </c:forEach>
                    <c:if test="${chartCheck eq 0}">
                    <img alt="항목별 그래프 이미지" src="${ImgUrl}chart/chart${chartCount}.JPG" width="0 px" height="8"> 0%
                    </c:if>
                    </td>
                </tr>
                <c:set var="chartCount" value="${chartCount+1}" />
                </c:if>
                </c:forEach>
                </c:if>
                
                <%-- 주관식 --%>
                <c:if test="${QestmInfo.qestnTyCode ==  '2'}">
                <%-- 설문통계(객관식) LOOP --%>
                <c:forEach items="${qestnrStatistic2}" var="QestmStatistic2" varStatus="status4">
                    <c:if test="${QestmInfo.qestnrTmplatId eq QestmStatistic2.qestnrTmplatId && QestmInfo.qestnrId eq QestmStatistic2.qestnrId && QestmInfo.qestnrQesitmId eq QestmStatistic2.qestnrQesitmId}">
                    <tr>    
                        <td style="background-color:#E3E3E3;" width="10px" align="right" valign="top"></td>
                        <td style="background-color:#E3E3E3;" >
                        <br>
                        <c:out value="${fn:replace(QestmStatistic2.respondNm , crlf , '<br/>')}" escapeXml="false" /> : <c:out value="${fn:replace(QestmStatistic2.respondAnswerCn , crlf , '<br/>')}" escapeXml="false" />
                        <br>
                        </td>
                    </tr>
                    </c:if>
                </c:forEach>
                </c:if>
            </table>                
        </td>
        </tr>
        </table>
</li>
<li>
    <input type="hidden" name="TY_${QestmInfo.qestnrQesitmId}" value="${QestmInfo.qestnTyCode}">
</li>
</c:forEach> 
</ul>                
                </div>
            </div>
            <!--detail area end -->


            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
                    <input type="submit" value="<spring:message code="button.inquire" />" onclick="fn_egov_list_QustnrRespondInfo(); return false;" />
            </div>
            </td></tr></table>
            <!-- 목록/저장버튼  끝-->

            <input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="${qestnrTmplatId}">
            <input name="qestnrId" id="qestnrId" type="hidden" value="${qestnrId}">
            
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