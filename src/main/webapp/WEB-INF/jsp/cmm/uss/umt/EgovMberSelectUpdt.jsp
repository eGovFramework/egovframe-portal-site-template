<%--
  Class Name : EgovMberSelectUpdt.jsp
  Description : 일반회원상세조회, 수정 JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.02  JJY          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 JJY
    since    : 2009.03.02
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">
	
<title>샘플 포털 > 포털시스템관리 > 사용자관리 > 회원관리</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="mberManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnListPage(){
    document.mberManageVO.action = "<c:url value='/uss/umt/mber/EgovMberManage.do'/>";
    document.mberManageVO.submit();
}
function fnDeleteMber(checkedIds) {
    if(confirm('<spring:message code="common.delete.msg" />')) {
        document.mberManageVO.checkedIdForDel.value=checkedIds;
        document.mberManageVO.action = "<c:url value='/uss/umt/mber/EgovMberDelete.do'/>";
        document.mberManageVO.submit(); 
    }
}
function fnPasswordMove(){
    document.mberManageVO.action = "<c:url value='/uss/umt/mber/EgovMberPasswordUpdtView.do'/>";
    document.mberManageVO.submit();
}
function fnUpdate(){
	document.mberManageVO.action = "<c:url value='/uss/umt/mber/EgovMberSelectUpdt.do'/>";
    if(validateMberManageVO(document.mberManageVO)){
        document.mberManageVO.submit();
    }
}

