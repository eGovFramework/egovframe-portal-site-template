<%--
  Class Name : EgovStplatListInqire.jsp
  Description : EgovStplatListInqire 화면
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
<title>샘플 포털 > 포털시스템관리 > 사용자관리 > 이용약관관리</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

<script type="text/javaScript">

/*********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_initl_stplatlist(){
    // 첫 입력란에 포커스..
    document.getElementById("searchKeyword").focus();
}

/*********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_select_linkPage(pageNo){
	document.getElementById("pageIndex").value = pageNo;
	document.getElementById("StplatListForm").action = "<c:url value='/uss/sam/stp/StplatListInqire.do'/>";
	document.getElementById("StplatListForm").submit();
}

/*********************************************************
 * 조회 처리 함수
 ******************************************************** */
function fn_egov_search_stplatcn(){
	document.getElementById("pageIndex").value = 1;
	document.getElementById("StplatListForm").submit();
}

/*********************************************************
 * 등록 처리 함수
 ******************************************************** */
function fn_egov_regist_stplatcn(){
	document.getElementById("StplatListForm").action = "<c:url value='/uss/sam/stp/StplatCnRegistView.do'/>";
	document.getElementById("StplatListForm").submit();    
}

/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_inquire_stplatdetail(useStplatId) {        

    // 사이트 키값(siteId) 셋팅.
    document.getElementById("useStplatId").value = useStplatId;    
    document.getElementById("StplatListForm").action = "<c:url value='/uss/sam/stp/StplatDetailInqire.do'/>";
    document.getElementById("StplatListForm").submit();    
                      
}
</script>
</head>
<body>
<!-- 자바스크립트 경고 태그  -->
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

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
                                        <li><a href="">포털시스템관리</a></li>
                                        <li><a href="">사용자관리</a></li>
                                        <li>이용약관관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form id="StplatListForm" name="StplatListForm" action="<c:url value='/uss/sam/stp/StplatListInqire.do'/>" method="post">

                                <h1 class="tit_1">포털시스템관리</h1>

                                <p class="txt_1">포털시스템의 사용자 및 권한에 대한 제반사항을 관리합니다.</p>

                                <h2 class="tit_2">사용자관리</h2>

                                <h3 class="tit_3">이용약관관리</h3>

                                <!-- 검색조건 -->
                                <div class="condition2">
                                    <label class="item f_select" for="searchCondition">
                                        <select id="searchCondition" name="searchCondition" title="검색조건 선택">
                                            <option selected value=''>선택하세요</option>
                                            <option value="useStplatNm" <c:if test="${searchVO.searchCondition == 'useStplatNm'}">selected="selected"</c:if> >이용약관명</option>
                                            <option value="useStplatCn" <c:if test="${searchVO.searchCondition == 'useStplatCn'}">selected="selected"</c:if> >이용약관내용</option>
                                         </select>
                                    </label>

                                    <span class="item f_search">
                                        <input id="searchKeyword" class="f_input w_500" name="searchKeyword" type="text" title="검색어 입력" value='<c:out value="${searchVO.searchKeyword}"/>' maxlength="35" >
                                        <button class="btn" type="submit" onclick="fn_egov_search_stplatcn(); return false;"><spring:message code="button.inquire" /></button><!-- 조회 -->
                                    </span>

                                    <a href="<c:url value='/uss/sam/stp/StplatCnRegistView.do'/>" class="item btn btn_blue_46 w_100"><spring:message code="button.create" /></a><!-- 등록 -->
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="이 표는 약관내용 대상 정보를 제공하며, 이용약관명, 이용약관내용, 등록일자 내용 정보로 구성되어 있습니다 .">
                                    	<caption>약관목록</caption>
                                        <colgroup>
                                            <col style="width: 70px;">
                                            <col style="width: 200px;">
                                            <col style="width: auto;">
                                            <col style="width: 120px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">순번</th>
                                                <th scope="col">이용약관명</th>
                                                <th scope="col">이용약관내용</th>
                                                <th scope="col">등록일자</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	
                                        	<c:if test="${fn:length(resultList) == 0}">
                                        	<tr>
                                        		<td colspan="4"><spring:message code="common.nodata.msg" /></td>
                                        	</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                                            <tr>
                                                <td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
                                                <td>
                                                	<a href="#LINK" class="lnk" onClick="fn_egov_inquire_stplatdetail('<c:out value="${resultInfo.useStplatId}"/>')">
                                                		<c:out value="${resultInfo.useStplatNm}"/>
                                                	</a>
                                                </td>
                                                <td onClick="fn_egov_inquire_stplatdetail('<c:out value="${resultInfo.useStplatId}"/>')">
                                                	<a href="#LINK" class="lnk" onClick="fn_egov_inquire_stplatdetail('<c:out value="${resultInfo.useStplatId}"/>')">
                                                		<c:out value='${fn:substring(resultInfo.useStplatCn, 0, 40)}'/>
                                                	</a>
                                                </td>
                                                <td><c:out value='${fn:substring(resultInfo.lastUpdtPnttm, 0, 10)}'/></td>
                                            </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                </div>

								<!-- 페이징 -->
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo = "${paginationInfo}" type="renew" jsFunction="fn_egov_select_linkPage" />
                                        </ul>
                                    </div>
                                </div>
                                <!-- // 페이징 끝 -->
                                
                                <input id="useStplatId" name="useStplatId" type="hidden" value="">
                                <input id="pageIndex" name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
                                
                                </form>
                                
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