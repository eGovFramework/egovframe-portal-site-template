<%--
  Class Name :
  Description :
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.19   이삼섭          최초 생성
     2011.08.31  JJY       경량환경 버전 생성

    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.19
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images/egovframework/cop/bbs/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet" type="text/css">
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />" ></script>
<c:choose>
<c:when test="${preview == 'true'}">
<script type="text/javascript">
<!--
	function press(event) {
	}

	function fn_egov_addNotice() {
	}

	function fn_egov_select_noticeList(pageNo) {
	}

	function fn_egov_inqire_notice(nttId, bbsId) {
	}
//-->
</script>
</c:when>
<c:otherwise>
<script type="text/javascript">
<!--
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_noticeList('1');
		}
	}

	function fn_egov_addNotice() {
		document.frm.action = "<c:url value='/cop/bbs${prefix}/addBoardArticle.do'/>";
		document.frm.submit();
	}

	function fn_egov_select_noticeList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
		document.frm.submit();
	}

	function fn_egov_inqire_notice(nttId, bbsId) {
		//document.subForm.nttId.value = nttId;
		//document.subForm.bbsId.value = bbsId;
		//document.subForm.action = "<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>";
		//document.subForm.submit();
	}
//-->
</script>
</c:otherwise>
</c:choose>
<title><c:out value="${brdMstrVO.bbsNm}"/> 목록</title>

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
                            <li><strong>${brdMstrVO.bbsNm}</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->

			<form name="frm" action ="<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>" method="post">
			<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
			<input type="hidden" name="nttId"  value="0" />
			<input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
			<input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
			<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<input type="submit" value="실행" onclick="fn_egov_select_noticeList('1'); return false;" id="invisible" class="invisible" />

			<!-- sub title start -->
            <div><h2><c:out value="${brdMstrVO.bbsNm}"/></h2></div>
            <!-- sub title end -->

            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
	                <div class="search_conditions" >
	                    <select name="searchCnd" class="select" title="검색조건 선택">
					           <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >제목</option>
					           <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >내용</option>
					           <option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> >작성자</option>
					    </select>
					    <input name="searchWrd" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);" title="검색어 입력">
	                </div>
	                <div class="search_buttons">
				        <input type="submit" value="<spring:message code='button.inquire' />" onclick="fn_egov_select_noticeList('1'); return false;" />
				        <c:if test="${brdMstrVO.authFlag == 'Y'}">
				            <a href="<c:url value='/cop/bbs${prefix}/addBoardArticle.do?bbsId=${boardVO.bbsId}'/>"><spring:message code="button.create" /></a>
				        </c:if>
	                </div>
                </div>
            </div>
            <!-- search area end -->

            </form>

<!-- search result start -->
            <div class="search_result_div">

                <table width="98%" cellpadding="0" cellspacing="0" summary="번호, 제목, 게시시작일, 게시종료일, 작성자, 작성일, 조회수   입니다">
                <caption>게시물목록</caption>

                <colgroup>
                    <col width="5%" >
                    <col >
                    <c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
                      <col width="15%" >
                      <col width="15%" >
                    </c:if>
                    <c:if test="${anonymous != 'true'}">
                      <col width="10%" >
                    </c:if>
                    <col width="15%" >
                    <col width="5%" >
                </colgroup>

                <thead>
                <tr>
                    <th>번호</th>
				    <th>제목</th>
				    <c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
				        <th>게시시작일</th>
				        <th>게시종료일</th>
				    </c:if>
				    <c:if test="${anonymous != 'true'}">
				        <th>작성자</th>
				    </c:if>
				    <th>작성일</th>
				    <th>조회수</th>
                </tr>
                </thead>

                <tbody>
				<c:if test="${fn:length(resultList) == 0}">
			        <tr>
			        <c:choose>
			            <c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
			                <td colspan="7" ><spring:message code="common.nodata.msg" /></td>
			            </c:when>
			            <c:otherwise>
			                <c:choose>
			                    <c:when test="${anonymous == 'true'}">
			                        <td colspan="4" ><spring:message code="common.nodata.msg" /></td>
			                    </c:when>
			                    <c:otherwise>
			                        <td colspan="5" ><spring:message code="common.nodata.msg" /></td>
			                    </c:otherwise>
			                </c:choose>
			            </c:otherwise>
			          </c:choose>
			          </tr>
			     </c:if>
                 <c:forEach var="result" items="${resultList}" varStatus="status">
			     <tr>
			        <td ><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
			        <td align="left">
			        <form name="subForm" method="post" action="<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>">
			            <c:if test="${result.replyLc!=0}">
			                <c:forEach begin="0" end="${result.replyLc}" step="1">
			                    &nbsp;
			                </c:forEach>
			                <img src="<c:url value='/images/reply_arrow.gif'/>" alt="reply arrow">
			            </c:if>
			            <c:choose>
			                <c:when test="${result.isExpired=='Y' || result.useAt == 'N'}">
			                    <c:out value="${result.nttSj}" />
			                </c:when>
			                <c:otherwise>
			                        <input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
			                        <input type="hidden" name="nttId"  value="<c:out value="${result.nttId}"/>" />
			                        <input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
			                        <input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
			                        <input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
			                        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			                        <span class="link"><input type="submit" style="width:320px;border:solid 0px black;text-align:left;" value="<c:out value="${result.nttSj}"/>" ></span>
			                </c:otherwise>
			            </c:choose>
			            </form>
			        </td>
			        <c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
			            <td ><c:out value="${result.ntceBgnde}"/></td>
			            <td ><c:out value="${result.ntceEndde}"/></td>
			        </c:if>
			        <c:if test="${anonymous != 'true'}">
			            <td ><c:out value="${result.frstRegisterNm}"/></td>
			        </c:if>
			        <td ><c:out value="${result.frstRegisterPnttm}"/></td>
			        <td ><c:out value="${result.inqireCo}"/></td>
			     </tr>
			     </c:forEach>
                 </tbody>

                 </table>
            </div>
            <!-- search result end -->

			<div id="paging_div"><ul class="paging_align">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_noticeList" />
				</ul>
			</div>

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