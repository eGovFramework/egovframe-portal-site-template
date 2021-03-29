<%--
  Class Name : EgovStplatDetailInqire.jsp
  Description : EgovStplatDetailInqire 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01   박정규          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 박정규
    since    : 2009.02.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>약관 상세조회</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_inqire_stplatlist() {
	document.getElementById("StplatManageForm").action = "<c:url value='/uss/sam/stp/StplatListInqire.do'/>";
	document.getElementById("StplatManageForm").submit();
}

/* ********************************************************
 * 수정처리화면
 ******************************************************** */
function fn_egov_updt_stplatcn(useStplatId){
	// Update하기 위한 키값을 셋팅
	document.getElementById("StplatManageForm").useStplatId.value = useStplatId;
	document.getElementById("StplatManageForm").action = "<c:url value='/uss/sam/stp/StplatCnUpdtView.do'/>";
	document.getElementById("StplatManageForm").submit();	
}

 /* ********************************************************
  * 삭제처리
  ******************************************************** */
  function fn_egov_delete_stplatcn(useStplatId){
		if	(confirm("<spring:message code='common.delete.msg' />"))	{	
			// Delete하기 위한 키값을 셋팅
			document.getElementById("StplatManageForm").useStplatId.value = useStplatId;	
			document.getElementById("StplatManageForm").action = "<c:url value='/uss/sam/stp/StplatCnDelete.do'/>";
			document.getElementById("StplatManageForm").submit();
		}	
	}	
//-->
</script>
</head>

<body>
<!-- 자바스크립트 경고 태그  -->
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

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
                            <li>사용자관리</li>
                            <li>&gt;</li>
                            <li><strong>이용약관관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->

            <form id="StplatManageForm" name="StplatManageForm" action="<c:url value='/uss/sam/stp/StplatDetailInqire.do'/>" method="post">

            <!-- sub title start -->
            <div><h2>약관 상세조회</h2></div>
            <!-- sub title end -->
            
            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">                  
                    <table summary="이 표는 약관내용 대상 정보를 제공하며, 이용약관명, 이용약관내용, 정보제공동의내용 정보로 구성되어 있습니다 .">
                        <tr>
                            <td class="td_width">이용약관명<img src="<c:url value='/images/required.gif' />" alt="필수항목" title="필수항목" width="15" height="15"></td>
                            <td class="td_content">
                                <c:out value="${result.useStplatNm}"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_width">이용약관내용</td>
                            <td class="td_content">
                                <textarea id="useStplatCn" name="useStplatCn" class="textarea" title="이용약관내용 입력"  cols="100" rows="15" readonly><c:out value="${result.useStplatCn}"/></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_width">정보제공동의내용</td>
                            <td class="td_content">
                                <textarea id="infoProvdAgreCn" name="infoProvdAgreCn" class="textarea" title="정보제공동의내용 입력" cols="100" rows="15" readonly><c:out value="${result.infoProvdAgreCn}"/></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_width">등록일자</td>
                            <td class="td_content">
                                <c:out value="${result.lastUpdusrPnttm}"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!--detail area end -->
            
            <input name="useStplatId" type="hidden" value="<c:out value="${resultList[0].useStplatId}" />">
            <input name="cmd" type="hidden" value="">
            <div style="visibility:hidden;display:none;"><input name="iptSubmit" type="submit" value="전송" title="전송"></div>
            </form>
                            
            <!-- fucntion button start -->
            <div class="buttons" align="center" style="margin-bottom:100px">
                <a href="#LINK" onclick="fn_egov_updt_stplatcn('<c:out value="${result.useStplatId}"/>'); return false;"><spring:message code="button.update" /></a>
                <a href="#LINK" onclick="fn_egov_delete_stplatcn('<c:out value="${result.useStplatId}"/>'); return false;"><spring:message code="button.delete" /></a>
                <form name="formList" action="<c:url value='/uss/sam/stp/StplatListInqire.do'/>" method="post">
                <a href="<c:url value='/uss/sam/stp/StplatListInqire.do'/>" onclick="fn_egov_inqire_stplatlist(); return false;" type="submit"><spring:message code="button.list" /></a>
                <input type="submit" id="invisible" class="invisible"/>
                </form>
            </div>
            <!-- function button end -->
            
            </div><!-- contents end -->
        </div>
    </div>
    <!-- footer 시작 -->
    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
    <!-- //footer 끝 -->
</div>
<!-- //wrap end -->

</body>
</html>