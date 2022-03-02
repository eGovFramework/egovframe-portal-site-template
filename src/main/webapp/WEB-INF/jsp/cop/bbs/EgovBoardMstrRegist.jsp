<%--
  Class Name : EgovBoardMstrRegist.jsp
  Description : 게시판 생성 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.12   이삼섭          최초 생성
     2009.06.26   한성곤          2단계 기능 추가 (댓글관리, 만족도조사)
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.12
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
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

<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardMaster" staticJavascript="false" xhtml="true" cdata="false" />
<script type="text/javascript">
	function fn_egov_regist_brdMstr(){
		if (!validateBoardMaster(document.boardMaster)){
			return;
		}

		if (confirm('<spring:message code="common.regist.msg" />')) {
			form = document.boardMaster;
			form.action = "<c:url value='/cop/bbs/insertBBSMasterInf.do'/>";
			form.submit();
		}
	}
	
	function fn_egov_select_brdMstrList(){
		form = document.boardMaster;
		form.action = "<c:url value='/cop/bbs/SelectBBSMasterInfs.do'/>";
		form.submit();	
	}
	
	function fn_egov_inqire_tmplatInqire(){
		
        var $dialog = $('<div id="modalPan"></div>')
    	.html('<iframe style="border: 0px; " src="' + "<c:url value='/cop/com/selectTemplateInfsPop.do'/>" +'" width="100%" height="100%"></iframe>')
    	.dialog({
        	autoOpen: false,
            modal: true,
            width: 1300,
            height: 700,
            title: "템플릿 목록"
    	});
        $(".ui-dialog-titlebar").hide();
    	$dialog.dialog('open');
	}
	
	function showModalDialogCallback(retVal) {
		
		if(retVal != null){
            var tmp = retVal.split("|");
            document.getElementById("tmplatId").value = tmp[0];
            document.getElementById("tmplatNm").value = tmp[1];
        }
		
		fn_egov_modal_remove();
	}
	
    /**********************************************************
     * 모달 종료 버튼
     ******************************************************** */
    function fn_egov_modal_remove() {
    	$('#modalPan').remove();
    }
	
</script>

