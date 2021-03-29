<%--
  Class Name : govGroupSearch.jsp
  Description : govGroupSearch Search 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.23    lee.m.j          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 lee.m.j
    since    : 2009.03.23
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<title>그룹 정보</title>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fncManageChecked() {

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var returnValue = "";
    var checkCount = 0;
    var returnBoolean = false;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                	checkCount++;
                    checkField[i].value = checkId[i].value;
                    returnValue = checkField[i].value;
                }
            }

            if(checkCount > 1) {
                alert("하나 이상의 그룹이 선택되었습니다.");
                return;
            } else if(checkCount < 1) {
                alert("선택된 그룹이 없습니다.");
                return;
            }
        } else {
        	if(checkField.checked == true) {
        		returnValue = checkId.value;
        	} else {
                alert("선택된 그룹이 없습니다.");
                return;
            }
        }

        returnBoolean = true;

    } else {
    	alert("조회 결과가 없습니다.");
    }

    document.listForm.groupId.value = returnValue;

    return returnBoolean;
    
}

function fncSelectGroupList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
 // document.listForm.action = "<c:url value='/sec/gmt/EgovGroupSearchList.do'/>";
    document.listForm.submit();
}

function fncSelectGroup(groupId) {
 // window.returnValue = groupId;
    opener.listForm.searchKeyword.value = groupId;
    window.close();
}

function fncSelectGroupConfirm() {
	if(fncManageChecked()) {
		opener.listForm.searchKeyword.value = document.listForm.groupId.value;
     // window.returnValue = document.listForm.groupId.value;
		window.close();
	}
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
 // document.listForm.action = "<c:url value='/sec/gmt/EgovGroupSearchList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
    	fncSelectGroupList('1');
    }
}
//-->
</script>

</head>

<body>

        <div id="middle_content">
            <div id="content_field"><!--contents start-->
            
            <form name="listForm" action="<c:url value='/sec/gmt/EgovGroupSearchList.do'/>" method="post">
            
            <!-- sub title start -->
            <div><h2>그룹 조회 팝업</h2></div>
            <!-- sub title end -->
            
            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >그룹 명 : 
                    <input name="searchKeyword" type="text" value="<c:out value='${groupManageVO.searchKeyword}'/>" title="검색" onkeypress="press();" />
                </div>
                    <div class="search_buttons">
				      <input type="submit" value="조회" onclick="javascript:fncSelectGroupList('1')" class="btnNew" > 
				      <a href="#LINK" onclick="javascript:fncSelectGroupConfirm()" style="selector-dummy:expression(this.hideFocus=false);">확인</a> 
                    </div>
                </div> 
            </div>
            <!-- search area end -->
            
            <!-- search result start -->
            <div class="search_result_div_popup">
            
                <table width="98%" cellpadding="0" cellspacing="0" summary="그룹 조회 결과를  보여주는 테이블입니다.그룹 ID,그룹 명의 정보를 담고 있습니다.">
                <caption>그룹목록</caption>
                
                <colgroup>
                    <col width="5%" > 
                    <col width="15%" >
                    <col width="80%" >
                </colgroup>
                
                <thead>
                <tr>      
                    <th class="title" width="3%" scope="col" nowrap="nowrap"></th>  
				    <th class="title" width="15%" scope="col" nowrap="nowrap">그룹 ID</th>
				    <th class="title" width="25%" scope="col" nowrap="nowrap">그룹 명</th>
                </tr>
                </thead>
                
                <tbody>
                <c:if test="${fn:length(groupList) == 0}">
                <tr> 
                      <td class="lt_text3" colspan="3">
                          <spring:message code="common.nodata.msg" />
                      </td>
                </tr>                                                 
                </c:if>
				<c:forEach var="group" items="${groupList}" varStatus="status">
				<tr>
				    <td class="lt_text3" nowrap="nowrap"><input type="checkbox" name="delYn" class="check2" title="선택"><input type="hidden" name="checkId" value="<c:out value="${group.groupId}"/>" /></td>
				    <td class="lt_text" nowrap="nowrap"><a href="#LINK" onclick="javascript:fncSelectGroup('<c:out value="${group.groupId}"/>')"><c:out value="${group.groupId}"/></a></td>
				    <td class="lt_text" nowrap="nowrap"><c:out value="${group.groupNm}"/></td>
				</tr>
				</c:forEach>
                </tbody>
                  
                </table>
            </div>
            <!-- search result end -->
            
			
			
			<input type="hidden" name="groupId"/>
			<input type="hidden" name="groupIds"/>
			<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/>
			<input type="hidden" name="searchCondition"/>
			
			</form>

            </div><!-- contents end -->
        </div>
        <c:if test="${!empty groupManageVO.pageIndex }">
            <div id="paging_div">
                <ul class="paging_align">
                    <ui:pagination paginationInfo = "${paginationInfo}"
                        type="image"
                        jsFunction="linkPage"
                        /></ul>
            </div>
            </c:if>

</body>
</html>
