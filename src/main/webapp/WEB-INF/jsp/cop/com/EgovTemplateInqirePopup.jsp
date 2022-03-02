<%--
  Class Name : 
  Description : 
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.18   이삼섭          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.18
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images_old/egovframework/cop/com/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

<script type="text/javascript">
    function press(event) {
        if (event.keyCode==13) {
            fn_egov_select_tmplatInfo('1');
        }
    }
    function fn_egov_select_tmplatInfo(pageNo){
        document.frm.pageIndex.value = pageNo;
        document.frm.action = "<c:url value='/cop/com/selectTemplateInfsPop.do'/>";
        document.frm.submit();  
    }
    
    function fn_egov_returnTmplatInfo(tmplatId, tmplatNm){
    	
        var retVal = tmplatId +"|"+tmplatNm;
        
        parent.showModalDialogCallback(retVal);
    }
    
    /* ********************************************************
     * 취소처리
     ******************************************************** */
    function fn_egov_cancel_popup() {
    	parent.fn_egov_modal_remove();
    }

</script>
<title>템플릿 목록</title>

</head>
<body>

	<!-- 템플릿 정보 팝업 -->
    <div class="popup EgovTemplateInqirePopup" style="background-color: white;">
        <div class="pop_inner">
            <div class="pop_header">
                <h1>템플릿 목록</h1>
                <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>

            <div class="pop_container">
                <!-- 검색조건 -->
                <div class="condition">
                    <label class="item f_select" for="sel1">
                        <select id="sel1" name="searchCnd" title="검색조건" class="select">
                            <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >템플릿명</option>
                            <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >템플릿구분</option>
                        </select>
                    </label>

                    <span class="item f_search">
                        <input class="f_input w_500" name="searchWrd" type="text" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);" title="검색어 입력">
                        <button class="btn" type="submit" onclick="javascript:fn_egov_select_tmplatInfo('1'); return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
                    </span>

                </div>
                <!--// 검색조건 -->

                <!-- 게시판 -->
                <div class="board_list">
                    <table summary="번호, 템플릿명, 템플릿구분, 템플릿경로, 사용여부, 등록일자, 선택 목록입니다">
                    	<caption>템플릿목록관리</caption>
                        <colgroup>
                            <col style="width: 70px;">
                            <col style="width: 130px;">
                            <col style="width: 120px;">
                            <col style="width: auto;">
                            <col style="width: 100px;">
                            <col style="width: 150px;">
                            <col style="width: 100px;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">템플릿명</th>
                                <th scope="col">템플릿구분</th>
                                <th scope="col">템플릿경로</th>
                                <th scope="col">사용여부</th>
                                <th scope="col">등록일자</th>
                                <th scope="col">선택</th>
                            </tr>
                        </thead>
                        <tbody>
                        	
                        	<c:if test="${fn:length(resultList) == 0}">
                        		<tr>
                        			<td nowrap colspan="6" ><spring:message code="common.nodata.msg" /></td>
                        		</tr>
                        	</c:if>
                        	
                        	<c:forEach var="result" items="${resultList}" varStatus="status">
                            <tr>
                                <td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
                                <td><c:out value="${result.tmplatNm}"/></td>
                                <td><c:out value="${result.tmplatSeCodeNm}"/></td>
                                <td class="al"><c:out value="${result.tmplatCours}"/></td>
                                <td>
                                	<c:if test="${result.useAt == 'N'}"><spring:message code="button.notUsed" /></c:if>
                                	<c:if test="${result.useAt == 'Y'}"><spring:message code="button.use" /></c:if>
                                </td>
                                <td><c:out value="${result.frstRegisterPnttm}"/></td>
                                <td>
                                	<c:if test="${result.useAt == 'Y'}">
                                	<a href="#LINK" class="btn btn_blue_30 w_80" onClick="javascript:fn_egov_returnTmplatInfo('<c:out value="${result.tmplatId}"/>','<c:out value="${result.tmplatNm}"/>')">
                                		선택
                                	</a>
                                	</c:if>
                                </td>
                            </tr>
                            </c:forEach>
                            
                        </tbody>
                    </table>
                </div>

				<!-- 페이지 네비게이션 시작 -->
                <div class="board_list_bot">
                    <div class="paging" id="paging_div">
                        <ul>
                            <ui:pagination paginationInfo = "${paginationInfo}" type="renew" jsFunction="fn_egov_select_tmplatInfo" />
                        </ul>
                    </div>
                </div>
                <!-- // 페이지 네비게이션 끝 -->
                <!--// 게시판 -->
            </div>
        </div>
    </div>
    <!-- // 템플릿 정보 팝업 끝 -->
    
    <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
    
    </form>
    
</body>
</html>