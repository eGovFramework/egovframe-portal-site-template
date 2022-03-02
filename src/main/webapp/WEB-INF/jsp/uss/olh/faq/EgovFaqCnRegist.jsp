<%--
  Class Name : EgovFaqCnRegist.jsp
  Description : EgovFaqCnRegist 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01   박정규          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 박정규
    since    : 2009.02.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date"  %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>샘플 포털 > 정보마당 > FAQ</title>
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
function fn_egov_regist_faqcn(form){

	// 서버사이드 테스트용
	/*	
		form.action = "<c:url value='/uss/olh/faq/FaqCnRegist.do'/>";
		form.submit(); 
		return;
	*/

	
	if (!validateFaqManageVO(form)) {
		
		return;
	} else {
		
		if(confirm('<spring:message code="common.regist.msg" />')) {
			
			form.action = "<c:url value='/uss/olh/faq/FaqCnRegist.do'/>";
			form.submit();
		}
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

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <!-- Header -->
		<c:import url="/sym/mms/EgovHeader.do" />
		<!--// Header -->

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
                                        <li><a class="home" href="">Home</a></li>
                                        <li><a href="">정보마당</a></li>
                                        <li>FAQ</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<!-- 상단타이틀(파일첨부를 위한 폼명 및 Enctype 설정 -->
								<form:form modelAttribute="faqManageVO" name="faqManageVO" action="${pageContext.request.contextPath}/uss/olh/faq/FaqCnRegist.do" method="post" enctype="multipart/form-data">
								<!-- 첨부파일을 위한 Hidden -->
								<input type="hidden" name="posblAtchFileNumber" id="posblAtchFileNumber" value="3">

                                <h1 class="tit_1">정보마당</h1>

                                <p class="txt_1">표준프레임워크 서비스, 이렇게 활용하십시오.</p>

                                <h2 class="tit_2">FAQ</h2>

                                <!-- FAQ 등록수정 -->
                                <div class="board_view">

									<dl class="board_faq_top">
                                        <dt style="position: relative; top: 20px;"><label for="qestnSj">질문제목</label><span class="req">필수</span></dt>
                                        <dd>
                                            <form:input id="" class="f_txt w_full" path="qestnSj" maxlength="70" title="질문제목" />
                                            <form:errors path="qestnSj" />
                                        </dd>
                                    </dl>

                                    <div class="board_article_faq reg">
                                        <span class="q">Q</span>
                                        <form:textarea path="qestnCn" cols="30" rows="10" title="질문내용"/>
                                        <form:errors path="qestnCn" />
                                    </div>

                                    <div class="board_article_faq reg">
                                        <span class="a">A</span>
                                        <form:textarea path="answerCn" cols="30" rows="10" title="답변내용"/>
                                        <form:errors path="answerCn" />
                                    </div>

									<!--첨부파일 테이블 레이아웃 설정 Start..-->
                                    <div class="board_attach faqreg">
                                        
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
                                    </div>
                                    <!--첨부파일 테이블 레이아웃 End.-->
                                    
                                    <!-- 목록/저장버튼  시작 -->
                                    <div class="board_view_bot">
                                        <div class="left_col btn3">
                                        </div>

                                        <div class="right_col btn1">
                                        	<a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_regist_faqcn(document.faqManageVO); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                            <a href="<c:url value='/uss/olh/faq/FaqListInqire.do'/>" class="btn btn_blue_46 w_100" onclick="fn_egov_inqire_faqcnlist(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                        </div>
                                    </div>
                                    <!-- // 목록/저장버튼  끝 -->
                                    
                                    <!--첨부파일 업로드 가능화일 설정 Start..-->
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
			                        <!-- 첨부파일 업로드 가능화일 설정 End.-->
			                        
                                </div>
                                <!-- FAQ -->
                                
                                </form:form>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
		<c:import url="/sym/mms/EgovFooter.do" />
		<!--// Footer -->
    </div>
    
</body>
</html>