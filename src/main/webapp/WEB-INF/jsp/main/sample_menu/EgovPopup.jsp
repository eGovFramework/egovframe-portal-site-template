<%--
  Class Name : EgovPopup.jsp
  Description : 샘플화면 - 팝업화면 샘플(sample)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<title>표준프레임워크 경량환경 내부업무템플릿</title>
<link href="css/default.css" rel="stylesheet" type="text/css" >
</head>
<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>	
<!-- 메뉴 시작 -->
<div id="popup_wrap">
	<div class="h_title">비밀번호 수정</div>
	<div class="popup">
		<table style=" ">
			<tr>
				<th>아이디</th>
				<td><input type="text" value="gdhong" /></td>
			</tr>
			<tr>
				<th>기존비밀번호</th>
				<td><input type="password" value="gdhong" /></td>
			</tr>
			<tr>
				<th>기존비밀번호확인</th>
				<td><input type="password" value="gdhong" /></td>
			</tr>
		</table>		
	<div class="buttons" style="float:left;clear:both;"><a href="#">저장 </a></div>		
	</div>		
</div>
</body>
</html>