<%--
  Class Name : EgovBoardUseInfInqire.jsp
  Description :  게시판  사용정보  조회화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.02   이삼섭          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.04.02
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
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

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardUseInf" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	function fn_egov_updt_bbsUseInf(){
		if (!validateBoardUseInf(document.boardUseInf)){
			return;
		}
		
		document.boardUseInf.action = "<c:url value='/cop/com/updateBBSUseInf.do'/>";
		document.boardUseInf.submit();
	}
	function fn_egov_select_bbsUseInfs(){
		document.boardUseInf.action = "<c:url value='/cop/com/selectBBSUseInfs.do'/>";
		document.boardUseInf.submit();		
	}
	
</script>
<title>샘플 포털 > 포털서비스관리 > 서비스관리 > 게시판사용관리</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

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
                                        <li><a href="">포털서비스관리</a></li>
                                        <li><a href="">서비스관리</a></li>
                                        <li>게시판사용관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="boardUseInf" method="post" action="<c:url value='/cop/com/updateBBSUseInf.do'/>">
								<div style="visibility:hidden;display:none;"><input name="iptSubmit" type="submit" value="전송" title="전송"></div>
								<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
								<input type="hidden" name="bbsId" value="<c:out value='${bdUseVO.bbsId}'/>" />
								<input type="hidden" name="trgetId" value="<c:out value='${bdUseVO.trgetId}'/>" />

                                <h1 class="tit_1">포털서비스관리</h1>

                                <p class="txt_1">포털시스템에서 제공되는 서비스들에 대한 컨텐츠를 관리합니다.</p>

                                <h2 class="tit_2">서비스관리</h2>
                                
                                <h3 class="tit_3">게시판사용관리</h3>

                                <div class="board_view2">
                                    <table summary="게시판명, 커뮤니티/ 동호회명, 사용여부  입니다">
                                        <colgroup>
                                            <col style="width: 200px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">게시판 명</span>
                                            </td>
                                            <td>
                                            	<c:out value="${bdUseVO.bbsNm}" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">커뮤니티/동호회 명</span>
                                            </td>
                                            <td>
                                            	<c:choose>
                                            		<c:when test="${not empty bdUseVO.cmmntyNm}">
                                            			<c:out value="${bdUseVO.cmmntyNm}" />
                                            		</c:when>
                                            		<c:when test="${not empty bdUseVO.clbNm}">
                                            			<c:out value="${bdUseVO.clbNm}" />
                                            		</c:when>
                                            		<c:otherwise>(시스템  활용)</c:otherwise>
                                            	</c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="useAt">사용여부</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td class="rdoSet"><!-- 2개이상 radio 있을때 필요 -->
                                                <label for="rdo1" class="mr30 <c:if test="${bdUseVO.useAt == 'Y'}"> on</c:if>">
                                                    <input type="radio" id="rdo1" name="useAt" class="radio2" value="Y" <c:if test="${bdUseVO.useAt == 'Y'}"> checked="checked"</c:if>>
                                                    사용
                                                </label>
                                                <label for="rdo2" class="<c:if test="${bdUseVO.useAt == 'N'}"> on</c:if>">
                                                    <input type="radio" id="rdo2" name="useAt" class="radio2" value="N" <c:if test="${bdUseVO.useAt == 'N'}"> checked="checked"</c:if>>
                                                    미사용
                                                </label>
                                                <br/><form:errors path="useAt" />
                                            </td>
                                        </tr>
                                        <c:choose>
                                        	<c:when test="${not empty bdUseVO.provdUrl}">
	                                        <tr>
	                                            <td class="lb">
	                                                <span class="min">제공 URL</span>
	                                            </td>
	                                            <td>
	                                                <a href="<c:url value="${bdUseVO.provdUrl}" />" target="_new" class="lnk">
	                                                	<c:url value="${bdUseVO.provdUrl}" />
	                                                </a>
	                                            </td>
	                                        </tr>
                                        	</c:when>
                                        </c:choose>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  시작-->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="<c:url value='/cop/com/updateBBSUseInf.do'/>" class="btn btn_blue_46 w_100" onclick="fn_egov_updt_bbsUseInf(); return false;">저장</a><!-- 저장 -->
                                        <a href="<c:url value='/cop/com/selectBBSUseInfs.do'/>" class="btn btn_blue_46 w_100" onclick="fn_egov_select_bbsUseInfs(); return false;">목록</a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- 목록/저장버튼  끝-->
                                
                                </form>
                                
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