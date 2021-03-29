<%--
  Class Name : EgovBoardMstrRegist.jsp
  Description : 게시판 생성 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.12   이삼섭          최초 생성
     2009.06.26   한성곤          2단계 기능 추가 (댓글관리, 만족도조사)
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.12
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardMaster" staticJavascript="false" xhtml="true" cdata="false" />
<script type="text/javascript" src="<c:url value='/js/showModalDialog.js'/>" ></script>
<script type="text/javascript">
	function fn_egov_regist_brdMstr(){
		if (!validateBoardMaster(document.boardMaster)){
			return;
		}

		if (confirm('<spring:message code="common.regist.msg" />')) {
			form = document.boardMaster;
			form.action = "<c:url value='/cop/bbs/insertBBSMasterInf.do'/>";
			form.submit();					
		}
	}
	
	function fn_egov_select_brdMstrList(){
		form = document.boardMaster;
		form.action = "<c:url value='/cop/bbs/SelectBBSMasterInfs.do'/>";
		form.submit();	
	}
	
	function fn_egov_inqire_tmplatInqire(){
		form = document.boardMaster;
		var retVal;
		var url = "<c:url value='/cop/com/openPopup.do?requestUrl=/cop/com/selectTemplateInfsPop.do&typeFlag=BBS&width=850&height=360'/>";		
		var openParam = "dialogWidth: 850px; dialogHeight: 360px; resizable: 0, scroll: 1, center: 1";
		 
		retVal = window.showModalDialog(url,"p_tmplatInqire", openParam);
		if(retVal != null){
			var tmp = retVal.split("|");
			form.tmplatId.value = tmp[0];
			form.tmplatNm.value = tmp[1];
		}
	}
	
	function showModalDialogCallback(retVal) {
		if(retVal != null){
            var tmp = retVal.split("|");
            form.tmplatId.value = tmp[0];
            form.tmplatNm.value = tmp[1];
        }
	}
	
</script>

<title>게시판 생성</title>

<style type="text/css">
h1 {
	font-size: 12px;
}

caption {
	visibility: hidden;
	font-size: 0;
	height: 0;
	margin: 0;
	padding: 0;
	line-height: 0;
}
</style>


</head>
<body>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
기능을 사용하실 수 없습니다.</noscript>

<!-- login status start -->
<div id="login_area"><c:import
	url="/EgovPageLink.do?link=main/inc/EgovIncTborder" /></div>
<!-- //login status end -->
<!-- wrap start -->
<div id="wrap"><!-- header start -->
<div id="subheader"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>
<!-- //header end --> <!--  타이틀 이미지 시작 -->
<div id="title_img_div"><img
	src="<c:url value='/'/>images/title_image/img_title05.gif" alt="" /></div>
<!--  //타이틀 이미지 끝 -->
<div id="bodywrap">
<div id="leftmenu_div"><c:import
	url="/sym/mms/EgovMainMenuLeft.do" /></div>
<div id="middle_content"><!-- 현재위치 네비게이션 시작 -->
<div id="cur_loc">
<div id="cur_loc_align">
<ul>
	<li>HOME</li>
	<li>&gt;</li>
	<li>포털서비스관리</li>
	<li>&gt;</li>
	<li>서비스관리</li>
	<li>&gt;</li>
	<li><strong>게시판생성관리</strong></li>
