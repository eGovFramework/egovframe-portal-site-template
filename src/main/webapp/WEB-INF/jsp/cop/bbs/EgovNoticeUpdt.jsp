<%--
  Class Name : EgovNoticeUpdt.jsp
  Description : 게시물 수정 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.19   이삼섭          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.19
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<!-- script type="text/javascript" src="<c:url value='/html/egovframework/cmm/utl/htmlarea/EgovWebEditor.js'/>" ></script-->
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">
	function fn_egov_validateForm(obj){
		return true;
	}

	function fn_egov_regist_notice(){
		//document.board.onsubmit();

		if (!validateBoard(document.board)){
			return;
		}
		
		if (confirm('<spring:message code="common.update.msg" />')) {
			document.board.action = "<c:url value='/cop/bbs${prefix}/updateBoardArticle.do'/>";
			document.board.submit();					
		}
	}	
	
	function fn_egov_select_noticeList() {
		document.board.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
		document.board.submit();	
	}
	
	function fn_egov_check_file(flag) {
		if (flag=="Y") {
			document.getElementById('file_upload_posbl').style.display = "block";
			document.getElementById('file_upload_imposbl').style.display = "none";			
		} else {
			document.getElementById('file_upload_posbl').style.display = "none";
			document.getElementById('file_upload_imposbl').style.display = "block";
		}
	}	
</script>
<style type="text/css">
.noStyle {background:ButtonFace; BORDER-TOP:0px; BORDER-bottom:0px; BORDER-left:0px; BORDER-right:0px;}
  .noStyle th{background:ButtonFace; padding-left:0px;padding-right:0px}
  .noStyle td{background:ButtonFace; padding-left:0px;padding-right:0px}
</style>
<title><c:out value='${bdMstr.bbsNm}'/> - 게시글 수정</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

