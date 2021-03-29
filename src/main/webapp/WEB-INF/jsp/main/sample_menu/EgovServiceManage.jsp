<%--
  Class Name : EgovServiceManage.jsp
  Description : 샘플화면 - 민원신청내역화면(sample)
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
<title>샘플화면(민원발급신청)</title>
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
                            <li><strong>민원신청내역</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field">
                <div><h2>민원신청내역</h2></div>
                <p>※7일 이전의 신청내용은 검색기간을 입력한 후 확인하시기 바랍니다.</p>
                <div class="search_service">
                    <div class="search_area">                   
                        <form action="" id="SubTopSearch1"name="SubTopSearch1" method="post">
                            <span class="search_txt">기간별 검색</span>
                            <select id="subsearchYear" name="subsearchYear" style="width:70px;">
                                <option value="">2011</option>
                            </select>
                            <select id="subsearchMonth" name="subsearchMonth" style="width:50px;">
                                <option value="">08</option>
                            </select>
                            <select id="subsearchDay" name="subsearchDay" style="width:50px;">
                                <option value="">21</option>
                            </select>
                            <span class="search_txt">부터~</span>
                            <select id="subsearchYearNew" name="subsearchYearNew">
                                <option value="">2011</option>
                            </select>
                            <select id="subsearchMonthNew" name="subsearchMonthNew">
                                <option value="">08</option>
                            </select>
                            <select id="subsearchDayNMew" name="subsearchDayNMew">
                                <option value="">21</option>
                            </select><span class="search_txt">까지</span>
                            <button class="btnSearch" title="검색" type="submit">&nbsp;</button>                
                        </form>
                    </div>
                </div>
            </div>
            <div class="search_result_div">
            <table summary="" cellpadding="0" cellspacing="0">
                    <caption>민원신청내역</caption>
                    <colgroup>
                        <col width="160" > 
                        <col width="200" >  
                        <col width="60" >
                        <col width="%" >
                        <col width="%" >
                        <col width="100" >
                        <col width="70" >
                    </colgroup>
                    <thead>
                    <tr>
                        <th>민원접수번호[신청일]</th>
                        <th>민원사무명</th>
                        <th>부수</th>
                        <th>처리상태</th>
                        <th>교부기관</th>
                        <th>연락처</th>
                        <th>추가신청</th>
                    </tr>
                    </thead>
                    <tbody>                 
                    <!-- loop 시작 -->                                
                    <tr>
                        <td>2011-08-11</td>
                        <td>표준프레임워크 인증서 발급</td>
                        <td>300</td>
                        <td>발급대기</td>
                        <td>행정안전부</td>
                        <td>1544-5555</td>
                        <td>신청</td>
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
            <!-- //페이지 네비게이션 끝 -->
        </div>
    </div>
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div>
<!-- //wrap end -->
</body>
</html>