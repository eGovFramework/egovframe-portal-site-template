<%--
  Class Name : EgovQustnrManageList.jsp
  Description : 설문관리 목록 페이지
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.09
   
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images_old/egovframework/com/uss/olp/qmc/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>샘플 포털 > 포털서비스관리 > 설문관리 > 설문지</title>
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
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/olp/qmc/EgovQustnrManageList.do'/>";
    document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_QustnrManage(){
    location.href = "<c:url value='/uss/olp/qmc/EgovQustnrManageRegist.do'/>";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_modify_QustnrManage(){
    location.href = "<c:url value='/uss/olp/qmc/EgovQustnrManageModify.do'/>";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_QustnrManage(qestnrId){
    var vFrom = document.listForm;
    vFrom.qestnrId.value = qestnrId;
    vFrom.action = "<c:url value='/uss/olp/qmc/EgovQustnrManageDetail.do'/>";
    vFrom.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fn_egov_delete_QustnrManage(qestnrId){
    var vFrom = document.listForm;
    if(confirm('<spring:message code="common.delete.msg" />')) {
        vFrom.qestnrId.value = qestnrId;
        vFrom.cmd.value = 'del';
        vFrom.action = "<c:url value='/uss/olp/qmc/EgovQustnrManageList.do'/>";
        vFrom.submit();
    }else{
        vFrom.cmd.value = '';
    }
}
/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_QustnrManage(){
    var vFrom = document.listForm;

    vFrom.action = "<c:url value='/uss/olp/qmc/EgovQustnrManageList.do'/>";
    vFrom.submit();
    
}

/* ********************************************************
 * 선택한 설문지정보 -> 설문문항 바로가기
 ******************************************************** */
function fn_egov_list_QustnrQestnManag(qestnrId, qestnrTmplatId, Type){
    var vFrom = document.listForm;
    var sAction = "";
    vFrom.qestnrId.value = qestnrId;
    vFrom.qestnrTmplatId.value = qestnrTmplatId;
    vFrom.searchCondition.options[0].selected = true;
    vFrom.searchKeyword.value = '';
    vFrom.searchMode.value = 'Y';

    //QRM QQM QRI
    if(Type == 'QRM'){ //설문응답자정보
        sAction  = "<c:url value='/uss/olp/qrm/EgovQustnrRespondManageList.do'/>";
    }else if(Type == 'QQM'){ //설문문항
        sAction  = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageList.do'/>";
    }else if(Type == 'QRI'){ //응답자결과
        sAction  = "<c:url value='/uss/olp/qri/EgovQustnrRespondInfoList.do'/>";
    }
    
    vFrom.action = sAction;
    vFrom.submit();

}
 /* ********************************************************
  * 통계
  ******************************************************** */
function fn_egov_statistics_QustnrQestnManag(qestnrId, qestnrTmplatId){
    var vFrom = document.listForm;
    vFrom.qestnrId.value = qestnrId;
    vFrom.qestnrTmplatId.value = qestnrTmplatId;
    vFrom.searchCondition.options[0].selected = true;
    vFrom.searchKeyword.value = '';
    vFrom.action = "<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageStatistics.do'/>"; 
    vFrom.submit();
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
                                        <li><a href="">포털서비스관리</a></li>
                                        <li><a href="">설문관리</a></li>
                                        <li>설문지</li>
                                    </ul>
                                </div>
                                <!--// Location -->

                                <h1 class="tit_1">포털서비스관리</h1>

                                <p class="txt_1">포털시스템에서 제공되는 서비스들에 대한 컨텐츠를 관리합니다.</p>

                                <h2 class="tit_2">설문관리</h2>

                                <h3 class="tit_3">설문지</h3>

                                <!-- 검색조건 -->
                                <div class="condition">
                                
                                	<form name="listForm" action="<c:url value='/uss/olp/qmc/EgovQustnrManageList.do'/>" method="post">
                                	
                                    <label class="item f_select" for="sel1">
                                        <select name="searchCondition" title="검색조건 선택" id="sel1">
                                            <option value=''>선택하세요</option>
                                            <option value='QUSTNR_SJ' <c:if test="${searchCondition == 'QUSTNR_SJ'}">selected</c:if>>설문제목</option>
                                            <option value='FRST_REGISTER_ID' <c:if test="${searchCondition == 'FRST_REGISTER_ID'}">selected</c:if>>등록자</option>
                                        </select>
                                    </label>

                                    <span class="item f_search">
                                        <input class="f_input w_500" name="searchKeyword" type="text" size="30" value="${searchKeyword}" title="검색어 입력" maxlength="35">
                                        <button class="btn" type="submit" onclick="fn_egov_search_QustnrManage(); return false;"><spring:message code="button.inquire" /></button><!-- 검색 -->
                                    </span>

                                    <a href="<c:url value='/uss/olp/qmc/EgovQustnrManageRegist.do'/>" class="item btn btn_blue_46 w_100"><spring:message code="button.create" /></a>
                                    
                                    <input name="qestnrId" type="hidden" value="">
	                                <input name="qestnrTmplatId" type="hidden" value="">
	                                <input name="searchMode" type="hidden" value="">
	                                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
	                                
	                                </form>
                                    
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table>
                                    	<caption summary="설문관리 목록 을 제공한다.">설문관리 목록</caption>
                                    	
                                        <colgroup>
                                            <col style="width: 70px;">
                                            <col style="width: auto;">
                                            <col style="width: 180px;">
                                            <col style="width: 85px;">
                                            <col style="width: 85px;">
                                            <col style="width: 85px;">
                                            <col style="width: 85px;">
                                            <col style="width: 75px;">
                                            <col style="width: 100px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">순번</th>
                                                <th scope="col">설문제목</th>
                                                <th scope="col">설문기간</th>
                                                <th scope="col">설문응답자<br>정보</th>
                                                <th scope="col">설문문항</th>
                                                <th scope="col">설문조사</th>
                                                <th scope="col">통계</th>
                                                <th scope="col">등록자</th>
                                                <th scope="col">등록일자</th>
                                            </tr>
                                        </thead>
                                        
                                        <tbody>
                                        	<!-- 데이터가 없을 때 -->
                                        	<c:if test="${fn:length(resultList) == 0}">
                                        	<tr>
                                        		<td colspan="9"><spring:message code="common.nodata.msg" /></td>
                                        	</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                                            <tr>
                                                <td>${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}</td>
                                                <td class="al">
                                                	<form name="subForm" method="post" action="<c:url value='/uss/olp/qmc/EgovQustnrManageDetail.do'/>">
                                                		<input name="qestnrId" type="hidden" value="${resultInfo.qestnrId}">
                                                		<input name="qestnrTmplatId" type="hidden" value="">
                                                		<input name="searchMode" type="hidden" value="">
                                                		<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
                                                		
                                                		<a href="#LINK" class="lnk" onclick="fn_egov_detail_QustnrManage('${resultInfo.qestnrId}'); return false;"><c:out value="${resultInfo.qestnrSj}"/></a>
                                               		</form>  
                                                </td>
                                                <td>${resultInfo.qestnrBeginDe} ~ ${resultInfo.qestnrEndDe}</td>
                                                <td>
                                                	<form name="subForm" method="post" action="<c:url value='/uss/olp/qrm/EgovQustnrRespondManageList.do'/>">
                                                		<input name="qestnrId" type="hidden" value="${resultInfo.qestnrId}">
                                                		<input name="qestnrTmplatId" type="hidden" value="${resultInfo.qestnrTmplatId}">
                                                		<input name="searchMode" type="hidden" value="Y">
                                                		
                                                		<a href="#LINK" class="btn btn_blue_30 w_50" onclick="fn_egov_list_QustnrQestnManag('${resultInfo.qestnrId}','${resultInfo.qestnrTmplatId}','QRM'); return false;">보기</a>
                                               		</form>
                                                </td>
                                                <td>
                                                	<form name="subForm" method="post" action="<c:url value='/uss/olp/qqm/EgovQustnrQestnManageList.do'/>">
                                                		<input name="qestnrId" type="hidden" value="${resultInfo.qestnrId}">
                                                		<input name="qestnrTmplatId" type="hidden" value="${resultInfo.qestnrTmplatId}">
                                                		<input name="searchMode" type="hidden" value="Y">
                                                		
                                                		<a href="#LINK" class="btn btn_blue_30 w_50" onclick="fn_egov_list_QustnrQestnManag('${resultInfo.qestnrId}','${resultInfo.qestnrTmplatId}','QQM'); return false;">보기</a>
                                               		</form>
                                                </td>
                                                <td>
                                                	<form name="subForm" method="post" action="<c:url value='/uss/olp/qri/EgovQustnrRespondInfoList.do'/>">
                                                		<input name="qestnrId" type="hidden" value="${resultInfo.qestnrId}">
                                                		<input name="qestnrTmplatId" type="hidden" value="${resultInfo.qestnrTmplatId}">
                                                		<input name="searchMode" type="hidden" value="Y">
                                                		
                                                		<a href="#LINK" class="btn btn_blue_30 w_50" onclick="fn_egov_list_QustnrQestnManag('${resultInfo.qestnrId}','${resultInfo.qestnrTmplatId}','QRI'); return false;">보기</a>
                                               		</form>
                                                </td>
                                                <td>
                                                	<form name="subForm" method="post" action="<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageStatistics.do'/>">
                                                		<input name="qestnrId" type="hidden" value="${resultInfo.qestnrId}">
                                                		<input name="qestnrTmplatId" type="hidden" value="${resultInfo.qestnrTmplatId}">
                                                		<input name="searchMode" type="hidden" value="">
                                                		
                                                		<a href="#LINK" class="btn btn_blue_30 w_50" onclick="fn_egov_statistics_QustnrQestnManag('${resultInfo.qestnrId}','${resultInfo.qestnrTmplatId}'); return false;">보기</a>
                                               		</form>
                                                </td>
                                                <td>${resultInfo.frstRegisterNm}</td>
                                                <td>${fn:substring(resultInfo.frstRegisterPnttm, 0, 10)}</td>
                                            </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo = "${paginationInfo}" type="renew" jsFunction="linkPage" /></ul>
                                        </ul>
                                    </div>
                                </div>
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