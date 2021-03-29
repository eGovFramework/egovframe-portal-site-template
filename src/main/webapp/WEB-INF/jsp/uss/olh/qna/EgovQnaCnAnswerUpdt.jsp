<%--
  Class Name : EgovQnaCnAnswerUpdt.jsp
  Description : EgovQnaCnAnswerUpdt 화면
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
<title>Q&amp;A내용답변수정</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="qnaManageVO" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javaScript" language="javascript">

/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_initl_qnacnanswer(){

	// 첫 입력란에 포커스..
	qnaManageVO.answerCn.focus();
	
}

/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_updt_qnacnanswer(form, qaId){

	// 서버사이드 테스트용
	/*	
		form.action = "<c:url value='/uss/olh/qnm/QnaCnAnswerUpdt.do'/>";
		form.submit(); 
		return;
	*/

	if (!validateQnaManageVO(form)) {
			
		return;
		
	} else {

	
		form.qaId.value = qaId;
		form.action = "<c:url value='/uss/olh/qnm/QnaCnAnswerUpdt.do'/>";
		form.submit();	
				
	}
		
}

/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_inqire_qnaanswerlist() {

	qnaManageVO.action = "<c:url value='/uss/olh/qnm/QnaAnswerListInqire.do'/>";
	qnaManageVO.submit();
		
}

/* ********************************************************
 * 메일발송을 위한 화면을 호출
 ******************************************************** */
function fn_egov_pop_mailform() {
/*	
	var url 	= "<c:url value='/ems/insertSndngMailView.do'/>";	
	var	status 	= "width=640,height=480,top=200,left=200";

			
	window.open(url,'popup', status);
*/	 
}


</script>
</head>
<body onLoad="fn_egov_initl_qnacnanswer();">

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
                            <li>서비스관리</li>
                            <li>&gt;</li>
                            <li><strong>Q&amp;A답변관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
			<!-- 상단타이틀 -->
			<form:form commandName="qnaManageVO" name="qnaManageVO" action="${pageContext.request.contextPath}/uss/olh/qnm/QnaCnAnswerUpdt.do" method="post"> 
			<!-- hidden 화일정의-->	
			<input name="qaId" type="hidden" value="<c:out value='${result.qaId}'/>">
			<input name="writngPassword" type="hidden" value="<c:out value='${result.writngPassword}'/>">
			
			<!-- sub title start -->
            <div><h2>Q&amp;A내용답변수정</h2></div>
            <!-- sub title end -->
            
            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">                  
					<!-- 등록  폼 영역  -->
					<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="Q&amp;A에 대한 답변을 수정합니다.">
					  <caption>Q&amp;A답변수정</caption>
					  <tr> 
					    <td class="td_width"><label for="wrterNm">작성자명</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					        <input id="wrterNm" name="wrterNm" type="text" size="22" readonly value="<c:out value='${result.wrterNm}'/>" maxlength="20" title="작성자명">  
					    </td>
					  </tr>
					
					  <tr> 
					    <td class="td_width"><label for="areaNo">전화번호</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					        <input id="areaNo" name="areaNo" type="text" size="5"       readonly value="<c:out value='${result.areaNo}'/>" maxlength="5" title="전화번호(지역)">-
					        <input id="middleTelno" name="middleTelno" type="text" size="5"  readonly value="<c:out value='${result.middleTelno}'/>" maxlength="5" title="전화번호(국번)">-
					        <input id="endTelno" name="endTelno" type="text" size="5"     readonly value="<c:out value='${result.endTelno}'/>" maxlength="5" title="전화번호(지번)">               
					    </td>
					  </tr> 
					
					  <tr> 
					    <td class="td_width"><label for="emailAdres">이메일</label></td>
					    <td class="td_content">
					        <input id="emailAdres" name="emailAdres" type="text" size="30" readonly value="<c:out value='${result.emailAdres}'/>" maxlength="30" title="이메일">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					        <input type="hidden" name="emailAnswerAt" id="emailAnswerAt" value="N"/>
					    </td>
					  </tr> 
					
					  <tr> 
					    <td class="td_width"><label for="qestnSj">질문제목</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">    
					        <input id="qestnSj" name="qestnSj" type="text" size="70" readonly value="<c:out value="${result.qestnSj}"/>" maxlength="70" title="질문제목">                     
					    </td>
					  </tr> 
					
					  <tr> 
					    <td class="td_width"><label for="qestnCn">질문내용</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">    
					      <textarea id="qestnCn" name="qestnCn" class="textarea"  cols="95" rows="10"  readonly="readonly" title="질문내용"><c:out value="${result.qestnCn}"/>
					      </textarea>                                      
					    </td>
					  </tr> 
					
					  <tr> 
					    <td class="td_width"><label for="qnaProcessSttusCode">진행처리상태</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					        <select id="qnaProcessSttusCode" name="qnaProcessSttusCode" class="select" title="진행처리상태">
					            <c:forEach var="forResult" items="${resultList}" varStatus="status">
					                <option value='<c:out value="${forResult.code}"/>' <c:if test="${forResult.code == result.qnaProcessSttusCode}">selected="selected"</c:if> >
					                   <c:out value="${forResult.codeNm}"/>
					                </option>
					            </c:forEach>                                                   
					        </select>                   
					    </td>
					  </tr> 
					
					  <tr> 
					    <td class="td_width"><label for="answerCn">답변내용</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">    
					      <form:textarea path="answerCn" cols="95" rows="5" cssClass="txaClass" title="답변내용"/>   
					      <form:errors path="answerCn"/>                                                                              
					    </td>
					  </tr> 
					   
					</table>                    
                </div>
            </div>
            <!--detail area end -->

            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
                <input type="submit" value="저장" onclick="fn_egov_updt_qnacnanswer(document.qnaManageVO,'<c:out value="${result.qaId}"/>'); return false;"/>
                <a href="<c:url value='/uss/olh/qnm/QnaAnswerListInqire.do'/>" onclick="fn_egov_inqire_qnaanswerlist(); return false;"><spring:message code="button.list" /></a>
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