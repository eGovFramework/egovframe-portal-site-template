<%--
  Class Name : EgovQustnrQestnManageList.jsp
  Description : 설문문항 목록 페이지
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09  장동한           최초 생성
     2011.08.31  JJY       		경량환경 버전 생성
     2023.06.09  김신해 			NSR 보안조치 (설문문항 조회 크로스사이트 스크립트 방지)
 
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
<title>샘플 포털 > 포털서비스관리 > 설문관리 > 설문지</title>
<base target="_self">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

<script type="text/javascript" src="<c:url value='/js/showModalDialogCallee.js'/>" ></script>
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageListPopup.do'/>";
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

	vFrom.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageListPopup.do'/>";
	vFrom.submit();
	
}
/* ********************************************************
 * 선택 처리 함수
 ******************************************************** */
function fn_egov_open_QustnrQestnManage(qestnrQesitmId, cnt, qestnTyCode){
	
	var opener = parent;

	opener.document.getElementById("qestnrQesitmId").value = qestnrQesitmId;
	opener.document.getElementById("qestnrQesitmCn").value = document.getElementById("iptText_"+ cnt).value;
	if( opener.document.getElementById("divQestnTyCode") != null ){
		if(qestnTyCode == '1')
			opener.document.getElementById("divQestnTyCode").innerText = '객관식';
		else if(qestnTyCode == '2')
			opener.document.getElementById("divQestnTyCode").innerText = '주관식';
	}
	
	fn_egov_cancel_popup();
}

function fn_egov_cancel_popup() {
	
// 	self.close();
	
	parent.fn_egov_modal_remove();
}
</script>
</head>
<body>
<!-- 자바스크립트 경고 태그  -->
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

	<form name="listForm" id="listForm" action="<c:url value='/uss/olp/qqm/EgovQustnrQestnManageListPopup.do'/>" method="post">

    <!-- 설문항목등록시 설문문항목록조회 팝업 -->
    <div class="popup POP_SURVEY_ITEM">
        <div class="pop_inner">
            <div class="pop_header">
                <h1>설문문항 정보</h1>
                <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>

            <div class="pop_container">
                <!-- 검색조건 -->
                <div class="condition">
                    <label class="item f_select" for="sel111">
                        <select id="sel111" name="searchCondition" title="검색조건 선택">
                            <option value=''>선택하세요</option>
							<option value='QESTN_CN' <c:if test="${searchVO.searchCondition == 'QESTN_CN'}">selected</c:if>>질문내용</option>
							<option value='MXMM_CHOISE_CO' <c:if test="${searchVO.searchCondition == 'MXMM_CHOISE_CO'}">selected</c:if>>최대선택건수</option>
                        </select>
                    </label>

                    <span class="item f_search">
                        <input class="f_input w_500" type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" maxlength="35" title="검색어 입력">
                        <button class="btn" type="submit" onclick="fn_egov_search_QustnrQestnManage(); return false;"><spring:message code="button.inquire" /></button><!-- 조회 -->
                    </span>

                </div>
                <!--// 검색조건 -->

                <!-- 게시판 -->
                <div class="board_list">
                    <table summary="목록 을 제공한다.">
                    	<caption>목록 을 제공한다</caption>
                        <colgroup>
                            <col style="width: 80px;">
                            <col style="width: auto;">
                            <col style="width: 100px;">
                            <col style="width: 100px;">
                            <col style="width: 100px;">
                            <col style="width: 100px;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">질문내용</th>
                                <th scope="col">질문유형</th>
                                <th scope="col">등록자</th>
                                <th scope="col">등록일자</th>
                                <th scope="col"></th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                            <tr>
                                <td>${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}</td>
                                <td class="al">
                                	<a href="#LINK" class="lnk" onClick="fn_egov_open_QustnrQestnManage('${resultInfo.qestnrQesitmId}', '${status.count}', '${resultInfo.qestnTyCode}')">
                                		${resultInfo.qestnCn}
                                	</a>
                                </td>
                                <td>
                                	<c:if test="${resultInfo.qestnTyCode == '1'}">객관식</c:if>
									<c:if test="${resultInfo.qestnTyCode == '2'}">주관식</c:if>
                                </td>
                                <td>${resultInfo.frstRegisterNm}</td>
                                <td>${fn:substring(resultInfo.frstRegistPnttm, 0, 10)}</td>
                                <td>
	                                <a href="#LINK" class="btn btn_blue_30 w_80" onClick="fn_egov_open_QustnrQestnManage('${resultInfo.qestnrQesitmId}', '${status.count}', '${resultInfo.qestnTyCode}')">
	                            		선택
	                                </a>
	                                <input name="iptText_${status.count}" id="iptText_${status.count}" type="hidden" value="${resultInfo.qestnCn}">
                                </td>
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
                
                <c:if test="${qustnrQestnManageVO.searchMode == 'Y'}">
				<input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="${qustnrQestnManageVO.qestnrTmplatId}">
				<input name="qestnrId" id="qestnrId" type="hidden" value="${qustnrQestnManageVO.qestnrId}">
				<input name="searchMode" id="qestnrId" type="hidden" value="${qustnrQestnManageVO.searchMode}">
				</c:if>
				
				<input name="qestnrQesitmId" id="qestnrQesitmId" type="hidden" value="">
				<input name="cmd" type="hidden" value="">
				
				<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
				
				</form>
                
                <!--// 게시판 -->
            </div>
        </div>
    </div>
    <!--// 설문항목등록시 설문문항목록조회 팝업 -->


    <script>
        $('.POP_SURVEY_ITEM').show();
    </script>
    
</body>
</html>