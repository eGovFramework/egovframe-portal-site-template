<%--
  Class Name : EgovQustnrRespondInfoManageStatistics.jsp
  Description : 설문지 통계
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
<c:set var="ImgUrl" value="/images_old/egovframework/com/uss/olp/qnn/"/>
<%pageContext.setAttribute("crlf", "\r\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>샘플 포털 > 정보마당 > 설문조사</title>
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
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrRespondInfo(){
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_QustnrRespondInfo(){
    location.href = "<c:url value='${returnUrl}'/>";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_QustnrRespondInfo(){
    
}

/************************************************************************
//셀렉트 박스 선택했는 찾는 함수
************************************************************************/

function fn_egov_selectBoxChecking(sbName){

    var FLength= document.getElementsByName(sbName).length;

    var reuslt = false;
    for(var i=0; i < FLength; i++)
    {
        if(document.getElementsByName(sbName)[i].checked == true){
            reuslt=true;
        }
    }
    
    return reuslt;
}
/************************************************************************
//셀렉트박스 값 컨트롤 함수
************************************************************************/
function fn_egov_SelectBoxValue(sbName)
{
var FValue = "";
for(var i=0; i < document.getElementById(sbName).length; i++)
{
if(document.getElementById(sbName).options[i].selected == true){

FValue=document.getElementById(sbName).options[i].value;
}
}

return  FValue;
}
</script>
</head>
<body onLoad="fn_egov_init_QustnrRespondInfo()">

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
                                        <li><a href="">정보마당</a></li>
                                        <li>설문조사</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="qustnrRespondInfoManage" action="#LINK" method="post">

                                <h1 class="tit_1">정보마당</h1>

                                <p class="txt_1">표준프레임워크 서비스, 이렇게 활용하십시오.</p>

                                <h2 class="tit_2">설문조사</h2>

                                <h3 class="tit_4">설문 통계</h3>

                                <div class="board_view2 txtonly">
                                    <table>
                                        <colgroup>
                                            <col style="width: 140px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                            	설문제목
                                            </td>
                                            <td>
                                            	<c:out value="${fn:replace(Comtnqestnrinfo[0].qestnrSj, crlf, '<br/>')}" escapeXml="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	설문목적
                                            </td>
                                            <td>
                                            	<c:out value="${fn:replace(Comtnqestnrinfo[0].qestnrPurps, crlf, '<br/>')}" escapeXml="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	설문작성<br>안내내용
                                            </td>
                                            <td>
                                            	<c:out value="${fn:replace(Comtnqestnrinfo[0].qestnrWritngGuidanceCn, crlf, '<br/>')}" escapeXml="true" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	설문대상
                                            </td>
                                            <td>
                                            	<c:if test="${Comtnqestnrinfo[0].qestnrTrget == '1'}">학생</c:if>
									            <c:if test="${Comtnqestnrinfo[0].qestnrTrget == '2'}">대학생</c:if>
									            <c:if test="${Comtnqestnrinfo[0].qestnrTrget == '3'}">직장인</c:if>
									            <c:if test="${Comtnqestnrinfo[0].qestnrTrget == '4'}">군인</c:if>
									            <c:if test="${Comtnqestnrinfo[0].qestnrTrget == '5'}">교사</c:if>
									            <c:if test="${Comtnqestnrinfo[0].qestnrTrget == '6'}">기타</c:if>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	설문기간
                                            </td>
                                            <td>
                                            	${Comtnqestnrinfo[0].qestnrBeginDe}~${Comtnqestnrinfo[0].qestnrEndDe}
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								
                                <div class="board_view3">
                                	<c:forEach items="${Comtnqustnrqesitm}" var="QestmInfo" varStatus="status1">
	                                    <table>
	                                        <colgroup>
	                                            <col style="width: 200px;">
	                                            <col style="width: auto;">
	                                        </colgroup>
	                                        <tr>
	                                            <td class="lb" colspan="2">
	                                            	<label for="">
	                                            		${status1.count}. <c:out value="${fn:replace(QestmInfo.qestnCn, crlf, '<br/>')}" escapeXml="true" />
	                                            	</label>
	                                            	<span class="req">필수</span>
	                                            </td>
	                                        </tr>
	                                        
	                                        <!-- 객관식 -->
	                                        <c:if test="${QestmInfo.qestnTyCode ==  '1'}">
	                                        	<!-- 설문항목 LOOP -->
									            <c:set var="chartCount" value="1" />
									            <c:forEach items="${Comtnqustnriem}" var="QestmItem" varStatus="status2">
									            <c:set var="chartCheck" value="0" />
									            	<tr>
									                	<!-- 해당 설문문항 AND 설문문항 체크 -->
									                	<c:if test="${QestmInfo.qestnrTmplatId eq QestmItem.qestnrTmplatId && QestmInfo.qestnrId eq QestmItem.qestnrId && QestmInfo.qestnrQesitmId eq QestmItem.qestnrQesitmId}">
				                                            <td class="writer">
				                                            	<c:out value="${fn:replace(QestmItem.iemCn, crlf, '<br/>')}" escapeXml="true" />
				                                            </td>
				                                            <td>
				                                            	<!-- 설문통계(객관식) LOOP -->
				                                            	<c:forEach items="${qestnrStatistic1}" var="QestmStatistic1" varStatus="status3">
				                                            		<c:if test="${QestmInfo.qestnrTmplatId eq QestmStatistic1.qestnrTmplatId && QestmInfo.qestnrId eq QestmStatistic1.qestnrId && QestmStatistic1.qestnrQesitmId eq QestmItem.qestnrQesitmId && QestmStatistic1.qustnrIemId eq QestmItem.qustnrIemId}">
				                                            			 ${QestmStatistic1.qustnrPercent}%
				                                            			<c:set var="chartCheck" value="${chartCheck+1}" />
				                                            		</c:if>
				                                            	</c:forEach>
				                                            	<c:if test="${chartCheck eq 0}">
				                                            		 0%
				                                            	</c:if>
				                                            </td>
				                                            <c:set var="chartCount" value="${chartCount+1}" />
	                                            		</c:if>
	                                            	</tr>
	                                            </c:forEach>
	                                        </c:if>
	                                        <!-- // 객관식 끝 -->
	                                        
                                            <!-- 주관식 -->
                                            <c:if test="${QestmInfo.qestnTyCode ==  '2'}">
                                            	<!-- 설문통계(주관식) LOOP -->
                                            	<c:forEach items="${qestnrStatistic2}" var="QestmStatistic2" varStatus="status4">
                                            		<tr>
	                                            		<c:if test="${QestmInfo.qestnrTmplatId eq QestmStatistic2.qestnrTmplatId && QestmInfo.qestnrId eq QestmStatistic2.qestnrId && QestmInfo.qestnrQesitmId eq QestmStatistic2.qestnrQesitmId}">
				                                            <td class="writer">
				                                            	<c:out value="${fn:replace(QestmStatistic2.respondNm, crlf, '<br/>')}" escapeXml="true" />
				                                            </td>
				                                            <td>
				                                            	<c:out value="${fn:replace(QestmStatistic2.respondAnswerCn, crlf, '<br/>')}" escapeXml="true" />
				                                            </td>
	                                            		</c:if>
                                            		</tr>
                                            	</c:forEach>
                                            </c:if>
	                                        <!-- // 주관식 끝 -->
	                                    </table>
	                                    
	                                    <input type="hidden" name="TY_${QestmInfo.qestnrQesitmId}" value="${QestmInfo.qestnTyCode}">
	                                    
                                    </c:forEach>
                                </div>
                                
								<!-- 목록/저장버튼  시작-->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_list_QustnrRespondInfo(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- 목록/저장버튼  끝-->
                                
                                <input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="${qestnrTmplatId}">
					            <input name="qestnrId" id="qestnrId" type="hidden" value="${qestnrId}">
					            
					            </form>
                                
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