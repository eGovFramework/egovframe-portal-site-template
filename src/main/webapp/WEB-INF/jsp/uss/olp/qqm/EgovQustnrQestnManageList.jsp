<%--
  Class Name : EgovQustnrQestnManageList.jsp
  Description : 설문문항 목록 페이지
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한         최초 생성
     2011.08.31    JJY       	경량환경 버전 생성
     2023.06.09    김신해 		NSR 보안조치 (설문문항 검색 크로스사이트 스크립트 방지)
 
    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.19
   
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images_old/egovframework/com/uss/olp/qqm/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>샘플 포털 > 포털서비스관리 > 설문관리 > 설문문항</title>
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
	document.listForm.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageList.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_QustnrQestnManage(){
	var vFrom = document.listForm;
	vFrom.cmd.value = '';
	vFrom.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageRegist.do'/>";
	vFrom.submit();
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_modify_QustnrQestnManage(){
	location.href = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageModify.do'/>";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_QustnrQestnManage(qestnrQesitmId){
	var vFrom = document.listForm;
	vFrom.qestnrQesitmId.value = qestnrQesitmId;
	vFrom.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageDetail.do'/>";
	vFrom.submit();
}
/* ********************************************************
 * 문항통계
 ******************************************************** */
function fn_egov_statistics_QustnrQestnManage(qestnrQesitmId){
	var vFrom = document.listForm;
	vFrom.qestnrQesitmId.value = qestnrQesitmId;
	vFrom.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageStatistics.do'/>"; 
	vFrom.submit();
}

/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fn_egov_delete_QustnrQestnManage(qestnrId){
	var vFrom = document.listForm;
	if(confirm('<spring:message code="common.delete.msg" />')) {
		vFrom.qestnrId.value = qestnrId;
		vFrom.cmd.value = 'del';
		vFrom.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageList.do'/>";
		vFrom.submit();
	}else{
		vFrom.cmd.value = '';
	}
}
/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_QustnrQestnManage(){
	var vFrom = document.listForm;

	vFrom.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageList.do'/>";
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
                                        <li>설문문항</li>
                                    </ul>
                                </div>
                                <!--// Location -->

                                <h1 class="tit_1">포털서비스관리</h1>

                                <p class="txt_1">포털시스템에서 제공되는 서비스들에 대한 컨텐츠를 관리합니다.</p>

                                <h2 class="tit_2">설문관리</h2>

                                <h3 class="tit_3">설문문항</h3>

                                <!-- 검색조건 -->
                                <div class="condition">
                                
                                	<form name="listForm" id="listForm" action="<c:url value='/uss/olp/qqm/EgovQustnrQestnManageList.do'/>" method="post">
                                
                                    <label class="item f_select" for="sel1">
                                        <select name="searchCondition" title="검색조건 선택" id="sel1">
                                            <option value=''>선택하세요</option>
                                            <option value='QESTN_CN' <c:if test="${searchVO.searchCondition == 'QESTN_CN'}">selected</c:if>>질문내용</option>
                                            <option value='MXMM_CHOISE_CO' <c:if test="${searchVO.searchCondition == 'MXMM_CHOISE_CO'}">selected</c:if>>최대선택건수</option>
                                        </select>
                                    </label>

                                    <span class="item f_search">
                                        <input class="f_input w_500" name="searchKeyword" type="text" size="30" value="<c:out value='${searchVO.searchKeyword}'/>" maxlength="35" title="검색어 입력">
                                        <button class="btn" type="submit" onclick="fn_egov_search_QustnrQestnManage(); return false;"><spring:message code="button.inquire" /></button><!-- 조회 -->
                                    </span>

                                    <a href="<c:url value='/uss/olp/qqm/EgovQustnrQestnManageRegist.do'/>" class="item btn btn_blue_46 w_100"><spring:message code="button.create" /></a><!-- 등록 -->
                                    
                                    <c:if test="${qustnrQestnManageVO.searchMode == 'Y'}">
										<input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="${qustnrQestnManageVO.qestnrTmplatId}">
										<input name="qestnrId" id="qestnrId" type="hidden" value="${qustnrQestnManageVO.qestnrId}">
										<input name="searchMode" id="qestnrId" type="hidden" value="${qustnrQestnManageVO.searchMode}">
									</c:if>
						
									<input name="qestnrQesitmId" type="hidden" value="">
									<input name="cmd" type="hidden" value="">
									
									<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
									
									</form>
                                    
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table>
                                    	<caption>설문문항 목록</caption>
                                        <colgroup>
                                            <col style="width: 70px;">
                                            <col style="width: auto;">
                                            <col style="width: 120px;">
                                            <col style="width: 85px;">
                                            <col style="width: 85px;">
                                            <col style="width: 120px;">
                                            <col style="width: 120px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">순번</th>
                                                <th scope="col">질문내용</th>
                                                <th scope="col">질문유형</th>
                                                <th scope="col">질문항목</th>
                                                <th scope="col">통계</th>
                                                <th scope="col">등록자</th>
                                                <th scope="col">등록일자</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:if test="${fn:length(resultList) == 0}">
                                            <tr>
                                                <td colspan="7"><spring:message code="common.nodata.msg" /></td>
                                            </tr>
                                            </c:if>
                                            
                                            <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                                            <tr>
                                                <td>${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}</td>
                                                <td class="al">
                                                	<form name="subForm" method="post" action="<c:url value='/uss/olp/qqm/EgovQustnrQestnManageDetail.do'/>">
                                                	<c:if test="${qustnrQestnManageVO.searchMode == 'Y'}">
	                                                	<input name="qestnrTmplatId" type="hidden" value="${qustnrQestnManageVO.qestnrTmplatId}">
	                                                	<input name="qestnrId" type="hidden" value="${qustnrQestnManageVO.qestnrId}">
	                                                	<input name="searchMode" type="hidden" value="${qustnrQestnManageVO.searchMode}">
                                                	</c:if>
                                                	<input name="qestnrQesitmId" type="hidden" value="${resultInfo.qestnrQesitmId}">
                                                	<a href="#LINK" class="lnk" onclick="fn_egov_detail_QustnrQestnManage('${resultInfo.qestnrQesitmId}'); return false;"><c:out value="${resultInfo.qestnCn}"/></a>
                                                	</form>
                                                </td>
                                                <td>
                                                	<c:if test="${resultInfo.qestnTyCode == '1'}">객관식</c:if>
                                                	<c:if test="${resultInfo.qestnTyCode == '2'}">주관식</c:if>
                                                </td>
                                                <td>
                                                	<form name="subForm" method="post" action="<c:url value='/uss/olp/qim/EgovQustnrItemManageList.do'/>">
                                                		<input name="qestnrQesitmId" type="hidden" value="${resultInfo.qestnrQesitmId}">
                                                		<input name="searchMode" type="hidden" value="Y">
                                                		<input type="submit" class="btn btn_blue_30 w_50" style="border: none; cursor: pointer;" value="보기">
                                                	</form>
                                                </td>
                                                <td>
                                                	<form name="subForm" method="post" action="<c:url value='/uss/olp/qqm/EgovQustnrQestnManageStatistics.do'/>">
                                                		<c:if test="${qustnrQestnManageVO.searchMode == 'Y'}">
                                                			<input name="qestnrTmplatId" type="hidden" value="${qustnrQestnManageVO.qestnrTmplatId}">
                                                			<input name="qestnrId" type="hidden" value="${qustnrQestnManageVO.qestnrId}">
                                                			<input name="searchMode" type="hidden" value="${qustnrQestnManageVO.searchMode}">
                                                		</c:if>
                                                		<input name="qestnrQesitmId" type="hidden" value="${resultInfo.qestnrQesitmId}">
                                                		<a href="#LINK" class="btn btn_blue_30 w_50" onclick="fn_egov_statistics_QustnrQestnManage('${resultInfo.qestnrQesitmId}'); return false;">보기</a>
                                                	</form>
                                                </td>
                                                <td>${resultInfo.frstRegisterNm}</td>
                                                <td>${fn:substring(resultInfo.frstRegistPnttm, 0, 10)}</td>
                                            </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

								<!-- 페이징 -->
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo = "${paginationInfo}" type="renew" jsFunction="linkPage" />
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