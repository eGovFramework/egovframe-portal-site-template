<%--
  Class Name : EgovQnaPasswordConfirm.jsp
  Description : EgovQnaPasswordConfirm 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01   박정규          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 박정규
    since    : 2009.02.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self" >
<title>샘플 포털 > 정보마당 > QnA</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
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
 * 초기화
 ******************************************************** */
function fn_egov_initl_qnacn(){

	// 작성글 비밀번호 입력란에 포커스..
	document.QnaManageForm.writngPassword.focus();

}

/* ********************************************************
 * 확인처리
 ******************************************************** */
function fn_egov_confirm_qnapassword(){
	
// 	getDialogArguments();
// 	var opener = window.dialogArguments;

// 	//  현재화면의 작성 비밀번호
// 	var	ls_writngPassword = document.QnaManageForm.writngPassword.value;
	
// 	// 부모화면으로 작성비밀번호를 넘긴다.
// 	opener.document.QnaManageForm.writngPassword.value = ls_writngPassword;	
	
// 	// 부모화면으로 결과값을 True 넘긴다.
// 	window.returnValue = true;	
// 	window.close();	

	// 현재화면의 작성 비밀번호
	var	ls_writngPassword = document.QnaManageForm.writngPassword.value;
	
	// 부모화면으로 작성비밀번호를 넘긴다.
	parent.document.QnaManageForm.writngPassword.value = ls_writngPassword;
	
	parent.document.QnaManageForm.action = "<c:url value='/uss/olh/qna/QnaPasswordConfirm.do'/>"; 	 	
	parent.document.QnaManageForm.submit();
	
	fn_egov_cancel_popup();

}

/* ********************************************************
 * 취소처리
 ******************************************************** */
function fn_egov_cancel_popup() {
	
// 	self.close();
	
	parent.fn_egov_modal_remove();
}

</script>

</head>
<body onLoad="fn_egov_initl_qnacn();">

	<form name="QnaManageForm" method="post" onsubmit="fn_egov_confirm_qnapassword();" action="#LINK">
	
	<!-- 작성비밀번호확인 팝업 -->
    <div class="popup POP_CONFIRM_PWD">
        <div class="pop_inner">
            <div class="pop_header">
                <h1>작성 비밀번호 확인</h1>
                <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>

            <div class="pop_container">
                <div class="box_1">
                    <label for="writngPassword">작성글 비밀번호</label>
                    <input id="writngPassword" class="f_txt2 ml15" name="writngPassword" type="password" value="" maxlength="20" title="작성글 비밀번호"/>
                </div>

                <div class="btn_area al_c pt20">
                    <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fn_egov_confirm_qnapassword(); return false;"><spring:message code='button.confirm' /></a><!-- 확인 -->
                    <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="fn_egov_cancel_popup(); return false;"><spring:message code='button.reset' /></a><!-- 취소 -->
                </div>
            </div>
        </div>
    </div>
    <!--// 작성비밀번호확인 팝업 -->
    
    </form>
</body>
</html>