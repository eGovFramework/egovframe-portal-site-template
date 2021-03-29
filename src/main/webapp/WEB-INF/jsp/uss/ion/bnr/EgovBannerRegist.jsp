<%--
  Class Name : EgovRoleUpdate.jsp
  Description : EgovRoleUpdate 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01    lee.m.j          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 lee.m.j
    since    : 2009.02.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<title>배너 등록</title>
<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="banner" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

function fncSelectBannerList() {
    var varFrom = document.getElementById("banner");
    varFrom.action = "<c:url value='/uss/ion/bnr/selectBannerList.do'/>";
    varFrom.submit();       
}

function fncBannerInsert() {
    var varFrom = document.getElementById("banner");
    varFrom.action = "<c:url value='/uss/ion/bnr/addBanner.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateBanner(varFrom)){           
            return;
        }else{
            if(varFrom.bannerImage.value != '') {
                varFrom.submit();
            } else {
                alert("배너이미지는 필수 입력값입니다.");
                return;
            }
        } 
    }
}

function fncOnChangeImage() {
	var varFrom = document.getElementById("banner");
	varFrom.bannerImage.value = varFrom.file_1.value;
}

function fncBannerDelete() {
    var varFrom = document.getElementById("banner");
    varFrom.action = "<c:url value='/uss/ion/bnr/removeBanner.do'/>";
    if(confirm("삭제 하시겠습니까?")){
        varFrom.submit();
    }
}

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
            
            <form:form commandName="banner" method="post" action="${pageContext.request.contextPath}/uss/ion/bnr/addBanner.do" enctype="multipart/form-data"> 
			<input type="hidden" name="posblAtchFileNumber" value="1" >
			<input type="hidden" name="bannerImage" >

            <!-- sub title start -->
            <div><h2>배너 등록</h2></div>
            <!-- sub title end -->

            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">                  
					<table summary="배너정보를 입력하는 항목">
					  <caption>배너 등록</caption>
					  <tr>
					    <td class="td_width"><label for="bannerId">배너ID</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content"><input name="bannerId" id="bannerId" title="배너ID" type="text" value="<c:out value='${banner.bannerId}'/>" size="30" class="readOnlyClass" readonly="readonly" ></td>
					  </tr>
					  <tr>
					    <td class="td_width"><label for="bannerNm">배너명</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content"><input name="bannerNm" id="bannerNm" title="배너명" type="text" value="<c:out value='${banner.bannerNm}'/>" maxLength="10" size="30" >&nbsp;<form:errors path="bannerNm" /></td>
					  </tr>
					  <tr>
					    <td class="td_width"><label for="linkUrl">링크URL</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content"><input name="linkUrl" id="linkUrl" title="링크URL" type="text" value="<c:out value='${banner.linkUrl}'/>" maxLength="255" size="50" >&nbsp;<form:errors path="linkUrl" /></td>
					  </tr>
					  <tr>
					    <td class="td_width"><label for="egovComFileUploader">배너이미지</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					        <input type="file" name="file_1" id="egovComFileUploader" title="배너이미지" onchange="javascript:fncOnChangeImage();">
					    </td>
					  </tr>
					  <tr>
					    <td class="td_width"><label for="bannerDc">배너설명</label></td>
					    <td class="td_content"><input name="bannerDc" id="bannerDc" title="배너설명" type="text" value="<c:out value='${banner.bannerDc}'/>" maxLength="100" size="80"  ></td>
					  </tr>  
					  <tr>
					    <td class="td_width"><label for="sortOrdr">정렬순서</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content"><input name="sortOrdr" id="sortOrdr" type="text" title="정렬순서" value="<c:out value='${banner.sortOrdr}'/>" maxLength="5" size="10" >&nbsp;<form:errors path="sortOrdr" /></td>
					  </tr>   
					  <tr>
					    <td class="td_width"><label for="reflctAt">반영여부</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					      <select name="reflctAt" id="reflctAt" title="반영여부">
					          <option value="Y" <c:if test="${banner.reflctAt == 'Y'}">selected</c:if> >Y</option>
					          <option value="N" <c:if test="${banner.reflctAt == 'N'}">selected</c:if> >N</option>
					      </select>
					   </td> 
					  </tr>  
					  <tr>
					    <td class="td_width"><label for="regDate">등록일시</label></td>
					    <td class="td_content"><input name="regDate" id="regDate" title="등록일시" type="text" value="<c:out value="${banner.regDate}"/>" maxLength="20" size="20" class="readOnlyClass" readonly="readonly" ></td>
					  </tr>
					</table>
                </div>
            </div>
            <!--detail area end -->
            
            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
                <input type="submit" value="<spring:message code="button.save" />" onclick="fncBannerInsert(); return false;">
                <a href="<c:url value='/uss/ion/bnr/selectBannerList.do'/>?pageIndex=<c:out value='${bannerVO.pageIndex}'/>&amp;searchKeyword=<c:out value="${bannerVO.searchKeyword}"/>&amp;searchCondition=1" onclick="fncSelectBannerList(); return false;"><spring:message code="button.list" /></a>
            </div>
            </td></tr></table>
            <!-- 목록/저장버튼  끝-->
            
			<input type="hidden" name="searchCondition" value="<c:out value='${bannerVO.searchCondition}'/>" >
			<input type="hidden" name="searchKeyword" value="<c:out value='${bannerVO.searchKeyword}'/>" >
			<input type="hidden" name="pageIndex" value="<c:out value='${bannerVO.pageIndex}'/>" >
			<!-- 검색조건 유지 -->
			
			</form:form>
  
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

