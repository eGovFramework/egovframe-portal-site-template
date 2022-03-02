<%--
  Class Name : EgovFaqDetailInqure.jsp
  Description : EgovFaqDetailInqure 화면
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
<title>샘플 포털 > 포털서비스관리 > 서비스관리 > FAQ관리</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_initl_faq(){

}

/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_inqire_faqlist() {

	document.FaqManageForm.action = "<c:url value='/uss/olh/faq/admin/FaqListInqire.do'/>";
	document.FaqManageForm.submit();
}

/* ********************************************************
 * 수정처리화면
 ******************************************************** */
function fn_egov_updt_faq(faqId){

	// Update하기 위한 키값(faqId)을 셋팅
	document.FaqManageForm.faqId.value = faqId;	
	document.FaqManageForm.action = "<c:url value='/uss/olh/faq/admin/FaqCnUpdtView.do'/>";
	document.FaqManageForm.submit();
}
function fn_egov_delete_faq(faqId){

	if	(confirm('<spring:message code="common.delete.msg" />')) {
		// Delete하기 위한 키값(faqId)을 셋팅
		document.FaqManageForm.faqId.value = faqId;	
		document.FaqManageForm.action = "<c:url value='/uss/olh/faq/FaqCnDelete.do'/>";
		document.FaqManageForm.submit();
	}
}

</script>
</head>

<body onLoad="fn_egov_initl_faq();">

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
                                        <li>포털서비스관리</li>
                                        <li><a href="">서비스관리</a></li>
                                        <li>FAQ관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="FaqManageForm" action="${pageContext.request.contextPath}/uss/olh/faq/admin/FaqCnUpdtView.do" method="post">

                                <h1 class="tit_1">포털서비스관리</h1>

                                <p class="txt_1">포털시스템에서 제공되는 서비스들에 대한 컨텐츠를 관리합니다.</p>
                                
                                <h2 class="tit_2">서비스관리</h2>

                                <h3 class="tit_3">FAQ관리</h3>

                                <!-- 게시판 상세보기 -->
                                <div class="board_view2">
                                    <div class="board_view_top">
                                        <div class="tit"><c:out value="${result.qestnSj}"/></div><!-- 제목 -->
                                        <div class="info">
                                            <dl>
                                                <dt>등록일자</dt>
                                                <dd><c:out value="${result.lastUpdusrPnttm}"/></dd>
                                            </dl>
                                            <dl>
                                                <dt>조회수</dt>
                                                <dd><c:out value="${result.inqireCo}"/></dd>
                                            </dl>
                                        </div>
                                    </div>

                                    <div class="board_article_faq">
                                        <span class="q">Q</span>
										<textarea id="qestnCn" name="qestnCn" class="textarea"  cols="30" rows="10" readonly="readonly" title="질문내용"><c:out value="${result.qestnCn}"/></textarea>
                                    </div>

                                    <div class="board_article_faq">
                                        <span class="a">A</span>
										<textarea id="answerCn" name="answerCn" class="textarea" cols="30" rows="10" readonly="readonly" title="답변내용"><c:out value="${result.answerCn}"/></textarea>
                                    </div>

									<!-- 첨부파일목록 시작 -->
                                    <div class="board_attach">
                                    <c:if test="${not empty result.atchFileId}">
                                        <dl>
                                            <dt>첨부</dt>
                                            <dd>
                                            	<c:import charEncoding="utf-8" url="/cmm/fms/selectFileInfs.do" >
								                    <c:param name="param_atchFileId" value="${result.atchFileId}" />
								                </c:import>
                                            </dd>
                                        </dl>
                                    </c:if>
                                    </div>
                                    <!-- /첨부파일목록 끝 -->

									<!-- 목록/저장버튼  시작-->
                                    <div class="board_view_bot">
                                        <div class="left_col btn3">
                                            <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="fn_egov_updt_faq('<c:out value="${result.faqId}"/>'); return false;"><spring:message code="button.update" /></a><!-- 수정 -->
                                            <a href="<c:url value='/uss/olh/faq/admin/FaqCnDelete.do'/>?faqId=<c:out value='${result.faqId}'/>" class="btn btn_skyblue_h46 w_100" onclick="fn_egov_delete_faq('<c:out value="${result.faqId}"/>'); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                        </div>

                                        <div class="right_col btn1">
                                            <a href="<c:url value='/uss/olh/faq/admin/FaqListInqire.do'/>" class="btn btn_blue_46 w_100" onclick="fn_egov_inqire_faqlist(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                        </div>
                                    </div>
                                    <!-- 목록/저장버튼  끝-->
                                </div>
                                <!-- 게시판 상세보기 -->
                                
                                <input name="faqId" type="hidden" value="">
                                
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