<%--
  Class Name : EgovSystemManage.jsp
  Description : 샘플화면 - 관리용(sample)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="content-language" content="ko">
<title>샘플화면(사용자관리)</title>
<link href="css/default.css" rel="stylesheet" type="text/css" >
</head>
<body>
<noscript><p>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</p></noscript>	
<!-- login status start -->
<div id="login_area"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncTborder" /></div>
<!-- //login status end -->
<!-- wrap start -->
<div id="wrap">	
	<!-- header start -->
	<div id="subheader"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>	
	<!-- //header end -->
	<!--  타이틀 이미지 시작 -->
	<div id="title_img_div"><img src="<c:url value='/'/>images/title_image/img_title06.gif" alt="" /></div>
	<!--  //타이틀 이미지 끝 -->
	<div id="bodywrap">
		<div id="leftmenu_div"><c:import url="/sym/mms/EgovMainMenuLeft.do" /></div>
		<div id="middle_content">
			<!-- 현재위치 네비게이션 시작 -->
			<div id="cur_loc">
					<div id="cur_loc_align">
						<ul>
							<li>HOME</li>
							<li>&gt;</li>
							<li>포털시스템관리</li>
							<li>&gt;</li>
							<li><strong>사용자관리</strong></li>
						</ul>
					</div>
			</div>
			<div id="content_field">
				<div><h2>표준프레임워크 포털 시스템 관리</h2></div>
					
			</div>
		</div>
	</div>
	<!-- footer 시작 -->
	<div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
	<!-- //footer 끝 -->
</div>
<!-- //wrap end -->
</body>
</html>