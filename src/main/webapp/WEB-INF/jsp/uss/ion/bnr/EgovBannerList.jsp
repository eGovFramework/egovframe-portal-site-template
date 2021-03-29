<%--
  Class Name : EgovBannerList.jsp
  Description : EgovBannerList 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01    lee.m.j          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 lee.m.j
    since    : 2009.02.01
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<title>배너 목록조회</title>
<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fncCheckAll() {
    var checkField = document.listForm.delYn;
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}

function fncManageChecked() {

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var returnValue = "";
    var returnBoolean = false;
    var checkCount = 0;
    
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                	checkCount++;
                    checkField[i].value = checkId[i].value;
                    if(returnValue == "")
                        returnValue = checkField[i].value;
                    else 
                        returnValue = returnValue + ";" + checkField[i].value;
                }
            }
            if(checkCount > 0) 
                returnBoolean = true;
            else {
                alert("선택된  배너가 없습니다.");
                returnBoolean = false;
            }
        } else {
            if(document.listForm.delYn.checked == false) {
                alert("선택된 배너가 없습니다.");
                returnBoolean = false;
            }
            else {
                returnValue = checkId.value;
                returnBoolean = true;
            }
        }
    } else {
    	alert("조회된 결과가 없습니다.");
    }

    document.listForm.bannerIds.value = returnValue;
    return returnBoolean;
}

function fncSelectBannerList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/ion/bnr/selectBannerList.do'/>";
    document.listForm.submit();
}

function fncSelectBanner(bannerId) {
    document.listForm.bannerId.value = bannerId;
    document.listForm.action = "<c:url value='/uss/ion/bnr/getBanner.do'/>";
    document.listForm.submit();   
}

function fncAddBannerInsert() {
	if(document.listForm.pageIndex.value == "") {
		document.listForm.pageIndex.value = 1;
	} 
    document.listForm.action = "<c:url value='/uss/ion/bnr/addViewBanner.do'/>";
    document.listForm.submit(); 
}

function fncBannerListDelete() {
	if(fncManageChecked()) {
        if(confirm("삭제하시겠습니까?")) {
            document.listForm.action = "<c:url value='/uss/ion/bnr/removeBannerList.do'/>";
            document.listForm.submit();
        }
    }
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/ion/bnr/selectBannerList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
    	fncSelectBannerList('1');
    }
}
-->
</script>

</head>

<body>

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
                            <li><strong>배너관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
            <form name="listForm" action="<c:url value='/uss/ion/bnr/selectBannerList.do'/>" method="post">
            
            <!-- sub title start -->
            <div><h2>배너 관리</h2></div>
            <!-- sub title end -->

            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >배너명 : 
                    <input name="searchKeyword" title="검색어" type="text" value="<c:out value="${bannerVO.searchKeyword}"/>" size="25" onkeypress="press();" id="searchKeyword">
                </div>
                    <div class="search_buttons">
	    				<input type="submit" value="<spring:message code="button.inquire" />" onclick="fncSelectBannerList('1'); return false;">
						<a href="<c:url value='/uss/ion/bnr/addViewBanner.do'/>?pageIndex=<c:out value='${bannerVO.pageIndex}'/>&amp;searchKeyword=<c:out value="${bannerVO.searchKeyword}"/>&amp;searchCondition=1" onclick="fncAddBannerInsert(); return false;"><spring:message code="button.create" /></a>
                    </div>
                </div> 
            </div>
            <!-- search area end -->
			<input type="hidden" name="bannerId">
			<input type="hidden" name="pageIndex" value="<c:if test="${empty bannerVO.pageIndex }">1</c:if><c:if test="${!empty bannerVO.pageIndex }"><c:out value='${bannerVO.pageIndex}'/></c:if>">
			<input type="hidden" name="searchCondition" value="1">
			
			</form>

            <!-- search result start -->
            <div class="search_result_div">
            
                <table width="98%" cellpadding="0" cellspacing="0" summary="메인화면에서 배너에 대한 목록으로 배너명, 링크url,배너설명,반영여부를 제공한다.">
                <caption>배너 목록</caption>
                
                <colgroup>
                    <col width="20%" > 
                    <col width="30%" >
                    <col width="40%" >
                    <col width="10%" >
                </colgroup>
                
                <thead>
                <tr>      
                    <th class="title" width="20%" scope="col">배너 명</th>
				    <th class="title" width="30%" scope="col">링크 URL</th>
				    <th class="title" width="40%" scope="col">배너 설명</th>
				    <th class="title" width="10%" scope="col">반영여부</th>       
                </tr>
                </thead>
                
                <tbody>
                <c:if test="${fn:length(bannerList) == 0}">
                <tr> 
                      <td class="lt_text3" colspan="4">
                          <spring:message code="common.nodata.msg" />
                      </td>
                </tr>                                                 
                </c:if>
				<c:forEach var="banner" items="${bannerList}" varStatus="status">
				<tr>
				    <td class="lt_text3" >
				        <form name="item" method="post" action="<c:url value='/uss/ion/bnr/getBanner.do'/>">
				            <input type="hidden" name="bannerId" value="<c:out value="${banner.bannerId}"/>">
				            <input type="hidden" name="pageIndex" value="<c:out value='${bannerVO.pageIndex}'/>">
				            <input type="hidden" name="searchCondition" value="<c:out value='${bannerVO.searchCondition}'/>">
				            <input type="hidden" name="searchKeyword" value="<c:out value="${bannerVO.searchKeyword}"/>">
				            <span class="link"><input type="submit" value="<c:out value="${banner.bannerNm}"/>" onclick="fncSelectBanner('<c:out value="${banner.bannerId}"/>'); return false;"></span>
				        </form>
				    </td>
				    <td class="lt_text3" ><c:out value="${banner.linkUrl}"/></td>
				    <td class="lt_text3" ><c:out value="${banner.bannerDc}"/></td>
				    <td class="lt_text3" ><c:out value="${banner.reflctAt}"/></td>
				</tr>
				</c:forEach>
                </tbody>
                  
                </table>
            </div>
            <!-- search result end -->
      

			<c:if test="${!empty bannerVO.pageIndex }">
			<div id="paging_div">
			    <ul class="paging_align">
			        <ui:pagination paginationInfo = "${paginationInfo}"
			            type="image"
			            jsFunction="linkPage"
			            /></ul>
			</div>
			</c:if>

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
