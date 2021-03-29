<%--
  Class Name : EgovBoardUseInfList.jsp
  Description : 게시판  사용정보  목록화면
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_bbsUseInfs('1');
		}
	}
	
	function fn_egov_select_bbsUseInfs(pageNo) {
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/cop/com/selectCmyBBSUseInfsByTrget.do'/>";
		document.frm.submit();
	}
	
	function fn_egov_update_bbsUseInf(bbsId, trgetId) {
		if (confirm('<spring:message code="cop.use.msg" />')) {
			document.frm.bbsId.value = bbsId;
			document.frm.param_trgetId.value = trgetId;
			document.frm.useAt.value = 'Y';
			document.frm.action = "<c:url value='/cop/com/updateBBSUseInfByTrget.do'/>";
			document.frm.submit();
		}
	}
	
	function fn_egov_delete_bbsUseInf(bbsId, trgetId) {
		if (confirm('<spring:message code="cop.unuse.msg" />')) {
			document.frm.bbsId.value = bbsId;
			document.frm.param_trgetId.value = trgetId;
			document.frm.useAt.value = 'N';
			document.frm.action = "<c:url value='/cop/com/updateBBSUseInfByTrget.do'/>";
			document.frm.submit();
		}	
	}

	function fn_egov_insert_bbsUseInf(bbsId, trgetId) {
		if (confirm('<spring:message code="cop.use.msg" />')) {
			document.frm.bbsId.value = bbsId;
			document.frm.param_trgetId.value = trgetId;
			document.frm.useAt.value = 'Y';
			document.frm.action = "<c:url value='/cop/com/insertBBSUseInfByTrget.do'/>";
			document.frm.submit();
		}
	}
</script>

<title>게시판 사용정보 조회</title>

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
            
<form name="frm" method="post">
<input type="submit" id="invisible" class="invisible"/>
<input type="hidden" name="bbsId" />
<input type="hidden" name="trgetId" value='<c:out value="${trgetId}"/>' />
<input type="hidden" name="useAt" />
<input type="hidden" name="param_trgetId" />
<input type="hidden" name="trgetType" value='<c:out value="${trgetType}"/>' />


	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="40%"class="title_left">
	   <img src="<c:url value='/images/egovframework/com/cop/com/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle" alt="">
	   &nbsp;게시판 사용정보 조회</td>
	  <th >
	  </th>
	  <td width="10%" >
		   <select name="searchCnd" title="검색조건선택" class="select">
			   <!-- option selected value=''>--선택하세요--</option-->
			   <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >사용자명</option>
		   </select>
		</td>
	  <td width="35%">
	    <input name="searchWrd" title="검색어" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);"> 
	  </td>
	  <th width="10%">
	   <table border="0" cellspacing="0" cellpadding="0">
	    <tr> 
	      <td><img src="<c:url value='/images/egovframework/com/cop/com/btn/bu2_left.gif' />" width="8" height="20" alt="button left"></td>
	      <td background="<c:url value='/images/egovframework/com/cop/com/btn/bu2_bg.gif'/>" class="text_left" nowrap="nowrap">
	      <a href="<c:url value='/cop/com/selectCmyBBSUseInfsByTrget.do'/>" onclick="javascript:fn_egov_select_bbsUseInfs('1'); return false;">조회</a> 
	      </td>
	      <td><img src="<c:url value='/images/egovframework/com/cop/com/btn/bu2_right.gif'/>" width="8" height="20" alt="button right"></td>
	    </tr>
	   </table>
	  </th>  
	 </tr>
	</table>
	<table width="100%" cellpadding="8" class="table-line">
	 <thead>
	  <tr>
	    <!-- th class="title" width="3%" nowrap="nowrap"><input type="checkbox" name="all_check" class="check2"></th-->  
	    <th class="title" width="10%" nowrap="nowrap">번호</th>
	    <th class="title" width="37%" nowrap="nowrap">게시판명</th>
	    <th class="title" width="30%" nowrap="nowrap">사용자명</th>
	    <th class="title" width="10%" nowrap="nowrap">사용여부</th>   
	    <th class="title" width="10%" nowrap="nowrap">상태변경</th>         
	  </tr>
	 </thead>    
	 <tbody>
	 <c:forEach var="result" items="${resultList}" varStatus="status">
	 	<tr>
	    <td class="lt_text3" nowrap="nowrap"><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
	    <td class="lt_text" nowrap="nowrap"><c:out value="${result.bbsNm}"/></td>
	    <td class="lt_text3" nowrap="nowrap"><c:out value="${result.userNm}"/></td>
    	<c:choose>
    		<c:when test="${result.useAt=='Y'}">
			    <td class="lt_text3" nowrap="nowrap">
			    	<spring:message code="button.use" />    
			    </td>
			    <td class="lt_text3" nowrap="nowrap">
			    	<input type="button" value="사용중지" onClick="javascript:fn_egov_delete_bbsUseInf('<c:out value="${result.bbsId}"/>','<c:out value="${result.trgetId}"/>');" />
			    </td>     		
    		</c:when>
    		<c:when test="${result.useAt=='N'}">
			    <td class="lt_text3" nowrap="nowrap">
			    	<spring:message code="button.notUsed" />    
			    </td>
			    <td class="lt_text3" nowrap="nowrap">
			    	<input type="button" value="사용" onClick="javascript:fn_egov_update_bbsUseInf('<c:out value="${result.bbsId}"/>','<c:out value="${result.trgetId}"/>');" />
			    </td>     		
    		</c:when>
    		<c:otherwise>
		 	    <td class="lt_text3" nowrap="nowrap">
			    	미사용
			    </td>
			    <td class="lt_text3" nowrap="nowrap">
			    	<input type="button" value="사용" onClick="javascript:fn_egov_insert_bbsUseInf('<c:out value="${result.bbsId}"/>','<c:out value="${result.trgetId}"/>');" />
			    </td>    		
    		</c:otherwise>
    	</c:choose>	    
	    
	  </tr>
	 </c:forEach>
		 <c:if test="${fn:length(resultList) == 0}">
		  <tr>
		    <td class="lt_text3" nowrap colspan="6" ><spring:message code="common.nodata.msg" /></td>  
		  </tr>		 
		 </c:if>	 
	 </tbody>  
	 <!--tfoot>
	  <tr class="">
	   <td colspan=6 align="center"></td>
	  </tr>
	 </tfoot -->
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr> 
	    <td height="10"></td>
	  </tr>
	</table>
	<div id="paging_div">
	<ul class="paging_align">
		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_bbsUseInfs" />
	</ul>
	</div>
	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
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