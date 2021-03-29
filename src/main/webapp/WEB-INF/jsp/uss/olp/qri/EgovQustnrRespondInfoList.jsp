<%--
  Class Name : EgovQustnrRespondInfoList.jsp
  Description : 설문조사 목록 페이지
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
<c:set var="ImgUrl" value="/images/egovframework/com/uss/olp/qri/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>설문조사 목록</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/uss/olp/qri/EgovQustnrRespondInfoList.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_QustnrRespondInfo(){
	location.href = "<c:url value='/uss/olp/qri/EgovQustnrRespondInfoRegist.do'/>";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_modify_QustnrRespondInfo(){
	location.href = "<c:url value='/uss/olp/qri/EgovQustnrRespondInfoModify.do'/>";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_QustnrRespondInfo(qestnrQesrspnsId){
	var vFrom = document.listForm; 
	vFrom.qestnrQesrspnsId.value = qestnrQesrspnsId; 
	vFrom.action = "<c:url value='/uss/olp/qri/EgovQustnrRespondInfoDetail.do'/>"; 
	vFrom.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fn_egov_delete_QustnrRespondInfo(qestnrId){
	var vFrom = document.listForm;
	if(confirm("삭제 하시겠습니까?")){
		vFrom.qestnrId.value = qestnrId;
		vFrom.cmd.value = 'del';
		vFrom.action = "<c:url value='/uss/olp/qri/EgovQustnrRespondInfoList.do'/>";
		vFrom.submit();
	}else{
		vFrom.cmd.value = '';
	}
}
/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_QustnrRespondInfo(){
	var vFrom = document.listForm;

	vFrom.action = "<c:url value='/uss/olp/qri/EgovQustnrRespondInfoList.do'/>";
	vFrom.submit();
	
}

/* ********************************************************
 * 선택한 설문지정보 -> 설문문항 바로가기
 ******************************************************** */
function fn_egov_list_QustnrQestnManag(qestnrId, qestnrTmplatId){
	var vFrom = document.listForm;
	vFrom.qestnrId.value = qestnrId;
	vFrom.qestnrTmplatId.value = qestnrTmplatId;
	vFrom.searchCondition.options[0].selected = true;
	vFrom.searchKeyword.value = '';
	vFrom.searchMode.value = 'Y';
	vFrom.action = "<c:url value='/uss/olp/qqm/EgovQustnrQestnManageList.do'/>";
	vFrom.submit();

}

</script>
</head>
<body>
<!-- 자바스크립트 경고 태그  -->
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
<!-- login status start -->
<div id="login_area"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncTborder" /></div>
<!-- //login status end -->
<!-- wrap start -->
<div id="wrap"> 
    <!-- header start -->
    <div id="subheader"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>  
    <!-- //header end -->
    <!--  타이틀 이미지 시작 -->
    <div id="title_img_div"><img src="<c:url value='/'/>images/title_image/img_title05.gif" alt="" /></div>
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
                            <li>포털서비스관리</li>
                            <li>&gt;</li>
                            <li>서비스관리</li>
                            <li>&gt;</li>
                            <li><strong>Q&amp;A답변관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->

            <form name="listForm" id="listForm" action="<c:url value='/uss/olp/qim/EgovQustnrItemManageList.do'/>" method="post">
                
            <!-- sub title start -->
            <div><h2>설문조사 목록</h2></div>
            <!-- sub title end -->

            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >
                    <select name="searchCondition" title="검색조건 선택">
			           <option value=''>--선택하세요--</option>
			           <option value='ETC_ANSWER_CN' <c:if test="${searchCondition == 'ETC_ANSWER_CN'}">selected</c:if>>기타답변내용</option>
			           <option value='RESPOND_ANSWER_CN' <c:if test="${searchCondition == 'RESPOND_ANSWER_CN'}">selected</c:if>>응답자답변내용</option>
			           <option value='RESPOND_NM' <c:if test="${searchCondition == 'RESPOND_NM'}">selected</c:if>>응답자명</option>
			       </select>
			       <input name="searchKeyword" type="text" size="30" value="${searchKeyword}" title="검색어 입력" maxlength="35" />
                </div>
                    <div class="search_buttons">
					     <input type="submit" value="<spring:message code="button.inquire" />" onclick="fn_egov_search_QustnrRespondInfo(); return false;" />      
					     <a href="<c:url value='/uss/olp/qri/EgovQustnrRespondInfoRegist.do'/>"><spring:message code="button.create" /></a>
                    </div>
                </div> 
            </div>
            <!-- search area end -->
            
            <!-- search result start -->
            <div class="search_result_div">
            
                <table width="98%" cellpadding="0" cellspacing="0" summary="이 표는 설문조사 대상 정보를 제공하며, 순번, 문항유형, 설문문항, 설문항목, 작성자명, 등록일자 정보로 구성되어 있습니다 .">
                <caption>설문조사 목록</caption>
                
                <colgroup>
                    <col width="35px" > 
                    <col width="100px" >
                    <col >
                    <col width="100px" >
                    <col width="70px" >
                    <col width="70px" >
                </colgroup>
                
                <thead>
                <tr>      
				    <th>순번</th>
				    <th>문항유형</th>
				    <th>설문문항</th>
				    <th>설문항목</th>
				    <th>작성자명</th>   
				    <th>등록일자</th>
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
				    <td class="lt_text3" >${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}</td>
				    <td class="lt_text3" >
				    <c:if test="${resultInfo.qestnTyCode == '1'}">객관식</c:if>
				    <c:if test="${resultInfo.qestnTyCode == '2'}">주관식</c:if>
				    </td>
				    <td class="lt_text3" >
				    <span class="link"><input type="submit" style="width:320px;border:solid 0px black;text-align:left;" value="<c:out value="${resultInfo.qestnCn}"/>" onclick="fn_egov_detail_QustnrRespondInfo('${resultInfo.qestnrQesrspnsId}'); return false;"></span>      
				    </td>
				    <td class="lt_text3" >${resultInfo.iemCn}</td>
				    <td class="lt_text3" >${resultInfo.frstRegisterNm}</td>
				    <td class="lt_text3" >${fn:substring(resultInfo.frstRegisterPnttm, 0, 10)}</td>
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
			
			<input name="qestnrId" type="hidden" value="">
			<input name="qestnrTmplatId" type="hidden" value="">
			<input name="qustnrIemId" type="hidden" value="">
			<input name="qestnrQesrspnsId" type="hidden" value="">
			<input name="searchMode" type="hidden" value="">
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">

			</form>

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

