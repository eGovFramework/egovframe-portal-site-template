<%--
  Class Name : EgovBoardMstrUpdt.jsp
  Description : 게시판 속성정보 변경화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.12   이삼섭          최초 생성
     2009.06.26   한성곤          2단계 기능 추가 (댓글관리, 만족도조사)
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.12
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
<script type="text/javascript" src="<c:url value="/js/EgovBBSMng.js" />" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardMaster" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/showModalDialog.js'/>" ></script>
<script type="text/javascript">
	function fn_egov_validateForm(obj){
		return true;
	}
	
	function fn_egov_update_brdMstr(){
		if (!validateBoardMaster(document.boardMaster)){
			return;
		}
		
		if(confirm('<spring:message code="common.update.msg" />')){
			document.boardMaster.action = "<c:url value='/cop/bbs/UpdateBBSMasterInf.do'/>";
			document.boardMaster.submit();					
		}
	}	
	
	function fn_egov_select_brdMstrList(){
		document.boardMaster.action = "<c:url value='/cop/bbs/SelectBBSMasterInfs.do'/>";
		document.boardMaster.submit();	
	}	
	
	function fn_egov_delete_brdMstr(){
		if(confirm('<spring:message code="common.delete.msg" />')){
			document.boardMaster.action = "<c:url value='/cop/bbs/DeleteBBSMasterInf.do'/>";
			document.boardMaster.submit();	
		}		
	}
	
	function fn_egov_inqire_tmplatInqire(){
		var retVal;
		var url = "<c:url value='/cop/com/openPopup.do?requestUrl=/cop/com/selectTemplateInfsPop.do&typeFlag=BBS&width=850&height=360'/>";		
		var openParam = "dialogWidth: 850px; dialogHeight: 360px; resizable: 0, scroll: 1, center: 1";
		 
		retVal = window.showModalDialog(url,"p_tmplatInqire", openParam);
		if(retVal != null){
			var tmp = retVal.split("|");
			document.boardMaster.tmplatId.value = tmp[0];
			document.boardMaster.tmplatNm.value = tmp[1];
		}
	}
	
	function showModalDialogCallback(retVal) {
		if(retVal != null){
			var tmp = retVal.split("|");
			document.boardMaster.tmplatId.value = tmp[0];
			document.boardMaster.tmplatNm.value = tmp[1];
		}
    }
</script>
<title>게시판 정보수정</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>


