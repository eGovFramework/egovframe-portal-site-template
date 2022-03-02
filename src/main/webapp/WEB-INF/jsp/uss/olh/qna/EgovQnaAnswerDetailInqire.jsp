<%--
  Class Name : EgovQnaAnswerDetailInqure.jsp
  Description : EgovQnaAnswerDetailInqure 화면
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>샘플 포털 > 포털서비스관리 > 서비스관리 > QnA답변관리</title>
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
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_inqire_qnaanswerlist() {

	document.QnaManageForm.action = "<c:url value='/uss/olh/qnm/QnaAnswerListInqire.do'/>";
	document.QnaManageForm.submit();
		
}

/* ********************************************************
 * 수정처리화면
 ******************************************************** */
function fn_egov_updt_qnacnanswer(qaId){

	// Update하기 위한 키값을 셋팅
	document.QnaManageForm.qaId.value = qaId;	

	document.QnaManageForm.action = "<c:url value='/uss/olh/qnm/QnaCnAnswerUpdtView.do'/>";
	document.QnaManageForm.submit();	

		
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
                                        <li><a href="">포털서비스관리</a></li>
                                        <li><a href="">서비스관리</a></li>
                                        <li>QnA답변관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="QnaManageForm" action="<c:url value='/uss/olh/qnm/QnaCnAnswerUpdtView.do'/>" method="post">

                                <h1 class="tit_1">포털서비스관리</h1>

                                <p class="txt_1">포털시스템에서 제공되는 서비스들에 대한 컨텐츠를 관리합니다.</p>

                                <h2 class="tit_2">서비스관리</h2>

                                <h3 class="tit_3">QnA답변관리</h3>

                                <div class="board_view2">
                                    <table summary="Q&amp;A에 대한 답변을 조회합니다.">
                                    	<caption>Q&amp;A답변상세조회</caption>
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
                                            	<c:out value="${result.passwordConfirmAt}"/>
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
                                                <span class="min">이메일</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.emailAdres}"/>
                                            	<input type="hidden" name="emailAnswerAt" id="emailAnswerAt" value="N"/> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">작성일자</span>
                                            </td>
                                            <td>
                                            	<c:if test="${result.writngDe != null}">
                                            		<c:out value='${fn:substring(result.writngDe, 0,4)}'/>-<c:out value='${fn:substring(result.writngDe, 4,6)}'/>-<c:out value='${fn:substring(result.writngDe, 6,8)}'/>
                                            	</c:if>
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
                                                <span class="min">진행처리상태</span>
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
                                                <textarea id="qestnCn" name="qestnCn" class="f_txtar w_full h_200" cols="30" rows="10" readonly title="질문내용"><c:out value="${result.qestnCn}"/></textarea>
                                            </td>
                                        </tr>
                                        
                                        <!--답변내용이 있을경우 Display...-->
                                        <c:if test="${result.qnaProcessSttusCode == '3'}">
                                        <tr>
                                            <td class="lb">
                                                <span class="min"><label for="answerCn">답변내용</label></span>
                                            </td>
                                            <td>
                                            	<textarea name="answerCn" class="f_txtar w_full h_200" cols="30" rows="10" readonly title="답변내용"><c:out value="${result.answerCn}"/></textarea>
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
                                        <%-- 
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
                                         --%>
                                        </c:if>
                                        <!-- // 답변내용이 있을경우 Display... 끝 -->
                                        
                                    </table>
                                </div>

								<!-- 목록/저장버튼  시작-->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_updt_qnacnanswer('<c:out value="${result.qaId}"/>'); return false;">답변</a><!-- 답변 -->
                                        <a href="<c:url value='/uss/olh/qnm/QnaAnswerListInqire.do'/>" class="btn btn_blue_46 w_100" onclick="fn_egov_inqire_qnaanswerlist(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- 목록/저장버튼  끝-->
                                
                                <input name="qaId" type="hidden" value="">
								<input name="writngPassword" 	type="hidden" value="">
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