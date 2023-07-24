<%--
  Class Name : EgovQustnrManageListPopup.jsp
  Description : 설문관리 목록 페이지
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09  장동한           최초 생성
     2011.08.31  JJY       		경량환경 버전 생성
     2023.06.09  김신해 		  	NSR 보안조치 (설문지 조회 크로스사이트 스크립트 방지)
 
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
	document.listForm.action = "<c:url value='/uss/olp/qmc/EgovQustnrManageListPopup.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_QustnrManage(){
	var vFrom = document.listForm;

	vFrom.action = "<c:url value='/uss/olp/qmc/EgovQustnrManageListPopup.do'/>";
	vFrom.submit();
}
/* ********************************************************
 * 선택 처리 함수
 ******************************************************** */
function fn_egov_open_QustnrManage(qestnrId, qestnrTmplatId, cnt){
	
// 	getDialogArguments();
// 	var opener = window.dialogArguments;

// 	opener.document.getElementById("qestnrId").value = qestnrId;
// 	opener.document.getElementById("qestnrTmplatId").value = qestnrTmplatId;
// 	opener.document.getElementById("qestnrCn").value = document.getElementById("iptText_"+ cnt).value;
// 	window.returnValue=true;
// 	window.close();

	parent.document.getElementById("qestnrId").value = qestnrId;
	parent.document.getElementById("qestnrTmplatId").value = qestnrTmplatId;
	parent.document.getElementById("qestnrCn").value = document.getElementById("iptText_"+ cnt).value;
	fn_egov_cancel_popup();
}

/* ********************************************************
 * 취소처리
 ******************************************************** */
function fn_egov_cancel_popup() {
	
// 	self.close();
	
	parent.fn_egov_modal_remove();
}

</script>
</head>
<body style="min-width: 1024px;">
	<!-- 자바스크립트 경고 태그  -->
	<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

    <div class="wrap EgovQustnrManageListPopup">

        <div class="pop_inner">
        
        	<form name="listForm" id="listForm" action="<c:url value='/uss/olp/qmc/EgovQustnrManageListPopup.do'/>" method="post">
        	
        	<div class="pop_header">
                <h1>설문관리 정보</h1>
                <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>

            <!-- 검색조건 -->
            <div class="condition2">
                <label class="item f_select" for="sel1">
                    <select id="sel1" name="searchCondition" title="검색조건 선택">
                        <option value=''>선택하세요</option>
                        <option value='QUSTNR_SJ' <c:if test="${searchCondition == 'QUSTNR_SJ'}">selected</c:if>>설문제목</option>
                        <option value='QUSTNR_PURPS' <c:if test="${searchCondition == 'QUSTNR_PURPS'}">selected</c:if>>설문목적</option>
                    </select>
                </label>

                <span class="item f_search">
                    <input id="searchWord" class="f_input w_500" name="searchKeyword" type="text" value="<c:out value='${searchKeyword}'/>" title="검색어 입력" maxlength="35" >
                    <button class="btn" type="submit" onclick="fn_egov_search_QustnrManage(); return false;"><spring:message code="button.inquire" /></button><!-- 조회 -->
                </span>
            </div>
            <!--// 검색조건 -->

            <!-- 게시판 -->
            <div class="board_list">
                <table summary="SUMMARY">
                	<caption>약관목록</caption>
                    <colgroup>
                        <col style="width: 70px;">
                        <col style="width: auto;">
                        <col style="width: 200px;">
                        <col style="width: 120px;">
                        <col style="width: 120px;">
                        <col style="width: 100px;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">설문제목</th>
                            <th scope="col">설문기간</th>
                            <th scope="col">등록자</th>
                            <th scope="col">등록일자</th>
                            <th scope="col">선택</th>
                        </tr>
                    </thead>
                    <tbody>
                    
                    	<c:if test="${fn:length(resultList) == 0}">
                    	<tr>
                    		<td colspan="6"><spring:message code="common.nodata.msg" /></td>
                    	</tr>
                    	</c:if>
                    	
                    	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                        <tr>
                            <td>${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}</td>
                            <td class="al" >
                            	${resultInfo.qestnrSj}
                            </td>
                            
                            
                            
                            
                            <td>${resultInfo.qestnrBeginDe}~${resultInfo.qestnrEndDe}</td>
                            <td>${resultInfo.frstRegisterNm}</td>
                            <td>${fn:substring(resultInfo.frstRegisterPnttm, 0, 10)}</td>
                            <td>
                            	<a href="#LINK" class="btn btn_blue_30 w_80" onClick="fn_egov_open_QustnrManage('${resultInfo.qestnrId}', '${resultInfo.qestnrTmplatId}', '${status.count}')">선택</a>
                            	<input name="iptText_${status.count}" id="iptText_${status.count}" type="hidden" value="<c:out value='${resultInfo.qestnrSj}'/>">
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
            <!--// 게시판 -->
            
            <input name="qestnrId" type="hidden" value="">
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
			
        	</form>

        </div>
    </div>
    
</body>
</html>