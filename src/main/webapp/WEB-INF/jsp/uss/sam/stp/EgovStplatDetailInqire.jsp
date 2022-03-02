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
<title>샘플 포털 > 포털시스템관리 > 사용자관리 > 이용약관관리</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

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
                                        <li><a href="">포털시스템관리</a></li>
                                        <li><a href="">사용자관리</a></li>
                                        <li>이용약관관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

                                <h1 class="tit_1">포털시스템관리</h1>

                                <p class="txt_1">포털시스템의 사용자 및 권한에 대한 제반사항을 관리합니다.</p>

                                <h2 class="tit_2">사용자관리</h2>

                                <h3 class="tit_3">이용약관관리</h3>

                                <div class="board_view2">
                                
                                	<form id="StplatManageForm" name="StplatManageForm" action="<c:url value='/uss/sam/stp/StplatDetailInqire.do'/>" method="post">
                                
                                    <table summary="이 표는 약관내용 대상 정보를 제공하며, 이용약관명, 이용약관내용, 정보제공동의내용 정보로 구성되어 있습니다 .">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">이용약관명</span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.useStplatNm}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="useStplatCn">이용약관내용</label>
                                            </td>
                                            <td>
												<textarea id="useStplatCn" name="useStplatCn" class="f_txtar w_full h_200" title="이용약관내용 입력" cols="30" rows="10" readonly><c:out value="${result.useStplatCn}"/></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="infoProvdAgreCn">정보제공동의내용</label>
                                            </td>
                                            <td>
                                                <textarea id="infoProvdAgreCn" name="infoProvdAgreCn" class="f_txtar w_full h_200" title="정보제공동의내용 입력" cols="30" rows="10" readonly><c:out value="${result.infoProvdAgreCn}"/></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">등록일자</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.lastUpdusrPnttm}"/>
                                            </td>
                                        </tr>
                                    </table>
                                    
                                    <input name="useStplatId" type="hidden" value="<c:out value="${resultList[0].useStplatId}" />">
						            <input name="cmd" type="hidden" value="">
						            <div style="visibility:hidden;display:none;"><input name="iptSubmit" type="submit" value="전송" title="전송"></div>
						            </form>
                                    
                                </div>

								<!-- 목록/저장버튼  시작-->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="fn_egov_delete_stplatcn('<c:out value="${result.useStplatId}"/>'); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_updt_stplatcn('<c:out value="${result.useStplatId}"/>'); return false;"><spring:message code="button.update" /></a><!-- 수정 -->
                                        <form name="formList" action="<c:url value='/uss/sam/stp/StplatListInqire.do'/>" method="post" style="display: inline; margin-left: 10px;">
                                        	<a href="<c:url value='/uss/sam/stp/StplatListInqire.do'/>" class="btn btn_blue_46 w_100" onclick="fn_egov_inqire_stplatlist(); return false;" type="submit"><spring:message code="button.list" /></a><!-- 목록 -->
                                        </form>
                                    </div>
                                </div>
                                <!-- 목록/저장버튼  끝-->
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