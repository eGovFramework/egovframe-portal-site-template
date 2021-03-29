<%--
  Class Name : EgovLoginUsr.jsp
  Description : Login 인증 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.03  박지욱          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 박지욱
    since    : 2009.03.03
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link href="<c:url value='/'/>css/default.css" rel="stylesheet" type="text/css" >

<title>로그인</title>
<script type="text/javascript">
<!--
function actionLogin() {

    if (document.loginForm.id.value =="") {
        alert("아이디를 입력하세요");
    } else if (document.loginForm.password.value =="") {
        alert("비밀번호를 입력하세요");
    } else {
        document.loginForm.action="<c:url value='/uat/uia/actionSecurityLogin.do'/>";
        //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
        //document.loginForm.action="<c:url value='/j_spring_security_check'/>";
        document.loginForm.submit();
    }
}


function goRegiUsr() {
    var userSe = document.loginForm.userSe.value;
    // 일반회원
    if (userSe == "GNR") {
        document.loginForm.action="<c:url value='/uss/umt/cmm/EgovMberSbscrbView.do'/>";
        document.loginForm.submit();
    }else{
        alert("일반회원 가입만 허용됩니다.");
    }
}

function setCookie (name, value, expires) {
    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
}

function getCookie(Name) {
    var search = Name + "="
    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
        offset = document.cookie.indexOf(search)
        if (offset != -1) { // 쿠키가 존재하면
            offset += search.length
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset)
            // 쿠키 값의 마지막 위치 인덱스 번호 설정
            if (end == -1)
                end = document.cookie.length
            return unescape(document.cookie.substring(offset, end))
        }
    }
    return "";
}

function saveid(form) {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    if (form.checkId.checked)
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    else
        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
    setCookie("saveid", form.id.value, expdate);
}

function getid(form) {
    form.checkId.checked = ((form.id.value = getCookie("saveid")) != "");
}

function fnInit() {
    var message = document.loginForm.message.value;
    if (message != "") {
        alert(message);
    }
    
    getid(document.loginForm);
}
//-->
</script>
</head>
<body onLoad="fnInit();">

<!-- login status start -->
<div id="login_area"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncTborder" /></div>
<!-- //login status end -->
<!-- wrap start -->
<div id="wrap"> 
    <!-- header start -->
    <div id="header"><c:import url="/sym/mms/EgovMainMenuHead.do?flag=MAIN" /></div>

    <div id="bodywrap">
        <div id="leftmenu_div"><c:import url="/sym/mms/EgovMainMenuLeft.do" /></div>
        <div id="middle_content">
            <!-- sub title start -->
            <div><h2>로그인</h2></div>
            <!-- sub title end -->

            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">  
                <form name="loginForm" action ="<c:url value='/uat/uia/actionSecurityLogin.do'/>" method="post"> 
                <div style="visibility:hidden;display:none;">
	                <input name="iptSubmit1" type="submit" value="전송" title="전송" />
	            </div> 
	            <input type="hidden" name="message" value="${message}" />

	            <table summary="로그인 테이블">
	               <tr>
	                 <td class="td_width">아이디</td>
	                 <td class="td_content">
	                     <input type="text" name="id" id="id" title="아이디" maxlength="10"/>
	                 </td>
	               </tr>
	               <tr>
	                 <td class="td_width">비밀번호</td>
	                 <td class="td_content">
	                     <input type="password" name="password" id="password" title="비밀번호" onKeyDown="javascript:if (event.keyCode == 13) { actionLogin(); }"/>
	                     <input type="checkbox" name="checkId" id="checkId" title="암호저장여부" onClick="javascript:saveid(document.loginForm);" />ID저장
	                 </td>
	               </tr>
	             </table>
             
	             <!-- 목록/저장버튼  시작-->
	             <div class="buttons" align="center" style="margin-bottom:100px">
	                <a href="#LINK" onClick="actionLogin()">로그인</a>
	                <a href="#LINK" onClick="goRegiUsr();">회원가입</a>
	             </div>
	             <!-- 목록/저장버튼  끝-->
            
	             <input name="userSe" type="hidden" value="GNR"/>
	             <input name="j_username" type="hidden"/>
		         </form>
                                   
                 </div>
                
            </div>
            <!--detail area end -->
               
        </div> 
    </div>
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div>

</body>
</html>


