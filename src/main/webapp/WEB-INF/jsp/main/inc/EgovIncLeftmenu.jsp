<%--
  Class Name : EgovIncLeftmenu.jsp
  Description : 좌메뉴 화면(include)
  Modification Information
 
       수정일              수정자              수정내용
    ----------  ----------   ---------------------------
    2011.08.31  JJY          경량환경 버전 생성
    2021.08.13  신용호         신규 디자인 적용 및 스크립트 수정
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="leftMenuNo" value="${empty sessionScope.menuNo ? 1000000 : sessionScope.menuNo}" />

<div class="nav">
	<div class="inner">

		<c:forEach var="result" items="${list_menulist}">
			<c:if test="${result.menuNo == leftMenuNo}">
				<h2><c:out value="${result.menuNm}"/></h2>
			</c:if>
		</c:forEach>

		<ul>
			<c:forEach var="result" items="${list_menulist}">
				<c:if test="${result.upperMenuId == leftMenuNo}">
					<li>
						<a href="<c:url value='${result.chkURL}'/>"><c:out value="${result.menuNm}"/></a>
						<ul>
							<c:forEach var="sub" items="${list_menulist}">
								<c:if test="${sub.upperMenuId == result.menuNo}">
									<li><a href="<c:url value='${sub.chkURL}'/>"><c:out value="${sub.menuNm}"/></a></li>
								</c:if>
							</c:forEach>
						</ul>
					</li>
				</c:if>
			</c:forEach>
		</ul>

	</div>
</div>
