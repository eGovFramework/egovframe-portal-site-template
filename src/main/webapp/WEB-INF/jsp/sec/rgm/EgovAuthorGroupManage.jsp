<%--
  Class Name : EgovAuthorGroupManage.jsp
  Description : EgovAuthorGroupManage List 화면
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
<title>권한그룹 목록</title>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fncCheckAll() {
    var checkField = document.listForm.delYn;
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

function fncManageChecked() {

    var resultCheck = false;

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var selectAuthor = document.listForm.authorManageCombo;
    var booleanRegYn = document.listForm.regYn;
    var listMberTyCode = document.listForm.mberTyCode;
        
    var returnId = "";
    var returnAuthor = "";
    var returnRegYn = "";
    var returnmberTyCode = "";

    var checkedCount = 0;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedCount++;
                    checkField[i].value = checkId[i].value;
                    if(returnId == "") {
                        returnId = checkField[i].value;
                        returnAuthor = selectAuthor[i].value;
                        returnRegYn = booleanRegYn[i].value;
                        returnmberTyCode = listMberTyCode[i].value;
                    }
                    else {
                        returnId = returnId + ";" + checkField[i].value;
                        returnAuthor = returnAuthor + ";" + selectAuthor[i].value;
                        returnRegYn = returnRegYn + ";" + booleanRegYn[i].value;
                        returnmberTyCode = returnmberTyCode + ";" + listMberTyCode[i].value;
                        
                    }
                }
            }

            if(checkedCount > 0) 
                resultCheck = true;
            else {
                alert("선택된  항목이 없습니다.");
                resultCheck = false;
            }
            
        } else {
             if(document.listForm.delYn.checked == false) {
                alert("선택 항목이 없습니다.");
                resultCheck = false;
            }
            else {
                returnId = checkId.value;
                returnAuthor = selectAuthor.value;
                returnRegYn = booleanRegYn.value;
                returnmberTyCode = listMberTyCode.value;

                resultCheck = true;
            }
        } 
    } else {
        alert("조회된 결과가 없습니다.");
    }
    
    document.listForm.userIds.value = returnId;
    document.listForm.authorCodes.value = returnAuthor;
    document.listForm.regYns.value = returnRegYn;
    document.listForm.mberTyCodes.value = returnmberTyCode;
    return resultCheck;
}

function fncSelectAuthorGroupList(pageNo){
    //document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupList.do'/>";
    document.listForm.submit();
}

function fncAddAuthorGroupInsert() {

	if(!fncManageChecked()) return;
	
    if(confirm("등록하시겠습니까?")) {
        document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupInsert.do'/>";
        document.listForm.submit();
    }
}

function fncAuthorGroupDeleteList() {
 
	if(!fncManageChecked()) return;

    if(confirm("삭제하시겠습니까?")) {
        document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupDelete.do'/>";
        document.listForm.submit(); 
    }
}

function linkPage(pageNo){
    //document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/rgm/EgovAuthorGroupList.do'/>";
    document.listForm.submit();
}

function fncSelectAuthorGroupPop() {

    if(document.listForm.searchCondition.value == '3') {
    	window.open("<c:url value='/sec/gmt/EgovGroupSearchList.do'/>","notice","height=500, width=485, top=50, left=20, scrollbars=no, resizable=no");
    } else {
        alert("그룹을 선택하세요.");
        return;
    }
    
    /*
    var url = "<c:url value='/sec/gmt/EgovGroupSearchView.do'/>";
    var varParam = new Object();
    var openParam = "dialogWidth:500px;dialogHeight:485px;scroll:no;status:no;center:yes;resizable:yes;";
    var retVal;

    if(document.listForm.searchCondition.value == '3') {
        retVal = window.showModalDialog(url, varParam, openParam);
        if(retVal) {
            document.listForm.searchKeyword.value = retVal;
        }
    } else {
        alert("그룹을 선택하세요.");
        return;
    }
    */

}

function onSearchCondition() {
	document.listForm.searchKeyword.value = "";
	if(document.listForm.searchCondition.value == '3') {
        document.listForm.searchKeyword.readOnly = true;
	} else {
		document.listForm.searchKeyword.readOnly = false;
	}
}

