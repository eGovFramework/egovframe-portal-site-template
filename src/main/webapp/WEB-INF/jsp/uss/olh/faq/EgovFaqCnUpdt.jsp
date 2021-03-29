<%--
  Class Name : 
  Description : 
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01   박정규          최초 생성
     2011.07.18 옥찬우     경로수정( Line 161 : /com/cmm/fms/selectFileInfs.do -> /cmm/fms/selectFileInfs.do )
     2011.07.20 옥찬우     <Input> Tag id 속성추가( Line : 113 ) 파일 첨부 갯수 제한기능을 위한 내용추가 ( Line : 200 ~ 206 )
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 박정규
    since    : 2009.02.01
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page contentType="text/html; charset=utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<html>
<head>
<title>FAQ내용수정</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="faqManageVO" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javaScript" language="javascript">

/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_initl_faqcn(){

	// 첫 입력란에 포커스..
	faqManageVO.qestnSj.focus();
	
}

/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_updt_faqcn(form, faqId){

	// 서버사이드 테스트용
	/*	
		form.action = "<c:url value='/uss/olh/faq/FaqCnUpdt.do'/>";
		form.submit(); 
		return;
	*/

	if (!validateFaqManageVO(form)) {
			 			
		return;
			
	} else {

		// form.faqId.value = faqId; 주석처리
		form.action = "<c:url value='/uss/olh/faq/FaqCnUpdt.do'/>";
		form.submit();
			
	} 	
		
}

/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_inqire_faqcnlist() {

	faqManageVO.action = "<c:url value='/uss/olh/faq/FaqListInqire.do'/>";
	faqManageVO.submit();
		
}

function fn_egov_check_file(flag) {
	if(flag=="Y") {
		document.getElementById('file_upload_posbl').style.display = "block";
		document.getElementById('file_upload_imposbl').style.display = "none";			
	} else {
		document.getElementById('file_upload_posbl').style.display = "none";
		document.getElementById('file_upload_imposbl').style.display = "block";
	}
}	


</script>
</head>
<body onLoad="fn_egov_initl_faqcn();">
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
                            <li><strong>FAQ</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
            <!-- sub title start -->
            <div><h2>FAQ내용수정</h2></div>
            <!-- sub title end -->
			
			<!-- 상단타이틀 파일첨부를 위한 폼명 및 Enctype 설정-->
			<form:form commandName="faqManageVO" name="faqManageVO" action="${pageContext.request.contextPath}/uss/olh/faq/FaqCnUpdt.do" method="post"  enctype="multipart/form-data">
			<!-- FaqCnUpdtView.do Call을 위한 처리-->
            <input name="faqId" type="hidden" value="<c:out value='${result.faqId}'/>">
			<!-- 첨부파일을 위한 Hidden -->	
			<input type="hidden" name="posblAtchFileNumber" id="posblAtchFileNumber" value="3">  
			<!-- 첨부파일 삭제 후 리턴 URL -->
			<input type="hidden" name="returnUrl" id="returnUrl" value="<c:url value='/uss/olh/faq/FaqCnUpdtView.do'/>"/>	  

            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">                  
					<table summary="FAQ에 대한 정보를 수정합니다.">
					<caption>FAQ내용수정</caption>
					  <tr> 
					    <td class="td_width"><label for="qestnSj">질문제목</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					        <form:input path="qestnSj" size="70" maxlength="70" title="질문제목"/>
					        <form:errors path="qestnSj"/>                                
					    </td>
					  </tr>
					  <tr> 
					    <td class="td_width"><label for="qestnCn">질문내용</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content"> 
					      <form:textarea path="qestnCn" cols="100" rows="15" cssClass="txaClass"  title="질문내용"/>   
					      <form:errors path="qestnCn"/>                                                                       
					    </td>
					  </tr> 
					  <tr> 
					    <td class="td_width"><label for="answerCn">답변내용</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					      <form:textarea path="answerCn" cols="100" rows="15" cssClass="txaClass"  title="답변내용"/>   
					      <form:errors path="answerCn"/>                                                                       
					    </td>
					  </tr> 
					    
					 <!-- 첨부목록을 보여주기 위한 -->  
					    <c:if test="${result.atchFileId != ''}">
					    <tr> 
					        <td class="td_width">첨부파일 목록&nbsp;&nbsp;</td>
					            <td class="td_content">
					                <c:import charEncoding="utf-8" url="/cmm/fms/selectFileInfs.do" >
					                    <c:param name="param_atchFileId" value="${result.atchFileId}" />
					                </c:import>
					            </td>
					    </tr>
					    </c:if>
					 <!--첨부화일 업로드를 위한 Start -->
					  <tr> 
					    <td class="td_width"><label for="egovComFileUploader">파일첨부&nbsp;&nbsp;</label></td>
				        <td class="td_content">
				            <div id="file_upload_posbl" >   
				                <input name="file_1" id="egovComFileUploader" type="file" title="파일첨부" />
				                <div id="egovComFileList"></div>
				            </div>
				            <div id="file_upload_imposbl"  style="display:none;" >
				                <spring:message code="common.imposbl.fileupload" />
				            </div>      
				        </td>           
					  </tr>
					 <!-- 첨부화일 업로드를 위한 end..-->
					</table>
					<!-- 첨부파일 업로드 가능화일 설정(Update) Start..-->
                    <script type="text/javascript">
                    <!--
                        var existFileNum = null;        
                        var maxFileNum = null;
                        if (document.faqManageVO.fileListCnt != null) {
                            existFileNum = document.faqManageVO.fileListCnt.value;
                        }
                        if (document.getElementById('posblAtchFileNumber') != null) {
                            maxFileNum = document.getElementById('posblAtchFileNumber').value;
                        }
                        if(existFileNum=="undefined" || existFileNum ==null){
                            existFileNum = 0;
                        }
                    
                        if(maxFileNum=="undefined" || maxFileNum ==null){
                            maxFileNum = 0;
                        }       
                    
                        var uploadableFileNum = maxFileNum - existFileNum;
                    
                        if(uploadableFileNum<0) {
                            uploadableFileNum = 0;
                        }
                        if(uploadableFileNum != 0){
                            
                            fn_egov_check_file('Y');
                            
                            var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum );
                            multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
                            
                        }else{
                            fn_egov_check_file('N');
                        }           
                    //-->
                    </script>   
                    <!-- 첨부파일 업로드 가능화일 설정(Update) End.-->
                    <c:if test="${result.atchFileId == null}">
                            <input type="hidden" name="fileListCnt" id="fileListCnt" value="0" >
                            <input name="atchFileAt" id="atchFileAt" type="hidden" value="N">
                        </c:if> 
                        <c:if test="${result.atchFileId != null}">
                            <input name="atchFileAt" id="atchFileAt" type="hidden" value="Y">
                        </c:if>
                </div>
            </div>
            <!--detail area end -->

            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
                <input type="submit" value="<spring:message code="button.save" />" onclick="fn_egov_updt_faqcn(document.faqManageVO,'<c:out value="${result.faqId}"/>'); return false;" />
                <a href="<c:url value='/uss/olh/faq/FaqListInqire.do'/>" onclick="fn_egov_inqire_faqcnlist(); return false;"><spring:message code="button.list" /></a>
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