</head>
<body>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

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
                            <li><strong>게시판생성관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
            <form:form commandName="boardMaster" name="boardMaster" action="<c:url value='/cop/bbs/SelectBBSMasterInfs.do'/>" method="post" >
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<input name="bbsId" type="hidden" value="<c:out value='${result.bbsId}'/>" />
			<input name="bbsTyCode" type="hidden" value="<c:out value='${result.bbsTyCode}'/>" />
			<input name="bbsAttrbCode" type="hidden" value="<c:out value='${result.bbsAttrbCode}'/>" />
			<input name="replyPosblAt" type="hidden" value="<c:out value='${result.replyPosblAt}'/>" />

            <!-- sub title start -->
            <div><h2>게시판 정보수정</h2></div>
            <!-- sub title end -->

            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">
				    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="게시판명,게시판 소개,게시판 유형,게시판 속성,답장가능여부, ..   입니다">
				      <tr> 
				        <td class="td_width">
				            <label for="bbsNm">
				                게시판명
				            </label>    
				            <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/>
				        </td>
				        <td class="td_content" colspan="3">
				          <input title="게시판명입력" name="bbsNm" type="text" size="60" value='<c:out value="${result.bbsNm}"/>' maxlength="60" > 
				          <br/><form:errors path="bbsNm" />
				        </td>
				      </tr>
				      
				      <tr> 
				        <td class="td_width">
				            <label for="bbsIntrcn"> 
				                게시판 소개
				            </label>    
				            <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/>
				        </td>
				        <td class="td_content" colspan="3">
				          <textarea title="게시판소개입력" name="bbsIntrcn" class="textarea"  cols="95" rows="4" ><c:out value="${result.bbsIntrcn}" escapeXml="true" /></textarea> 
				          <form:errors path="bbsIntrcn" />
				        </td>
				      </tr>
				      
				      <tr> 
				        <td class="td_width">게시판 유형</td>
				        <td class="td_content"><c:out value="${result.bbsTyCodeNm}"/>   
				        </td>
				        <td class="td_width">게시판 속성</td>    
				        <td class="td_content"><c:out value="${result.bbsAttrbCodeNm}"/>    
				        </td>    
				      </tr> 
				      <tr> 
				        <td class="td_width">답장가능여부</td>
				        <td class="td_content">
				            <c:choose>
				                <c:when test="${result.replyPosblAt == 'Y'}">
				                    <spring:message code="button.possible" /> 
				                </c:when>
				                <c:otherwise>
				                    <spring:message code="button.impossible" />
				                </c:otherwise>
				            </c:choose>
				        </td>
				        <td class="td_width">
				            <label for="fileAtchPosblAt">
				                파일첨부가능여부
				            </label>    
				            <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/>
				        </td>    
				        <td class="td_content">
				            <spring:message code="button.possible" /> : <input type="radio" name="fileAtchPosblAt" class="radio2" 
                                    onclick="document.boardMaster.posblAtchFileNumber.disabled='';"
                                    value="Y" <c:if test="${result.fileAtchPosblAt == 'Y'}"> checked="checked"</c:if>>&nbsp;
                                <spring:message code="button.impossible" /> : <input type="radio" name="fileAtchPosblAt" class="radio2" 
                                    onclick="document.boardMaster.posblAtchFileNumber.disabled='disabled';"
                                    value="N" <c:if test="${result.fileAtchPosblAt == 'N'}"> checked="checked"</c:if>>
				            <br/><form:errors path="fileAtchPosblAt" />
				        </td>
				      </tr> 
				      
				      <tr> 
				        <td class="td_width">
				            <label for="posblAtchFileNumber">   
				                첨부가능파일 숫자
				            </label>    
				        </td>
				        <td class="td_content" colspan="3">
				            <select title="첨부가능파일 숫자선택" name="posblAtchFileNumber" class="select" <c:if test="${result.fileAtchPosblAt == 'N'}"> disabled="disabled"</c:if>>
				               <option selected value="0">--선택하세요--</option>
				               <option value='1' <c:if test="${result.posblAtchFileNumber == '1'}">selected="selected"</c:if>>1개</option>
				               <option value='2' <c:if test="${result.posblAtchFileNumber == '2'}">selected="selected"</c:if>>2개</option>
				               <option value='3' <c:if test="${result.posblAtchFileNumber == '3'}">selected="selected"</c:if>>3개</option>
				           </select>
				           <br/><form:errors path="posblAtchFileNumber" />
				        </td>
				      </tr>
				         
				      <tr> 
				        <td class="td_width">
				            <label for="tmplatNm">  
				                템플릿 정보
				            </label>    
				            <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/>
				        </td>
				        <td class="td_content" colspan="3">
				         <input title="템플릿정보입력" name="tmplatNm" type="text" size="20" value="<c:out value="${result.tmplatNm}"/>"  maxlength="20" readonly >
				         <input name="tmplatId" type="hidden" size="20" value='<c:out value="${result.tmplatId}"/>' >
				         &nbsp;<a href="#LINK" onclick="fn_egov_inqire_tmplatInqire(); return false;"><img src="<c:url value='/images/img_search.gif' />"
				                    width="15" height="15" align="middle" alt="새창"></a>
				         <br/><form:errors path="tmplatId" />
				        </td>
				      </tr>
				        <!-- 2009.06.26 : 2단계 기능 추가  -->
				        <c:if test="${addedOptions == 'true'}">
				
				          <tr> 
				            <td class="td_width">추가 선택사항</td>
				            <td class="td_content" colspan="3" >
				                <select title="추가선택사항선택" name="option" class="select" <c:if test="${result.option != 'na'}">disabled="disabled"</c:if>>
				                    <option value='na' <c:if test="${result.option == 'na'}">selected="selected"</c:if>>---선택하세요--</option>
				                    <option value='' <c:if test="${result.option == ''}">selected="selected"</c:if>>미선택</option>
				                    <option value='comment' <c:if test="${result.option == 'comment'}">selected="selected"</c:if>>댓글</option>
				                    <option value='stsfdg' <c:if test="${result.option == 'stsfdg'}">selected="selected"</c:if>>만족도조사</option>
				               </select>
				               ※ 추가 선택사항은 수정 불가 (미설정된 기존 게시판의 경우 처음 설정은 가능함)
				            </td>
				          </tr>
				
				        </c:if>
				        <!-- 2009.06.26 : 2단계 기능 추가  -->            
				    </table>
                        
                </div>
            </div>
            <!--detail area end -->

            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
                <input type="button" value="<spring:message code="button.save" />" onclick="javascript:fn_egov_update_brdMstr(); return false;" />
                <a href="#LINK" onclick="fn_egov_delete_brdMstr(); return false;"><spring:message code="button.delete" /></a>
                <input type="submit" value="<spring:message code="button.list" />" onclick="fn_egov_select_brdMstrList(); return false;" />
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