</head>
<!-- body onload="javascript:editor_generate('nttCn');"-->
<body onLoad="document.board.nttSj.focus();">
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
            
			<form:form commandName="board" name="board" method="post" enctype="multipart/form-data" >
			<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<input type="hidden" name="returnUrl" value="<c:url value='/cop/bbs/forUpdateBoardArticle.do'/>"/>
			
			<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
			<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
			
			<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
			<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
			<input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
			<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
			<input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
			<input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
			<input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
			
			<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
			
			<c:if test="${anonymous != 'true'}">
			<input type="hidden" name="ntcrNm" value="dummy">	<!-- validator 처리를 위해 지정 -->
			<input type="hidden" name="password" value="dummy">	<!-- validator 처리를 위해 지정 -->
			</c:if>
			
			<c:if test="${bdMstr.bbsAttrbCode != 'BBSA01'}">
			   <input name="ntceBgnde" type="hidden" value="10000101">
			   <input name="ntceEndde" type="hidden" value="99991231">
			</c:if>
			
			<!-- sub title start -->
            <div><h2><c:out value='${bdMstr.bbsNm}'/> - 게시글 수정</h2></div>
            <!-- sub title end -->
            
            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="generalTable">
      <tr> 
        <td class="td_width"><spring:message code="cop.nttSj" />
        <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
        <td class="td_content">
          <input name="nttSj" title="<spring:message code="cop.nttSj" />" type="text" size="60" value='<c:out value="${result.nttSj}" />'  maxlength="60" >
           <br/><form:errors path="nttSj" /> 
        </td>
      </tr>
      <tr> 
        <td class="td_width"><spring:message code="cop.nttCn" />
        <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
        <td class="td_content">
          <textarea id="nttCn" name="nttCn" title="<spring:message code="cop.nttCn" />" class="textarea" cols="95" rows="28" ><c:out value="${result.nttCn}" escapeXml="false" /></textarea> 
          <form:errors path="nttCn" />
        </td>
      </tr>
      <c:if test="${bdMstr.bbsAttrbCode == 'BBSA01'}"> 
          <tr> 
            <td class="td_width"><spring:message code="cop.noticeTerm" />
            <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
            <td class="td_content">
              <input name="ntceBgnde" type="hidden" value='<c:out value="${result.ntceBgnde}" />'>
              <input name="ntceBgndeView" type="text" size="10" title="ntceBgndeView"
                value="${fn:substring(result.ntceBgnde, 0, 4)}-${fn:substring(result.ntceBgnde, 4, 6)}-${fn:substring(result.ntceBgnde, 6, 8)}"  readOnly
                onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceBgnde, document.board.ntceBgndeView,'','<c:url value='/sym/cmm/EgovselectNormalCalendar.do'/>');" >
              <img src="<c:url value='/images/egovframework/cop/bbs/icon/bu_icon_carlendar.gif' />"
                onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceBgnde, document.board.ntceBgndeView,'','<c:url value='/sym/cmm/EgovselectNormalCalendar.do'/>');"
                width="15" height="15" alt="calendar">
              ~
              <input name="ntceEndde" type="hidden"  value='<c:out value="${result.ntceEndde}" />'>
              <input name="ntceEnddeView" type="text" size="10" title="ntceEnddeView"
                value="${fn:substring(result.ntceEndde, 0, 4)}-${fn:substring(result.ntceEndde, 4, 6)}-${fn:substring(result.ntceEndde, 6, 8)}"  readOnly
                onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceEndde, document.board.ntceEnddeView,'','<c:url value='/sym/cmm/EgovselectNormalCalendar.do'/>');"  >
              <img src="<c:url value='/images/egovframework/cop/bbs/icon/bu_icon_carlendar.gif' />"
                onClick="javascript:fn_egov_NormalCalendar(document.board, document.board.ntceEndde, document.board.ntceEnddeView,'','<c:url value='/sym/cmm/EgovselectNormalCalendar.do'/>');"
                width="15" height="15" alt="calendar">
                 <br/><form:errors path="ntceBgndeView" />    
                 <br/><form:errors path="ntceEnddeView" />                  
            </td>
          </tr>
      </c:if>   
      <c:if test="${not empty result.atchFileId}">
          <tr> 
            <td class="td_width"><spring:message code="cop.atchFileList" /></td>
            <td class="td_content">
                <c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
                    <c:param name="param_atchFileId" value="${result.atchFileId}" />
                </c:import>
            </td>
          </tr>
      </c:if>   
      <c:if test="${bdMstr.fileAtchPosblAt == 'Y'}"> 
          <tr> 
            <td class="td_width"><label for="egovComFileUploader" ><spring:message code="cop.atchFile" /></label></td>
            <td class="td_content">
            <div id="file_upload_posbl"  style="display:none;" >    
                  <input name="file_1" id="egovComFileUploader" type="file" />
                  <div id="egovComFileList"></div>
            </div>
            <div id="file_upload_imposbl"  style="display:none;" >
                <spring:message code="common.imposbl.fileupload" />
            </div>
            <c:if test="${empty result.atchFileId}">
	            <input type="hidden" id="fileListCnt" name="fileListCnt" value="0" />
	        </c:if> 
            </td>
          </tr>
      </c:if>
    </table>
      <c:if test="${bdMstr.fileAtchPosblAt == 'Y'}"> 
      <script type="text/javascript">
        var existFileNum = document.board.fileListCnt.value;        
        var maxFileNum = document.board.posblAtchFileNumber.value;

        if (existFileNum=="undefined" || existFileNum ==null) {
            existFileNum = 0;
        }
        if (maxFileNum=="undefined" || maxFileNum ==null) {
            maxFileNum = 0;
        }       
        var uploadableFileNum = maxFileNum - existFileNum;
        if (uploadableFileNum<0) {
            uploadableFileNum = 0;
        }               
        if (uploadableFileNum != 0) {
            fn_egov_check_file('Y');
            var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum );
            multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
        } else {
            fn_egov_check_file('N');
        }           
     </script>
     </c:if>               
                </div>
            </div>
            <!--detail area end -->
            
            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
                <c:if test="${bdMstr.authFlag == 'Y'}">
                    <c:if test="${result.frstRegisterId == searchVO.frstRegisterId}"> 
                        <a href="#LINK" onclick="javascript:fn_egov_regist_notice(); return false;"><spring:message code='button.save' /></a> 
                    </c:if>
                </c:if>
                <a href="#LINK" onclick="javascript:fn_egov_select_noticeList(); return false;"><spring:message code="button.list" /></a> 
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