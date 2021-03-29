<%--
  Class Name : EgovUserManage.jsp
  Description : 사용자관리(조회,삭제) JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.02  JJY          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 JJY
    since    : 2009.03.02
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<title>회원 목록</title>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnCheckAll() {
    var checkField = document.listForm.checkField;
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}
function fnDeleteUser() {
    var checkField = document.listForm.checkField;
    var id = document.listForm.checkId;
    var checkedIds = "";
    var checkedCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedIds += ((checkedCount==0? "" : ",") + id[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkedIds = id.value;
            }
        }
    }
    if(checkedIds.length > 0) {
    	//alert(checkedIds);
        if(confirm("<spring:message code="common.delete.msg" />")){
        	document.listForm.checkedIdForDel.value=checkedIds;
            document.listForm.action = "<c:url value='/uss/umt/mber/EgovMberDelete.do'/>";
            document.listForm.submit();
        }
    }
}
function fnSelectUser(id) {
	document.listForm.selectedId.value = id;
	array = id.split(":");
	if(array[0] == "") {
	} else {
	    userTy = array[0];
	    userId = array[1];    
	}
	document.listForm.selectedId.value = userId;
    document.listForm.action = "<c:url value='/uss/umt/mber/EgovMberSelectUpdtView.do'/>";
    document.listForm.submit();
}
function fnAddUserView() {
    document.listForm.action = "<c:url value='/uss/umt/mber/EgovMberInsertView.do'/>";
    document.listForm.submit();
}
function fnLinkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/umt/mber/EgovMberManage.do'/>";
    document.listForm.submit();
}
function fnSearch(){
	document.listForm.pageIndex.value = 1;
	document.listForm.action = "<c:url value='/uss/umt/mber/EgovMberManage.do'/>";
    document.listForm.submit();
}
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>
//-->
</script>
</head>
<body>
<!-- login status start -->
<div id="login_area"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncTborder" /></div>
<!-- //login status end -->
<!-- wrap start -->
<div id="wrap"> 
    <!-- header start -->
    <div id="subheader"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>  
    <!-- //header end -->
    <!--  타이틀 이미지 시작 -->
    <div id="title_img_div"><img src="<c:url value='/'/>images/title_image/img_title06.gif" alt="" /></div>
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
                            <li>포털시스템관리</li>
                            <li>&gt;</li>
                            <li>사용자관리</li>
                            <li>&gt;</li>
                            <li><strong>회원관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
        
        
            <!-- sub title start -->
            <div><h2>일반회원관리</h2></div>
            <!-- sub title end -->
            
	        <!-- content start -->
	        <form name="listForm" action="/uss/umt/mber/EgovMberManage.do" method="post">
	        <input name="selectedId" type="hidden" />
	        <input name="checkedIdForDel" type="hidden" />
	        <input name="pageIndex" type="hidden" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
	        
	        <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >                   
                    <select name="sbscrbSttus" id="sbscrbSttus" title="조회조건1">
                        <option value="0" <c:if test="${empty userSearchVO.sbscrbSttus || userSearchVO.sbscrbSttus == '0'}">selected="selected"</c:if> >상태(전체)</option>
                        <option value="A" <c:if test="${userSearchVO.sbscrbSttus == 'A'}">selected="selected"</c:if> >가입신청</option>
                        <option value="D" <c:if test="${userSearchVO.sbscrbSttus == 'D'}">selected="selected"</c:if> >삭제</option>
                        <option value="P" <c:if test="${userSearchVO.sbscrbSttus == 'P'}">selected="selected"</c:if> >승인</option>
                        </select>
                    <select name="searchCondition" id="searchCondition" title="조회조건2">
                        <option value="0" <c:if test="${userSearchVO.searchCondition == '0'}">selected="selected"</c:if> >ID</option>
                        <option value="1" <c:if test="${empty userSearchVO.searchCondition || userSearchVO.searchCondition == '1'}">selected="selected"</c:if> >Name</option>
                    </select>
                    <input name="searchKeyword" id="searchKeyword" title="검색" type="text" value="<c:out value="${userSearchVO.searchKeyword}"/>" />
                </div>
                <div class="search_buttons">
                    <!-- 검색 -->
                    <input type="submit" value="<spring:message code="button.search" />" onclick="fnSearch(); return false;" />
                    <!-- 삭제 -->
                    <a href="#LINK" onclick="fnDeleteUser(); return false;"><spring:message code="button.delete" /></a>
                    <!-- 목록 -->
                    <a href="<c:url value='/uss/umt/mber/EgovMberManage.do'/>" ><spring:message code="button.list" /></a>
                    <!-- 등록 -->
                    <a href="<c:url value='/uss/umt/mber/EgovMberInsertView.do'/>" onclick="fnAddUserView(); return false;"><spring:message code="button.create" /></a>
                </div>
                </div> 
            </div>
            <!-- search area end -->
            
	        <div>사용자수 <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong></div>

            <!-- search result start -->
            <div class="search_result_div">
            
                <table width="98%" cellpadding="0" cellspacing="0" summary="회원목록">
                <caption>회원목록</caption>
                
                <colgroup>
                    <col width="5%" > 
                    <col width="5%" >  
                    <col width="10%" >
                    <col width="10%" >
                    <col width="15%" > 
                    <col width="15%" >  
                    <col width="20%" >
                    <col width="20%" >
                </colgroup>
                
                <thead>
                <tr>      
                    <th class="title" scope="col">No.</th>
                    <th class="title" scope="col">
                        <input name="checkAll" type="checkbox" title="Check All" onclick="javascript:fnCheckAll();"/>
                    </th>
                    <th class="title" scope="col">아이디</th>
                    <th class="title" scope="col">사용자이름</th>
                    <th class="title" scope="col">사용자이메일</th>
                    <th class="title" scope="col">전화번호</th>
                    <th class="title" scope="col">등록일</th>
                    <th class="title" scope="col">가입상태</th>          
                </tr>
                </thead>
                
                <tbody>
                <c:if test="${fn:length(resultList) == 0}">
                <tr> 
                      <td class="lt_text3" colspan="8">
                          <spring:message code="common.nodata.msg" />
                      </td>
                </tr>                                                 
                </c:if>
                <c:forEach var="result" items="${resultList}" varStatus="status">
                    <tr>
                        <td class="lt_text3" ><c:out value="${status.count}"/></td>
                        <td class="lt_text3" >
                            <input name="checkField" title="checkField <c:out value="${status.count}"/>" type="checkbox"/>
                            <input name="checkId" type="hidden" value="<c:out value='${result.userTy}'/>:<c:out value='${result.uniqId}'/>"/>
                        </td>
                        <td class="lt_text3" style="cursor:pointer;cursor:hand" >
                            <span class="link"><a href="<c:url value='/uss/umt/mber/EgovMberSelectUpdtView.do'/>?selectedId=<c:out value="${result.uniqId}"/>"  onclick="javascript:fnSelectUser('<c:out value="${result.userTy}"/>:<c:out value="${result.uniqId}"/>'); return false;"><c:out value="${result.userId}"/></a></span>
                        </td>
                        <td class="lt_text3" ><c:out value="${result.userNm}"/></td>
                        <td class="lt_text3" ><c:out value="${result.emailAdres}"/></td>
                        <td class="lt_text3" ><c:out value="${result.areaNo}"/>)<c:out value="${result.middleTelno}"/>-<c:out value="${result.endTelno}"/></td>
                        <td class="lt_text3" ><c:out value="${result.sbscrbDe}"/></td>
                        <td class="lt_text3" >
                            <c:forEach var="entrprsMberSttus_result" items="${entrprsMberSttus_result}" varStatus="status">
                                <c:if test="${result.sttus == entrprsMberSttus_result.code}"><c:out value="${entrprsMberSttus_result.codeNm}"/></c:if>
                            </c:forEach>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
                  
                </table>
            </div>
            <!-- search result end -->
            
	        
	        <!--  page start -->
	        <div id="paging_div">
	                <div id="pagination"><ul class="paging_align">
	                <ui:pagination paginationInfo = "${paginationInfo}"
	                    type="image"
	                    jsFunction="fnLinkPage"
	                    /></ul>
	                </div>  
	        </div>
	        <br/>
	        <!--  page end -->
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
