<%--
  Class Name : EgovQnaCnUpdt.jsp
  Description : EgovQnaCnUpdt 화면
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
<title>Q&amp;A 수정</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="qnaManageVO" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javaScript" language="javascript">

/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_initl_qnacn(){

	// 첫 입력란에 포커스..

	
}

/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_updt_qnacn(form, qaId){

	if (!validateQnaManageVO(form)) {
			 			
		return;
			
	} else {

		form.qaId.value = qaId;
		form.action = "<c:url value='/uss/olh/qna/QnaCnUpdt.do'/>";
		form.submit();	
										
	}
			
}

/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_inqire_qnalist() {

	qnaManageVO.action = "<c:url value='/uss/olh/qna/QnaListInqire.do'/>";
	qnaManageVO.submit();
		
}


</script>
</head>
<body onLoad="fn_egov_initl_qnacn();">

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
                            <li><strong>Q&amp;A</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
			<!-- 상단타이틀 -->
			<form:form commandName="qnaManageVO" name="qnaManageVO" action="${pageContext.request.contextPath}/uss/olh/qna/QnaCnUpdt.do" method="post"> 	 
			<input name="qaId" type="hidden" value="<c:out value='${result.qaId}'/>">
			<input name="answerCn" type="hidden" value="Testing...">
			
			<!-- sub title start -->
            <div><h2>Q&amp;A 등록 및 수정</h2></div>
            <!-- sub title end -->
            
            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">                  
					<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="Q&amp;A에 대한 정보를 수정합니다.">
					<caption>Q&amp;A내용수정</caption>
					  <tr> 
					    <td class="td_width"><label for="wrterNm">작성자명</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수항목"></td>
					    <td class="td_content">
					        <form:input path="wrterNm" size="20" maxlength="20" title="작성자명"/>
					        <form:errors path="wrterNm"/>
					    </td>
					  </tr>
					  
					  <tr> 
					    <td class="td_width"><label for="writngPassword">작성 비밀번호</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수항목"></td>
					    <td class="td_content">
					        <input id="writngPassword" name="writngPassword" type="password" size="20" value="<c:out value='${result.writngPassword}'/>"  maxlength="20" title="작성 비밀번호">                     
					    </td>
					  </tr>
					  
					  <tr> 
					    <td class="td_width"><label for="areaNo">전화번호</label></td>
					    <td class="td_content">
					        <form:input path="areaNo" size="4" maxlength="4" title="전화번호(지역)"/>-<form:input path="middleTelno" size="4" maxlength="4" title="전화번호(국번)"/>-<form:input path="endTelno" size="4" maxlength="4" title="전화번호(지번)"/>
					        <form:errors path="areaNo"/> 
					        <form:errors path="middleTelno"/>
					        <form:errors path="endTelno"/>                        
					    </td>
					  </tr> 
					
					  <tr> 
					    <td class="td_width"><label for="emailAdres">이메일</label></td>
					    <td class="td_content">
					        <input id="emailAdres" name="emailAdres" type="text" size="30" value="<c:out value='${result.emailAdres}'/>" maxlength="30" title="이메일">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					        <input type="hidden" name = "emailAnswerAt" id ="emailAnswerAt" value="N"/>
					    </td>
					  </tr> 
					
					  <tr> 
					    <td class="td_width"><label for="qestnSj">질문제목</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수항목"></td>
					    <td class="td_content">    
					        <form:input path="qestnSj" size="70" maxlength="70"  title="질문제목"/>
					        <form:errors path="qestnSj"/>                                                                                         
					    </td>
					  </tr> 
					
					  <tr> 
					    <td class="td_width"><label for="qestnCn">질문내용</label><img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수항목"></td>
					    <td class="td_content">    
					      <form:textarea path="qestnCn" cols="95" rows="20" cssClass="txaClass"  title="질문내용"/>   
					      <form:errors path="qestnCn"/>                                                                                              
					    </td>
					  </tr> 
					   
					</table>
                </div>
            </div>
            <!--detail area end -->
            
            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
                <input type="submit" value="<spring:message code="button.save" />" onclick="fn_egov_updt_qnacn(document.qnaManageVO,'<c:out value="${result.qaId}"/>'); return false;" />
                <a href="<c:url value='/uss/olh/qna/QnaListInqire.do'/>" onclick="fn_egov_inqire_qnalist(); return false;"><spring:message code="button.list" /></a>
            </div>
            </td></tr></table>
            <!-- 목록/저장버튼  끝-->
	  
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