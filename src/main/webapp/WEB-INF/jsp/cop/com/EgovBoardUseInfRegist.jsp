<%--
  Class Name : EgovBoardUseInfRegist.jsp
  Description : 게시판  사용정보  등록화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.02   이삼섭          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.04.02
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardUseInf" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/showModalDialog.js'/>" ></script>
<script type="text/javascript">
	function fn_egov_select_bbsUseInfs(){
		document.boardUseInf.action = "<c:url value='/cop/com/selectBBSUseInfs.do'/>";
		document.boardUseInf.submit();
	}
	
	function fn_egov_regist_bbsUseInf(){
		if (!validateBoardUseInf(document.boardUseInf)){
			return;
		}
		
		if (confirm('<spring:message code="common.regist.msg" />')) {
			document.boardUseInf.param_trgetType.value = document.boardUseInf.trgetType.value;
			document.boardUseInf.action = "<c:url value='/cop/com/insertBBSUseInf.do'/>";
			document.boardUseInf.submit();		
		}
	}
	
	function fn_egov_inqire_bbsInf(){
		var retVal;
		var url = "<c:url value='/cop/com/openPopup.do?requestUrl=/cop/bbs/SelectBBSMasterInfsPop.do&width=850&height=520'/>";		
		var openParam = "dialogWidth: 850px; dialogHeight: 520px; resizable: 0, scroll: 1, center: 1";	
		
		retVal = window.showModalDialog(url,"p_cmmntyInqire", openParam);
		if(retVal != null){
			var tmp = retVal.split("|");
			document.boardUseInf.bbsId.value = tmp[0];
			document.boardUseInf.bbsNm.value = tmp[1];
		}		
	}
	
	function showModalDialogCallback(retVal) {
		if(retVal != null){
            var tmp = retVal.split("|");
            document.boardUseInf.bbsId.value = tmp[0];
            document.boardUseInf.bbsNm.value = tmp[1];
        }   
	}
	
	function fn_egov_selectTargetType(obj) {

		var retVal;
		var _strType = obj.value;
		
		if (_strType == 'CMMNTY') {
			retVal = fn_egov_inqire_cmmnty();
		} else if (_strType == 'CLUB') {
			retVal = fn_egov_inqire_club();
		} else if (_strType == '') {
			retVal = "|";
		} else {
			retVal = "SYSTEM_DEFAULT_BOARD"+"|"+"시스템 활용";
		}
				
		if (retVal != null) {
			var tmp = retVal.split("|");
			document.boardUseInf.trgetId.value = tmp[0];
			document.boardUseInf.trgetNm.value = tmp[1];
		}
	}
	
	/* function fn_egov_inqire_cmmnty(){
		var retVal;
		var url = "<c:url value='/cop/com/openPopup.do?requestUrl=/cop/cmy/selectCmmntyInfsByPop.do&width=850&height=360'/>";		
		var openParam = "dialogWidth: 850px; dialogHeight: 360px; resizable: 0, scroll: 1, center: 1";
		 
		retVal = window.showModalDialog(url,"p_cmmntyInqire", openParam);
		return retVal;
	}	
	
	function fn_egov_inqire_club(){
		var retVal;
		var url = "<c:url value='/cop/com/openPopup.do?requestUrl=/cop/clb/selectClubInfsByPop.do&width=850&height=360'/>";		
		var openParam = "dialogWidth: 850px; dialogHeight: 360px; resizable: 0, scroll: 1, center: 1";
		 
		retVal = window.showModalDialog(url,"p_cmmntyInqire", openParam);
		return retVal;		
	} */
</script>
<title>게시판 사용등록</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

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
                            <li><strong>게시판사용관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
			<form:form commandName="boardUseInf" name="boardUseInf" method="post">
			<div style="visibility:hidden;display:none;"><input name="iptSubmit" type="submit" value="전송" title="전송"></div>
			<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
			<input type="hidden" name="param_trgetType" value="" />
			
			<!-- sub title start -->
            <div><h2>게시판 사용등록</h2></div>
            <!-- sub title end -->
            
            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">
				    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register">
				      <tr>   
				        <td class="td_width"><spring:message code="cop.bbsNm" />
				            <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/>
				        </td>
				        <td class="td_content" colspan="3">
				          <input name="bbsId" type="hidden" /> 
				          <input name="bbsNm" type="text" size="40" value=""  maxlength="40" title="게시판명" readonly /> 
				          &nbsp;<a href="#LINK" onclick="fn_egov_inqire_bbsInf();" style="selector-dummy: expression(this.hideFocus=false);"><img src="<c:url value='/images/img_search.gif' />"
				                    width="15" height="15" align="middle" alt="새창" /></a>
				          <br/><form:errors path="bbsId" />                   
				        </td>
				      </tr>
				      <tr> 
				        <td class="td_width">
				            <label for="trgetType">
				                <spring:message code="cop.trgetNm" />
				            </label>    
				            <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/>
				        </td>
				        <td class="td_content">
				           <select id="trgetType" name="trgetType" class="select" title="" onChange="javascript:fn_egov_selectTargetType(this)"  >
				               <option selected value="">--선택하세요--</option>
				               <option value="SYSTEM" >시스템</option>            
				           </select>
				           <input type="hidden" name="trgetId" value="" />
				           <input type="text" name="trgetNm" value=""  size="40" title="" readonly="readonly" />
				           <br/><form:errors path="trgetId" />
				        </td>
				      </tr>
				    </table>
                </div>
            </div>
            <!--detail area end -->

            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
                <input type="submit" value="<spring:message code="button.save" />" onclick="fn_egov_regist_bbsUseInf(); return false;" />
                <a href="<c:url value='/cop/com/selectBBSUseInfs.do'/>?searchCondition=1" onclick="fn_egov_select_bbsUseInfs(); return false;"><spring:message code="button.list" /></a>
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