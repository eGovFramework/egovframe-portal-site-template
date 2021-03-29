<%--
  Class Name : EgovQustnrRespondInfoDetail.jsp
  Description : 설문조사 상세보기
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
<c:set var="ImgUrl" value="/images/egovframework/com/uss/olp/qri/"/>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>설문조사 상세</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
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
	location.href = "<c:url value='/uss/olp/qri/EgovQustnrRespondInfoList.do'/>";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_modify_QustnrRespondInfo(){
	var vFrom = document.QustnrRespondInfoForm;
	vFrom.cmd.value = '';
	vFrom.action = "<c:url value='/uss/olp/qri/EgovQustnrRespondInfoModify.do'/>";;
	vFrom.submit();

}
/* ********************************************************
 * 삭제처리
 ******************************************************** */
function fn_egov_delete_QustnrRespondInfo(){
	var vFrom = document.QustnrRespondInfoForm;
	if(confirm("삭제 하시겠습니까?")){
		vFrom.cmd.value = 'del';
		vFrom.action = "<c:url value='/uss/olp/qri/EgovQustnrRespondInfoDetail.do'/>";
		vFrom.submit();
	}else{
		vFrom.cmd.value = '';
	}
}
</script>
</head>
<body onLoad="fn_egov_init_QustnrRespondInfo();">
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
    <div id="title_img_div"><img src="<c:url value='/'/>images/title_image/img_title03.gif" alt="" /></div>
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
                            <li>알림마당</li>
                            <li>&gt;</li>
                            <li><strong>공지사항</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
            <form name="QustnrRespondInfoForm" id="QustnrRespondInfoForm" action="<c:url value='/uss/olp/qri/EgovQustnrRespondInfoModify.do'/>" method="post">
            
            <!-- sub title start -->
            <div><h2>설문조사 상세보기</h2></div>
            <!-- sub title end -->


            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">
					<table  summary="이 표는 설문조사 대상 정보를 제공하며, 설문관리정보, 설문문항정보, 설문유형, 성문항목정보, 응답자답변내용, 기타답변내용, 응답자명 정보로 구성되어 있습니다 .">
						<tr> 
						    <td class="td_width">설문관리정보</td>
						    <td class="td_content">
						    <c:out value="${fn:replace(resultList[0].qestnrSj , crlf , '<br/>')}" escapeXml="false" />
						    <input name="qestnrId" type="hidden" value="${resultList[0].qestnrId}">
						    <input name="qestnrTmplatId" type="hidden" value="${resultList[0].qestnrTmplatId}">  
						    </td>
						</tr>
						<tr> 
						    <td class="td_width">설문문항정보</td>
						    <td class="td_content">
						    <c:out value="${fn:replace(resultList[0].qestnCn , crlf , '<br/>')}" escapeXml="false" />
						    <input name="qestnrQesitmId" type="hidden" value="${resultList[0].qestnrQesitmId}">
						    </td>
						</tr>
						<tr> 
						    <td class="td_width">설문유형</td>
						    <td class="td_content">
						    <c:if test="${resultList[0].qestnTyCode == '1'}">객관식</c:if>
						    <c:if test="${resultList[0].qestnTyCode == '2'}">주관식</c:if>
						      <!-- <input name="title" type="text" size="73" value="" maxlength="70" style="width:100%;">   -->
						    </td>
						</tr>
						<tr> 
						    <td class="td_width">설문항목정보</td>
						    <td class="td_content">
						        <c:out value="${fn:replace(resultList[0].iemCn , crlf , '<br/>')}" escapeXml="false" />
						        <input name="qustnrIemId" type="hidden" value="${resultList[0].qustnrIemId}">
						    </td>
						</tr>   
						<tr> 
						    <td class="td_width">응답자답변내용<br>(주관식)</td>
						    <td class="td_content">
						      <br>
						      <c:out value="${fn:replace(resultList[0].respondAnswerCn , crlf , '<br/>')}" escapeXml="false" />
						      <br><br>
						    </td>
						</tr>
						<tr> 
						    <td class="td_width">기타답변내용</td>
						    <td class="td_content">
						      <br>
						      <c:out value="${fn:replace(resultList[0].etcAnswerCn , crlf , '<br/>')}" escapeXml="false" />
						      <br><br>
						    </td>
						</tr>
						<tr> 
						    <td class="td_width">응답자명</td>
						    <td class="td_content">
						         <c:out value="${fn:replace(resultList[0].respondNm , crlf , '<br/>')}" escapeXml="false" />
						    </td>
						</tr>
					</table>
                </div>
            </div>
            <!--detail area end -->
            
            <input name="qestnrQesrspnsId" type="hidden" value="<c:out value="${resultList[0].qestnrQesrspnsId}" />">
            <input name="cmd" type="hidden" value="">
            <div style="visibility:hidden;display:none;"><input name="iptSubmit" type="submit" value="전송" title="전송"></div>
            </form>
                
            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr>
	            <td>
	            <div class="buttons" align="center" style="margin-bottom:100px">
	                <form name="formList" action="<c:url value='/uss/olp/qri/EgovQustnrRespondInfoList.do'/>" method="post">
				    <input type="submit" value="<spring:message code="button.list" />" onclick="fn_egov_list_QustnrRespondInfo(); return false;"/>
				    </form>
	            </div>
	            </td>
	            <td>
                <div class="buttons" align="center" style="margin-bottom:100px">
                    <form name="formDelete" action="<c:url value='/uss/olp/qri/EgovQustnrRespondInfoDetail.do'/>" method="post"> 
				    <input type="submit" value="<spring:message code="button.delete" />" onclick="fn_egov_delete_QustnrRespondInfo(); return false;"/>
				    <input name="qestnrQesrspnsId" type="hidden" value="${resultList[0].qestnrQesrspnsId}"/>
				    <input name="cmd" type="hidden" value="del"/>
				    </form>
                </div>
                </td>
                <td>
                <div class="buttons" align="center" style="margin-bottom:100px">
                    <form name="formUpdt" action="<c:url value='/uss/olp/qri/EgovQustnrRespondInfoModify.do'/>" method="post"> 
				    <input type="submit" value="<spring:message code="button.update" />" onclick="fn_egov_modify_QustnrRespondInfo(); return false;"/>
				    <input name="qestnrQesrspnsId" type="hidden" value="${resultList[0].qestnrQesrspnsId}"/>
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