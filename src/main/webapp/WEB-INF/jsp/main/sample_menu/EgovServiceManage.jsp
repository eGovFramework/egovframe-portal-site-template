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
<title>샘플 포털 > 민원광장 > 민원신청</title>
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
                                        <li>민원신청</li>
                                    </ul>
                                </div>
                                <!--// Location -->

                                <h1 class="tit_1">민원광장</h1>

                                <p class="txt_1">프레임워크 관련 서비스의 운영개선을 위한 창조적인 의견이나 아이디어 제안을 기다립니다.</p>

                                <h2 class="tit_2">민원신청</h2>

                                <p class="txt_2">※ 7일 이전의 신청내용은 검색기간을 입력한 후 확인하시기 바랍니다.</p>
                                
                                <!-- 검색조건 -->
                                <div class="condition2 terms">
                                    <span class="lb mr15">기간별 검색</span>

                                    <label class="f_select mr5" for="yy">
                                        <select name="" id="y" title="연도">
                                            <option value="">2021</option>
                                        </select>
                                    </label>

                                    <label class="f_select mr5" for="mm">
                                        <select name="" id="mm" title="월">
                                            <option value="">08</option>
                                        </select>
                                    </label>

                                    <label class="f_select mr5" for="dd">
                                        <select name="" id="dd" title="일">
                                            <option value="">08</option>
                                        </select>
                                    </label>

                                    <span class="lb mr5">부터~</span>

                                    <label class="f_select mr5" for="mm">
                                        <select name="" id="mm" title="월">
                                            <option value="">08</option>
                                        </select>
                                    </label>

                                    <label class="f_select mr5" for="dd">
                                        <select name="" id="dd" title="일">
                                            <option value="">08</option>
                                        </select>
                                    </label>

                                    <span class="lb mr15">까지</span>

                                    <a href="" class="btn btn_search_w">등록</a>
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table>
                                        <colgroup>
                                            <col style="width: 170px;">
                                            <col style="width: auto;">
                                            <col style="width: 90px;">
                                            <col style="width: 115px;">
                                            <col style="width: 115px;">
                                            <col style="width: 115px;">
                                            <col style="width: 90px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">민원접수번호 [신청일]</th>
                                                <th scope="col">민원사무명</th>
                                                <th scope="col">부수</th>
                                                <th scope="col">처리상태</th>
                                                <th scope="col">교부기관</th>
                                                <th scope="col">연락처</th>
                                                <th scope="col">추가신청</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>2021-06-13</td>
                                                <td><a href="/pst_webapp/EgovPageLink.do?link=main/sample_menu/EgovServiceIssuance" class="lnk">표준프레임워크 인증서 발급</a></td>
                                                <td>300</td>
                                                <td>발급대기</td>
                                                <td>행정안전부</td>
                                                <td>1544-5555</td>
                                                <td>신청</td>
                                            </tr>
                                            <tr>
                                                <td>2021-06-13</td>
                                                <td><a href="/pst_webapp/EgovPageLink.do?link=main/sample_menu/EgovServiceIssuance" class="lnk">표준프레임워크 인증서 발급</a></td>
                                                <td>300</td>
                                                <td>발급대기</td>
                                                <td>행정안전부</td>
                                                <td>1544-5555</td>
                                                <td>신청</td>
                                            </tr>
                                            <tr>
                                                <td>2021-06-13</td>
                                                <td><a href="/pst_webapp/EgovPageLink.do?link=main/sample_menu/EgovServiceIssuance" class="lnk">표준프레임워크 인증서 발급</a></td>
                                                <td>300</td>
                                                <td>발급대기</td>
                                                <td>행정안전부</td>
                                                <td>1544-5555</td>
                                                <td>신청</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <li class="btn"><a href="" class="first">처음</a></li>
                                            <li class="btn"><a href="" class="btn prev">이전</a></li>
                                            <li><strong>1</strong></li>
                                            <li><a href="">2</a></li>
                                            <li><a href="">3</a></li>
                                            <li><a href="">4</a></li>
                                            <li><a href="">5</a></li>
                                            <li><a href="">6</a></li>
                                            <li><a href="">7</a></li>
                                            <li><a href="">8</a></li>
                                            <li><a href="">9</a></li>
                                            <li><a href="">10</a></li>
                                            <li class="btn"><a href="" class="btn next">다음</a></li>
                                            <li class="btn"><a href="" class="btn last">마지막</a></li>
                                        </ul>
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