function fn_egov_ZipSearch(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/sym/cmm/EgovCcmZipSearchList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1100,
        height: 600
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

function fn_egov_returnValue(retVal){
	if (retVal) {
		document.getElementById("zip_view").value  = retVal.vZip;
		document.getElementById("adres").value  = retVal.sAddr;
	}
	
	fn_egov_modal_remove();
}

/**********************************************************
 * 모달 종료 버튼
 ******************************************************** */
function fn_egov_modal_remove() {
	$('#modalPan').remove();
}
//-->
</script>
</head>
<body>

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
                                        <li><a href="">포털시스템관리</a></li>
                                        <li><a href="">사용자관리</a></li>
                                        <li>회원관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="mberManageVO" name="mberManageVO"  method="post" >
								
								<!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
					            <input name="checkedIdForDel" type="hidden" />
					            <!-- 검색조건 유지 -->
					            <input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
					            <input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
					            <input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
					            <input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
					            <!-- 우편번호검색 -->
					            <input type="hidden" name="zip_url" value="<c:url value='/sym/cmm/EgovCcmZipSearchPopup.do'/>" />
					            <!-- 사용자유형정보 : password 수정화면으로 이동시 타겟 유형정보 확인용, 만약검색조건으로 유형이 포함될경우 혼란을 피하기위해 userTy명칭을 쓰지 않음-->
					            <input type="hidden" name="userTyForPassword" value="<c:out value='${mberManageVO.userTy}'/>" />

                                <h1 class="tit_1">포털시스템관리</h1>

                                <p class="txt_1">포털시스템의 사용자 및 권한에 대한 제반사항을 관리합니다.</p>

                                <h2 class="tit_2">사용자관리</h2>

                                <h3 class="tit_3">회원관리</h3>

                                <div class="board_view2">
                                    <table summary="일반회원정보 상세조회">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="mberId">일반회원아이디</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="mberId" id="mberId" class="f_txt w_350" size="20" readonly="readonly" maxlength="20" />
                                                <form:errors path="mberId" cssClass="error" />
                                                <form:hidden path="uniqId" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="mberNm">일반회원이름</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="mberNm" id="mberNm" class="f_txt w_350" maxlength="60" />
                                                <form:errors path="mberNm" cssClass="error" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="passwordHint">비밀번호힌트</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_350" for="passwordHint">
                                                    <form:select path="passwordHint" id="passwordHint" name="passwordHint" title="비밀번호힌트">
                                                    	<form:option value="" label="--선택하세요--"/>
                                                    	<form:options items="${passwordHint_result}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                    <form:errors path="passwordHint" cssClass="error"/>
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="passwordCnsr">비밀번호정답</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="passwordCnsr" id="passwordCnsr" class="f_txt w_350" maxlength="100" />
                                                <form:errors path="passwordCnsr" cssClass="error"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="sexdstnCode">성별구분코드</label>
                                            </td>
                                            <td>
                                                <label class="f_select w_160" for="sexdstnCode">
                                                    <form:select path="sexdstnCode" id="sexdstnCode" name="sexdstnCode" title="성별구분코드">
					                                    <form:option value="" label="--선택하세요--"/>
					                                    <form:options items="${sexdstnCode_result}" itemValue="code" itemLabel="codeNm"/>
					                                </form:select>
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="areaNo">전화번호</label>
                                            </td>
                                            <td>
                                                <form:input path="areaNo" id="areaNo" class="f_txt w_80" maxlength="4" />
                                                <span class="f_txt_inner mr5 ml5" title="전화번호 첫번째">-</span>
                                                <form:input path="middleTelno" id="middleTelno" class="f_txt w_80" maxlength="4" />
                                                <span class="f_txt_inner mr5 ml5">-</span>
                                                <form:input path="endTelno" id="endTelno" class="f_txt w_80" maxlength="4" />
                                                <form:errors path="areaNo" cssClass="error" />
                                                <form:errors path="middleTelno" cssClass="error" />
                                                <form:errors path="endTelno" cssClass="error" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="mberFxnum">팩스번호</label>
                                            </td>
                                            <td>
                                                <input class="f_txt w_350" type="text" id="">
                                                <form:input path="mberFxnum" id="mberFxnum" class="f_txt w_350" maxlength="15" />
                                                <form:errors path="mberFxnum" cssClass="error" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="moblphonNo">핸드폰번호</label>
                                            </td>
                                            <td>
                                                <form:input path="moblphonNo" id="mberFxnum" class="f_txt w_350" maxlength="15" />
                                                <form:errors path="moblphonNo" cssClass="error" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="mberEmailAdres">이메일주소</label>
                                            </td>
                                            <td>
                                                <form:input path="mberEmailAdres" id="mberEmailAdres" class="f_txt w_350" maxlength="50" />
                                                <form:errors path="mberEmailAdres" cssClass="error" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="zip_view">우편번호</label>
                                            </td>
                                            <td>
                                                <span class="f_search2 w_350">
                                                    <input name="zip_view" id="zip_view" type="text" value="<c:out value='${mberManageVO.zip}'/>" maxlength="8" readonly="readonly" />
                                                    <form:hidden path="zip" />
                                                    <button type="button" class="btn" onclick="fn_egov_ZipSearch();"></button>
                                                </span>
                                                <span class="f_txt_inner ml15">(우편번호 검색)</span>
                                                <form:errors path="zip" cssClass="error" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="adres">주소</label>
                                            </td>
                                            <td>
                                                <form:input path="adres" id="adres" class="f_txt w_full" maxlength="100" readonly="true" />
                                                <form:errors path="adres" cssClass="error" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="detailAdres">상세주소</label>
                                            </td>
                                            <td>
                                                <form:input path="detailAdres" id="detailAdres" class="f_txt w_full" maxlength="100" />
                                                <form:errors path="detailAdres" cssClass="error" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="groupId">그룹아이디</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_350" for="groupId">
                                                    <form:select path="groupId" id="groupId" name="groupId">
					                                    <form:option value="" label="--선택하세요--"/>
					                                    <form:options items="${groupId_result}" itemValue="code" itemLabel="codeNm"/>
					                                </form:select>
					                                <form:errors path="groupId" cssClass="error"/>
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="mberSttus">일반회원상태코드</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_350" for="mberSttus">
                                                    <form:select path="mberSttus" id="mberSttus" name="mberSttus">
					                                    <form:option value="" label="--선택하세요--"/>
					                                    <form:options items="${mberSttus_result}" itemValue="code" itemLabel="codeNm"/>
					                                </form:select>
					                                <form:errors path="mberSttus" cssClass="error"/>
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  시작-->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="<c:url value='/uss/umt/mber/EgovMberManage.do'/>" class="btn btn_skyblue_h46 w_100" onclick="fnDeleteMber('<c:out value='${mberManageVO.userTy}'/>:<c:out value='${mberManageVO.uniqId}'/>'); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                        <a href="<c:url value='/uss/umt/mber/EgovMberPasswordUpdtView.do'/>" class="btn btn_skyblue_h46 w_100" onclick="fnPasswordMove(); return false;"><spring:message code="button.passwordUpdate" /></a><!-- 암호변경 -->
                                        <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:document.mberManageVO.reset();"><spring:message code="button.reset" /></a><!-- 취소 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fnUpdate(); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value='/uss/umt/mber/EgovMberManage.do'/>" class="btn btn_blue_46 w_100" onclick="fnListPage(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- 목록/저장버튼  끝-->
                                
                                <form:hidden path="password" />
                                </form:form>
                                
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