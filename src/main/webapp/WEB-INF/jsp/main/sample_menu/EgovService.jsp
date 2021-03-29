<%--
  Class Name : EgovService.jsp
  Description : 샘플화면 - 민원발급화면(sample)
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
<title>샘플화면 (민원발급)</title>
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
	<div id="title_img_div"><img src="<c:url value='/'/>images/title_image/img_title02.gif" alt="" /></div>
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
							<li>민원광장</li>
							<li>&gt;</li>
							<li><strong>민원발급</strong></li>
						</ul>
					</div>
			</div>
			<div id="content_field">
				<div><h2>민원발급</h2></div>
				<div class="search_service">
					<div class="search_area">					
						<form action="" name="" id="SubTopSearch" method="post">
							<select id="subsearch" name="subsearch">
							<option value="">민원 검색</option>
							<option value="">게시물검색</option>
							<option value=""></option>
							</select>
							<input type="text" style="" onfocus="" class="inputText" name="search" id="search">&nbsp;<button class="btnSearch" title="검색" type="submit"></button>				
						</form>						
					</div>
					<div class="search_top_table">					
						<table>
							<tr>
								<td class="td_width">소속기관별</td>
								<td class="td_content">
								<select id="subsearch" name="subsearch">
									<option value="">통합검색</option>
									<option value="">게시물검색</option>
									<option value=""></option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="td_width">처리기관별</td>
								<td class="td_content">
								<select id="subsearch" name="subsearch">
									<option value="">통합검색</option>
									<option value="">게시물검색</option>
									<option value=""></option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="td_width">인증서 필요여부</td>
								<td class="td_content"><input type="radio" name="1" /><label for="1">필요</label>
								</td>
							</tr>
						</table>
					</div>
					
				</div>
					<h3>인터넷 민원신청(1274건)</h3>
			</div>
			<div class="search_result_div">
			<table summary="" cellpadding="0" cellspacing="0">
					<caption></caption>
					<colgroup>
					<col width="40" /> 
					<col width="200" />  
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="70" />
					<col width="50" />
					</colgroup>
					<thead>
					<tr>
						<th>번호</th>
						<th>민원사무명</th>
						<th>인터넷신청</th>
						<th>처리기관</th>
						<th>소속기관</th>
						<th>수령방법</th>
						<th>인증서</th>
					</tr>
					</thead>
					<tbody>		  			
					<!-- loop 시작 -->								
					<tr>
						<td><strong>1</strong></td>
						<td>표준프레임워크 인증서 발급</td>
						<td><a href="">신청</a></td>
						<td>행정안전부</td>
						<td>삼성SDS</td>
						<td>전자발급</td>
						<td>불필요</td>
					</tr>
					<tr>
						<td><strong>1</strong></td>
						<td>표준프레임워크 인증서 발급</td>
						<td><a href="">신청</a></td>
						<td>행정안전부</td>
						<td>삼성SDS</td>
						<td>전자발급</td>
						<td>불필요</td>
					</tr>
					<tr>
						<td><strong>1</strong></td>
						<td>표준프레임워크 인증서 발급</td>
						<td><a href="">신청</a></td>
						<td>행정안전부</td>
						<td>삼성SDS</td>
						<td>전자발급</td>
						<td>불필요</td>
					</tr>
					<tr>
						<td><strong>1</strong></td>
						<td>표준프레임워크 인증서 발급</td>
						<td><a href="">신청</a></td>
						<td>행정안전부</td>
						<td>삼성SDS</td>
						<td>전자발급</td>
						<td>불필요</td>
					</tr>
					<tr>
						<td><strong>1</strong></td>
						<td>표준프레임워크 인증서 발급</td>
						<td><a href="">신청</a></td>
						<td>행정안전부</td>
						<td>삼성SDS</td>
						<td>전자발급</td>
						<td>불필요</td>
					</tr>
					</tbody>
					</table>	
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