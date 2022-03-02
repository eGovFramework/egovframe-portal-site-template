<%--
  Class Name : EgovQustnrItemManageList.jsp
  Description : 설문항목 목록 페이지(popup)
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
<c:set var="ImgUrl" value="/images_old/egovframework/com/uss/olp/qim/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<title>설문항목 목록(팝업)</title>
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
	document.listForm.action = "<c:url value='/uss/olp/qim/EgovQustnrItemManageListPopup.do'/>";
   	document.listForm.submit();
}

/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_QustnrItemManage(){
	var vFrom = document.listForm;
	
	if(vFrom.searchKeyword.value == ""){
		alert('검색어를 입력해주세요!');
		vFrom.searchKeyword.focus();
		return;
	}
	
	if(vFrom.searchCondition.selectedIndex == 0){
		alert('검색 구분을 선택해주세요!');
		vFrom.searchCondition.focus();
		return;
	}

	vFrom.action = "<c:url value='/uss/olp/qim/EgovQustnrItemManageListPopup.do'/>";
	                
	vFrom.submit();
	
}

/* ********************************************************
* 선택처리 함수
******************************************************** */
function fn_egov_open_QustnrItemManage(qestnrId, qestnrTmplatId, qustnrIemId, cnt){
	
	parent.document.getElementById("qestnrId").value = qestnrId;
	parent.document.getElementById("qestnrTmplatId").value = qestnrTmplatId;
	parent.document.getElementById("qustnrIemId").value = qustnrIemId;
	parent.document.getElementById("qustnrIemCn").value = document.getElementById("iptText_"+ cnt).value;
	
	fn_egov_cancel_popup();
}

/* ********************************************************
 * 취소처리
 ******************************************************** */
function fn_egov_cancel_popup() {
	parent.fn_egov_modal_remove();
}

</script>
</head>
<body>
<!-- 자바스크립트 경고 태그  -->
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

	<form name="listForm" id="listForm" action="<c:url value='/uss/olp/qim/EgovQustnrItemManageListPopup.do'/>" method="post">
	
	<!-- 설문항목 목록 팝업 -->
    <div class="popup EgovQustnrItemManageListPopup">
        <div class="pop_inner">
            <div class="pop_header">
                <h1>설문항목 목록</h1>
                <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>

            <div class="pop_container">
                <!-- 검색조건 -->
                <div class="condition">
                    <label class="item f_select" for="sel111">
                        <select id="sel111" name="searchCondition" title="검색조건 선택">
                            <option value="">선택하세요</option>
                            <option value='IEM_CN' <c:if test="${searchCondition == 'IEM_CN'}">selected</c:if>>설문항목</option>
                            <option value='FRST_REGISTER_ID' <c:if test="${searchCondition == 'FRST_REGISTER_ID'}">selected</c:if>>등록자</option>
                        </select>
                    </label>

                    <span class="item f_search">
                        <input class="f_input w_500" name="searchKeyword" type="text" value="${searchKeyword}" title="검색어 입력" maxlength="35" />
                        <button class="btn" type="submit" onclick="fn_egov_search_QustnrItemManage(); return false;"><spring:message code="button.inquire" /></button><!-- 조회 -->
                    </span>
                </div>
                <!--// 검색조건 -->

                <!-- 게시판 -->
                <div class="board_list">
                    <table summary="이 표는 설문항목 목록 정보를 제공하며, 순번, 항목내용, 기타답변여부, 등록자, 등록일자 정보로 구성되어 있습니다 .">
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
                                <th scope="col">순번</th>
                                <th scope="col">항목내용</th>
                                <th scope="col">기타답변여부</th>
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
	                                <a href="#LINK" class="lnk" onClick="fn_egov_open_QustnrItemManage('${resultInfo.qestnrId}', '${resultInfo.qestnrTmplatId}', '${resultInfo.qustnrIemId}', '${status.count}')">
	                                	${resultInfo.iemCn}
	                                </a>
                                </td>
                                <td>${resultInfo.etcAnswerAt}</td>
                                <td>${resultInfo.frstRegisterNm}</td>
                                <td>${fn:substring(resultInfo.frstRegisterPnttm, 0, 10)}</td>
                                <td>
	                                <a href="#LINK" class="btn btn_blue_30 w_80" onClick="fn_egov_open_QustnrItemManage('${resultInfo.qestnrId}', '${resultInfo.qestnrTmplatId}', '${resultInfo.qustnrIemId}', '${status.count}')">
	                                	선택
	                                </a>
                                </td>
                                
                                <input name="iptText_${status.count}" id="iptText_${status.count}" type="hidden" value="${resultInfo.iemCn}">
                            </tr>
                            </c:forEach>
                            
                        </tbody>
                    </table>
                </div>

				<!-- 페이지 네비게이션 시작 -->
                <div class="board_list_bot">
                    <div class="paging" id="paging_div">
                        <ul>
                            <ui:pagination paginationInfo = "${paginationInfo}" type="renew" jsFunction="linkPage" />
                        </ul>
                    </div>
                </div>
                <!-- // 페이지 네비게이션 끝 -->
                <!--// 게시판 -->
            </div>
        </div>
    </div>
    <!--// 설문항목 목록 팝업 -->
    
    <input name="qestnrId" id="qestnrId" type="hidden" value="">
	<input name="qestnrQesitmId" id="qestnrQesitmId" type="hidden" value="">
	<input name="qustnrIemId" id="qustnrIemId" type="hidden" value="">
	<input name="searchMode" id="searchMode" type="hidden" value="">
	
	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
	
	</form>
    
</body>
</html>