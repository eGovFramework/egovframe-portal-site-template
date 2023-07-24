<%--
  Class Name : EgovQustnrRespondInfoList.jsp
  Description : 설문조사 목록 페이지
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09  장동한           최초 생성
     2011.08.31  JJY       		경량환경 버전 생성
     2023.06.09  김신해 			NSR 보안조치 (설문조사 검색 크로스사이트 스크립트 방지)
 
    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.09
   
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images_old/egovframework/com/uss/olp/qri/"/>
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
	if(confirm('<spring:message code="common.delete.msg" />')) {
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

								<form name="listForm" id="listForm" action="<c:url value='/uss/olp/qim/EgovQustnrItemManageList.do'/>" method="post">

                                <h1 class="tit_1">포털서비스관리</h1>

                                <p class="txt_1">포털시스템에서 제공되는 서비스들에 대한 컨텐츠를 관리합니다.</p>

                                <h2 class="tit_2">설문관리</h2>

                                <h3 class="tit_3">설문지</h3>

                                <!-- 검색조건 -->
                                <div class="condition">
                                    <label class="item f_select" for="sel1">
                                        <select id="sel1" name="searchCondition" title="검색조건 선택">
                                            <option value=''>선택하세요</option>
											<option value='ETC_ANSWER_CN' <c:if test="${searchCondition == 'ETC_ANSWER_CN'}">selected</c:if>>기타답변내용</option>
											<option value='RESPOND_ANSWER_CN' <c:if test="${searchCondition == 'RESPOND_ANSWER_CN'}">selected</c:if>>응답자답변내용</option>
											<option value='RESPOND_NM' <c:if test="${searchCondition == 'RESPOND_NM'}">selected</c:if>>응답자명</option>
                                        </select>
                                    </label>

                                    <span class="item f_search">
                                        <input class="f_input w_500" name="searchKeyword" type="text" value="<c:out value='${searchKeyword}'/>" title="검색어 입력" maxlength="35" />
                                        <button class="btn" type="submit" onclick="fn_egov_search_QustnrRespondInfo(); return false;"><spring:message code="button.inquire" /></button><!-- 조회 -->
                                    </span>

                                    <a href="<c:url value='/uss/olp/qri/EgovQustnrRespondInfoRegist.do'/>" class="item btn btn_blue_46 w_100"><spring:message code="button.create" /></a><!-- 등록 -->
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="이 표는 설문조사 대상 정보를 제공하며, 순번, 문항유형, 설문문항, 설문항목, 작성자명, 등록일자 정보로 구성되어 있습니다 .">
                                    	<caption>설문조사 목록</caption>
                                        <colgroup>
                                            <col style="width: 70px;">
                                            <col style="width: 180px;">
                                            <col style="width: auto;">
                                            <col style="width: 85px;">
                                            <col style="width: 85px;">
                                            <col style="width: 85px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">순번</th>
                                                <th scope="col">문항유형</th>
                                                <th scope="col">설문문항</th>
                                                <th scope="col">설문항목</th>
                                                <th scope="col">작성자명</th>
                                                <th scope="col">등록일자</th>
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
                                                <td>
                                                	<c:if test="${resultInfo.qestnTyCode == '1'}">객관식</c:if>
													<c:if test="${resultInfo.qestnTyCode == '2'}">주관식</c:if>
                                                </td>
                                                <td class="al">
                                                	<a href="" class="lnk" onclick="fn_egov_detail_QustnrRespondInfo('${resultInfo.qestnrQesrspnsId}'); return false;">
                                                		<c:out value="${resultInfo.qestnCn}"/>
                                                	</a>
                                                </td>
                                                <td>${resultInfo.iemCn}</td>
                                                <td>${resultInfo.frstRegisterNm}</td>
                                                <td>${fn:substring(resultInfo.frstRegisterPnttm, 0, 10)}</td>
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
                                
                                <input name="qestnrId" type="hidden" value="">
								<input name="qestnrTmplatId" type="hidden" value="">
								<input name="qustnrIemId" type="hidden" value="">
								<input name="qestnrQesrspnsId" type="hidden" value="">
								<input name="searchMode" type="hidden" value="">
								<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>">
								
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