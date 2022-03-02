<%--
  Class Name : EgovQustnrRespondInfoRegist.jsp
  Description : 설문조사 등록 페이지
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
<c:set var="ImgUrl" value="<c:url value='/images_old/'/>"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%pageContext.setAttribute("crlf", "\r\n"); %>
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
	location.href = "<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageList.do'/>";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_QustnrRespondInfo(){
	var varFrom = document.qustnrRespondInfoManage;

	//설문응답자  Validtation

	if(varFrom.sexdstnCode.selectedIndex == 0){
		alert('설문응답자정보 성별을  택해주세요!');
		varFrom.sexdstnCode.focus();
		return;
	}else if(varFrom.occpTyCode.selectedIndex == 0){
		alert('설문응답자정보 직업을 선택해주세요!');
		varFrom.occpTyCode.focus();
		return;
	}else if(varFrom.brthYYYY.selectedIndex == 0){
		alert('설문응답자정보 생년월일(년)을 선택해주세요!');
		varFrom.brthYYYY.focus();
		return;
	}else if(varFrom.brthMM.selectedIndex == 0){
		alert('설문응답자정보 생년월일(월)을 선택해주세요!');
		varFrom.brthMM.focus();
		return;
	}else if(varFrom.brthDD.selectedIndex == 0){
		alert('설문응답자정보 생년월일(일)을 선택해주세요!');
		varFrom.brthDD.focus();
		return;
	}else if(varFrom.respondNm.value == ""){
		alert('설문응답자정보 응답자명을 입력해주세요!');
		varFrom.respondNm.focus();
		return;
	}


	
	//설문정보 Validtation
	<c:forEach items="${Comtnqustnrqesitm}" var="QestmInfo" varStatus="status1">
	<c:if test="${QestmInfo.qestnTyCode ==  '1'}">	
	if((!fn_egov_selectBoxChecking("${QestmInfo.qestnrQesitmId}"))){
		alert('${status1.count}번 설문문항을 작성해 주세요!');
		document.getElementsByName("${QestmInfo.qestnrQesitmId}")[0].focus();
		return;
	}

		<c:forEach items="${Comtnqustnriem}" var="QestmItem" varStatus="status01">
		<c:if test="${QestmInfo.qestnrTmplatId eq QestmItem.qestnrTmplatId && QestmInfo.qestnrId eq QestmItem.qestnrId && QestmInfo.qestnrQesitmId eq QestmItem.qestnrQesitmId}">
		
			<c:if test="${QestmItem.etcAnswerAt eq  'Y'}">
			//기타답변을 선택했는체크
			if(fn_egov_RadioBoxValue("${QestmInfo.qestnrQesitmId}") == "${QestmItem.qustnrIemId}"){
				if(document.getElementById("ETC_${QestmItem.qustnrIemId}").value == ""){
					alert('${status1.count}번 설문문항 기타답변을 작성해주세요!');
					document.getElementById("ETC_${QestmItem.qustnrIemId}").focus();
					return;
				}
			}
			
			</c:if>
		</c:if>
		</c:forEach>
	</c:if>


	<c:if test="${QestmInfo.qestnTyCode ==  '2'}">
	if( document.getElementById("${QestmInfo.qestnrQesitmId}").value == "" ){ 
		//alert('${status1.count}. ${QestmInfo.qestnCn}       \n\n설문문항을 작성해 주세요!');
		alert('${status1.count}번 설문문항을 작성해 주세요!');
		document.getElementById("${QestmInfo.qestnrQesitmId}").focus();
		return;
	}
	</c:if>
	</c:forEach>
	
	
	if(confirm('<spring:message code="common.regist.msg" />')) {

		varFrom.brth.value = fn_egov_SelectBoxValue('brthYYYY') + "" + fn_egov_SelectBoxValue('brthMM') + "" + fn_egov_SelectBoxValue('brthDD');
		varFrom.action =  "<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageRegist.do'/>";
		varFrom.submit();
	}
}
/************************************************************************
//라디오박스 : 몇개선택했는데 체크해주는함수 
************************************************************************/
function fn_egov_checkbox_amout_max( sbName){
	var FLength= document.getElementsByName(sbName).length;

	var reuslt = false;
	var reusltCount = 0;
	for(var i=0; i < FLength; i++)
	{
		if(document.getElementsByName(sbName)[i].checked == true){
			reusltCount++;
		}
	}

	return reusltCount;
	
}
/************************************************************************
//라디오박스 : 최대선택건수 체크
************************************************************************/
function fn_egov_checkbox_amout( sbName, sbCount, sbObj){

	var FLength= document.getElementsByName(sbName).length;

	var reuslt = false;
	var reusltCount = 0;
	for(var i=0; i < FLength; i++)
	{
		if(document.getElementsByName(sbName)[i].checked == true){
			reusltCount++;
		}
	}

	if(reusltCount > sbCount){
	 	alert("최대선택건수 [" + sbCount + "]건을  초과하였습니다!" );
	 	sbObj.checked=false;
	 	return;
	}
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

/************************************************************************
//라디오박스 체크 박스
************************************************************************/
function fn_egov_RadioBoxValue(sbName)
{
	var FLength = document.getElementsByName(sbName).length;
	var FValue = "";
	for(var i=0; i < FLength; i++)
	{
		if(document.getElementsByName(sbName)[i].checked == true){
			FValue = document.getElementsByName(sbName)[i].value;
		}
	}
	
	return FValue;
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

								<form name="qustnrRespondInfoManage" method="post" action="#LINK">

                                <h1 class="tit_1">정보마당</h1>

                                <p class="txt_1">표준프레임워크 서비스, 이렇게 활용하십시오.</p>

                                <h2 class="tit_2">설문조사</h2>
                                
                                <h2 class="tit_3">설문참여(설문응답자 정보)</h2>

                                <div class="board_view2">
                                    <table>
                                        <colgroup>
                                            <col style="width: 140px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="">성별</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_130" for="sex">
                                                    <select id="sex" name="sexdstnCode" title="성별선택">
                                                        <option value="">선택</option>
                                                       	<c:forEach items="${comCode014}" var="comCodeList" varStatus="status">
                                                       	<option value="${comCodeList.code}" <c:if test="${comCodeList.code eq Emplyrinfo.sexdstnCode}">selected</c:if>>${comCodeList.codeNm}</option>
                                                       	</c:forEach>
                                                    </select>
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="">직업</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_130" for="job">
                                                    <select id="job" name="occpTyCode" title="직업">
                                                        <option value="">선택</option>
                                                        <c:forEach items="${comCode034}" var="comCodeList" varStatus="status">
													        <option value="${comCodeList.code}">${comCodeList.codeNm}</option>
													    </c:forEach> 
                                                    </select>
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="">생년월일</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_130" for="brthYYYY">
                                                    <select id="brthYYYY" name="brthYYYY" title="연도 선택">
                                                        <option value="">선택</option>
                                                        <c:forEach var="h" begin="1960" end="2021" step="1">
												            <option value="${h}" <c:if test="${fn:substring(Emplyrinfo.brth, 0, 4) ==  h}">selected</c:if>>${h}</option>
												          </c:forEach>
                                                    </select>
                                                </label>
                                                <span class="f_txt_inner mr10 ml10">년</span>
                                                <label class="f_select" for="brthMM">
                                                    <select id="brthMM" name="brthMM" title="월 선택">
                                                        <option value="">선택</option>
                                                        <c:forEach var="h" begin="1" end="12" step="1">
											            <c:choose>
											                <c:when test="${h < 10}">
											                <c:set var="brthMM" value="0${h}"/>
											                </c:when>
											                <c:otherwise>
											                <c:set var="brthMM" value="${h}"/>
											                </c:otherwise>
											            </c:choose>
											            <option value="<c:if test="${h < 10}">0</c:if>${h}" <c:if test="${fn:substring(Emplyrinfo.brth, 4, 6) ==  brthMM}">selected</c:if>><c:if test="${h < 10}">0</c:if>${h}</option>
											          </c:forEach>
                                                    </select>
                                                </label>
                                                <span class="f_txt_inner mr10 ml10">월</span>
                                                <label class="f_select" for="brthDD">
                                                    <select id="brthDD" name="brthDD" title="일 선택">
                                                        <option value="">선택</option>
                                                        <c:forEach var="h" begin="1" end="31" step="1">
												            <c:choose>
												                <c:when test="${h < 10}">
												                <c:set var="brthDD" value="0${h}"/>
												                </c:when>
												                <c:otherwise>
												                <c:set var="brthDD" value="${h}"/>
												                </c:otherwise>
												            </c:choose>
												            <option value="<c:if test="${h < 10}">0</c:if>${h}" <c:if test="${fn:substring(Emplyrinfo.brth, 6, 8) ==  brthDD}">selected</c:if>><c:if test="${h < 10}">0</c:if>${h}</option>
												          </c:forEach>
                                                    </select>
                                                </label>
                                                <span class="f_txt_inner ml10">일</span>
                                                
                                                <input name="brth" id="brth" type="hidden" value="">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="">응답자명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="respondNm" title="응답자명 입력" value="${Emplyrinfo.emplyrNm}" maxlength="50" class="f_txt" type="text" id="">
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <h2 class="tit_4">설문참여(설문정보)</h2>

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
                                                <c:out value="${fn:replace(Comtnqestnrinfo[0].qestnrSj , crlf , '<br/>')}" escapeXml="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                설문목적
                                            </td>
                                            <td>
                                                <c:out value="${fn:replace(Comtnqestnrinfo[0].qestnrPurps , crlf , '<br/>')}" escapeXml="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                설문작성<br>안내내용
                                            </td>
                                            <td>
                                                <c:out value="${fn:replace(Comtnqestnrinfo[0].qestnrWritngGuidanceCn , crlf , '<br/>')}" escapeXml="false" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                설문대상
                                            </td>
                                            <td>
                                                <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '1'}">학생</c:if>
									            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '2'}">대학생</c:if>
									            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '3'}">직장인</c:if>
									            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '4'}">군인</c:if>
									            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '5'}">교사</c:if>
									            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '6'}">기타</c:if>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                설문기간
                                            </td>
                                            <td>
                                                ${Comtnqestnrinfo[0].qestnrBeginDe} ~ ${Comtnqestnrinfo[0].qestnrEndDe}
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <div class="board_view4">
                                    <c:import charEncoding="utf-8" url="/uss/olp/qri/template/template.do" >
										<c:param name="templateUrl" value="${QustnrTmplatManage[0].qestnrTmplatCours}" />
									</c:import>
                                </div>

								<!-- 목록/저장버튼  시작-->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" onclick="fn_egov_save_QustnrRespondInfo(document.qustnrRespondInfoManage); return false;" class="btn btn_blue_46 w_100">저장</a><!-- 저장 -->
                                        <a href="<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageList.do'/>" class="btn btn_blue_46 w_100">목록</a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- 목록/저장버튼  끝-->
                                
                                
                                <input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="${qestnrTmplatId}">
								<input name="qestnrId" id="qestnrId" type="hidden" value="${qestnrId}">
								<input name="cmd" type="hidden" value="<c:out value='save'/>">
                                
                                <!--// 게시판 -->
                                
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