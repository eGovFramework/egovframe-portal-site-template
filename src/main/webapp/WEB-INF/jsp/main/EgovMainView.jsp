<%--
  Class Name : EgovMainView.jsp
  Description : 메인화면
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성

    author   : 실행환경개발팀 JJY
    since    : 2011.08.31
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="content-language" content="ko">
<title>경량환경 템플릿 포털사이트</title>
<link href="<c:url value='/'/>css/default.css" rel="stylesheet" type="text/css" >
</head>
<body>
<noscript><p>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</p></noscript>
<!-- login status start -->
<div id="login_area"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncTborder" /></div>
<!-- //login status end -->
<!-- wrap start -->
<div id="wrap">
	<!-- header start -->
	<div id="header"><c:import url="/sym/mms/EgovMainMenuHead.do?flag=MAIN" /></div>
	<!-- //header end -->
	<!-- 타이틀이미지, 로그인 시작 -->
	<div id="titlewrap">
		<div class="main_img"><img src="<c:url value='/'/>images/header/img_portal_title.gif" width="719" height="94" alt="" /></div>
		<div class="main_login">
    		<%
               LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
               if(loginVO != null){
            %>
    		<ul>
    		    <li><h3>[로그인정보 제공(예시)]</h3></li>
    		    <li><%= loginVO.getName()%>님 로그인하셨습니다.</li>
    		    <li>로그인 :2011-08-30 12:45 (예)</li>
    		    <li>받은 쪽지 : 3건 (예)</li>
    		</ul>
    		<%  } else { %>
            <!-- 메인화면 로그인위치를 사용하는 경우 -->
			<ul>
				<li>
					<input disabled="disabled" type="text" class="input_style" maxlength="25" title="아이디를 입력하세요." id="user_id" name="user_id" />
				</li>
				<li>
					<input disabled="disabled" type="password" class="input_style" maxlength="25" title="비밀번호를 입력하세요." id="user_password" name="user_password" />
				</li>
			</ul>
			<ul class="btn_area">
				<li><input disabled="disabled" type="checkbox" id="idsave"><label for="idsave">아이디 저장</label></li>
				<li><a href="<c:url value='/uat/uia/egovLoginUsr.do'/>"><img alt="로그인" src="<c:url value='/'/>images/header/btn_login.gif" /></a></li>
			</ul>
			<div class="find_idpw">[메인화면 로그인위치 예시]</div>
	     <%  } %>
		</div>
	</div>
	<!-- //타이틀이미지, 로그인 끝 -->
	<div id="bodywrap">
		<div id="leftcontent_wrap">
			<!-- 한번에 신청하는 민원 시작 -->
			<div class="leftcontent01">
				<div class="leftcontent01_title"><img src="<c:url value='/'/>images/header/img_leftcontent_title01.gif" width="228" height="31" alt="한번에 신청하는 민원" /></div>
				<div class="btn_detail01"><a href="#LINK" onclick="javascript:goMenuPage('2000000'); return false;" ><img src="<c:url value='/'/>images/header/btn_detailview.gif" width="71" height="17" alt="자세히 보기" title="자세히 보기 링크를 통해 샘플화면으로 이동합니다.(민원)" /></a></div>
				<div class="leftcontent01_btn">
					<ul>
						<li><a href="#LINK"><img src="<c:url value='/'/>images/header/btn_leftcontent01.gif" width="70" height="87" alt="기술지원 필요 시 유지보수 민원" title="자세히 보기 링크를 통해 샘플화면으로 이동합니다.(민원)" /></a></li>
						<li><a href="#LINK"><img src="<c:url value='/'/>images/header/btn_leftcontent02.gif" width="67" height="87" alt="구매제품  A/S민원" title="자세히 보기 링크를 통해 샘플화면으로 이동합니다.(민원)" /></a></li>
					</ul>
				</div>
			</div>
			<!-- //한번에 신청하는 민원 끝 -->
			<div class="leftcontent02">
				<div class="leftcontent02_title"><A HREF="#LINK"><img src="<c:url value='/'/>images/header/img_leftcontent_title02.gif" width="210" height="71" alt="홍보물 정보 보기" title="기타자료에 대한 샘플링크 위치 표시입니다.(이동, 기능 없음)" /></A></div>
				<div class="btn_detail02"><a href="#LINK"><img src="<c:url value='/'/>images/header/btn_detailview.gif" width="71" height="17" alt="자세히 보기" title="기타자료에 대한 샘플링크 위치 표시입니다.(이동, 기능 없음)" /></a></div>
			</div>
			<div class="leftcontent03">
				<div class="leftcontent03_title">
				    <a href="<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageList.do'/>">
				    <img src="<c:url value='/'/>images/header/img_leftcontent_title03.gif" width="228" height="44" alt="포털설문참여" />
				    </a>
				</div>
				<c:forEach var="result" items="${qriList}" varStatus="status">
				<div class="vote02">
                    <ul>
                        <li><h3>${result.qestnrSj}</h3>
                        <ul>
                            <li>
                                <a href="<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageList.do'/>">
                                <img alt="참여하기" src="<c:url value='/'/>images/header/btn_vote.gif" />
                                </a>
                            </li>
                        </ul>
                        </li>
                     </ul>
				</div>
				</c:forEach>
			</div>
		</div>
		<!-- 중간 영역 시작 -->
		<div id="middlecontent_wrap">
			<div id="news">
				<ul>
					<li><img alt="공지사항" src="<c:url value='/'/>images/header/tab01_on.gif" /></li>
					<li><img alt="묻고답하기" src="<c:url value='/'/>images/header/tab02_off.gif" /></li>
					<li class="li_line" ><span class="btn_more_board"><a href="<c:url value='/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA'/>"><img src="<c:url value='/'/>images/header/bg_more.gif" alt="게시물 더보기"/></a></span></li>
				</ul>
			</div>
			<div id="content01" style="display: visible; height:130px">
				<ul>
				    <c:forEach var="result" items="${notiList}" varStatus="status">
				        <li>
				            <div class="boardtext">
				            <a href="<c:url value='/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA'/>">
				            <c:if test="${result.replyLc!=0}">
                                <c:forEach begin="0" end="${result.replyLc}" step="1">
                                    &nbsp;
                                </c:forEach>
                                <img src="<c:url value='/images/reply_arrow.gif'/>" alt="reply arrow"/>
                            </c:if>
                            <c:choose>
                                <c:when test="${result.isExpired=='Y' || result.useAt == 'N'}">
                                    <c:out value="${result.nttSj}" />
                                </c:when>
                                <c:otherwise>
                                    <c:out value="${result.nttSj}" />
                                </c:otherwise>
                            </c:choose>
				            </a></div>
				            <div class="date"><c:out value="${result.frstRegisterPnttm}"/></div></li>
				    </c:forEach>
				</ul>
			</div>
			<div id="content02" style="display:none;">
				<ul>
					<li><div class="boardtext"><a href="#LINK">7월보안점검행사안내입니다(행사장소:표준프레임워크 1층 로비) </a></div><div class="date">2011-07-29</div></li>
				</ul>
			</div>
			<div id="faq_div">
				<div class="faq_img1">
				    <img alt="FAQ목록" src="<c:url value='/'/>images/header/img_middlecontent_title02.gif" />
				    <span class="btn_more_board">
				    <a href="<c:url value='/uss/olh/faq/FaqListInqire.do' />">
				        <img src="<c:url value='/'/>images/header/bg_more.gif" alt="FAQ더보기"/>
				    </a>
				    </span>
				</div>
				<div class="faq_img2"><img alt="프레임워크 경량화 서비스에 대해 자주 사용하는 질문 등에 대한 일반적인 답변들을 확인할 수 있습니다." src="<c:url value='/'/>images/header/img_middlecontent_subtitle.gif" /></div>
				<c:forEach var="result" items="${faqList}" varStatus="status">
				<div class="faq_list">
					<ul>
						<li class="q"><a href="<c:url value='/uss/olh/faq/FaqListInqire.do' />"><c:out value="${result.qestnSj}"/></a></li>
						<li class="a"><c:out value="${fn:substring(fn:escapeXml(result.answerCn), 0, 70)}" /></li>
					</ul>
				</div>
				</c:forEach>
			</div>
		</div>
		<!-- //중간 영역 끝 -->
		<div id="rightcontent_wrap">
			<div id="download_div">
				<div class="download_img">
				    <a href="<c:url value='/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_BBBBBBBBBBBB'/>">
				    <img alt="최신게시물 목록" src="<c:url value='/'/>images/header/img_rightcontent_title01.gif" />
				    </a>
				</div>
				<ol>
				    <c:set var="index" value="1"/>
				    <c:forEach var="result" items="${bbsList}" varStatus="status">
				    <li><img src="<c:url value='/'/>images/header/num0${index}.gif" alt="" />
				        <a href="<c:url value='/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_BBBBBBBBBBBB'/>">
				        <c:out value="${fn:substring(fn:escapeXml(result.nttSj), 0, 18)}" />
				        </a>
				    </li>
				    <c:set var="index" value="${index+1}"/>
                    </c:forEach>
                    <c:if test="${fn:length(bbsList) == 0}" >
                        <li>최신 게시물이 없습니다.</li>
                    </c:if>
				</ol>
			</div>
			<div id="banner_div">
			    <div class="bnpadtop">링크</div>
				<div class="bnpadding"><a href="http://www.mois.go.kr/" target="_blank"><img src="<c:url value='/'/>images/header/banner_mois.png" alt="행정안전부" /></a></div>
				<div class="bnpadding"><a href="http://www.nia.or.kr/" target="_blank"><img src="<c:url value='/'/>images/header/banner_nia_2020.png" alt="NIA 한국지능정보사회진흥원" /></a></div>
				<div class="bnpadding"><a href="http://www.egovframe.go.kr/" target="_blank"><img src="<c:url value='/'/>images/header/banner_egovportal.gif" alt="전자정부표준프레임워크 포털" /></a></div>
				<div class="bnpadding"><a href="http://open.egovframe.go.kr/" target="_blank"><img src="<c:url value='/'/>images/header/banner_opencmm.gif" alt="오픈커뮤니티" /></a></div>
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
<%

%>