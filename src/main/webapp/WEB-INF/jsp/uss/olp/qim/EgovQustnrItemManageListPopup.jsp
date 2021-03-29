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
<c:set var="ImgUrl" value="/images/egovframework/com/uss/olp/qim/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<title>설문항목 목록(팝업)</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
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
	getDialogArguments();
	var opener = window.dialogArguments;

	opener.document.getElementById("qestnrId").value = qestnrId;
	opener.document.getElementById("qestnrTmplatId").value = qestnrTmplatId;
	opener.document.getElementById("qustnrIemId").value = qustnrIemId;
	opener.document.getElementById("qustnrIemCn").value = document.getElementById("iptText_"+ cnt).value;
	window.returnValue=true;
	window.close();
}
		 

</script>
</head>
<body>
<!-- 자바스크립트 경고 태그  -->
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
        <div id="middle_content">
            <div id="content_field"><!--contents start-->

            <form name="listForm" id="listForm" action="<c:url value='/uss/olp/qim/EgovQustnrItemManageListPopup.do'/>" method="post">
            
            <!-- sub title start -->
            <div><h2>설문항목 목록</h2></div>
            <!-- sub title end -->
            
            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >
                    <select name="searchCondition" title="검색조건 선택">
			           <option value=''>--선택하세요--</option>
			           <option value='IEM_CN' <c:if test="${searchCondition == 'IEM_CN'}">selected</c:if>>설문항목</option>
			           <option value='FRST_REGISTER_ID' <c:if test="${searchCondition == 'FRST_REGISTER_ID'}">selected</c:if>>등록자</option>
			       </select>
			       <input name="searchKeyword" type="text" size="30" value="${searchKeyword}" title="검색어 입력" maxlength="35" />
                </div>
                    <div class="search_buttons">
                    <input type="submit" value="<spring:message code="button.inquire" />" onclick="fn_egov_search_QustnrItemManage(); return false;" />
                    <!-- a href="/uss/olp/qim/EgovQustnrItemManageRegist.do"><spring:message code="button.create" /></a-->
                    </div>
                </div> 
            </div>
            <!-- search area end -->
            
            <!-- search result start -->
            <div class="search_result_div">
            
				<table summary="이 표는 설문항목 목록 정보를 제공하며, 순번, 항목내용, 기타답변여부, 등록자, 등록일자 정보로 구성되어 있습니다 .">
				<thead>
				<tr>
				    <th scope="col" class="title" width="5%" nowrap="nowrap">순번</th>
				    <th scope="col" class="title" nowrap="nowrap">항목내용</th>
				    <th scope="col" class="title" width="100px" nowrap="nowrap">기타답변여부</th>
				    <th scope="col" class="title" width="15%" nowrap="nowrap">등록자</th>   
				    <th scope="col" class="title" width="15%" nowrap="nowrap">등록일자</th>
				    <th scope="col" class="title" width="30px" nowrap="nowrap"></th>
				</tr>
				</thead>    
				<tbody>
				<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
				<tr>
				    <td class="lt_text3" >${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}</td>
				    <td class="lt_text3" >
				    <div class="divDotText" style="width:320px; border:solid 0px;"><a href="#LINK" onClick="fn_egov_open_QustnrItemManage('${resultInfo.qestnrId}', '${resultInfo.qestnrTmplatId}', '${resultInfo.qustnrIemId}', '${status.count}')">${resultInfo.iemCn}</a></div>
				    </td>
				    <td class="lt_text3" >${resultInfo.etcAnswerAt}</td>
				    <td class="lt_text3" >${resultInfo.frstRegisterNm}</td>
				    <td class="lt_text3" >${fn:substring(resultInfo.frstRegisterPnttm, 0, 10)}</td>
				    <td class="lt_text3" ><a href="#LINK" onClick="fn_egov_open_QustnrItemManage('${resultInfo.qestnrId}', '${resultInfo.qestnrTmplatId}', '${resultInfo.qustnrIemId}', '${status.count}')">선택</a>
				    <input name="iptText_${status.count}" id="iptText_${status.count}" type="hidden" value="${resultInfo.iemCn}">   
				    </td>
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
							jsFunction="linkPage"
							/></ul>
			</div>
			
			<input name="qestnrId" id="qestnrId" type="hidden" value="">
			<input name="qestnrQesitmId" id="qestnrQesitmId" type="hidden" value="">
			<input name="qustnrIemId" id="qustnrIemId" type="hidden" value="">
			<input name="searchMode" id="searchMode" type="hidden" value="">
			
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
			
			</form>

            </div><!-- contents end -->
        </div>

</body>
</html>

