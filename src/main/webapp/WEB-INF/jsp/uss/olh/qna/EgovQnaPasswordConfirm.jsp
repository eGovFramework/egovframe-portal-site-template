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
<title>작성비밀번호 확인</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javascript" src="<c:url value='/js/showModalDialogCallee.js'/>" ></script>
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
	
	getDialogArguments();
	var opener = window.dialogArguments;

	//  현재화면의 작성 비밀번호
	var	ls_writngPassword = document.QnaManageForm.writngPassword.value;
	
	// 부모화면으로 작성비밀번호를 넘긴다.
	opener.document.QnaManageForm.writngPassword.value = ls_writngPassword;	
	
	// 부모화면으로 결과값을 True 넘긴다.
	window.returnValue = true;	
	window.close();	

}

/* ********************************************************
 * 취소처리
 ******************************************************** */
function fn_egov_cancel_qnapassword() {
	
	self.close();
			
}

</script>

</head>
<body onLoad="fn_egov_initl_qnacn();">
<div id="content" style="width:270px">
    <form name="QnaManageForm" method="post" onsubmit="fn_egov_confirm_qnapassword();" action="#LINK">
        <input type="submit" id="invisible" class="invisible"/>
        <table width="100%" cellpadding="8" class="table-search" border="0">
            <tr>
                <td width="100%" class="title_left">
                    <h2>작성 비밀번호 확인</h2>
                </td>
            </tr>
        </table>
        <!-- 등록  폼 영역  -->
        <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register">
            <caption>작성 비밀번호 확인</caption>
            <tr> 
                <th scope="row" width="45%" height="23" class="required_text" nowrap >
                    <label for="writngPassword">작성글 비밀번호</label>
                </th>
                <td width="55%" nowrap="nowrap">
                    <input id="writngPassword" name="writngPassword" type="password" size="20" value="" maxlength="20" title="작성글 비밀번호"/>  
                </td>
            </tr>
        </table>
        <!-- 목록/저장버튼  시작-->
        <table border="0" cellspacing="0" cellpadding="0" align="center">
            <tr>
                <td>
                    <div class="buttons" align="center" style="margin-bottom:100px">
                        <a href="#LINK" onclick="javascript:fn_egov_confirm_qnapassword(); return false;">확인</a>
                        <a href="#LINK" onclick="JavaScript:fn_egov_cancel_qnapassword(); return false;">취소</a>
                    </div>
                </td>
            </tr>
        </table>
        <!-- 목록/저장버튼  끝-->
    </form>
</div>
</body>
</html>