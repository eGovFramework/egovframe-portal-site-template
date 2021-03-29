<%--
  Class Name : EgovQustnrRespondInfoManageList.jsp
  Description : 설문조사(설문등록) 목록 페이지
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
<c:set var="ImgUrl" value="/images/egovframework/com/uss/olp/qnn/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%--  자마스크립트 메세지 출력 --%>
${reusltScript}
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
	document.listForm.action = "<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageList.do'/>";
   	document.listForm.submit();
}

/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_QustnrManage(){
	var vFrom = document.listForm;

	vFrom.action = "<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageList.do'/>";
	vFrom.submit();
	
}

/* ********************************************************
 * 선택한 설문지정보 -> 설문문항 바로가기
 ******************************************************** */
function fn_egov_regist_QustnrRespondInfoManage(qestnrId, qestnrTmplatId){

	 document.getElementById("qestnrId").value = qestnrId;
	 document.getElementById("qestnrTmplatId").value = qestnrTmplatId; 
	 document.listForm.action = "<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageRegist.do'/>";
	 document.listForm.submit();
}

 /* ********************************************************
  * 선택한 전체 통계보기
  ******************************************************** */
 function fn_egov_statistics_QustnrRespondInfoManage(qestnrId, qestnrTmplatId){

 	 document.getElementById("qestnrId").value = qestnrId;
 	 document.getElementById("qestnrTmplatId").value = qestnrTmplatId; 
 	 document.listForm.action = "<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageStatistics.do'/>";
 	 document.listForm.submit();
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
    <div id="title_img_div"><img src="<c:url value='/'/>images/title_image/img_title04.gif" alt="" /></div>
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
                            <li>정보마당</li>
                            <li>&gt;</li>
                            <li><strong>설문조사</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
            <form name="listForm" id="listForm" action="<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageList.do'/>" method="post">
            
            <!-- sub title start -->
            <div><h2>설문참여  목록</h2></div>
            <!-- sub title end -->
            
            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >
                    <select name="searchCondition" title="검색조건 선택">
			            <option value=''>--선택하세요--</option>
			            <option value='QESTNR_SJ' <c:if test="${searchCondition == 'QESTNR_SJ'}">selected</c:if>>설문제목</option>
			            <option value='FRST_REGISTER_ID' <c:if test="${searchCondition == 'FRST_REGISTER_ID'}">selected</c:if>>등록자</option>
			        </select>
			        <input name="searchKeyword" type="text" size="30" value="${searchKeyword}" maxlength="35" title="검색어 입력" />
                </div>
                    <div class="search_buttons">
                        <input type="submit" value="<spring:message code="button.inquire" />" onclick="fn_egov_search_QustnrManage(); return false;" />      
                    </div>
                </div> 
            </div>
            <!-- search area end -->
            
            <!-- search result start -->
            <div class="search_result_div">
            
                <table width="98%" cellpadding="0" cellspacing="0" summary="이 표는 설문제목 정보를 제공하며, 순번, 설문제목, 설문기간, 통계, 등록자, 등록일자 정보로 구성되어 있습니다 .">
                <caption>설문참여목록</caption>
                
                <colgroup>
                    <col width="35px" > 
                    <col >
                    <col width="150px" >
                    <col width="60px" >
                    <col width="70px" >
                    <col width="70px" >
                </colgroup>
                
                <thead>
                <tr>      
				    <th>순번</th>
				    <th>설문제목</th>
				    <th>설문기간</th>
				    <th>통계</th>
				    <th>등록자</th>   
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
				    <td class="lt_text3L" >
				    <span class="link"><input type="submit" style="width:320px;border:solid 0px black;text-align:left;" value="<c:out value="${resultInfo.qestnrSj}"/>" onclick="fn_egov_regist_QustnrRespondInfoManage('${resultInfo.qestnrId}','${resultInfo.qestnrTmplatId}'); return false;"></span>
				    </td>
				    <td class="lt_text3" >${resultInfo.qestnrBeginDe}~${resultInfo.qestnrEndDe}</td>
				    <td class="lt_text3" ><a href="#LINK" onClick="fn_egov_statistics_QustnrRespondInfoManage('${resultInfo.qestnrId}','${resultInfo.qestnrTmplatId}')">보기</a></td>
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
			
			<input name="qestnrId" id="qestnrId" type="hidden" value="">
			<input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="">
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

