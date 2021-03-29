<%--
  Class Name : EgovQustnrManageModify.jsp
  Description : 설문관리 수정 페이지
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
<c:set var="ImgUrl" value="/images/egovframework/com/uss/olp/qmc/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>설문관리 수정</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js' />"></script>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="qustnrManageVO" staticJavascript="false" xhtml="true" cdata="false"/>

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
function fn_egov_save_QustnrManage(form){

	var sStartDay = form.qestnrBeginDe.value.replaceAll("-","");
	var sEndDay = form.qestnrEndDe.value.replaceAll("-","");

	var iStartDay = parseInt(sStartDay);
	var iEndDay = parseInt(sEndDay);
	
	if(confirm("<spring:message code='common.save.msg' />")){
		if(!validateQustnrManageVO(form)){ 			
			return;
		}else{
			if(iStartDay > iEndDay || iEndDay < iStartDay){
				alert("설문기간  시작일은 종료일  보다 클수 없고 \n\n설문기간 종료일은 시작일 보다 작을수 없습니다!");
				return;
			}
			form.submit();
		}
	}
}

/* ********************************************************
* PROTOTYPE JS FUNCTION
******************************************************** */
String.prototype.trim = function(){
	return this.replace(/^\s+|\s+$/g, "");
}

String.prototype.replaceAll = function(src, repl){
	 var str = this;
	 if(src == repl){return str;}
	 while(str.indexOf(src) != -1) {
	 	str = str.replace(src, repl);
	 }
	 return str;
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
            
            <c:set var="qustnrManageVO.qestnrSj" value="${resultList[0].qestnrPurps}"/>
            <form:form commandName="qustnrManageVO" name="qustnrManageVO">
            
            <!-- sub title start -->
            <div><h2>설문관리 수정</h2></div>
            <!-- sub title end -->

            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">
					<table summary="설문관리정보 수정정보를  제공한다">
					<caption>설문관리 수정정보</caption>
					  <tr> 
					    <td class="td_width"><label for="qestnrSj">설문제목</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					      
					      <form:input path="qestnrSj" size="73" cssClass="txaIpt" maxlength="250" title="설문제목 입력" />
					      <form:errors path="qestnrSj"/>
					    </td>
					  </tr>
					  <tr> 
					    <td class="td_width"><label for="qestnrPurps">설문목적</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					        <form:textarea path="qestnrPurps" rows="3" cols="100" title="설문목적 입력" />
					        <form:errors path="qestnrPurps"/>
					    </td>
					  </tr>
					  <tr> 
					    <td class="td_width"><label for="qestnrWritngGuidanceCn">설문작성안내 내용</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					        <form:textarea path="qestnrWritngGuidanceCn" rows="3" cols="100" title="설문작성안내내용 입력"/>
					        <form:errors path="qestnrWritngGuidanceCn"/>
					    </td>
					  </tr> 
					  
					  <tr> 
					    <td class="td_width"><label for="qestnrTrget">설문대상</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					        <form:select path="qestnrTrget" title="설문대상 선택">
					            <option value="">선택</option>
					            <form:options items="${comCode034}" itemValue="code" itemLabel="codeNm"/>
					        </form:select>
					        <div><form:errors path="qestnrTrget"/></div> 
					    </td>
					  </tr>
					  
					  <tr> 
					    <td class="td_width"><label for="qestnrBeginDe">설문기간</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					      <form:input path="qestnrBeginDe" size="10" maxlength="10" readonly="true" title="설문기간 시작일 입력" />
					      <form:errors path="qestnrBeginDe"/>
					      <a href="#LINK" onClick="javascript:fn_egov_NormalCalendar(document.forms[0], document.forms[0].qestnrBeginDe);">
					      <img src="<c:url value='/images/calendar.gif' />" align="middle" style="border:0px" alt="설문기간시작달력" title="새창">
					      </a>
					      ~<form:input path="qestnrEndDe" size="10" maxlength="10" readonly="true" title="설문기간  종료일 입력"/>
					      <form:errors path="qestnrEndDe"/>
					      <a href="#LINK" onClick="javascript:fn_egov_NormalCalendar(document.forms[0], document.forms[0].qestnrEndDe);">
					      <img src="<c:url value='/images/calendar.gif' />" align="middle"  style="border:0px" alt="설문기간종료달력" title="새창">
					      </a>
					    </td>
					  </tr>
					  
					    <tr> 
					    <td class="td_width">템플릿 유형<img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					        <c:forEach items="${listQustnrTmplat}" var="resultQustnrTmplat" varStatus="status">
					          <img src="${pageContext.request.contextPath}/uss/olp/qtm/EgovQustnrTmplatManageImg.do?qestnrTmplatId=${resultQustnrTmplat.qestnrTmplatId}" align="middle" alt="템플릿유형 이미지" title="템플릿유형 이미지">
					        </c:forEach>
					        <c:forEach items="${listQustnrTmplat}" var="resultQustnrTmplat" varStatus="status">
					          <input type="radio" name="qestnrTmplatIds" value="${resultQustnrTmplat.qestnrTmplatId}" style="border:0px" <c:if test="${resultList[0].qestnrTmplatId ==  resultQustnrTmplat.qestnrTmplatId}">checked</c:if> disabled />${resultQustnrTmplat.qestnrTmplatTy}
					        </c:forEach>
					    </td>
					  </tr>
					</table>                
                </div>
            </div>
            <!--detail area end -->
            
            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
                <a href="<c:url value='/uss/olp/qmc/EgovQustnrManageList.do'/>">목록</a>
                <input type="submit" value="저장" onclick="fn_egov_save_QustnrManage(this.form); return false;"/>
            </div>
            </td></tr></table>
            <!-- 목록/저장버튼  끝-->

			<input name="qestnrTmplatId" type="hidden" value="${resultList[0].qestnrTmplatId}">
			<input name="qestnrId" type="hidden" value="${resultList[0].qestnrId}">
			<input name="cmd" type="hidden" value="<c:out value='save'/>">
			<input type="hidden" name="cal_url" value="<c:url value='/sym/cal/EgovNormalCalPopup.do'/>">
			</form:form>

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