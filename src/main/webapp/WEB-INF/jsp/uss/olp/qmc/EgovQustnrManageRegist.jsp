<%--
  Class Name : EgovQustnrManageRegist.jsp
  Description : 설문관리 등록 페이지
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.09
   
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="ImgUrl" value="/images_old/egovframework/com/uss/olp/qmc/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>샘플 포털 > 포털서비스관리 > 설문관리 > 설문지</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">

<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js' />"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>

<validator:javascript formName="qustnrManageVO" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javaScript" language="javascript">


/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrManage(){
    // 시작일자, 종료일자
    if (document.qustnrManageVO.qestnrBeginDe.value == "" && document.qustnrManageVO.qestnrEndDe.value == "") {
        var now = new Date();
        var year= now.getFullYear();
        var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
        var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
        var toDay = year + "-" + mon + "-" + day;
        
        document.qustnrManageVO.qestnrBeginDe.value = toDay;
        document.qustnrManageVO.qestnrEndDe.value = toDay;
    } else if (document.qustnrManageVO.qestnrBeginDe.value != "" && document.qustnrManageVO.qestnrBeginDe.value != "") {
        var fromDate = document.qustnrManageVO.qestnrBeginDe.value;
        var toDate = document.qustnrManageVO.qestnrEndDe.value;
        document.qustnrManageVO.qestnrBeginDe.value = fromDate.substring(0, 4) + "-" + fromDate.substring(4, 6) + "-" + fromDate.substring(6, 8);
        document.qustnrManageVO.qestnrEndDe.value = toDate.substring(0, 4) + "-" + toDate.substring(4, 6) + "-" + toDate.substring(6, 8);
    }
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_QustnrManage(){
	location.href = "<c:url value='/uss/olp/qmc/EgovQustnrManageList.do'/>";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_QustnrManage(){
	var form = document.qustnrManageVO;
	
	var sStartDay = form.qestnrBeginDe.value.replaceAll("-","");
	var sEndDay = form.qestnrEndDe.value.replaceAll("-","");
	
	var iStartDay = parseInt(sStartDay);
	var iEndDay = parseInt(sEndDay);
	
	if(confirm("<spring:message code="common.save.msg" />")){
		if(!validateQustnrManageVO(form)){
			return;
		}else{
			if(iStartDay > iEndDay || iEndDay < iStartDay){
				alert("설문기간  시작일은 종료일  보다 클수 없고 \n\n설문기간 종료일은 시작일 보다 작을수 없습니다!");
				return;
			}
			form.submit();
		}
	}
}

/* ********************************************************
* PROTOTYPE JS FUNCTION
******************************************************** */
String.prototype.trim = function(){
	return this.replace(/^\s+|\s+$/g, "");
}

String.prototype.replaceAll = function(src, repl){
	 var str = this;
	 if(src == repl){return str;}
	 while(str.indexOf(src) != -1) {
	 	str = str.replace(src, repl);
	 }
	 return str;
}

/* ********************************************************
 * 달력
 ******************************************************** */
function fn_egov_init_date(){
	
	$("#qestnrBeginDe").datepicker(
	        {dateFormat:'yy-mm-dd'
	         , showOn: 'button'
	         , buttonImage: '<c:url value='/images/ico_calendar.png'/>'
	         , buttonImageOnly: true
	         
	         , showMonthAfterYear: true
	         , showOtherMonths: true
		     , selectOtherMonths: true
		     , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
				
	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});

	$("#qestnrEndDe").datepicker( 
	        {dateFormat:'yy-mm-dd'
	         , showOn: 'button'
	         , buttonImage: '<c:url value='/images/ico_calendar.png'/>'
	         , buttonImageOnly: true
	         
	         , showMonthAfterYear: true
	         , showOtherMonths: true
		     , selectOtherMonths: true
		     , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
				
	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});
}
</script>
</head>

<style type="text/css">
.ui-datepicker-trigger {
	margin-left: 10px;
	vertical-align: middle;
}
</style>

<body onLoad="fn_egov_init_QustnrManage(); fn_egov_init_date();">

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
                                        <li><a href="">설문관리</a></li>
                                        <li>설문지</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="qustnrManageVO" name="qustnrManageVO">

                                <h1 class="tit_1">포털서비스관리</h1>

                                <p class="txt_1">포털시스템에서 제공되는 서비스들에 대한 컨텐츠를 관리합니다.</p>

                                <h2 class="tit_2">설문관리</h2>

                                <h3 class="tit_3">설문지</h3>

                                <div class="board_view2">
                                    <table>
                                    	<caption>등록 을 제공한다</caption>
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="qestnrSj">설문제목</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="qestnrSj" class="f_txt w_full" maxlength="250" title="설문제목 입력"/>
                                                <form:errors path="qestnrSj"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="qestnrPurps">설문목적</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:textarea path="qestnrPurps" class="f_txtar w_full h_80" rows="30" cols="10" title="설문목적 입력"/>
                                                <form:errors path="qestnrPurps"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="qestnrWritngGuidanceCn">설문작성<br>안내내용</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:textarea path="qestnrWritngGuidanceCn" class="f_txtar w_full h_80" rows="30" cols="10" title="설문작성안내 내용 입력"/>
                                                <form:errors path="qestnrWritngGuidanceCn"/> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="qestnrTrget">설문대상</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select" for="qestnrTrget">
                                                    <form:select path="qestnrTrget" title="설문대상 선택">
                                                    	<option value="">선택</option>
                                                    	<form:options items="${comCode034}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                    <form:errors path="qestnrTrget"/> 
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="qestnrBeginDe">설문기간</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input type="text" name="qestnrBeginDe" id="qestnrBeginDe" class="f_date" maxlength="10" value="<c:out value='${resultInfo.qestnrBeginDe}'/>" title="시작일자입력" />&nbsp ~ &nbsp
                                                <input type="text" name="qestnrEndDe" id="qestnrEndDe" class="f_date" maxlength="10" value="<c:out value='${resultInfo.qestnrEndDe}'/>" title="시작일자입력" title="종료일자입력" >
                                                <form:errors path="qestnrBeginDe"/>
                                                <form:errors path="qestnrEndDe"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                               	 템플릿 유형
                                                <span class="req">필수</span>
                                            </td>
                                            <td class="rdoSet"><!-- 2개이상 radio 있을때 필요 -->
                                            	<c:forEach items="${listQustnrTmplat}" var="resultQustnrTmplat" varStatus="status">
                                                	<img class="vam mr5" src="<c:url value='/'/>uss/olp/qtm/EgovQustnrTmplatManageImg.do?qestnrTmplatId=${resultQustnrTmplat.qestnrTmplatId}" alt="템플릿유형 이미지" title="템플릿유형 이미지" style="width: 65px; height: 50px;">
	                                                
	                                                    <input type="radio" name="qestnrTmplatId" value="<c:out value='${resultQustnrTmplat.qestnrTmplatId}'/>" checked>
	                                                    <c:out value='${resultQustnrTmplat.qestnrTmplatTy}'/>
	                                                
                                                </c:forEach>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  시작-->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onClick="fn_egov_save_QustnrManage(); return false;">저장</a><!-- 저장 -->
                                        <a href="<c:url value='/uss/olp/qmc/EgovQustnrManageList.do'/>" class="btn btn_blue_46 w_100">목록</a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- 목록/저장버튼  끝-->
                                
                                <input name="cmd" type="hidden" value="<c:out value='save'/>">
                                <input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>">
                                </form:form>
                                
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