function press() {

    if (event.keyCode==13) {
    	fncSelectAuthorGroupList('1');
    }
}
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
                            <li>사용자권한관리</li>
                            <li>&gt;</li>
                            <li><strong>사용자별권한관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
            <form:form name="listForm" action="<c:url value='/sec/rgm/EgovAuthorGroupList.do'/>" method="post">
            
            <!-- sub title start -->
            <div><h2>권한 그룹 관리</h2></div>
            <!-- sub title end -->
            
            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >조회조건 : 
                    <select name="searchCondition" onchange="onSearchCondition()" title="조회조건">
	                    <option value="1" <c:if test="${authorGroupVO.searchCondition == '1'}">selected</c:if> >사용자 ID</option>
	                    <option value="2" <c:if test="${authorGroupVO.searchCondition == '2'}">selected</c:if> >사용자 명</option>
	                    <option value="3" <c:if test="${authorGroupVO.searchCondition == '3'}">selected</c:if> >그룹</option>
                    </select>&nbsp;<input name="searchKeyword" type="text" value="<c:out value='${authorGroupVO.searchKeyword}'/>" size="25" title="검색" onkeypress="press();"/>
                </div>
                    <div class="search_buttons">
                        <a href="#LINK" onclick="javascript:fncSelectAuthorGroupPop()">팝업</a>
                        &nbsp;
				        <a href="#LINK" onclick="javascript:fncSelectAuthorGroupList('1')" style="selector-dummy:expression(this.hideFocus=false);">조회</a> 
				        <a href="#LINK" onclick="javascript:fncAddAuthorGroupInsert()" style="selector-dummy:expression(this.hideFocus=false);">등록</a> 
				        <a href="#LINK" onclick="javascript:fncAuthorGroupDeleteList()" style="selector-dummy:expression(this.hideFocus=false);">삭제</a> 
                    </div>
                </div> 
            </div>
            <!-- search area end -->
            
            <!-- search result start -->
            <div class="search_result_div">
            
                <table width="98%" cellpadding="0" cellspacing="0" summary="권한 그룹을 관리하는 테이블입니다.사용자 ID,사용자 명,사용자 유형,권한,등록 여부의 정보를 담고 있습니다.">
                <caption>권한그룹목록</caption>
                
                <colgroup>
                    <col width="5%" > 
                    <col width="10%" >
                    <col width="10%" >
                    <col width="10%" >
                    <col width="20%" >
                    <col width="10%" >
                </colgroup>
                
                <thead>
                <tr>      
				    <th><input type="checkbox" name="checkAll" title="선택여부" class="check2" onclick="javascript:fncCheckAll()"></th>  
				    <th>사용자 ID</th>
				    <th>사용자 명</th>
				    <th>사용자 유형</th>
				    <th>권한</th>
				    <th>등록 여부</th>
                </tr>
                </thead>
                
                <tbody>
                <c:if test="${fn:length(authorGroupList) == 0}">
                <tr> 
                      <td class="lt_text3" colspan="6">
                          <spring:message code="common.nodata.msg" />
                      </td>
                </tr>                                                 
                </c:if>
                
                <c:forEach var="authorGroup" items="${authorGroupList}" varStatus="status">
				<tr>
				    <td class="lt_text3" nowrap="nowrap"><input type="checkbox" name="delYn" class="check2" title="선택"><input type="hidden" name="checkId" value="<c:out value="${authorGroup.uniqId}"/>"/></td>
				    <td class="lt_text3" nowrap="nowrap"><c:out value="${authorGroup.userId}"/></td>
				    <td class="lt_text3" nowrap="nowrap"><c:out value="${authorGroup.userNm}"/></td>
				    <td class="lt_text3" nowrap="nowrap"><c:out value="${authorGroup.mberTyNm}"/><input type="hidden" name="mberTyCode" value="${authorGroup.mberTyCode}"/></td>
				    <td class="lt_text3" nowrap="nowrap"><select name="authorManageCombo" title="권한">
				            <c:forEach var="authorManage" items="${authorManageList}" varStatus="status">
				                <option value="<c:out value="${authorManage.authorCode}"/>" <c:if test="${authorManage.authorCode == authorGroup.authorCode}">selected</c:if> ><c:out value="${authorManage.authorNm}"/></option>
				            </c:forEach>
				        </select></td>
				    <td class="lt_text3" nowrap="nowrap"><c:out value="${authorGroup.regYn}"/><input type="hidden" name="regYn" value="<c:out value="${authorGroup.regYn}"/>"></td>
				</tr>
				</c:forEach>
                </tbody>
                  
                </table>
            </div>
            <!-- search result end -->
            
			<c:if test="${!empty authorGroupVO.pageIndex }">
			<div id="paging_div">
			    <ul class="paging_align">
			        <ui:pagination paginationInfo = "${paginationInfo}"
			            type="image"
			            jsFunction="linkPage"
			            /></ul>
			    <div align="right">
			        <input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly="readonly" title="메시지"/>
			    </div>
			</div>
			</c:if>
			
			<input type="hidden" name="userId"/>
			<input type="hidden" name="userIds"/>
			<input type="hidden" name="authorCodes"/>
			<input type="hidden" name="regYns"/>
			<input type="hidden" name="mberTyCodes"/>
			<input type="hidden" name="pageIndex" value="<c:out value='${authorGroupVO.pageIndex}'/>"/>
			
			</form:form>

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