<title>샘플 포털 > 포털서비스관리 > 서비스관리 > 게시판생성관리</title>

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
                                        <li>게시판생성관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="boardMaster" name="boardMaster" method="post" action="<c:url value='/cop/bbs/SelectBBSMasterInfs.do'/>">
								<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />

                                <h1 class="tit_1">포털서비스관리</h1>

                                <p class="txt_1">포털시스템에서 제공되는 서비스들에 대한 컨텐츠를 관리합니다.</p>

                                <h2 class="tit_2">서비스관리</h2>
                                
                                <h3 class="tit_3">게시판생성관리</h3>

                                <div class="board_view2">
                                    <table summary="게시판명,게시판소개,게시판 유형,게시판 속성,답장가능여부,파일첨부가능여부, ..  입니다">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="bbsNm"><spring:message code="cop.bbsNm" /></label><!-- 게시판 명 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td colspan="3">
                                                <form:input id="bbsNm" class="f_txt" title="게시판명입력" path="bbsNm" />
                                                <br /><form:errors path="bbsNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="bbsIntrcn"><spring:message code="cop.bbsIntrcn" /></label><!-- 게시판 소개 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td colspan="3">
                                                <form:textarea id="bbsIntrcn" class="f_txtar w_full h_80" title="게시판소개입력" path="bbsIntrcn" cols="30" rows="10" />
                                                <br /><form:errors path="bbsIntrcn" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="bbsTyCode"><spring:message code="cop.bbsTyCode" /></label><!-- 게시판 유형 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select" for="bbsTyCode">
                                                    <form:select id="bbsTyCode" name="bbsTyCode" path="bbsTyCode" title="게시판유형선택">
                                                    	<form:option value='' label="선택하세요" />
                                                    	<form:options items="${typeList}" itemValue="code" itemLabel="codeNm" />
                                                    </form:select>
                                                    <br /><form:errors path="bbsTyCode" />
                                                </label>
                                            </td>
                                            <td class="lb">
                                                <label for="bbsAttrbCode"><spring:message code="cop.bbsAttrbCode" /></label><!-- 게시판 속성 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select" for="bbsAttrbCode">
                                                    <form:select id="bbsAttrbCode" name="bbsAttrbCode" path="bbsAttrbCode" title="게시판속성선택">
                                                    	<form:option value='' label="선택하세요" />
                                                    	<form:options items="${attrbList}" itemValue="code" itemLabel="codeNm" />
                                                    </form:select>
                                                    <br /><form:errors path="bbsAttrbCode" />
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="replyPosblAt"><spring:message code="cop.replyPosblAt" /></label><!-- 답장가능여부 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td class="rdoSet"><!-- 2개이상 radio 있을때 필요 -->
                                            	<label for="rdo1" class="mr30 on">
                                                    <form:radiobutton id="rdo1" path="replyPosblAt" value="Y" />
                                                    Y
                                                </label>
                                                <label for="rdo2" class="">
                                                    <form:radiobutton id="rdo2" path="replyPosblAt" value="N" />
                                                    N
                                                </label>
                                                <br /><form:errors path="replyPosblAt" />
                                            </td>
                                            <td class="lb">
                                            	<label for="fileAtchPosblAt"><spring:message code="cop.fileAtchPosblAt" /></label><!-- 파일첨부가능여부 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td class="rdoSet"><!-- 2개이상 radio 있을때 필요 -->
                                            	<label for="rdo3" class="mr30 on">
                                                    <form:radiobutton id="rdo3" path="fileAtchPosblAt" value="Y" onclick="document.boardMaster.posblAtchFileNumber.disabled='';" />
                                                    Y
                                                </label>
                                                <label for="rdo4" class="">
                                                    <form:radiobutton id="rdo4" path="fileAtchPosblAt"  value="N" onclick="document.boardMaster.posblAtchFileNumber.disabled='disabled';" />
                                                    N
                                                </label>
                                                <br /><form:errors path="fileAtchPosblAt" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="posblAtchFileNumber"><spring:message code="cop.posblAtchFileNumber" /></label><!-- 첨부가능파일 숫자 -->
                                            </td>
                                            <td colspan="3">
                                                <label class="f_select" for="posblAtchFileNumber">
                                                    <form:select id="posblAtchFileNumber" name="posblAtchFileNumber" path="posblAtchFileNumber" title="첨부가능파일 숫자선택">
                                                    	<form:option value="0" label="선택하세요" />
                                                    	<form:option value='1'>1개</form:option>
                                                    	<form:option value='2'>2개</form:option>
                                                    	<form:option value='3'>3개</form:option>
                                                    </form:select>
                                                    <br /><form:errors path="posblAtchFileNumber" />
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="tmplatNm"><spring:message code="cop.tmplatId" /></label><!-- 템플릿 정보 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td colspan="3">
                                                <span class="f_search2 w_500">
                                                    <form:input id="tmplatNm" path="tmplatNm" readonly="true" title="템플릿정보입력" value="게시판 기본템플릿" />
                                                    <form:hidden id="tmplatId" path="tmplatId" value="TMPLAT_BOARD_DEFAULT" />
<!--                                                     <button type="button" class="btn" onclick="fn_egov_inqire_tmplatInqire(); return false;"></button> -->
                                                    <br /><form:errors path="tmplatId" />
                                                </span>
                                            </td>
                                        </tr>
                                        
                                        <!-- 2009.06.26 : 2단계 기능 추가  -->
                                        <c:if test="${addedOptions == 'true'}">
                                        <tr>
                                            <td class="lb">
                                                <label for="option">추가 선택사항</label><!-- 추가 선택사항 -->
                                            </td>
                                            <td colspan="3">
                                                <label class="f_select" for="option">
                                                    <form:select path="option" title="추가선택사항선택">
														<form:option value="" label="미선택" />
														<form:option value='comment'>댓글</form:option>
														<form:option value='stsfdg'>만족도조사</form:option>
													</form:select>
                                                </label>
                                            </td>
                                        </tr>
                                        </c:if>
                                        <!-- // 2009.06.26 : 2단계 기능 추가  -->
                                        
                                    </table>
                                </div>

								<!-- 목록/저장버튼  시작-->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fn_egov_regist_brdMstr(); return false;"><spring:message code="button.save"/></a><!-- 저장 -->
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_select_brdMstrList(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- 목록/저장버튼  끝-->
                                
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