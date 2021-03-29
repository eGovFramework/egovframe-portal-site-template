<%--
  Class Name : EgovNotice.jsp
  Description : 샘플화면 - 게시물화면 샘플(sample)
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
<title>샘플화면(공지사항)</title>
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
	<div id="title_img_div"><img src="<c:url value='/'/>images/title_image/img_title03.gif" alt="" /></div>
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
							<li>알림마당</li>
							<li>&gt;</li>
							<li><strong>공지사항</strong></li>
						</ul>
					</div>
			</div>
			<div id="content_field">
				<div><h2>공지사항</h2></div>


				<div class="default_tablestyle">
					<table summary="" cellpadding="0" cellspacing="0">
					<caption></caption>
					<colgroup>
					<col width="38" />
					<col width="500" />  
					<col width="50" />
					<col width="150" />
					<col width="" />
					</colgroup>
					<thead>
					<tr>
						<th scope="col" class="f_field">번호</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">조회수</th>
						<th scope="col">등록일</th>
					</tr>
					</thead>
					<tbody>		  			
					<!-- loop 시작 -->								
					<tr>
						<td><strong>10</strong></td>
						<td class="align_left_text"><a href="1">2011년 8월 표준프레임워크 개발관련 표준 세미나 안내(8월 15일 오후 13:00시)</a></td>
						<td>홍길동</td>
						<td>1232</td>
						<td>2011-04-04</td>
					</tr>
					<tr>
						<td><strong>9</strong></td>
						<td class="align_left_text"><a href="1">2011년 8월 표준프레임워크 개발관련 표준 세미나 안내(8월 15일 오후 13:00시)</a></td>
						<td>홍길동</td>
						<td>111</td>
						<td>2011-04-04</td>
					</tr>
					<tr>
						<td><strong>8</strong></td>
						<td class="align_left_text"><a href="1">2011년 8월 표준프레임워크 개발관련 표준 세미나 안내(8월 15일 오후 13:00시)</a></td>
						<td>홍길동</td>
						<td>324</td>
						<td>2011-04-04</td>
					</tr>	
					<tr>
						<td><strong>7</strong></td>
						<td class="align_left_text"><a href="1">2011년 8월 표준프레임워크 개발관련 표준 세미나 안내(8월 15일 오후 13:00시)</a></td>
						<td>홍길동</td>
						<td>521</td>
						<td>2011-04-04</td>
					</tr>	
					<tr>
						<td><strong>6</strong></td>
						<td class="align_left_text"><a href="1">2011년 8월 표준프레임워크 개발관련 표준 세미나 안내(8월 15일 오후 13:00시)</a></td>
						<td>홍길동</td>
						<td>755</td>
						<td>2011-04-04</td>
					</tr>
										<tr>
						<td><strong>5</strong></td>
						<td class="align_left_text"><a href="1">2011년 8월 표준프레임워크 개발관련 표준 세미나 안내(8월 15일 오후 13:00시)</a></td>
						<td>홍길동</td>
						<td>324</td>
						<td>2011-04-04</td>
					</tr>	
					<tr>
						<td><strong>4</strong></td>
						<td class="align_left_text"><a href="1">2011년 8월 표준프레임워크 개발관련 표준 세미나 안내(8월 15일 오후 13:00시)</a></td>
						<td>홍길동</td>
						<td>521</td>
						<td>2011-04-04</td>
					</tr>	
					<tr>
						<td><strong>3</strong></td>
						<td class="align_left_text"><a href="1">2011년 8월 표준프레임워크 개발관련 표준 세미나 안내(8월 15일 오후 13:00시)</a></td>
						<td>홍길동</td>
						<td>755</td>
						<td>2011-04-04</td>
					</tr>	
					<tr>
						<td><strong>2</strong></td>
						<td class="align_left_text"><a href="1">2011년 8월 표준프레임워크 개발관련 표준 세미나 안내(8월 15일 오후 13:00시)</a></td>
						<td>홍길동</td>
						<td>521</td>
						<td>2011-04-04</td>
					</tr>	
					<tr>
						<td><strong>1</strong></td>
						<td class="align_left_text"><a href="1">2011년 8월 표준프레임워크 개발관련 표준 세미나 안내(8월 15일 오후 13:00시)</a></td>
						<td>홍길동</td>
						<td>755</td>
						<td>2011-04-04</td>
					</tr>													
					</tbody>
					</table> 
				</div>
				<!-- 페이지 네비게이션 시작 -->
				<div id="paging_div">
					<ul class="paging_align">
						<li class="first"><img src="<c:url value='/'/>images/btn_prev.gif" alt="prev" /></li>
						<li><a href="#">1</a></li>
						<li>2</li>
						<li>3</li>
						<li>4</li>
						<li>5</li>
						<li class="first"><img src="<c:url value='/'/>images/btn_next.gif" alt="next" /></li>
					</ul>
				</div>

					
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