<%--
  Class Name : EgovQnaDetailInqure.jsp
  Description : EgovQnaDetailInqure 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01   박정규          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 박정규
    since    : 2009.02.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>샘플 포털 > 정보마당 > QnA</title>
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
	
<script type="text/javaScript" language="javascript">

/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_inqire_qnalist() {

	document.QnaManageForm.action = "<c:url value='/uss/olh/qna/QnaListInqire.do'/>";
	document.QnaManageForm.submit();
}

/* ********************************************************
 * 수정처리화면
 ******************************************************** */
function fn_egov_updt_qnacn(qaId){

// 	// Update하기 위한 키값을 셋팅
// 	document.QnaManageForm.qaId.value = qaId;	

// 	var url 	= "<c:url value='/uss/olh/qna/QnaPasswordConfirmView.do'/>";
// 	var	status 	= "dialogWidth=350px;dialogHeight=200px;resizable=no;center=yes";

	
// 	// 작성비밀번호 확인 화면을 호출한다.
// 	var returnValue = window.showModalDialog(url, self, status);

// 	// 결과값을 받아. 결과를 Submit한다.
//  	if	(returnValue)	{

//  		document.QnaManageForm.action = "<c:url value='/uss/olh/qna/QnaPasswordConfirm.do'/>"; 	 	
//  		document.QnaManageForm.submit();
 		
//  	}
	
	// qaId 값 세팅
	document.QnaManageForm.qaId.value = qaId;
	
<c:if test="${adminAt == 'Y'}">
	// 26.08.20 조치 : 관리자는 타인의 작성 비밀번호를 알 방법이 없으므로
	// 비밀번호 확인 모달을 건너뛰고 바로 수정화면으로 이동한다.
	// QnaCnUpdtView.do 의 assertCanModifyQna() 가 관리자를 무조건 통과시킨다.
	document.QnaManageForm.action = "<c:url value='/uss/olh/qna/QnaCnUpdtView.do'/>";
	document.QnaManageForm.submit();
	return;
</c:if>
	
	var url 	= "<c:url value='/uss/olh/qna/QnaPasswordConfirmView.do'/>";
	
	var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + url + '" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 600,
        height: 350
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

/**********************************************************
 * 삭제처리화면
 ******************************************************** */
function fn_egov_delete_qnacn(qaId){

	if	(confirm('<spring:message code="common.delete.msg" />')) {

		// Delete하기 위한 키값을 셋팅
		document.QnaManageForm.qaId.value = qaId;	
		document.QnaManageForm.action = "<c:url value='/uss/olh/qna/QnaCnDelete.do'/>";
		document.QnaManageForm.submit();
	}
}

/*********************************************************
 * 작성비밀번호.체크..
 ******************************************************** */
function fn_egov_passwordConfirm(){

	alert("작성 비밀번호를 확인 바랍니다!");
	
}


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
                                        <li><a href="">정보마당</a></li>
                                        <li>QnA</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="QnaManageForm" action="<c:url value='/uss/olh/qna/QnaPasswordConfirm.do'/>" method="post">
								<input name="qaId" type="hidden" value="<c:out value='${egovc:encrypt(result.qaId)}'/>">

                                <h1 class="tit_1">정보마당</h1>

                                <p class="txt_1">포털시스템에서 제공되는 서비스들에 대한 컨텐츠를 관리합니다.</p>

                                <h2 class="tit_2">QnA</h2>

                                <div class="board_view2">
                                    <table>
                                    	<caption>Q&amp;A상세조회</caption>
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">작성자명</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.wrterNm}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">전화번호</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.areaNo}"/>-<c:out value="${result.middleTelno}"/>-<c:out value="${result.endTelno}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">작성일자</span>
                                            </td>
                                            <td>
                                            	<c:out value='${fn:substring(result.writngDe, 0,4)}'/>-<c:out value='${fn:substring(result.writngDe, 4,6)}'/>-<c:out value='${fn:substring(result.writngDe, 6,8)}'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">조회수</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.inqireCo}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">질의응답처리상태</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.qnaProcessSttusCodeNm}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">질문제목</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.qestnSj}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="qestnCn">질문내용</label>
                                            </td>
                                            <td>
                                                <textarea id="qestnCn" class="f_txtar w_full h_200" name="qestnCn" cols="30" rows="10" readonly title="질문내용"><c:out value="${result.qestnCn}"/>
                                                </textarea>
                                            </td>
                                        </tr>
                                        
                                        <!-- 답변내용이 있을경우 Display... -->
                                        <c:if test="${result.qnaProcessSttusCode == '3'}">
	                                        <tr>
	                                            <td class="lb">
	                                                <label for="">답변내용</label>
	                                            </td>
	                                            <td>
	                                                <textarea class="f_txtar w_full h_200" name="answerCn" cols="30" rows="10" readonly="readonly" title="답변내용"><c:out value="${result.answerCn}"/>
	                                                </textarea>
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="lb">
	                                                <span class="min">답변일자</span>
	                                            </td>
	                                            <td>
	                                            	<c:if test="${result.answerDe != null}">
	                                            		<c:out value='${fn:substring(result.answerDe, 0,4)}'/>-<c:out value='${fn:substring(result.answerDe, 4,6)}'/>-<c:out value='${fn:substring(result.answerDe, 6,8)}'/>
	                                            	</c:if>
	                                            </td>
	                                        </tr>
	                                        <!--
	                                        <tr>
	                                            <td class="lb">
	                                                <span class="min">담당부서</span>
	                                            </td>
	                                            <td>
	                                            	<c:out value="${result.orgnztNm}"/>
	                                            </td>
	                                        </tr>
											<tr>
	                                            <td class="lb">
	                                                <span class="min">답변자</span>
	                                            </td>
	                                            <td>
	                                            	<c:out value="${result.emplyrNm}"/>
	                                            </td>
	                                        </tr>
											<tr>
	                                            <td class="lb">
	                                                <span class="min">전화번호</span>
	                                            </td>
	                                            <td>
	                                            	<c:out value="${result.offmTelno}"/>
	                                            </td>
	                                        </tr>
											<tr>
	                                            <td class="lb">
	                                                <span class="min">이메일</span>
	                                            </td>
	                                            <td>
	                                            	<c:out value="${result.aemailAdres}"/>
	                                            </td>
	                                        </tr>
											-->
                                        </c:if>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  시작-->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <%-- 26.08.20 조치 : 노출 조건이 없어 타인 글에도 수정/삭제 버튼이 노출됐다.
                                             노출 조건을 컨트롤러가 넣어둔 modifyAt(작성자 또는 관리자)로 감싼다. --%>
                                        <c:if test="${modifyAt == 'Y'}">
                                        <a href="<c:url value='/uss/olh/qna/QnaCnDelete.do'/>?qaId=<c:out value='${egovc:encrypt(result.qaId)}'/>" class="btn btn_skyblue_h46 w_100" onclick="fn_egov_delete_qnacn('<c:out value="${egovc:encrypt(result.qaId)}"/>'); return false;">
                                        	<spring:message code="button.delete" />
                                        </a><!-- 삭제 -->
                                        </c:if>
                                    </div>

                                    <div class="right_col btn1">
                                        <c:if test="${modifyAt == 'Y'}">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_updt_qnacn('<c:out value="${egovc:encrypt(result.qaId)}"/>'); return false;"><spring:message code="button.update" /></a><!-- 수정 -->
                                        </c:if>
                                        <a href="<c:url value='/uss/olh/qna/QnaListInqire.do'/>" class="btn btn_blue_46 w_100" onclick="fn_egov_inqire_qnalist(); return false;">
                                        	<spring:message code="button.list" />
                                        </a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- 목록/저장버튼  끝-->
                                
                                <%-- 26.08.24 조치 : 기존 조건 result.passwordConfirmAt == 'N,' 은
                                     forward 가 붙인 passwordConfirmAt=N 과 아래 빈 hidden 필드가
                                     파라미터 두 개로 합쳐져 만들어진 값에 의존하고 있었다.
                                     컨트롤러가 명시적으로 넣어주는 passwordFailAt 로 판정한다. --%>
                                <c:if test="${passwordFailAt == 'Y'}">
								<tr> 
									<td class="lt_text3" colspan=10>
										<script type="text/javascript">
											fn_egov_passwordConfirm();
										</script>
									</td>
								</tr>
								</c:if>
					
								<input name="writngPassword" type="hidden" value="">
								<input name="passwordConfirmAt" type="hidden" value="">
								
								</form>
                                
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