<%--
  Class Name :
  Description :
  Modification Information

       수정일              수정자             수정내용
    ----------  ---------   ---------------------------
    2009.03.19  이삼섭             최초 생성
    2011.08.31  JJY         경량환경 버전 생성
    2021.08.12  신용호              신규 디자인 적용

    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.19
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images_old/egovframework/cop/bbs/" />

<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

<!-- <link rel="stylesheet" href="<c:url value='/'/>css_old/default.css" type="text/css" > -->


<script type="text/javascript">
<!--

	function fn_egov_addNotice() {
		document.frm.action = "<c:url value='/cop/bbs${prefix}/addBoardArticle.do'/>";
		document.frm.submit();
	}

	function fn_egov_select_noticeList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
		document.frm.submit();
	}

	function fn_egov_inqire_notice(nttId, bbsId) {
		//document.subForm.nttId.value = nttId;
		//document.subForm.bbsId.value = bbsId;
		//document.subForm.action = "<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>";
		//document.subForm.submit();
	}
//-->
</script>
<title>샘플 포털 > 알림마당 > <c:out value="${brdMstrVO.bbsNm}" /></title>

</head>
<body>
	<!-- wrap start -->
	<div id="wrap">
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
										<li><a href="">알림마당</a></li>
										<li><c:out value="${brdMstrVO.bbsNm}" /></li>
									</ul>
								</div>
								<!--// Location -->

								<h1 class="tit_1">알림마당</h1>

								<p class="txt_1">표준프레임워크센터에서 회원여러분들께 알려드리는 모든 소식을 모았습니다.</p>

								<h2 class="tit_2">
									<c:out value="${brdMstrVO.bbsNm}" />
								</h2>

								<!-- 검색조건 -->
								<div class="condition">
								
									<form name="frm" action="<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>" method="post">
										<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
										<input type="hidden" name="nttId" value="0" />
										<input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
										<input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
										<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
										<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>" />
									
										<label class="item f_select" for="sel1">
										<select name="searchCnd" id="searchCnd" title="검색조건 선택">
												<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>제목</option>
												<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>내용</option>
												<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if>>작성자</option>
										</select>
										</label>
										<span class="item f_search">
											<input class="f_input w_500" type="text" name="searchWrd" value='<c:out value="${searchVO.searchWrd}"/>' title="검색어 입력">
											<button class="btn" type="submit" onclick="fn_egov_select_noticeList('1'); return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
										</span>
										<c:if test="${brdMstrVO.authFlag == 'Y'}">
											<a href="<c:url value='/cop/bbs${prefix}/addBoardArticle.do?bbsId=${boardVO.bbsId}'/>" class="item btn btn_blue_46 w_100"><spring:message code="button.create" /></a><!-- 등록 -->
										</c:if>
									
									</form>
									
								</div>
								<!--// 검색조건 -->

								<!-- 게시판 -->
								<div class="board_list">
									<table>
										<colgroup>
											<col style="width: 80px;">
											<col style="width: auto;">
											<c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
												<col style="width: auto;">
												<col style="width: auto;">
											</c:if>
											<c:if test="${anonymous != 'true'}">
												<col style="width: 100px;">
											</c:if>
											<col style="width: 120px;">
											<col style="width: 100px;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">번호</th>
												<th scope="col">제목</th>
												<c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
													<th scope="col">게시시작일</th>
													<th scope="col">게시종료일</th>
												</c:if>
												<c:if test="${anonymous != 'true'}">
													<th scope="col">작성자</th>
												</c:if>
												<th scope="col">작성일</th>
												<th scope="col">조회수</th>
											</tr>
										</thead>
										<tbody>
											
											<c:if test="${empty resultList}">
                                        		<tr>
                                        			<td colspan="5"><spring:message code="common.nodata.msg" /></td>
                                        		</tr>
                                        	</c:if>
											
											<c:forEach var="result" items="${resultList}" varStatus="status">
												<tr>
													<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}" /></td>
													<td class="al">
														<form name="subForm" method="post" action="<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>">
															<c:if test="${result.replyLc!=0}">
																<c:forEach begin="0" end="${result.replyLc}" step="1">
																	&nbsp;
																</c:forEach>
																<img src="<c:url value='/'/>images/ico_reply.png" alt="reply arrow">
															</c:if>
															<c:choose>
																<c:when test="${result.isExpired=='Y' || result.useAt == 'N'}">
																	<c:out value="${result.nttSj}" />
																</c:when>
																<c:otherwise>
																	<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
																	<input type="hidden" name="nttId" value="<c:out value="${result.nttId}"/>" />
																	<input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
																	<input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
																	<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
																	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>" />
																	<a href="javascript:;" onclick="parentNode.submit();" class="lnk">
																		<c:out value="${result.nttSj}" />
																	</a>
																</c:otherwise>
															</c:choose>
														</form>
													</td>
													<c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
														<td><c:out value="${result.ntceBgnde}" /></td>
														<td><c:out value="${result.ntceEndde}" /></td>
													</c:if>
													<c:if test="${anonymous != 'true'}">
														<td>관리자</td>
													</c:if>
													<td>${result.frstRegisterPnttm}</td>
													<td>${result.inqireCo}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>

								<div class="board_list_bot">
									<div class="paging" id="paging_div">
										<ul>
											<ui:pagination paginationInfo="${paginationInfo}" type="renew" jsFunction="fn_egov_select_noticeList" />
										</ul>
									</div>
								</div>
								<!--// 게시판 -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<c:import url="/sym/mms/EgovFooter.do" />

	</div>


</body>
</html>