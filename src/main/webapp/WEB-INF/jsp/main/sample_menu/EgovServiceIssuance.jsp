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
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
<title>샘플 포털 > 민원광장 > 민원발급</title>
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
                            <div id="contents" class="content">
                                 <!-- Location -->
                                <div class="location">
                                    <ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li><a href="">민원광장</a></li>
                                        <li>민원발급</li>
                                    </ul>
                                </div>
                                <!--// Location -->

                                <h1 class="tit_1">민원광장</h1>

                                <p class="txt_1">프레임워크 관련 서비스의 운영개선을 위한 창조적인 의견이나 아이디어 제안을 기다립니다.</p>

                                <h2 class="tit_2">민원발급</h2>

                                <!-- 검색조건 -->
                                <div class="condition terms">
                                    <label class="item f_select" for="sel1">
                                        <select name="" id="sel1" title="조건">
                                            <option value="0">민원검색</option>
                                        </select>
                                    </label>

                                    <span class="item f_search">
                                        <input class="f_input w_500" type="text" name="">
                                        <button class="btn" type="submit">조회</button>
                                    </span>
                                </div>
                                <!--// 검색조건 -->

                                <div class="board_view2">
                                    <table>
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="nttSj">소속기관별</label>
                                            </td>
                                            <td>
                                                <label class="item f_select" for="sel2">
                                                    <select name="" id="sel2" title="조건">
                                                        <option value="0">통합검색</option>
                                                    </select>
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="">처리기관별</label>
                                            </td>
                                            <td>
                                                <label class="item f_select" for="sel3">
                                                    <select name="" id="sel3" title="조건">
                                                        <option value="0">통합검색</option>
                                                    </select>
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="">인증서 필요여부</label>
                                            </td>
                                            <td>
                                                <label for="chk1" class="f_chk">
                                                    <input type="checkbox" name="aa" id="chk1">
                                                    필요
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <div class="board_top">
                                    <h3 class="tit_3">인터넷 민원신청</h3>

                                    <div class="right_col">
                                        <span class="list_cnt">총 <strong>1,274</strong> 건</span>
                                    </div>
                                </div>

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table>
                                        <colgroup>
                                            <col style="width: 90px;">
                                            <col style="width: auto;">
                                            <col style="width: 115px;">
                                            <col style="width: 115px;">
                                            <col style="width: 115px;">
                                            <col style="width: 115px;">
                                            <col style="width: 115px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">번호</th>
                                                <th scope="col">민원사무명</th>
                                                <th scope="col">인터넷신청</th>
                                                <th scope="col">처리기관</th>
                                                <th scope="col">소속기관</th>
                                                <th scope="col">수령방법</th>
                                                <th scope="col">인증서</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>3</td>
                                                <td><a href="" class="lnk">표준프레임워크 인증서 발급</a></td>
                                                <td>신청</td>
                                                <td>행정안전부</td>
                                                <td>삼성SDS</td>
                                                <td>전자발급</td>
                                                <td>불필요</td>
                                            </tr>
                                            <tr>
                                                <td>2</td>
                                                <td><a href="" class="lnk">표준프레임워크 인증서 발급</a></td>
                                                <td>신청</td>
                                                <td>행정안전부</td>
                                                <td>삼성SDS</td>
                                                <td>전자발급</td>
                                                <td>불필요</td>
                                            </tr>
                                            <tr>
                                                <td>1</td>
                                                <td><a href="" class="lnk">표준프레임워크 인증서 발급</a></td>
                                                <td>신청</td>
                                                <td>행정안전부</td>
                                                <td>삼성SDS</td>
                                                <td>전자발급</td>
                                                <td>불필요</td>
                                            </tr>
                                        </tbody>
                                    </table>
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