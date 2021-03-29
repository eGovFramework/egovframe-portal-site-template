<%--
  Class Name : EgovQustnrQestnManageList.jsp
  Description : 설문문항 목록 페이지
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.19
   
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images/egovframework/com/uss/olp/qqm/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>설문문항 목록 팝업</title>
<base target="_self">
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
	if(confirm("삭제 하시겠습니까?")){
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
function fn_egov_open_QustnrQestnManage(qestnrQesitmId,  cnt, qestnTyCode){
	getDialogArguments();
	var opener = window.dialogArguments;

	opener.document.getElementById("qestnrQesitmId").value = qestnrQesitmId;
	opener.document.getElementById("qestnrQesitmCn").value = document.getElementById("iptText_"+ cnt).value;
	if( opener.document.getElementById("divQestnTyCode") != null ){
		if(qestnTyCode == '1')
			opener.document.getElementById("divQestnTyCode").innerText = '객관식';
		else if(qestnTyCode == '2')
			opener.document.getElementById("divQestnTyCode").innerText = '주관식';
	}
	
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

            <form name="listForm" id="listForm" action="<c:url value='/uss/olp/qqm/EgovQustnrQestnManageListPopup.do'/>" method="post">
            
            <!-- sub title start -->
            <div><h2>설문문항 목록 팝업</h2></div>
            <!-- sub title end -->

            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >
                    <select name="searchCondition" class="select"  title="검색조건 선택">
			            <option value=''>--선택하세요--</option>
			            <option value='QESTN_CN' <c:if test="${searchVO.searchCondition == 'QESTN_CN'}">selected</c:if>>질문내용</option>
			            <option value='MXMM_CHOISE_CO' <c:if test="${searchVO.searchCondition == 'MXMM_CHOISE_CO'}">selected</c:if>>최대선택건수</option>
			        </select>
			        <input name="searchKeyword" type="text" size="30" value="${searchVO.searchKeyword}" maxlength="35"  title="검색어 입력"/>
                </div>
                    <div class="search_buttons">
                        <input type="submit" value="<spring:message code="button.inquire" />" onclick="fn_egov_search_QustnrQestnManage(); return false;" />
                    </div>
                </div> 
            </div>
            <!-- search area end -->
            
            <!-- search result start -->
            <div class="search_result_div">
                <table  summary="목록 을 제공한다.">
				<caption>목록 을 제공한다</caption>
				 <thead>
				  <tr>  
				    <th scope="col" class="title" width="10%" nowrap="nowrap">번호</th>
				    <th scope="col" class="title" >질문내용</th>
				    <th scope="col" class="title" width="20%" nowrap="nowrap">질문유형</th>
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
				        <a href="#LINK" onClick="fn_egov_open_QustnrQestnManage('${resultInfo.qestnrQesitmId}', '${status.count}', '${resultInfo.qestnTyCode}')">
				        ${resultInfo.qestnCn}
				        </a>
				    </td>
				    <td class="lt_text3" >
				    <c:if test="${resultInfo.qestnTyCode == '1'}">객관식</c:if>
				    <c:if test="${resultInfo.qestnTyCode == '2'}">주관식</c:if>
				    </td>
				    <td class="lt_text3" >${resultInfo.frstRegisterNm}</td>
				    <td class="lt_text3" >${fn:substring(resultInfo.frstRegisterPnttm, 0, 10)}</td>
				    <td class="lt_text3" >
				    <a href="#LINK" onClick="fn_egov_open_QustnrQestnManage('${resultInfo.qestnrQesitmId}', '${status.count}', '${resultInfo.qestnTyCode}')">선택</a>
				    <input name="iptText_${status.count}" id="iptText_${status.count}" type="hidden" value="${resultInfo.qestnCn}">
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

			<c:if test="${qustnrQestnManageVO.searchMode == 'Y'}">
			<input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="${qustnrQestnManageVO.qestnrTmplatId}">
			<input name="qestnrId" id="qestnrId" type="hidden" value="${qustnrQestnManageVO.qestnrId}">
			<input name="searchMode" id="qestnrId" type="hidden" value="${qustnrQestnManageVO.searchMode}">
			</c:if>
			
			<input name="qestnrQesitmId" id="qestnrQesitmId" type="hidden" value="">
			<input name="cmd" type="hidden" value="">
			
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
			
			</form>

            </div><!-- contents end -->
        </div>

</body>
</html>

