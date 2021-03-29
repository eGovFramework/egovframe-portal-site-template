<%--
  Class Name : EgovQustnrManageDetail.jsp
  Description : 설문관리 상세보기
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
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images/egovframework/com/uss/olp/qmc/"/>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>설문관리 상세조회</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javaScript" language="javascript">


/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrManage(){

}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_QustnrManage(){
	location.href = "<c:url value='/uss/olp/qmc/EgovQustnrManageList.do'/>";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_modify_QustnrManage(){
	var vFrom = document.QustnrManageForm;
	vFrom.cmd.value = '';
	vFrom.action = "<c:url value='/uss/olp/qmc/EgovQustnrManageModify.do'/>";;
	vFrom.submit();

}
/* ********************************************************
 * 삭제처리
 ******************************************************** */
function fn_egov_delete_QustnrManage(){
	var vFrom = document.QustnrManageForm;

	if(confirm("삭제시 설문관리, 설문항목, 설문문항, 설문응답자관리, 설문조사(설문결과)\n정보가 함께 삭제됩니다!\n\n삭제 하시겠습니까?")){
		vFrom.cmd.value = 'del';
		vFrom.action = "<c:url value='/uss/olp/qmc/EgovQustnrManageDetail.do'/>";
		vFrom.submit();
	}else{
		vFrom.cmd.value = '';
	}
}
</script>
</head>
<body onLoad="fn_egov_init_QustnrManage();">
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
    <div id="title_img_div"><img src="<c:url value='/'/>images/title_image/img_title05.gif" alt="" /></div>
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
                            <li>포털서비스관리</li>
                            <li>&gt;</li>
                            <li>설문관리</li>
                            <li>&gt;</li>
                            <li><strong>설문지</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
			<form name="QustnrManageForm" action="<c:url value='/uss/olp/qmc/EgovQustnrManageDetail.do'/>" method="post">

            <!-- sub title start -->
            <div><h2>설문관리 상세보기</h2></div>
            <!-- sub title end -->

            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">
                    <!--<table summary="SUMMARY">
                        <tr> 
                            <td class="td_width">
                                
                            </td>
                            <td class="td_content">
                                <form:input path="mberId" id="mberId" size="20" cssClass="txaIpt" readonly="true" maxlength="20" />
                                <div><form:errors path="mberId" cssClass="error" /></div>
                                <form:hidden path="uniqId" />
                            </td>
                        </tr>
                    </table>-->
					<table  summary="상세조회 목록을 제공한다.">
					<caption>설문관리 상세조회 정보를 제공한다</caption>
					  <tr> 
					    <td class="td_width">설문제목</td>
					    <td class="td_content">
					       ${resultList[0].qestnrSj}  
					    </td>
					  </tr>
					  <tr> 
					    <td class="td_width">설문목적</td>
					    <td class="td_content">
					      <br>
					      <c:out value="${fn:replace(resultList[0].qestnrPurps , crlf , '<br/>')}" escapeXml="false" />
					      <br><br>
					    </td>
					  </tr>
					  <tr> 
					    <td class="td_width">설문작성안내 내용</td>
					    <td class="td_content">
					      <br>
					      <c:out value="${fn:replace(resultList[0].qestnrWritngGuidanceCn , crlf , '<br/>')}" escapeXml="false" />
					      <br><br>
					    </td>
					  </tr> 
					  
					  <tr> 
					    <td class="td_width">설문대상</td>
					    <td class="td_content">
					    
					<c:forEach items="${comCode034}" var="comCodeList" varStatus="status">
					<c:if test="${comCodeList.code eq resultList[0].qestnrTrget}">  
					<c:out value="${fn:replace(comCodeList.codeNm , crlf , '<br/>')}" escapeXml="false" />
					</c:if>
					</c:forEach>
					
					    </td>
					  </tr>
					  
					  <tr> 
					    <td class="td_width">설문기간</td>
					    <td class="td_content">
					       ${resultList[0].qestnrBeginDe}~${resultList[0].qestnrEndDe}
					    </td>
					  </tr>
					  
					    <tr> 
					    <td class="td_width">템플릿 유형</td>
					    <td class="td_content">
					      ${resultList[0].qestnrTmplatTy} <img src="${pageContext.request.contextPath}/uss/olp/qtm/EgovQustnrTmplatManageImg.do?qestnrTmplatId=${resultList[0].qestnrTmplatId}" align="middle" alt="템플릿유형 이미지" title="템플릿유형 이미지"> 
					    </td>
					  </tr>
					</table>                    
                </div>
            </div>
            <!--detail area end -->
            
            <input name="qestnrId" type="hidden" value="${resultList[0].qestnrId}">
			<input name="cmd" type="hidden" value="<c:out value=''/>">
			<div style="visibility:hidden;display:none;"><input name="iptSubmit" type="submit" value="전송" title="전송"></div>
			</form>
                
            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr>
	            <td>
	            <div class="buttons" align="center" style="margin-bottom:100px">
	                <form name="formUpdt" action="<c:url value='/uss/olp/qmc/EgovQustnrManageModify.do'/>" method="post"> 
			            <input type="submit" value="<spring:message code="button.update" />" onclick="fn_egov_modify_QustnrManage(); return false;" />
			            <input name="qestnrId" type="hidden" value="${resultList[0].qestnrId}"/>
			        </form>
	            </div>
	            </td>
	            <td>
	            <div class="buttons" align="center" style="margin-bottom:100px">
	                <form name="formDelete" action="<c:url value='/uss/olp/qmc/EgovQustnrManageDetail.do'/>" method="post"> 
			        <input type="submit" value="<spring:message code="button.delete" />" onclick="fn_egov_delete_QustnrManage(); return false;"/>
			        <input name="qestnrId" type="hidden" value="${resultList[0].qestnrId}"/>
			        <input name="cmd" type="hidden" value="del"/>
			        </form>
	            </div>
	            </td>
	            <td>
	            <div class="buttons" align="center" style="margin-bottom:100px">
	                <form name="formList" action="<c:url value='/uss/olp/qmc/EgovQustnrManageList.do'/>" method="post">
			        <input type="submit" value="<spring:message code="button.list" />" onclick="fn_egov_list_QustnrManage(); return false;"/>
			        </form>
	            </div>
	            </td>
            </tr></table>
            <!-- 목록/저장버튼  끝-->

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