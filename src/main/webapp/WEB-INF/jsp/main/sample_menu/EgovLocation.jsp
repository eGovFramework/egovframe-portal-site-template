<%--
  Class Name : EgovAboutSite.jsp
  Description : 샘플화면 - 사이트소개(sample)
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
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
<title>샘플 포털 > 사이트 소개 > 찾아오시는 길</title>
<!-- <link href="css_old/default.css" rel="stylesheet" type="text/css" > -->
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
                            <div id="contents" class="content p_contactus">
                                 <!-- Location -->
                                 <div class="location">
                                    <ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li><a href="">사이트 소개</a></li>
                                        <li>찾아오시는 길</li>
                                    </ul>
                                </div>
                                <!--// Location -->

                                <h1 class="tit_1">사이트 소개</h1>

                                <p class="txt_1">표준프레임워크 경량환경 포털사이트를 소개합니다.</p>

                                <h2 class="tit_2">찾아오시는길</h2>

                                <p class="map"><img src="./images/map.png" alt=""></p>

                                <div class="addr">
                                    <div class="top">
                                        <div class="left_col">
                                            <h2>표준프레임워크센터 주소</h2>
                                            <dl>
                                                <dt>도로명주소</dt>
                                                <dd>04513 서울특별시 중구 세종대로 39 대한서울상공회의소 7층</dd>
                                            </dl>
                                            <dl>
                                                <dt>지번주소</dt>
                                                <dd>04513 서울특별시 중구 남대문로4가 45 대한서울상공회의소 7층</dd>
                                            </dl>
                                        </div>

                                        <div class="right_col">
                                            <p>
                                                <strong>QR코드로 위치알아보기</strong>
                                                스마트폰에서 QR코드<br>
                                                리더를 이용해 사진·<br>
                                                지도 등 다양한 정보를<br>
                                                확인하세요.
                                            </p>
                                            <p><img src="./images/qrcode.png" alt="QR코드"></p>
                                        </div>
                                    </div>

                                    <div class="bot">
                                        <div class="left_col">
                                            <h2>찾아오시는 길</h2>
                                            <dl>
                                                <dt>지하철 2호선</dt>
                                                <dd>시청역 9번 출구 5분거리</dd>
                                            </dl>
                                            <dl>
                                                <dt>지하철 1호선</dt>
                                                <dd>서울역 3번 출구 5분거리</dd>
                                            </dl>
                                        </div>

                                        <div class="right_col">
                                            <h2>연락처</h2>
                                            <dl>
                                                <dt class="call">전화</dt>
                                                <dd>0000-0000</dd>
                                            </dl>
                                            <dl>
                                                <dt class="email">이메일</dt>
                                                <dd>egovframesupport@gmail.com</dd>
                                            </dl>
                                        </div>
                                    </div>
                                </div>
                                
                                <!--// 게시판 -->
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