<%--
  Class Name : template.jsp
  Description : 설문기본 템플릿
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images/egovframework/com/uss/olp/qnn/"/>

<c:forEach items="${Comtnqustnrqesitm}" var="QestmInfo" varStatus="status1">

    	<table width="100%" border="0" cellpadding="2" cellspacing="0">
    	<tr>
    		<td style="background-color:#E3E3E3;">
    		${status1.count}. <c:out value="${fn:replace(QestmInfo.qestnCn , crlf , '<br/>')}" escapeXml="false" />
    		<c:if test="${QestmInfo.mxmmChoiseCo >  1}"><font color="red"><b>(최대선택건수 ${QestmInfo.mxmmChoiseCo})</b></font></c:if>
    		</td>
    	</tr>
    	<tr>
    	<td style="padding:0px 0px 0px 0px;margin:0px 0px 0px 0px;background-color:#E3E3E3;">		    		
		    <%-- 객관식 --%>
		    <c:if test="${QestmInfo.qestnTyCode ==  '1'}">	
	    	<table border="0" cellpadding="0" cellspacing="0">
	    	<tr>
		    	<c:forEach items="${Comtnqustnriem}" var="QestmItem" varStatus="status01">
		    	<c:if test="${QestmInfo.qestnrTmplatId eq QestmItem.qestnrTmplatId && QestmInfo.qestnrId eq QestmItem.qestnrId && QestmInfo.qestnrQesitmId eq QestmItem.qestnrQesitmId}">
		    		<td style="background-color:#E3E3E3;">
		    		
		    		<%-- 다중체크구현 로직 --%>
		    		<c:if test="${QestmInfo.mxmmChoiseCo ==  '1'}">	
		    		<input type="radio" name="${QestmItem.qestnrQesitmId}" value="${QestmItem.qustnrIemId}" style="border:0px;"> <c:out value="${fn:replace(QestmItem.iemCn , crlf , '<br/>')}" escapeXml="false" />
		    		</c:if>
		    		
		    		<c:if test="${QestmInfo.mxmmChoiseCo >  1}">
		    		<input type="checkbox" name="${QestmItem.qestnrQesitmId}" title="객관식 답변선택 여부" value="${QestmItem.qustnrIemId}" onClick="fn_egov_checkbox_amout('${QestmItem.qestnrQesitmId}', ${QestmInfo.mxmmChoiseCo}, this)"><c:out value="${fn:replace(QestmItem.iemCn , crlf , '<br/>')}" escapeXml="false" />
		    		</c:if>
		    		<%-- 기타답변여부 --%>
		    		<c:if test="${QestmItem.etcAnswerAt eq  'Y'}">
		    		<input name="ETC_${QestmItem.qustnrIemId}" id="ETC_${QestmItem.qustnrIemId}" title="기타답변내용" type="text" size="73" value="" maxlength="1000" style="width:150px;">	
		    		</c:if>
		    		<c:if test="${QestmItem.etcAnswerAt eq  'N' || QestmItem.etcAnswerAt eq ''}">
		    		<input name="ETC_${QestmItem.qustnrIemId}" id="ETC_${QestmItem.qustnrIemId}" type="hidden" size="73" value="" maxlength="1000">
		    		</c:if>
		    		</td>
		    	</c:if>
		    	</c:forEach>
	    	</tr>
	    	</table>
	    	</c:if>
	    	
    		<%-- 주관식 --%>
    		<c:if test="${QestmInfo.qestnTyCode ==  '2'}">
    		<textarea name="${QestmInfo.qestnrQesitmId}" id="${QestmInfo.qestnrQesitmId}" title="주관식 답변 내용" class="textarea"  cols="75" rows="4"  style="width:99%;" ></textarea>
    		</c:if>
	    </td>
    	</tr>
    	</table>
	<%-- 최대선택 건수 --%>
	<input type="hidden" name="MXMM_${QestmInfo.qestnrQesitmId}" value="${QestmInfo.mxmmChoiseCo}">
	<%-- 객관식/주관식  타입 --%>
	<input type="hidden" name="TY_${QestmInfo.qestnrQesitmId}" value="${QestmInfo.qestnTyCode}">
</c:forEach>