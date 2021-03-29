<%--
  Class Name : EgovQustnrQestnManageDetail.jsp
  Description : 설문문항 상세보기
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.19
   
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images/egovframework/com/uss/olp/qqm/"/>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>설문문항 상세조회</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrQestnManage(){

}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_QustnrQestnManage(){
	var vFrom = document.QustnrQestnManageForm;
	vFrom.cmd.value = '';
	vFrom.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageList.do'/>";
	vFrom.submit();
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_modify_QustnrQestnManage(){
	var vFrom = document.QustnrQestnManageForm;
	vFrom.cmd.value = '';
	vFrom.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageModify.do'/>";;
	vFrom.submit();

}
/* ********************************************************
 * 삭제처리
 ******************************************************** */
function fn_egov_delete_QustnrQestnManage(){
	var vFrom = document.QustnrQestnManageForm;
	if(confirm("삭제시  설문문항, 설문항목, 설문조사(설문결과)\n정보가 함께 삭제됩니다!\n\n삭제 하시겠습니까?")){
		vFrom.cmd.value = 'del';
		vFrom.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageDetail.do'/>";
		vFrom.submit();
	}else{
		vFrom.cmd.value = '';
	}
}
</script>
</head>
<body onLoad="fn_egov_init_QustnrQestnManage();">
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
                            <li><strong>설문문항</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
			<!-- 상단타이틀 -->
			<form name="QustnrQestnManageForm" id="QustnrQestnManageForm" action="<c:url value='/uss/olp/qqm/EgovQustnrQestnManageDetail.do'/>" method="post">
			
			<!-- sub title start -->
            <div><h2>설문문항 상세보기</h2></div>
            <!-- sub title end -->

            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">
					<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="설문문항 상세조회 정보를 제공한다.">
					<caption>설문문항 상세정보를 제공한다</caption>
					  <tr> 
					    <td class="td_width">설문지정보(제목)</td>
					    <td class="td_content">
					      ${resultList[0].qestnrSj}
					    </td>
					  </tr>
					  <tr> 
					    <td class="td_width">질문순번</td>
					    <td class="td_content">
					      ${resultList[0].qestnSn}  
					    </td>
					  </tr>
					  <tr> 
					    <td class="td_width">질문유형</td>
					    <td class="td_content">
							<c:forEach items="${cmmCode018}" var="comCodeList" varStatus="status">
							<c:if test="${comCodeList.code eq resultList[0].qestnTyCode}">  
							<c:out value="${fn:replace(comCodeList.codeNm , crlf , '<br/>')}" escapeXml="false" />
							</c:if>
							</c:forEach>
					    </td>
					  </tr>
					  <tr> 
					    <td class="td_width">질문 내용</td>
					    <td class="td_content">
					      <br>
					      <c:out value="${fn:replace(resultList[0].qestnCn , crlf , '<br/>')}" escapeXml="false" />
					      <br><br>
					    </td>
					  </tr> 
					  <tr> 
					    <td class="td_width">최대선택건수</td>
					    <td class="td_content">
					    ${resultList[0].mxmmChoiseCo}
					    </td>
					  </tr>
					</table>
                    
                </div>
            </div>
            <!--detail area end -->

			<input name="qestnrQesitmId" type="hidden" value="${resultList[0].qestnrQesitmId}">
			<input name="cmd" type="hidden" value="<c:out value=''/>">
			<%-- 설문지정보 상태유지 --%>
			<c:if test="${qustnrQestnManageVO.searchMode == 'Y'}">
			<input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="${qustnrQestnManageVO.qestnrTmplatId}">
			<input name="qestnrId" id="qestnrId" type="hidden" value="${qustnrQestnManageVO.qestnrId}">
			<input name="searchMode" id="searchMode" type="hidden" value="${qustnrQestnManageVO.searchMode}">
			</c:if>
			
			<div style="visibility:hidden;display:none;"><input name="iptSubmit" type="submit" value="전송" title="전송"></div>
			</form>
			
			<!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr>
            <td>
	            <div class="buttons" align="center" style="margin-bottom:100px">
	                <form name="formUpdt" action="<c:url value='/uss/olp/qqm/EgovQustnrQestnManageModify.do'/>" method="post"> 
				        <input type="submit" value="<spring:message code="button.update" />" onclick="fn_egov_modify_QustnrQestnManage(); return false;"/>
				        <c:if test="${qustnrQestnManageVO.searchMode == 'Y'}">
				        <input name="qestnrTmplatId" type="hidden" value="${qustnrQestnManageVO.qestnrTmplatId}"/>
				        <input name="qestnrId" type="hidden" value="${qustnrQestnManageVO.qestnrId}"/>
				        <input name="searchMode" type="hidden" value="${qustnrQestnManageVO.searchMode}"/>
				        </c:if>
				        <input name="qestnrQesitmId" type="hidden" value="${resultList[0].qestnrQesitmId}"/>
			        </form>
	            </div>
            </td>
            <td>
	            <div class="buttons" align="center" style="margin-bottom:100px">
	                <form name="formDelete" action="<c:url value='/uss/olp/qqm/EgovQustnrQestnManageDetail.do'/>" method="post"> 
				        <input type="submit" value="<spring:message code="button.delete" />" onclick="fn_egov_delete_QustnrQestnManage(); return false;"/>
				        <input name="qestnrQesitmId" type="hidden" value="${resultList[0].qestnrQesitmId}" />
				        <input name="cmd" type="hidden" value="del" />
			        </form>
	            </div>
            </td>
            <td>
	            <div class="buttons" align="center" style="margin-bottom:100px">
	                <form name="formList" action="<c:url value='/uss/olp/qqm/EgovQustnrQestnManageList.do'/>" method="post">
	                    <input type="submit" value="<spring:message code="button.list" />" onclick="fn_egov_list_QustnrQestnManage(); return false;" />
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