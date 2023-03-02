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
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>
<html>
<head>
<title>샘플 포털 > 포털서비스관리 > 서비스관리 > FAQ관리</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

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
		form.action = "<c:url value='/uss/olh/faq/admin/FaqCnUpdt.do'/>";
		form.submit(); 
		return;
	*/

	if (!validateFaqManageVO(form)) {
		
		return;
			
	} else {
		
		if(confirm('<spring:message code="common.update.msg" />')) {
			
			// form.faqId.value = faqId; 주석처리
			form.action = "<c:url value='/uss/olh/faq/FaqCnUpdt.do'/>";
			form.submit();
		}
	}
}

/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_inqire_faqcnlist() {

	faqManageVO.action = "<c:url value='/uss/olh/faq/admin/FaqListInqire.do'/>";
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

<style>
.board_attach2>span>input[type="button"] {
	position: relative;
	top: -8px;
}
</style>

<body onLoad="fn_egov_initl_faqcn();">

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
                                        <li>포털서비스관리</li>
                                        <li><a href="">서비스관리</a></li>
                                        <li>FAQ관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<!-- 상단타이틀 파일첨부를 위한 폼명 및 Enctype 설정-->
								<form:form modelAttribute="faqManageVO" name="faqManageVO" action="${pageContext.request.contextPath}/uss/olh/faq/admin/FaqCnUpdt.do" method="post" enctype="multipart/form-data">
								<!-- FaqCnUpdtView.do Call을 위한 처리-->
								<input name="faqId" type="hidden" value="<c:out value='${result.faqId}'/>">
								<!-- 첨부파일을 위한 Hidden -->	
								<input type="hidden" name="posblAtchFileNumber" id="posblAtchFileNumber" value="3">
								<!-- 첨부파일 삭제 후 리턴 URL -->
								<input type="hidden" name="returnUrl" id="returnUrl" value="<c:url value='/uss/olh/faq/admin/FaqCnUpdtView.do'/>"/>

                                <h1 class="tit_1">포털서비스관리</h1>

                                <p class="txt_1">포털시스템에서 제공되는 서비스들에 대한 컨텐츠를 관리합니다.</p>
                                
                                <h2 class="tit_2">서비스관리</h2>

                                <h3 class="tit_3">FAQ관리</h3>

                                <!-- FAQ 등록수정 -->
                                <div class="board_view2" summary="FAQ에 대한 정보를 수정합니다.">

                                    <dl class="board_faq_top">
                                        <dt style="position: relative; top: 20px;"><label for="qestnSj">질문제목</label><span class="req">필수</span></dt>
                                        <dd>
                                            <form:input class="f_txt w_full" path="qestnSj" maxlength="70" title="질문제목"/>
                                            <form:errors path="qestnSj"/>
                                        </dd>
                                    </dl>

                                    <div class="board_article_faq reg">
                                        <span class="q">Q</span>
                                        <form:textarea path="qestnCn" cols="30" rows="10" title="질문내용"/>
                                        <form:errors path="qestnCn"/>
                                    </div>

                                    <div class="board_article_faq reg">
                                        <span class="a">A</span>
                                        <form:textarea path="answerCn" cols="30" rows="10" title="답변내용"/>
                                        <form:errors path="answerCn"/>
                                    </div>

									<!-- 파일첨부 -->
                                    <div class="board_attach faqreg">
                                    	
                                    	<!-- 첨부파일목록 시작 -->
                                    	<c:if test="${result.atchFileId != null}">
                                    	<dl>
                                    		<dt><label for="atchFileList">첨부파일 목록</label></dt>
                                    		<dd>
                                    			<div class="board_attach2">
                                    				<span>
	                                    				<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
		                                                	<c:param name="param_atchFileId" value="${egovc:encrypt(result.atchFileId)}" />
		                                                </c:import>
	                                                </span>
                                    			</div>
                                    		</dd>
                                    	</dl>
                                    	</c:if>
                                    	<!-- /첨부파일목록 끝 -->
                                    	
                                    	<!-- 파일첨부 시작 -->
                                        <dl>
                                            <dt><label for="egovComFileUploader"><spring:message code="cop.atchFile" /></label></dt><!-- 파일첨부 -->
                                            <dd>
                                            	<div class="board_attach2" id="file_upload_posbl">
                                                    <input name="file_1" id="egovComFileUploader" type="file" />
                                                    <div id="egovComFileList"></div>
                                                </div>
                                                <div class="board_attach2" id="file_upload_imposbl">
                                                    <spring:message code="common.imposbl.fileupload" />
                                                </div>
                                            </dd>
                                        </dl>
                                        <!-- /파일첨부 끝 -->
                                        
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
											if (existFileNum == "undefined" || existFileNum == null) {
												existFileNum = 0;
											}
	
											if (maxFileNum == "undefined" || maxFileNum == null) {
												maxFileNum = 0;
											}
	
											var uploadableFileNum = maxFileNum - existFileNum;
	
											if (uploadableFileNum < 0) {
												uploadableFileNum = 0;
											}
											if (uploadableFileNum != 0) {
												fn_egov_check_file('Y');
												var multi_selector = new MultiSelector(document.getElementById('egovComFileList'), uploadableFileNum);
												multi_selector.addElement(document.getElementById('egovComFileUploader'));
											} else {
												fn_egov_check_file('N');
											}
										//-->
										</script>
										<!-- 첨부파일 업로드 가능화일 설정(Update) End.-->
										<c:if test="${result.atchFileId == null}">
											<input type="hidden" name="fileListCnt" id="fileListCnt" value="0">
											<input name="atchFileAt" id="atchFileAt" type="hidden" value="N">
										</c:if>
										<c:if test="${result.atchFileId != null}">
											<input name="atchFileAt" id="atchFileAt" type="hidden" value="Y">
										</c:if>
	                                        
	                                    </div>
	                                    
                                    <!-- // 파일첨부 끝 -->

									<!-- 목록/저장버튼  시작-->
									<div class="board_view_bot">
                                        <div class="left_col btn3">
                                        </div>

                                        <div class="right_col btn1">
                                        	<a href="" class="btn btn_blue_46 w_100" onclick="fn_egov_updt_faqcn(document.faqManageVO,'<c:out value="${result.faqId}"/>'); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                            <a href="<c:url value='/uss/olh/faq/admin/FaqListInqire.do'/>" class="btn btn_blue_46 w_100" onclick="fn_egov_inqire_faqcnlist(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                        </div>
                                    </div>
                                    <!-- 목록/저장버튼  끝-->
                                    
                                    </form:form>
                                    
                                </div>
                                <!-- FAQ -->
                                
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