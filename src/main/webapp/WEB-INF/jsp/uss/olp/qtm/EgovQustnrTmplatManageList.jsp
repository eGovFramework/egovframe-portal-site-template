<%--
  Class Name : EgovQustnrTmplatManageList.jsp
  Description : 설문템플릿 목록 페이지
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
<c:set var="ImgUrl" value="/images/egovframework/com/uss/olp/qtm/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>설문템플릿 목록</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageList.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수
 ******************************************************** */
function fn_egov_regist_QustnrTmplatManage(){
	location.href = "<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageRegist.do'/>";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_modify_QustnrTmplatManage(){
	location.href = "<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageModify.do'/>";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_QustnrTmplatManage(qestnrTmplatId){
	var vFrom = document.listForm;
	vFrom.qestnrTmplatId.value = qestnrTmplatId;
	vFrom.action = "<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageDetail.do'/>";
	vFrom.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fn_egov_delete_QustnrTmplatManage(mtgId){
	var vFrom = document.listForm;
	if(confirm("삭제 하시겠습니까?")){
		vFrom.mtgId.value = mtgId;
		vFrom.cmd.value = 'del';
		vFrom.action = "<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageList.do'/>";
		vFrom.submit();
	}else{
		vFrom.cmd.value = '';
	}
}
/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_QustnrTmplatManage(){
	var vFrom = document.listForm;

	vFrom.action = "<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageList.do'/>";
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
                            <li>설문관리</li>
                            <li>&gt;</li>
                            <li><strong>설문템플릿</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->

            <form name="listForm" id="listForm" action="<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageList.do'/>" method="post">

            <!-- sub title start -->
            <div><h2>설문템플릿 목록</h2></div>
            <!-- sub title end -->

            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >
                    <select name="searchCondition" title="검색조건 선택">
			            <option value=''>선택하세요</option>
			            <option value='QUSTNR_TMPLAT_DC' <c:if test="${searchCondition == 'QUSTNR_TMPLAT_DC'}">selected</c:if>>템플릿설명</option>
			            <option value='QUSTNR_TMPLAT_TY' <c:if test="${searchCondition == 'QUSTNR_TMPLAT_TY'}">selected</c:if>>템플릿유형</option>
			        </select>
			        <input name="searchKeyword" type="text" size="30" value="${searchKeyword}" maxlength="35" title="검색어 입력" >
                </div>
                    <div class="search_buttons">
				      <input type="submit" value="<spring:message code="button.inquire" />" onclick="fn_egov_search_QustnrTmplatManage(); return false;" class="btnNew" />
				      <a href="${pageContext.request.contextPath}/uss/olp/qtm/EgovQustnrTmplatManageRegist.do"><spring:message code="button.create" /></a>
                    </div>
                </div>
            </div>
            <!-- search area end -->

			<input name="qestnrTmplatId" type="hidden" value="">
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
			</form>

			<!-- search result start -->
            <div class="search_result_div">

                <table width="98%" cellpadding="0" cellspacing="0" summary="SUMMARY">
                <caption>약관목록</caption>

                <colgroup>
                    <col width="35px" >
                    <col width="100px" >
                    <col width="100px" >
                    <col >
                    <col width="70px" >
                    <col width="70px" >
                </colgroup>

                <thead>
                <tr>
                    <th>순번</th>
				    <th>템플릿유형</th>
				    <th>템플릿유형<br>이미지정보</th>
				    <th>템플릿설명</th>
				    <th>작성자명</th>
				    <th>등록일자</th>
                </tr>
                </thead>

                <tbody>
                <c:if test="${fn:length(resultList) == 0}">
                <tr>
                      <td class="lt_text3" colspan="7">
                          <spring:message code="common.nodata.msg" />
                      </td>
                </tr>
                </c:if>
				<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
				<tr>
				    <td class="lt_text3" nowrap="nowrap">${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}</td>
				    <td class="lt_text3L" nowrap="nowrap"><div class="divDotText" style="width:100px;">${resultInfo.qestnrTmplatTy}</div></td>
				    <td class="lt_text3">
				        <img src="/uss/olp/qtm/EgovQustnrTmplatManageImg.do?qestnrTmplatId=${resultInfo.qestnrTmplatId}" alt="${resultInfo.qestnrTmplatTy}템플릿이미지" title="${resultInfo.qestnrTmplatTy}템플릿이미지">
				    </td>
				    <!-- onLoad="if(this.width>65){this.width=65}" -->
				    <td class="lt_text3L" nowrap="nowrap">
				        <form name="subForm" method="post" action="<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageDetail.do'/>">
				        <input name="qestnrTmplatId" type="hidden" value="${resultInfo.qestnrTmplatId}">
				        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
				        <span class="link"><input type="submit" style="width:320px;border:solid 0px black;text-align:left;" value="<c:out value="${resultInfo.qestnrTmplatCn}"/>" onclick="fn_egov_detail_QustnrTmplatManage('${resultInfo.qestnrTmplatId}'); return false;"></span>
				        </form>

				    </td>
				    <td class="lt_text3">${resultInfo.frstRegisterNm}</td>
				    <td class="lt_text3">${fn:substring(resultInfo.frstRegisterPnttm, 0, 10)}</td>
				</tr>
				</c:forEach>
                </tbody>

                </table>
            </div>
            <!-- search result end -->

			<!--  페이지네비게이션  -->
			<div id="paging_div">
				<ul class="paging_align">
					<ui:pagination paginationInfo = "${paginationInfo}"
							type="image"
							jsFunction="linkPage"
							/></ul>
			</div>

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