<%--
  Class Name : EgovQnaDetailInqure.jsp
  Description : EgovQnaDetailInqure 화면
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
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Q&amp;A 상세조회</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javaScript" language="javascript">

/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_inqire_qnalist() {

	document.QnaManageForm.action = "<c:url value='/uss/olh/qna/QnaListInqire.do'/>";
	document.QnaManageForm.submit();
		
}

/* ********************************************************
 * 수정처리화면
 ******************************************************** */
function fn_egov_updt_qnacn(qaId){

	// Update하기 위한 키값을 셋팅
	document.QnaManageForm.qaId.value = qaId;	

	var url 	= "<c:url value='/uss/olh/qna/QnaPasswordConfirmView.do'/>";
	var	status 	= "dialogWidth=350px;dialogHeight=200px;resizable=no;center=yes";

	
	// 작성비밀번호 확인 화면을 호출한다.
	var returnValue = window.showModalDialog(url, self, status);

	// 결과값을 받아. 결과를 Submit한다.
 	if	(returnValue)	{

 		document.QnaManageForm.action = "<c:url value='/uss/olh/qna/QnaPasswordConfirm.do'/>"; 	 	
 		document.QnaManageForm.submit();
 		
 	}
	
}

/**********************************************************
 * 삭제처리화면
 ******************************************************** */
function fn_egov_delete_qnacn(qaId){

	if	(confirm("<spring:message code="common.delete.msg" />"))	{	

		// Delete하기 위한 키값을 셋팅
		document.QnaManageForm.qaId.value = qaId;	
		document.QnaManageForm.action = "<c:url value='/uss/olh/qna/QnaCnDelete.do'/>";
		document.QnaManageForm.submit();
			
	}	
	
}

/*********************************************************
 * 작성비밀번호.체크..
 ******************************************************** */
function fn_egov_passwordConfirm(){

	alert("작성 비밀번호를 확인 바랍니다!");
	
}


</script>
</head>
 
<body>

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
			<form name="QnaManageForm" action="<c:url value='/uss/olh/qna/QnaPasswordConfirm.do'/>" method="post">
			<input name="qaId" type="hidden" value="<c:out value='${result.qaId}'/>">

            <!-- sub title start -->
            <div><h2>Q&amp;A상세조회</h2></div>
            <!-- sub title end -->
            
            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">                  
					<table summary="Q&amp;A에 대한 정보를 조회합니다.">
					<caption>Q&amp;A상세조회</caption>  
					  <tr> 
					    <td class="td_width">작성자명&nbsp;&nbsp;</td>
					    <td class="td_content">
					        <c:out value="${result.wrterNm}"/>  
					    </td>
					  </tr>
					
					  <tr> 
					    <td class="td_width">전화&nbsp;&nbsp;</td>
					    <td class="td_content">    
					      <c:out value="${result.areaNo}"/>-<c:out value="${result.middleTelno}"/>-<c:out value="${result.endTelno}"/>                      
					    </td>
					  </tr> 
					
					  <tr> 
					    <td class="td_width">작성일자&nbsp;&nbsp;</td>
					    <td class="td_content">
					        <c:out value='${fn:substring(result.writngDe, 0,4)}'/>-<c:out value='${fn:substring(result.writngDe, 4,6)}'/>-<c:out value='${fn:substring(result.writngDe, 6,8)}'/>  
					    </td>
					  </tr>
					
					  <tr> 
					    <td class="td_width">조회횟수&nbsp;&nbsp;</td>
					    <td class="td_content">
					        <c:out value="${result.inqireCo}"/>  
					    </td>
					  </tr>
					
					  <tr> 
					    <td class="td_width">질의응답처리상태&nbsp;&nbsp;</td>
					    <td class="td_content">
					        <c:out value="${result.qnaProcessSttusCodeNm}"/>  
					    </td>
					  </tr>
					
					  <tr> 
					    <td class="td_width">질문제목&nbsp;&nbsp;</td>
					    <td class="td_content">    
					      <c:out value="${result.qestnSj}"/>                 
					    </td>
					  </tr> 
					
					  <tr> 
					    <td class="td_width"><label for="qestnCn">질문내용</label>&nbsp;&nbsp;</td>
					    <td class="td_content">    
					      <textarea id="qestnCn" name="qestnCn" cols="95" rows="10"  readonly title="질문내용"><c:out value="${result.qestnCn}"/>
					      </textarea>                       
					    </td>
					  </tr> 
					
					<!-- 답변내용이 있을경우 Display... -->
					<c:if test="${result.qnaProcessSttusCode == '3'}">
					  <tr> 
					    <td class="td_width"><label for="answerCn">답변내용</label>&nbsp;&nbsp;</td>
					    <td class="td_content">    
					      <textarea name="answerCn" cols="95" rows="5"  readonly="readonly" title="답변내용"><c:out value="${result.answerCn}"/>
					      </textarea>                                        
					    </td>
					  </tr> 
					  <tr> 
                        <td class="td_width">답변일자&nbsp;&nbsp;</td>
                        <td class="td_content">
                            <c:if test="${result.answerDe != null}">
                                <c:out value='${fn:substring(result.answerDe, 0,4)}'/>-<c:out value='${fn:substring(result.answerDe, 4,6)}'/>-<c:out value='${fn:substring(result.answerDe, 6,8)}'/>                                                           
                            </c:if>
                        </td>
                      </tr>
                      <!-- 
                      <tr> 
					    <td class="td_width">담당부서&nbsp;&nbsp;</td>
					    <td class="td_content">
					        <c:out value="${result.orgnztNm}"/>
					    </td>
					  </tr>
					  
					  <tr> 
					    <td class="td_width">답변자&nbsp;&nbsp;</td>
					    <td class="td_content">
					        <c:out value="${result.emplyrNm}"/>
					    </td>
					  </tr>
					  <tr> 
					    <td class="td_width">전화번호&nbsp;&nbsp;</td>
					    <td class="td_content">
					        <c:out value="${result.offmTelno}"/>
					    </td>
					  </tr>
					  <tr> 
					    <td class="td_width">이메일&nbsp;&nbsp;</td>
					    <td class="td_content">
					        <c:out value="${result.aemailAdres}"/>
					    </td>
					  </tr>
					   -->
					</c:if>
					</table>
                </div>
            </div>
            <!--detail area end -->
            
            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
			  <input type="submit" value="<spring:message code="button.update" />" onclick="fn_egov_updt_qnacn('<c:out value="${result.qaId}"/>'); return false;" />
			  <a href="<c:url value='/uss/olh/qna/QnaCnDelete.do'/>?qaId=<c:out value='${result.qaId}'/>" onclick="fn_egov_delete_qnacn('<c:out value="${result.qaId}"/>'); return false;"><spring:message code="button.delete" /></a>
			  <a href="<c:url value='/uss/olh/qna/QnaListInqire.do'/>" onclick="fn_egov_inqire_qnalist(); return false;"><spring:message code="button.list" /></a>
            </div>
            </td></tr></table>
            <!-- 목록/저장버튼  끝-->
            
			<c:if test="${result.passwordConfirmAt == 'N,'}">
			  <tr> 
			  	<td class="lt_text3" colspan=10>  		
				<script type="text/javascript">
					fn_egov_passwordConfirm();
				</script>  		
			  	</td>
			  </tr>   	          				 			   
			</c:if>

			<input name="writngPassword" 	type="hidden" value="">
			<input name="passwordConfirmAt" type="hidden" value="">
			
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