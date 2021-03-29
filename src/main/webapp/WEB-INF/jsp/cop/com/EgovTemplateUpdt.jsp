<%--
  Class Name : EgovTemplateUpdt.jsp
  Description : 템플릿 속성 수정화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.18   이삼섭          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.18
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
<validator:javascript formName="templateInf" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	function fn_egov_update_tmplatInfo() {
		if (!validateTemplateInf(document.templateInf)){
			return;
		}
		
		if (confirm('<spring:message code="common.update.msg" />')) {
			document.templateInf.action = "<c:url value='/cop/com/updateTemplateInf.do'/>";
			document.templateInf.submit();
		}
	}
	
	function fn_egov_select_tmplatInfo() {
		document.templateInf.action = "<c:url value='/cop/com/selectTemplateInfs.do'/>";
		document.templateInf.submit();	
	}
	
	function fn_egov_selectTmplatType(obj) {
		if (obj.value == 'TMPT01') {
			document.getElementById('sometext').innerHTML = "게시판 템플릿은 CSS만 가능합니다.";
		} else if (obj.value == '') {
			document.getElementById('sometext').innerHTML = "";
		} else {
			document.getElementById('sometext').innerHTML = "템플릿은 JSP만 가능합니다.";
		}		
	}

	function fn_egov_previewTmplat() {
        var frm = document.templateInf;
        
        var url = frm.tmplatCours.value;

        var target = "";
        var width = "";

        if (frm.tmplatSeCode.value == 'TMPT01') {
            target = "<c:url value='/cop/bbs/previewBoardList.do'/>";
            width = "1024";
        } else {
            alert('<spring:message code="cop.tmplatCours" /> 지정 후 선택해 주세요.');
        }

        if (target != "") {
            window.open(target + "?searchWrd="+url, "preview", "width=" + width + "px, height=800px;");
        }
    }
</script>
<title>템플릿 정보수정</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>


</head>
<body onload="fn_egov_selectTmplatType(document.templateInf.tmplatSeCode)">

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
                            <li><strong>게시판템플릿관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
            <!-- sub title start -->
            <div><h2>템플릿 정보수정</h2></div>
            <!-- sub title end -->
            
			<form:form commandName="templateInf" name="templateInf" method="post" >
			<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
			<input name="tmplatNm" type="hidden" value='<c:out value="${TemplateInfVO.tmplatNm}"/>' />
			
			<!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">
                    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register">
				      <tr> 
				        <td class="td_width"><spring:message code="cop.tmplatNm" /></td>
				        <td class="td_content">
				          <input name="tmplatId" type="hidden" size="60" value='<c:out value="${TemplateInfVO.tmplatId}"/>'  maxlength="60" >
				          <c:out value="${TemplateInfVO.tmplatNm}"/>
				          <br/><form:errors path="tmplatId" />   
				        </td>
				      </tr>
				      <tr> 
				        <td class="td_width">
				            <label for="tmplatSeCode">
				                <spring:message code="cop.tmplatSeCode" />
				            </label>    
				            <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required">
				        </td>
				        <td class="td_content">
				        <select id="tmplatSeCode" name="tmplatSeCode" class="select" onchange="fn_egov_selectTmplatType(this)">
				               <option selected value=''>--선택하세요--</option>
				            <c:forEach var="result" items="${resultList}" varStatus="status">
				                <option value='<c:out value="${result.code}"/>' <c:if test="${TemplateInfVO.tmplatSeCode == result.code}">selected="selected"</c:if> ><c:out value="${result.codeNm}"/></option>
				            </c:forEach>    
				        </select>&nbsp;&nbsp;&nbsp;<span id="sometext"></span>
				        <br/><form:errors path="tmplatSeCode" /> 
				        </td>
				      </tr> 
				      <tr> 
				        <td class="td_width">
				            <label for="tmplatCours">
				                <spring:message code="cop.tmplatCours" />
				            </label>    
				            <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required">
				        </td>
				        <td class="td_content">
				          <input id="tmplatCours" name="tmplatCours" type="text" size="60" value='<c:out value="${TemplateInfVO.tmplatCours}"/>' maxlength="60" style="width:100%">
				          <br/><form:errors path="tmplatCours" /> 
				        </td>
				      </tr>
				      <tr> 
				        <td class="td_width">
				            <label> 
				                <spring:message code="cop.useAt" />
				            </label>    
				            <img src="<c:url value='/images/required.gif' />" width="15" height="15" alt="required">
				        </td>
				        <td class="td_content">
				            Y : <input type="radio" name="useAt" class="radio2" value="Y"  <c:if test="${TemplateInfVO.useAt == 'Y'}"> checked="checked"</c:if> >&nbsp;
				            N : <input type="radio" name="useAt" class="radio2" value="N" <c:if test="${TemplateInfVO.useAt == 'N'}"> checked="checked"</c:if>>
				        </td>
				      </tr>  
				    
				    </table>
                </div>
            </div>
            <!--detail area end -->

<!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
                <a href="#LINK" onclick="javascript:fn_egov_update_tmplatInfo(); return false;"><spring:message code="button.save" /></a>
                <a href="<c:url value='/cop/com/selectTemplateInfs.do'/>" onclick="javascript:fn_egov_select_tmplatInfo(); return false;"><spring:message code="button.list" /></a>
                <a href="#LINK" onclick="javascript:fn_egov_previewTmplat(); return false;"><spring:message code="cop.preview" /></a>
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