</ul>
</div>
</div>
<div id="content_field"><!--contents start--> <form:form
	commandName="boardMaster" name="boardMaster" method="post"
	action="<c:url value='/cop/bbs/SelectBBSMasterInfs.do'/>">
	<input type="hidden" name="pageIndex"
		value="<c:out value='${searchVO.pageIndex}'/>" />

	<!-- sub title start -->
	<div>
	<h2>게시판 생성</h2>
	</div>
	<!-- sub title end -->

	<!--detail area start -->
	<div class="search_service">
	<div class="search_top_table">
	<table width="100%" border="0" cellpadding="0" cellspacing="1"
		class="table-register"
		summary="게시판명,게시판소개,게시판 유형,게시판 속성,답장가능여부,파일첨부가능여부, ..  입니다">
		<tr>
			<td class="td_width"><label for="bbsNm"> <spring:message
				code="cop.bbsNm" /> </label> <img
				src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목"
				width="15" height="15" /></td>
			<td class="td_content" colspan="3"><form:input title="게시판명입력"
				path="bbsNm" size="60" /> <br />
			<form:errors path="bbsNm" /></td>
		</tr>
		<tr>
			<td class="td_width"><label for="bbsIntrcn"> <spring:message
				code="cop.bbsIntrcn" /> </label> <img
				src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목"
				width="15" height="15" /></td>
			<td class="td_content" colspan="3"><form:textarea
				title="게시판소개입력" path="bbsIntrcn" cols="95" rows="4" /> <br />
			<form:errors path="bbsIntrcn" /></td>
		</tr>
		<tr>
			<td class="td_width"><label for="bbsTyCode"> <spring:message
				code="cop.bbsTyCode" /> </label> <img
				src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목"
				width="15" height="15" /></td>
			<td class="td_content"><form:select path="bbsTyCode"
				title="게시판유형선택">
				<form:option value='' label="--선택하세요--" />
				<form:options items="${typeList}" itemValue="code"
					itemLabel="codeNm" />
			</form:select> <br />
			<form:errors path="bbsTyCode" /></td>
			<td class="td_width"><label for="bbsAttrbCode"> <spring:message
				code="cop.bbsAttrbCode" /> </label> <img
				src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목"
				width="15" height="15" /></td>
			<td class="td_content"><form:select path="bbsAttrbCode"
				title="게시판속성선택">
				<form:option value='' label="--선택하세요--" />
				<form:options items="${attrbList}" itemValue="code"
					itemLabel="codeNm" />
			</form:select> <br />
			<form:errors path="bbsAttrbCode" /></td>
		</tr>

		<tr>
			<td class="td_width"><label for="replyPosblAt"> <spring:message
				code="cop.replyPosblAt" /> </label> <img
				src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목"
				width="15" height="15" /></td>
			<td class="td_content"><spring:message code="button.possible" />
			: <form:radiobutton path="replyPosblAt" value="Y" />&nbsp; <spring:message
				code="button.impossible" /> : <form:radiobutton path="replyPosblAt"
				value="N" /> <br />
			<form:errors path="replyPosblAt" /></td>
			<td class="td_width"><label for="fileAtchPosblAt"> <spring:message
				code="cop.fileAtchPosblAt" /> </label> <img
				src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목"
				width="15" height="15" /></td>
			<td class="td_content">
               <spring:message code="button.possible" /> : <form:radiobutton path="fileAtchPosblAt"  value="Y" 
                               onclick="document.boardMaster.posblAtchFileNumber.disabled='';" />&nbsp;
               <spring:message code="button.impossible" /> : <form:radiobutton path="fileAtchPosblAt"  value="N" 
                               onclick="document.boardMaster.posblAtchFileNumber.disabled='disabled';" />
                                   <br />
			<form:errors path="fileAtchPosblAt" /></td>
		</tr>

		<tr>
			<td class="td_width"><label for="posblAtchFileNumber"> <spring:message
				code="cop.posblAtchFileNumber" /> </label> </td>
			<td class="td_content" colspan="3"><form:select
				path="posblAtchFileNumber" title="첨부가능파일 숫자선택">
				<form:option value="0" label="---선택하세요--" />
				<form:option value='1'>1개</form:option>
				<form:option value='2'>2개</form:option>
				<form:option value='3'>3개</form:option>
			</form:select> <br />
			<form:errors path="posblAtchFileNumber" /></td>
		</tr>
		<tr>
			<td class="td_width"><label for="tmplatNm"> <spring:message
				code="cop.tmplatId" /> </label> <img
				src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목"
				width="15" height="15" /></td>
			<td class="td_content" colspan="3"><form:input path="tmplatNm"
				size="20" readonly="true" title="템플릿정보입력" /> <form:hidden
				path="tmplatId" /> &nbsp;<a href="#LINK"
				onclick="fn_egov_inqire_tmplatInqire(); return false;"
				style="selector-dummy: expression(this.hideFocus = false);"><img
				src="<c:url value='/images/img_search.gif' />" width="15"
				height="15" align="middle" alt="새창" /></a> <br />
			<form:errors path="tmplatId" /></td>
		</tr>
		<!-- 2009.06.26 : 2단계 기능 추가  -->
		<c:if test="${addedOptions == 'true'}">
			<tr>
				<td class="td_width"><label for="option">추가 선택사항</label></td>
				<td class="td_content" colspan="3"><form:select path="option"
					title="추가선택사항선택">
					<form:option value="" label="미선택" />
					<form:option value='comment'>댓글</form:option>
					<form:option value='stsfdg'>만족도조사</form:option>
				</form:select></td>
			</tr>
		</c:if>
		<!-- 2009.06.26 : 2단계 기능 추가  -->
	</table>
	</div>
	</div>
	<!--detail area end -->

	<!-- 목록/저장버튼  시작-->
	<table border="0" cellspacing="0" cellpadding="0" align="center">
		<tr>
			<td>
			<div class="buttons" align="center" style="margin-bottom: 100px">
			<input type="button" value="<spring:message code="button.save"/>"
				onclick="javascript:fn_egov_regist_brdMstr(); return false;" /> 
			<input type="submit" value="<spring:message code="button.list" />"
				onclick="fn_egov_select_brdMstrList(); return false;" /></div>
			</td>
		</tr>
	</table>
	<!-- 목록/저장버튼  끝-->

</form:form></div>
<!-- contents end --></div>
</div>
<!-- footer 시작 -->
<div id="footer"><c:import
	url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
<!-- //footer 끝 --></div>
<!-- //wrap end -->

</body>
</html>