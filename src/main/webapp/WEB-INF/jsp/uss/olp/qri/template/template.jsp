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
<c:set var="ImgUrl" value="/images_old/egovframework/com/uss/olp/qnn/"/>

<c:forEach items="${Comtnqustnrqesitm}" var="QestmInfo" varStatus="status1">
	<table>
		<!-- 설문 항목 제목 -->
		<tr>
			<td class="lb">
				<label for="">
					${status1.count}. <c:out value="${fn:replace(QestmInfo.qestnCn , crlf , '<br/>')}" escapeXml="false" />
					<c:if test="${QestmInfo.mxmmChoiseCo > 1}">
						<font color="red"><b>(최대선택건수 ${QestmInfo.mxmmChoiseCo})</b></font>
					</c:if>
				</label>
			</td>
		</tr>
		<!-- // 설문 항목 제목 끝 -->
		
		<!-- 설문 항목 내용 -->
		<tr>
			<!-- 객관식 -->
			<c:if test="${QestmInfo.qestnTyCode == '1'}">
				<td>
					<c:forEach items="${Comtnqustnriem}" var="QestmItem" varStatus="status01">
						<c:if test="${QestmInfo.qestnrTmplatId eq QestmItem.qestnrTmplatId && QestmInfo.qestnrId eq QestmItem.qestnrId && QestmInfo.qestnrQesitmId eq QestmItem.qestnrQesitmId}">

								<!-- 다중체크구현 로직 -->
								<c:if test="${QestmInfo.mxmmChoiseCo == '1'}">
									<input id="rdo1" type="radio" name="${QestmItem.qestnrQesitmId}" value="${QestmItem.qustnrIemId}">
									<c:out value="${fn:replace(QestmItem.iemCn , crlf , '<br/>')}" escapeXml="false" />
								</c:if>								
								<c:if test="${QestmInfo.mxmmChoiseCo > 1}">
									<input id="rdo1" type="checkbox" name="${QestmItem.qestnrQesitmId}" title="객관식 답변선택 여부" value="${QestmItem.qustnrIemId}" onClick="fn_egov_checkbox_amout('${QestmItem.qestnrQesitmId}', ${QestmInfo.mxmmChoiseCo}, this)">
									<c:out value="${fn:replace(QestmItem.iemCn , crlf , '<br/>')}" escapeXml="false" />
								</c:if>
								<!-- // 다중체크구현 로직 끝 -->
								
								<!-- 기타답변여부 -->
								<c:if test="${QestmItem.etcAnswerAt eq 'Y'}">
									<input name="ETC_${QestmItem.qustnrIemId}" id="ETC_${QestmItem.qustnrIemId}" title="기타답변내용" type="text" value="" maxlength="1000">
								</c:if>
								<c:if test="${QestmItem.etcAnswerAt eq 'N' || QestmItem.etcAnswerAt eq ''}">
									<input name="ETC_${QestmItem.qustnrIemId}" id="ETC_${QestmItem.qustnrIemId}" type="hidden" value="" maxlength="1000">
								</c:if>
								<!-- // 기타답변여부 끝 -->

						</c:if>
					</c:forEach>
				</td>
			</c:if>
			<!-- // 객관식 끝 -->
				
			<!-- 주관식 -->
			<c:if test="${QestmInfo.qestnTyCode == '2'}">
				<td>
					<textarea name="${QestmInfo.qestnrQesitmId}" id="${QestmInfo.qestnrQesitmId}" title="주관식 답변 내용" class="f_txtar w_full h_200" cols="30" rows="10"></textarea>
				</td>
			</c:if>
			<!-- // 주관식 끝 -->
		</tr>
		<!-- // 설문 항목 내용 끝 -->
	</table>
		
	<%-- 최대선택 건수 --%>
	<input type="hidden" name="MXMM_${QestmInfo.qestnrQesitmId}" value="${QestmInfo.mxmmChoiseCo}">
	<%-- 객관식/주관식  타입 --%>
	<input type="hidden" name="TY_${QestmInfo.qestnrQesitmId}" value="${QestmInfo.qestnTyCode}">
		
</c:forEach>