<%--
  Class Name : EgovQnaListInqire.jsp
  Description : EgovQnaListInqire 화면
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
<title>Q&amp;A 목록</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javaScript" language="javascript">

/*********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_initl_qnalist(){

	// 첫 입력란에 포커스..
	document.QnaListForm.searchKeyword.focus();
	
}

/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	
	document.QnaListForm.pageIndex.value = pageNo;
	document.QnaListForm.action = "<c:url value='/uss/olh/qna/QnaListInqire.do'/>";
   	document.QnaListForm.submit();
   	
}

/*********************************************************
 * 조회 처리 함수
 ******************************************************** */
function fn_egov_search_qnacn(){

	document.QnaListForm.pageIndex.value = 1;
	document.QnaListForm.submit();
	
}

/*********************************************************
 * Q&A 등록화면 호출
 ******************************************************** */
function fn_egov_regist_cnsltcn(){

	document.QnaListForm.action = "<c:url value='/uss/olh/qna/QnaCnRegistView.do'/>";
	document.QnaListForm.submit();
		
}

/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_inquire_qnadetail(qaId) {		

	// 사이트 키값(siteId) 셋팅.
	document.QnaListForm.qaId.value = qaId;	
//  document.QnaListForm.action = "<c:url value='/uss/olh/qna/QnaDetailInqire.do'/>";
  	document.QnaListForm.action = "<c:url value='/uss/olh/qna/QnaInqireCoUpdt.do'/>"; 
  	document.QnaListForm.submit();	
	   	   		
}

</script>
</head>
<body onLoad="fn_egov_initl_qnalist();">

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
                            <li><strong>Q&amp;A</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
            <form name="QnaListForm" action="<c:url value='/uss/olh/qna/QnaListInqire.do'/>" method="post">

			<!--실명확인을 위한  설정   Start...-->
			<input type="hidden" name="ihidnum" value="">
			<input type="hidden" name="realname" value="">
			
			<input type="hidden" name ="nextUrlName" value="QA등록">
			<input type="hidden" name ="nextUrl" value="/uss/olh/qna/QnaCnRegistView.do">
			
			<input type="hidden" name="certificationAt" value="${certificationAt}">
			<input type="hidden" name="loginRealnmAt" value="">
			
			<input type="hidden" name="wrterNm" value="">
			<!--실명확인을 위한  설정 End......-->

            <!-- sub title start -->
            <div><h2>Q&amp;A목록조회</h2></div>
            <!-- sub title end -->
            
            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >
                    <select name="searchCondition" class="select" title="조회조건 선택">
			           <option selected value=''>--선택하세요--</option>
			           <option value="wrterNm"  <c:if test="${searchVO.searchCondition == 'wrterNm'}">selected="selected"</c:if> >작성자명</option>
			           <option value="qestnSj"  <c:if test="${searchVO.searchCondition == 'qestnSj'}">selected="selected"</c:if> >질문제목</option>            
			       </select>
			       <input name="searchKeyword" type="text" size="35" value='<c:out value="${searchVO.searchKeyword}"/>'  maxlength="35" title="검색어 입력" >
                </div>
                    <div class="search_buttons">
                        <input type="submit" value="조회" onclick="fn_egov_search_qnacn(); return false;"/>
                        <a href="<c:url value='/uss/olh/qna/QnaCnRegistView.do'/>" onclick="fn_egov_regist_cnsltcn(); return false;"><spring:message code="button.create" /></a>
                    </div>
                </div> 
            </div>
            <!-- search area end -->
            
            <input name="qaId" type="hidden" value="">
			<input name="passwordConfirmAt" type="hidden" value="">
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			</form>
  
            <!-- search result start -->
            <div class="search_result_div">
            
                <table width="98%" cellpadding="0" cellspacing="0" summary="Q&amp;A에 대한 목록을 제공합니다.">
                <caption>Q&amp;A 목록</caption>
                
                <colgroup>
                    <col width="10%" > 
                    <col width="40%" >
                    <col width="15%" >
                    <col width="10%" >
                    <col width="10%" >
                    <col width="15%" >
                </colgroup>
                
                <thead>
                <tr>      
                    <th>순번</th>        
				    <th>질문제목</th>    
				    <th>작성자</th>        
				    <th>진행상태</th>               
				    <th>조회수</th>        
				    <th>작성일자</th> 
                </tr>
                </thead>
                
                <tbody>
                <c:if test="${fn:length(resultList) == 0}">
                <tr> 
                      <td class="lt_text3" colspan="6">
                          <spring:message code="common.nodata.msg" />
                      </td>
                </tr>                                                 
                </c:if>
			    <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
			    <tr>
			        <td class="lt_text3"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
			        <td class="lt_text3">
			            <a href = "<c:url value='/uss/olh/qna/QnaInqireCoUpdt.do'/>?qaId=${resultInfo.qaId}&amp;pageIndex=${searchVO.pageIndex}" 
			               onclick="fn_egov_inquire_qnadetail('<c:out value="${resultInfo.qaId}"/>'); return false;" >
			               <c:out value="${resultInfo.qestnSj}"/>
			            </a>
			        </td>
			        <td class="lt_text3"><c:out value="${resultInfo.wrterNm}"/></td>
			        <td class="lt_text3"><c:out value="${resultInfo.qnaProcessSttusCodeNm}"/></td>
			        <td class="lt_text3"><c:out value="${resultInfo.rdcnt}"/></td>               
			        <td class="lt_text3"><c:out value='${fn:substring(resultInfo.writngDe, 0,4)}'/>-<c:out value='${fn:substring(resultInfo.writngDe, 4,6)}'/>-<c:out value='${fn:substring(resultInfo.writngDe, 6,8)}'/></td>      
			    </tr>   
			    </c:forEach>
                </tbody>
                  
                </table>
            </div>
            <!-- search result end -->

			<div id="paging_div">
				<ul class="paging_align">
					<ui:pagination paginationInfo = "${paginationInfo}"
							type="image"
							jsFunction="fn_egov_select_linkPage"
							/></ul>
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
