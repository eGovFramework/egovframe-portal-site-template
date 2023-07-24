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
<title>샘플 포털 > 포털서비스관리 > 서비스관리 > QnA관리</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

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
	document.QnaListForm.action = "<c:url value='/uss/olh/qna/admin/QnaListInqire.do'/>";
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

	document.QnaListForm.action = "<c:url value='/uss/olh/qna/admin/QnaCnRegistView.do'/>";
	document.QnaListForm.submit();
		
}

/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_inquire_qnadetail(qaId) {		

	// 사이트 키값(siteId) 셋팅.
	document.QnaListForm.qaId.value = qaId;	
//  document.QnaListForm.action = "<c:url value='/uss/olh/qna/admin/QnaDetailInqire.do'/>";
  	document.QnaListForm.action = "<c:url value='/uss/olh/qna/admin/QnaInqireCoUpdt.do'/>"; 
  	document.QnaListForm.submit();	
	   	   		
}

</script>
</head>
<body>

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <!-- header start -->
	    <c:import url="/sym/mms/EgovHeader.do" />
	    <!-- //header end -->

        <div class="container">
            <div class="sub_layout">
                <div class="sub_in">
                    <div class="layout">
                        <!-- Left menu -->
	                    <c:import url="/sym/mms/EgovMenuLeft.do" />
	                    <!--// Left menu -->
        
                        <div class="content_wrap">
                            <div id="contents" class="content">
                                 <!-- Location -->
                                <div class="location">
                                    <ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li>포털서비스관리</li>
                                        <li><a href="">서비스관리</a></li>
                                        <li>QnA관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

                                <h1 class="tit_1">포털서비스관리</h1>

                                <p class="txt_1">포털시스템에서 제공되는 서비스들에 대한 컨텐츠를 관리합니다.</p>

                                <h2 class="tit_2">서비스관리</h2>

                                <h3 class="tit_3">QnA관리</h3>

                                <!-- 검색조건 -->
                                <div class="condition">
                                
                                	<form name="QnaListForm" action="<c:url value='/uss/olh/qna/admin/QnaListInqire.do'/>" method="post">

										<!--실명확인을 위한  설정   Start...-->
										<input type="hidden" name="ihidnum" value="">
										<input type="hidden" name="realname" value="">
										
										<input type="hidden" name ="nextUrlName" value="QA등록">
										<input type="hidden" name ="nextUrl" value="/uss/olh/qna/admin/QnaCnRegistView.do">
										
										<input type="hidden" name="certificationAt" value="<c:out value='${certificationAt}'/>">
										<input type="hidden" name="loginRealnmAt" value="">
										
										<input type="hidden" name="wrterNm" value="">
										<!--실명확인을 위한  설정 End......-->
                                
	                                    <label class="item f_select" for="sel1">
	                                        <select id="sel1" name="searchCondition" class="select" title="조회조건 선택">
	                                            <option selected="" value="">선택하세요</option>
	                                            <option value="wrterNm" <c:if test="${searchVO.searchCondition == 'wrterNm'}">selected="selected"</c:if> >작성자명</option>
	                                            <option value="qestnSj" <c:if test="${searchVO.searchCondition == 'qestnSj'}">selected="selected"</c:if> >질문제목</option>
	                                        </select>
	                                    </label>
	
	                                    <span class="item f_search">
	                                        <input class="f_input w_500" name="searchKeyword" type="text" value='<c:out value="${searchVO.searchKeyword}"/>' maxlength="35" title="검색어 입력" >
	                                        <button class="btn" type="submit" onclick="fn_egov_search_qnacn(); return false;">조회</button><!-- 조회 -->
	                                    </span>
	
	                                    <a href="<c:url value='/uss/olh/qna/admin/QnaCnRegistView.do'/>" class="item btn btn_blue_46 w_100" onclick="fn_egov_regist_cnsltcn(); return false;"><spring:message code="button.create" /></a><!-- 등록 -->
	                                    
	                                    <input name="qaId" type="hidden" value="">
										<input name="passwordConfirmAt" type="hidden" value="">
										<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
									</form>
                                    
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table>
                                    	<caption>Q&amp;A 목록</caption>
                                        <colgroup>
                                            <col style="width: 70px;">
                                            <col style="width: auto;">
                                            <col style="width: 120px;">
                                            <col style="width: 120px;">
                                            <col style="width: 120px;">
                                            <col style="width: 120px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">순번</th>
                                                <th scope="col">질문제목</th>
                                                <th scope="col">작성자</th>
                                                <th scope="col">진행상태</th>
                                                <th scope="col">조회수</th>
                                                <th scope="col">작성일자</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        
                                        	<c:if test="${fn:length(resultList) == 0}">
								            	<tr> 
								            		<td colspan="6">
								            			<spring:message code="common.nodata.msg" />
								            		</td>
								            	</tr>
								            </c:if>
								            
								            <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                                            <tr>
                                                <td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
                                                <td class="al">
                                                	<a href = "<c:url value='/uss/olh/qna/admin/QnaInqireCoUpdt.do'/>?qaId=${resultInfo.qaId}&amp;pageIndex=${searchVO.pageIndex}" class="lnk" onclick="fn_egov_inquire_qnadetail('<c:out value="${resultInfo.qaId}"/>'); return false;" >
                                                		<c:out value="${resultInfo.qestnSj}"/>
                                                	</a>
                                                </td>
                                                <td><c:out value="${resultInfo.wrterNm}"/></td>
                                                <td><c:out value="${resultInfo.qnaProcessSttusCodeNm}"/></td>
                                                <td><c:out value="${resultInfo.inqireco}"/></td>
                                                <td><c:out value='${fn:substring(resultInfo.writngDe, 0,4)}'/>-<c:out value='${fn:substring(resultInfo.writngDe, 4,6)}'/>-<c:out value='${fn:substring(resultInfo.writngDe, 6,8)}'/></td>
                                            </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                </div>

								<!-- 페이징 -->
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_select_linkPage" />
                                        </ul>
                                    </div>
                                </div>
                                <!-- // 페이징 끝 -->
                                
                                <!--// 게시판 -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- footer 시작 -->
	    <c:import url="/sym/mms/EgovFooter.do" />
	    <!-- //footer 끝 -->
    </div>
    
</body>
</html>