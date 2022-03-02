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
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

<title>샘플 포털 > 포털서비스관리 > 서비스관리 > 배너관리</title>
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

function fncBannerUpdate() {
    var varFrom = document.getElementById("banner");
    varFrom.action = "<c:url value='/uss/ion/bnr/updtBanner.do'/>";

    if(confirm('<spring:message code="common.update.msg" />')) {
        if(!validateBanner(varFrom)){           
            return;
        } else {
            varFrom.submit();
        } 
    }
}

function fncBannerDelete() {
    var varFrom = document.getElementById("banner");
    varFrom.action = "<c:url value='/uss/ion/bnr/removeBanner.do'/>";
    if(confirm('<spring:message code="common.delete.msg" />')){
        varFrom.submit();
    }
}

</script>
</head>

<body>
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
                                        <li><a href="">서비스관리</a></li>
                                        <li>배너관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="banner" method="post" action="${pageContext.request.contextPath}/uss/ion/bnr/updtBanner.do" enctype="multipart/form-data">
								<input type="hidden" name="posblAtchFileNumber" value="1" >

                                <h1 class="tit_1">포털서비스관리</h1>

                                <p class="txt_1">포털시스템에서 제공되는 서비스들에 대한 컨텐츠를 관리합니다.</p>

                                <h2 class="tit_2">서비스관리</h2>
                                
                                <h3 class="tit_3">배너관리</h3>

                                <div class="board_view2">
                                    <table summary="배너정보를 수정하는 항목">
                                    	<caption>배너 수정</caption>
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="bannerId">배너ID</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="bannerId" id="bannerId" class="f_txt" title="배너ID" type="text" value="<c:out value='${banner.bannerId}'/>" readonly="readonly" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="bannerNm">배너명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="bannerNm" id="bannerNm" class="f_txt" title="배너명" type="text" value="<c:out value='${banner.bannerNm}'/>" maxLength="10" >
                                                <form:errors path="bannerNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="linkUrl">링크URL</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="linkUrl" id="linkUrl" class="f_txt w_full" title="링크URL" type="text" value="<c:out value='${banner.linkUrl}'/>" maxLength="255" >
                                                <form:errors path="linkUrl" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="egovComFileUploader" class="min">배너이미지</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input class="f_file" type="file" name="file_1" id="egovComFileUploader" title="배너이미지파일">
                                                <input name="bannerImage" id="bannerImage" class="f_txt" type="text" style="width: 400px; margin-left: 20px;" title="배너이미지" value="<c:out value="${banner.bannerImage}"/>" maxLength="30" readonly="readonly" / >
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="bannerDc">배너설명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="bannerDc" id="bannerDc" class="f_txt w_full" title="배너설명" type="text" value="<c:out value='${banner.bannerDc}'/>" maxLength="100" >
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="sortOrdr">정렬순서</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="sortOrdr" id="sortOrdr" class="f_txt w_130" title="정렬순서" type="text" value="<c:out value='${banner.sortOrdr}'/>" maxLength="5" >
                                                <form:errors path="sortOrdr" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="reflctAt">반영여부</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select" for="reflctAt">
                                                    <select name="reflctAt" id="reflctAt" title="반영여부">
                                                        <option value="Y" <c:if test="${banner.reflctAt == 'Y'}">selected</c:if> >Y</option>
                                                        <option value="N" <c:if test="${banner.reflctAt == 'N'}">selected</c:if> >N</option>
                                                    </select>
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="regDate">등록일시</label>
                                            </td>
                                            <td>
                                                <input name="regDate" id="regDate" class="f_txt" title="등록일시" type="text" value="<c:out value="${banner.regDate}"/>" maxLength="50" readonly="readonly">
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  시작-->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="<c:url value='/uss/ion/bnr/removeBanner.do'/>?bannerId=<c:out value='${bannerVO.bannerId}'/>" class="btn btn_skyblue_h46 w_100" onclick="fncBannerDelete(); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fncBannerUpdate(); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value='/uss/ion/bnr/selectBannerList.do'/>?pageIndex=<c:out value='${bannerVO.pageIndex}'/>&amp;searchKeyword=<c:out value="${bannerVO.searchKeyword}"/>&amp;searchCondition=1" class="btn btn_blue_46 w_100" onclick="fncSelectBannerList(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- 목록/저장버튼  끝-->
                                
                                <input type="hidden" name="searchCondition" value="<c:out value='${bannerVO.searchCondition}'/>" >
								<input type="hidden" name="searchKeyword" value="<c:out value='${bannerVO.searchKeyword}'/>" >
								<input type="hidden" name="pageIndex" value="<c:out value='${bannerVO.pageIndex}'/>" >
								
								</form:form>
                                
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
