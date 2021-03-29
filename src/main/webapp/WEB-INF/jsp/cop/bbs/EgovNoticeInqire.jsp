<%--
  Class Name : EgovNoticeInqire.jsp
  Description : 게시물 조회 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.23   이삼섭          최초 생성
     2009.06.26   한성곤          2단계 기능 추가 (댓글관리, 만족도조사)
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.23
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">
	function onloading() {
		if ("<c:out value='${msg}'/>" != "") {
			alert("<c:out value='${msg}'/>");
		}
	}
	
	function fn_egov_select_noticeList(pageNo) {
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
		document.frm.submit();	
	}
	
	function fn_egov_delete_notice() {
		if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
			alert('등록시 사용한 패스워드를 입력해 주세요.');
			document.frm.password.focus();
			return;
		}
		
		if (confirm('<spring:message code="common.delete.msg" />')) {
			document.frm.action = "<c:url value='/cop/bbs${prefix}/deleteBoardArticle.do'/>";
			document.frm.submit();
		}	
	}
	
	function fn_egov_moveUpdt_notice() {
		if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
			alert('등록시 사용한 패스워드를 입력해 주세요.');
			document.frm.password.focus();
			return;
		}

		document.frm.action = "<c:url value='/cop/bbs${prefix}/forUpdateBoardArticle.do'/>";
		document.frm.submit();			
	}
	
	function fn_egov_addReply() {
		document.frm.action = "<c:url value='/cop/bbs${prefix}/addReplyBoardArticle.do'/>";
		document.frm.submit();			
	}	
</script>
<c:if test="${useComment == 'true'}">
<c:import url="/cop/bbs/selectCommentList.do" charEncoding="utf-8">
	<c:param name="type" value="head" />
</c:import>
</c:if>
<c:if test="${useSatisfaction == 'true'}">
<c:import url="/cop/bbs/selectSatisfactionList.do" charEncoding="utf-8">
	<c:param name="type" value="head" />
</c:import>
</c:if>
<c:if test="${useScrap == 'true'}">
<script type="text/javascript">
	function fn_egov_addScrap() {
		document.frm.action = "<c:url value='/cop/bbs/addScrap.do'/>";
		document.frm.submit();			
	}
</script>
</c:if>
<title><c:out value='${result.bbsNm}'/> - 글조회</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>


</head>
<body onload="onloading();">

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

			<form name="frm" method="post" action="<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>">
			<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
			<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" >
			<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" >
			<input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" >
			<input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" >
			<input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" >
			<input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" >
			<input type="submit" id="invisible" class="invisible"/>

            <!-- sub title start -->
            <div><h2><c:out value='${result.bbsNm}'/> - 글조회</h2></div>
            <!-- sub title end -->
            
            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">
                    <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#ffffff" class="generalTable">
				      <tr> 
				        <td class="td_width">제목</td>
				        <td class="td_content" colspan="5"><c:out value="${result.nttSj}" />
				        </td>
				      </tr>
				      <tr> 
				        <td class="td_width">작성자</td>
				        <td class="td_width">
				            <c:out value="${result.frstRegisterNm}" />
				        </td>
				        <td class="td_width">작성시간</td>
				        <td class="td_width"><c:out value="${result.frstRegisterPnttm}" />
				        </td>
			            <td class="td_width">조회수</td>
				        <td class="td_content"><c:out value="${result.inqireCo}" />
				        </td>
				      </tr>    
				      <tr> 
				        <td class="td_width">글내용</td>
				        <td class="td_width" colspan="5">
				        <textarea id="nttCn" name="nttCn" class="textarea" cols="95" rows="28" readonly="readonly" title="글내용"><c:out value="${result.nttCn}" escapeXml="false" /></textarea>
				        </td>
				      </tr>
				      <c:if test="${not empty result.atchFileId}">
				          <c:if test="${result.bbsAttrbCode == 'BBSA02'}">
				          <tr> 
				            <td class="td_width">첨부이미지</td>
				            <td class="td_content" colspan="5">
				                    <c:import url="/cmm/fms/selectImageFileInfs.do" charEncoding="utf-8">
				                        <c:param name="atchFileId" value="${result.atchFileId}" />
				                    </c:import>
				            </td>
				          </tr>
				          </c:if>
				          <tr> 
				            <td class="td_width">첨부파일 목록</td>
				            <td class="td_content" colspan="5">
				                <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
				                    <c:param name="param_atchFileId" value="${result.atchFileId}" />
				                </c:import>
				            </td>
				          </tr>
				      </c:if>
				      <c:if test="${anonymous == 'true'}">
				      <tr> 
				        <td class="td_width"><label for="password"><spring:message code="cop.password" /></label></td>
				        <td class="td_content" colspan="5">
				            <input name="password" title="암호" type="password" size="20" value="" maxlength="20" >
				        </td>
				      </tr>
				      </c:if>   
				    </table>
                </div>
            </div>
            <!--detail area end -->
            
            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
             <c:if test="${result.frstRegisterId == sessionUniqId}">     
                  <a href="#LINK" onclick="javascript:fn_egov_moveUpdt_notice(); return false;">수정</a> 
                  <a href="#LINK" onclick="javascript:fn_egov_delete_notice(); return false;">삭제</a> 
             </c:if>    
             <c:if test="${result.replyPosblAt == 'Y'}">     
                  <a href="#LINK" onclick="javascript:fn_egov_addReply(); return false;">답글작성</a> 
              </c:if>
              <a href="#LINK" onclick="javascript:fn_egov_select_noticeList('1'); return false;">목록</a> 
            </div>
            </td></tr></table>
            <!-- 목록/저장버튼  끝-->
            
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