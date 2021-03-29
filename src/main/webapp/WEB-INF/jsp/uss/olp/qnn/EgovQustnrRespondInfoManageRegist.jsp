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
<c:set var="ImgUrl" value="<c:url value='/images/'/>"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%pageContext.setAttribute("crlf", "\r\n"); %>
<html>
<head>
<title>설문조사</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
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
	
	
	if(confirm("<spring:message code="common.save.msg" />")){

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
    <div id="title_img_div"><img src="<c:url value='/'/>images/title_image/img_title04.gif" alt="" /></div>
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
                            <li>정보마당</li>
                            <li>&gt;</li>
                            <li><strong>설문조사</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
			<form name="qustnrRespondInfoManage" method="post" action="#LINK">
			
            <!-- sub title start -->
            <div><h2>설문참여(설문응답자 정보)</h2></div>
            <!-- sub title end -->


            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">
					<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="이 표는 설문제목 정보를 제공하며, 성별, 직업, 생년월일, 응답자명, 설문정보 , 설문제목, 설문작성 안내내용, 설문대상, 설문기간 정보로 구성되어 있습니다 .">
					  <tr> 
					    <td class="td_width">성별<img src="<c:url value='/images/required.gif'/>" alt="필수항목" title="필수항목" width="15" height="15"></td>
					    <td class="td_content">
					       
							<select name="sexdstnCode" title="성별 선택">
							    <option value="">선택</option>
							    <c:forEach items="${comCode014}" var="comCodeList" varStatus="status">
							        <option value="${comCodeList.code}" <c:if test="${comCodeList.code eq Emplyrinfo.sexdstnCode}">selected</c:if>>${comCodeList.codeNm}</option>
							    </c:forEach>  
							</select>
					
					    </td>
					  </tr>
					  <tr> 
					    <td class="td_width">직업<img src="<c:url value='/images/required.gif'/>" alt="필수항목" title="필수항목" width="15" height="15"></td>
					    <td class="td_content">
					
							<select name="occpTyCode" title="직업 선택">
							    <option value="">선택</option>
							    <c:forEach items="${comCode034}" var="comCodeList" varStatus="status">
							        <option value="${comCodeList.code}">${comCodeList.codeNm}</option>
							    </c:forEach>  
							</select>
					
					    </td>
					  </tr>
					  <tr> 
					    <td class="td_width">생년월일<img src="<c:url value='/images/required.gif'/>" alt="필수항목" title="필수항목" width="15" height="15"></td>
					    <td class="td_content">
					       <select name="brthYYYY" id="brthYYYY" title="연도 선택">
					        <option value="">선택</option>
					         <c:forEach var="h" begin="1960" end="2011" step="1">
					            <option value="${h}" <c:if test="${fn:substring(Emplyrinfo.brth, 0, 4) ==  h}">selected</c:if>>${h}</option>
					          </c:forEach>
					       </select>년
					       
					       <select name="brthMM" id="brthMM" title="월 선택">
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
					       </select>월
					       <select name="brthDD" id="brthDD" title="일 선택">
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
					       </select>일
					       
					       <input name="brth" id="brth" type="hidden" value="">
					    </td>
					  </tr> 
					  
					  <tr>
					    <td class="td_width">응답자명<img src="<c:url value='/images/required.gif'/>" alt="필수항목" title="필수항목" width="15" height="15"></td>
					    <td class="td_content">
					        <input name="respondNm" type="text" title="응답자명 입력" size="73" value="${Emplyrinfo.emplyrNm}" maxlength="50" style="width:120px;">
					    </td>
					  </tr>
					</table>
                
                </div>
            </div>
            <!--detail area end -->
                
            <!-- sub title start -->
            <div><h2>설문참여(설문정보)</h2></div>
            <!-- sub title end -->
            
            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">
					<table>
					<tr> 
					    <td class="td_width">설문제목 :</td>
					    <td class="td_content">
					    <c:out value="${fn:replace(Comtnqestnrinfo[0].qestnrSj , crlf , '<br/>')}" escapeXml="false" />
					    </td>
					</tr>
					<tr> 
					    <td class="td_width">설문목적 :</td>
					    <td class="td_content">
					    <c:out value="${fn:replace(Comtnqestnrinfo[0].qestnrPurps , crlf , '<br/>')}" escapeXml="false" />
					    </td>
					</tr>
					<tr> 
					    <td class="td_width"> 설문작성 안내내용 :</td>
					    
					    <td class="td_content">
					    <c:out value="${fn:replace(Comtnqestnrinfo[0].qestnrWritngGuidanceCn , crlf , '<br/>')}" escapeXml="false" />
					    </td>
					</tr>
					<tr> 
					    <td class="td_width">
					        설문대상  :
					            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '1'}">학생</c:if>
					            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '2'}">대학생</c:if>
					            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '3'}">직장인</c:if>
					            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '4'}">군인</c:if>
					            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '5'}">교사</c:if>
					            <c:if test="${Comtnqestnrinfo[0].qestnrTrget ==  '6'}">기타</c:if>
					    </td>
					    <td class="td_content">
					        설문기간 :
					        ${Comtnqestnrinfo[0].qestnrBeginDe}~${Comtnqestnrinfo[0].qestnrEndDe}
					    </td>
					</tr>
					</table>    
                </div>
            </div>
            <!--detail area end -->

			<!-- 설문템플릿설정 -->
			<c:import charEncoding="utf-8" url="/uss/olp/qri/template/template.do" > 
			<c:param name="templateUrl" value="${QustnrTmplatManage[0].qestnrTmplatCours}" /> 
			</c:import>  

            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
                <a href="<c:url value='/uss/olp/qnn/EgovQustnrRespondInfoManageList.do'/>">목록</a>
                <input type="submit" value="저장" onclick="fn_egov_save_QustnrRespondInfo(document.qustnrRespondInfoManage); return false;"/>
            </div>
            </td></tr></table>
            <!-- 목록/저장버튼  끝-->
            
			<input name="qestnrTmplatId" id="qestnrTmplatId" type="hidden" value="${qestnrTmplatId}">
			<input name="qestnrId" id="qestnrId" type="hidden" value="${qestnrId}">
			<input name="cmd" type="hidden" value="<c:out value='save'/>">
			</form>

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