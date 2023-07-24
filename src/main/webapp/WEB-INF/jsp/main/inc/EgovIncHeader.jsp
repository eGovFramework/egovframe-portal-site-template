<%--
  Class Name : EgovIncHeader.jsp
  Description : 화면상단 Header(include)
  Modification Information

       수정일      수정자         수정내용
    ----------  --------  ---------------------------
    2011.08.31  JJY       경량환경 버전 생성
    2021.08.12  신용호      신규 디자인 적용
    2023.06.09  이택진      NSR 보안조치 (크로스사이트 스크립트 방지를 위한 출력 코드 수정)

    author   : 실행환경개발팀 JJY
    since    : 2011.08.31
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">

<script type="text/javaScript" language="javascript">

function fn_egov_modal_create(){
	
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px;" src="' + "<c:url value='/EgovPageLink.do'/>?" + "linkIndex=" + 7 +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1200,
        height: 940
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/**********************************************************
 * 모달 종료 버튼
 ******************************************************** */
function fn_egov_modal_remove() {
	$('#modalPan').remove();
}

function getCurrentDate()
{
    var date = new Date();
    var year = date.getFullYear().toString();
    var month = date.getMonth() + 1;
    month = month < 10 ? '0' + month.toString() : month.toString();
    var day = date.getDate();
    day = day < 10 ? '0' + day.toString() : day.toString();
    var hour = date.getHours();
    hour = hour < 10 ? '0' + hour.toString() : hour.toString();
    var minites = date.getMinutes();
    minites = minites < 10 ? '0' + minites.toString() : minites.toString();
    var seconds = date.getSeconds();
    seconds = seconds < 10 ? '0' + seconds.toString() : seconds.toString();
    document.getElementById("currentDate").innerHTML = year + "-" + month + "-" + day + " " + hour + ":" + minites + ":" + seconds;
}
$(document).ready(function(){
    getCurrentDate();
});
</script>

<!-- Header -->
<div class="header">
    <div class="inner">
        <div class="left_col">
            <h1 class="logo"><a href="<c:url value='/'/>cmm/main/mainPage.do"><img src="<c:url value='/images/logo.png'/>" alt="표준프레임워크 포털 eGovFrame 샘플 포털"></a></h1>
            <a class="go" href="#LINK" onclick="fn_egov_modal_create(); return false;"><img src="<c:url value='/images/ico_question.png'/>" alt="메뉴구성 설명"></a>
        </div>

        <!-- 전체검색 -->
        <div id="TopSearch" class="total_search">
            <div class="search_box">
                <form method="post" action="#LINK" name="TopSearchForm" id="TopSearchForm">
                    <fieldset>
                        <legend>전체검색</legend>
                        <input type="text" name="search" id="search" placeholder="검색어를 입력하세요.">
                        <button type="submit">검색</button>
                    </fieldset>
                </form>
            </div>
            <ul class="list">
                <li><a href="#">표준프레임워크</a></li>
                <li><a href="#"><strong>경량환경</strong></a></li>
                <li><a href="#">내부업무</a></li>
                <li><a href="#">모바일</a></li>
            </ul>
        </div>
        <!--// 전체검색 -->
<%
    LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
    if(loginVO == null){
%>
		<c:set var="loginName" value=""/>
<% }else{ %>
		<c:set var="loginName" value="<%= loginVO.getName()%>"/>
	    <div class="top_menu">
            <span class="t"><span onclick="alert('개인정보 확인 등의 링크 제공'); return false;" style="cursor: pointer;"><c:out value="${loginName}" />님</span>, 로그인하셨습니다.</span>
            <span id="currentDate" class="d"></span>
        </div>
<% } %>



        <!-- gnb -->
		<div class="gnb">
			<ul>
		    	<c:forEach var="result" items="${list_headmenu}" varStatus="status">
		    	<li><a href="#LINK" onclick="javascript:goMenuPage('<c:out value="${result.menuNo}"/>')" class='<c:if test="${result.menuOrdr >= 5}">manager</c:if>'><c:out value="${result.menuNm}"/></a></li>
		        </c:forEach>
		    </ul>
		</div>
        <!-- gnb -->

        <!-- util menu -->
        <div class="util_menu">
            <ul>
				<c:if test="${loginName == ''}">
                <!-- case: 로그아웃했을경우 -->
	                <li><a href="<c:url value='/'/>uat/uia/egovLoginUsr.do" class="login" title="로그인">로그인</a></li>
				</c:if>
				<c:if test="${loginName != ''}">
                <!-- case: 로그인했을경우 -->
	                <li><a href="<c:url value='/'/>uat/uia/actionLogout.do" class="logout" title="로그아웃">로그아웃</a></li>
	                <li><a href="" class="mail" title="메일">메일<span>3</span>건</a></li>
	                <li><a href="" class="allmenu" title="전체메뉴">전체메뉴</a></li>
				</c:if>
            </ul>
        </div>
        
        <!-- all menu 210912 add -->
            <div class="all_menu">
                <div class="inner">
                    <div>
                        <h2>사이트소개</h2>
                        <ul>
                            <li><a href="/pst_webapp/EgovPageLink.do?linkIndex=3">사이트소개</a></li>
                            <li><a href="/pst_webapp/EgovPageLink.do?linkIndex=4">연혁</a></li>
                            <li><a href="/pst_webapp/EgovPageLink.do?linkIndex=5">조직소개</a></li>
                            <li><a href="/pst_webapp/EgovPageLink.do?linkIndex=6">찾아오시는 길</a></li>
                        </ul>
                    </div>

                    <div>
                        <h2>민원광장</h2>
                        <ul>
                            <li><a href="/pst_webapp/EgovPageLink.do?linkIndex=1">민원신청</a></li>
                            <li><a href="/pst_webapp/EgovPageLink.do?linkIndex=2">민원결과확인</a></li>
                        </ul>
                    </div>

                    <div>
                        <h2>알림마당</h2>
                        <ul>
                            <li><a href="/pst_webapp/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA">공지사항</a></li>
                            <li><a href="/pst_webapp/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_BBBBBBBBBBBB">자유게시판</a></li>
                        </ul>
                    </div>

                    <div>
                        <h2>정보마당</h2>
                        <ul>
                            <li><a href="/pst_webapp/uss/olh/faq/FaqListInqire.do">FAQ</a></li>
                            <li><a href="/pst_webapp/uss/olh/qna/QnaListInqire.do">QnA</a></li>
                            <li><a href="/pst_webapp/uss/olp/qnn/EgovQustnrRespondInfoManageList.do">설문조사</a></li>
                        </ul>
                    </div>

                    <div class="admin">
                        <h2>포털서비스관리</h2>
                        <h3>설문관리</h3>
                        <ul>
                            <li><a href="/pst_webapp/uss/olp/qmc/EgovQustnrManageList.do">설문지</a></li>
                            <li><a href="/pst_webapp/uss/olp/qtm/EgovQustnrTmplatManageList.do">설문템플릿</a></li>
                            <li><a href="/pst_webapp/uss/olp/qqm/EgovQustnrQestnManageList.do">설문문항</a></li>
                            <li><a href="/pst_webapp/uss/olp/qim/EgovQustnrItemManageList.do">설문항목</a></li>
                            <li><a href="/pst_webapp/uss/olp/qrm/EgovQustnrRespondManageList.do">설문응답결과</a></li>
                        </ul>
                        
                        <h3>서비스관리</h3>
                        <ul>
                            <li><a href="/pst_webapp/uss/olh/faq/admin/FaqListInqire.do">FAQ관리</a></li>
                            <li><a href="/pst_webapp/uss/olh/qna/admin/QnaListInqire.do">QnA관리</a></li>
                            <li><a href="/pst_webapp/uss/olh/qnm/QnaAnswerListInqire.do">QnA답변관리</a></li>
<!--                             <li><a href="/pst_webapp/cop/com/selectTemplateInfs.do">게시판템플릿관리</a></li> -->
                            <li><a href="/pst_webapp/cop/bbs/SelectBBSMasterInfs.do">게시판생성관리</a></li>
                            <li><a href="/pst_webapp/cop/com/selectBBSUseInfs.do">게시판사용관리</a></li>
                            <li><a href="/pst_webapp/cop/bbs/admin/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA">공지사항관리</a></li>
                            <li><a href="/pst_webapp/cop/bbs/admin/selectBoardList.do?bbsId=BBSMSTR_BBBBBBBBBBBB">자유게시판관리</a></li>
                            <li><a href="/pst_webapp/uss/ion/bnr/selectBannerList.do">배너관리</a></li>
                        </ul>
                    </div>

                    <div class="admin">
                        <h2>포털시스템관리</h2>
                        <h3>사용자관리</h3>
                        <ul>
                            <li><a href="/pst_webapp/uss/umt/mber/EgovMberManage.do">회원관리</a></li>
                            <li><a href="/pst_webapp/uss/sam/stp/StplatListInqire.do">이용약관관리</a></li>
                            <li><a href="/pst_webapp/uss/sam/ipm/listIndvdlInfoPolicy.do">개인정보보호관리</a></li>
                        </ul>

                        <h3>사용자권한관리</h3>
                        <ul>
                            <li><a href="/pst_webapp/sec/ram/EgovAuthorList.do">권한관리</a></li>
                            <li><a href="/pst_webapp/sec/gmt/EgovGroupList.do">사용자그룹관리</a></li>
                            <li><a href="/pst_webapp/sec/rgm/EgovAuthorGroupListView.do">사용자별권한관리</a></li>
                            <li><a href="/pst_webapp/sec/rmt/EgovRoleList.do">롤관리</a></li>
                        </ul>
                    </div>
                </div>

            </div>
            <!--// all menu -->
        
        <!--// util menu -->
    </div>
</div>
<!--// Header -->

<!-- topmenu start -->
<script type="text/javascript">
<!--
    function getLastLink(menuNo){
        var tNode = new Array;
        for (var i = 0; i < document.menuListForm.tmp_menuNm.length; i++) {
            tNode[i] = document.menuListForm.tmp_menuNm[i].value;
            var nValue = tNode[i].split("|");
            //선택된 메뉴(menuNo)의 하위 메뉴중 첫번재 메뉴의 링크정보를 리턴한다.
            if (nValue[1]==menuNo) {
                if(nValue[5]!="dir" && nValue[5]!="" && nValue[5]!="/"){
                    //링크정보가 있으면 링크정보를 리턴한다.
                    return nValue[5];
                }else{
                    //링크정보가 없으면 하위 메뉴중 첫번째 메뉴의 링크정보를 리턴한다.
                    return getLastLink(nValue[0]);
                }
            }
        }
    }
    function goMenuPage(menuNo){
        document.getElementById("menuNo").value=menuNo;
        //document.getElementById("link").value=getLastLink(menuNo);
        document.menuListForm.action = "<c:url value='/'/>"+getLastLink(menuNo).substring(1);
        document.menuListForm.submit();
    }
  //-->
</script>

<form name="menuListForm" action ="" method="post">
    <input type="hidden" id="menuNo" name="menuNo" value="<%=session.getAttribute("menuNo")%>" />
    <input type="hidden" id="link" name="link" value="" />
    <div style="width:0px; height:0px;">
    <c:forEach var="result" items="${list_menulist}" varStatus="status" >
    	<input type="hidden" name="tmp_menuNm" value="<c:out value='${result.menuNo}'/>|<c:out value='${result.upperMenuId}'/>|<c:out value='${result.menuNm}'/>|<c:out value='${result.relateImagePath}'/>|<c:out value='${result.relateImageNm}'/>|<c:out value='${result.chkURL}'/>|" />
    </c:forEach>
    </div>
</form>
