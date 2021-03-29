<%--
  Class Name : EgovFaqListInqire.jsp
  Description : EgovFaqListInqire 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01   박정규          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 박정규
    since    : 2009.02.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>FAQ 목록 조회</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javaScript" language="javascript">

/*********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_initl_faqlist(){

	// 첫 입력란에 포커스..
	document.FaqListForm.searchKeyword.focus();
	
}

/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	
	document.FaqListForm.pageIndex.value = pageNo;
	document.FaqListForm.action = "<c:url value='/uss/olh/faq/FaqListInqire.do'/>";
   	document.FaqListForm.submit();
   	
}

/*********************************************************
 * 조회 처리 함수
 ******************************************************** */
function fn_egov_search_faq(){

	document.FaqListForm.pageIndex.value = 1;
	document.FaqListForm.submit();
	
}

/*********************************************************
 * 등록 처리 함수
 ******************************************************** */
function fn_egov_regist_faq(){

	document.FaqListForm.action = "<c:url value='/uss/olh/faq/FaqCnRegistView.do'/>";
	document.FaqListForm.submit();	
	
}

/*********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_updt_faqlist(){

	document.FaqListForm.action = "<c:url value='/uss/olh/faq/FaqCnUpdtView.do'/>";
	document.FaqListForm.submit();	

}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_inquire_faqlistdetail(faqId) {		

	// Faqid
	document.FaqListForm.faqId.value = faqId;	
  	document.FaqListForm.action = "<c:url value='/uss/olh/faq/FaqInqireCoUpdt.do'/>";  	
  	document.FaqListForm.submit();	
	   	   		
}


</script>
</head>
<body onLoad="fn_egov_initl_faqlist();">

<!-- login status start -->
<div id="login_area"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncTborder" /></div>
<!-- //login status end -->
<!-- wrap start -->
<div id="wrap"> 
    <!-- header start -->
    <div id="subheader"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>  
    <!-- //header end -->
    <!--  타이틀 이미지 시작 -->
    <div id="title_img_div"><img src="<c:url value='/'/>images/title_image/img_title04.gif" alt="" /></div>
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
                            <li>정보마당</li>
                            <li>&gt;</li>
                            <li><strong>FAQ</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
            <form name="FaqListForm" action="<c:url value='/uss/olh/faq/FaqListInqire.do'/>" method="post">
            
            <!-- sub title start -->
            <div><h2>FAQ목록</h2></div>
            <!-- sub title end -->
            
            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >
                    <select name="searchCondition" class="select" title="조회조건 선택">
			           <option selected value=''>--선택하세요--</option>
			           <option value="qestnSj"  <c:if test="${searchVO.searchCondition == 'qestnSj'}">selected="selected"</c:if> >질문제목</option>            
			       </select>
			       <input name="searchKeyword" type="text" size="35" value='<c:out value="${searchVO.searchKeyword}"/>'  maxlength="35" title="검색어 입력" > 
                </div>
                    <div class="search_buttons">
                        <input type="submit" value="조회" onclick="fn_egov_search_faq(); return false;" />
                        <a href="<c:url value='/uss/olh/faq/FaqCnRegistView.do'/>" onclick="fn_egov_regist_faq(); return false;"><spring:message code="button.create" /></a>
                    </div>
                </div> 
            </div>
            <!-- search area end -->
            <input name="faqId" type="hidden" value="">
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			</form>

            <!-- search result start -->
            <div class="search_result_div">
            
                <table width="98%" cellpadding="0" cellspacing="0" summary="FAQ에 대한 목록을 제공합니다.">
                <caption>약관목록</caption>
                
                <colgroup>
                    <col width="15%" > 
                    <col width="55%" >
                    <col width="15%" >
                    <col width="15%" >
                </colgroup>
                
                <thead>
                <tr>      
                    <th>순번</th>        
				    <th>질문제목</th>                   
				    <th>조회수</th>        
				    <th>등록일자</th>               
                </tr>
                </thead>
                
                <tbody>
                <c:if test="${fn:length(resultList) == 0}">
                <tr> 
                      <td class="lt_text3" colspan="4">
                          <spring:message code="common.nodata.msg" />
                      </td>
                </tr>                                                 
                </c:if>
                <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                <tr>
			        <td class="lt_text3"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>         
			        <td class="lt_text3"  align="left">
			            <a href="<c:url value='/uss/olh/faq/FaqInqireCoUpdt.do?faqId=${resultInfo.faqId}&amp;pageIndex=${searchVO.pageIndex}'/>" onclick="fn_egov_inquire_faqlistdetail('<c:url value='${resultInfo.faqId}'/>'); return false;">
			                <c:out value="${resultInfo.qestnSj}"/>
			            </a>
			        </td>       
			        <td class="lt_text3"><c:out value="${resultInfo.inqireCo}"/></td>       
			        <td class="lt_text3"><fmt:formatDate value="${resultInfo.lastUpdtPnttm}"  pattern="yyyy-MM-dd"/></td>         
			    </tr>   
                </c:forEach>
                </tbody>
                  
                </table>
            </div>
            <!-- search result end -->
            
			<div id="paging_div">
				<ul class="paging_align">
					<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage"/>
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