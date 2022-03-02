<%--
  Class Name : EgovAuthorRoleManage.jsp
  Description : EgovAuthorRoleManage 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01    lee.m.j          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 lee.m.j
    since    : 2009.02.01
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
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

<title>샘플 포털 > 포털시스템관리 > 사용자권한관리 > 권한관리</title>

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

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var checkRegYn = document.listForm.regYn;
    var returnValue = "";
    var returnRegYns = "";
    var checkedCount = 0;
    var returnBoolean = false;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                	checkedCount++;
                    checkField[i].value = checkId[i].value;
                
	                if(returnValue == "") {
	                    returnValue = checkField[i].value;
	                    returnRegYns = checkRegYn[i].value;
	                }
	                else { 
	                    returnValue = returnValue + ";" + checkField[i].value;
	                    returnRegYns = returnRegYns + ";" + checkRegYn[i].value;
	                }
                }
            }

            if(checkedCount > 0) 
            	returnBoolean = true;
            else {
                alert("선택된  롤이 없습니다.");
                returnBoolean = false;
            }
        } else {
        	 if(document.listForm.delYn.checked == false) {
                alert("선택된 롤이 없습니다.");
            	returnBoolean = false;
            }
            else {
            	returnValue = checkId.value;
                returnRegYns = checkRegYn.value;

                returnBoolean = true;
            }
        }
    } else {
        alert("조회된 결과가 없습니다.");
    }

    document.listForm.roleCodes.value = returnValue;
    document.listForm.regYns.value = returnRegYns;

    return returnBoolean;

}

function fncSelectAuthorRoleList() {
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = "1";
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthorRoleList.do'/>";
    document.listForm.submit();
}

function fncSelectAuthorList(){
   // document.listForm.searchCondition.value = "1";
   // document.listForm.pageIndex.value = "1";
    document.listForm.searchKeyword.value = "";
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthorList.do'/>";
    document.listForm.submit();
}

function fncSelectAuthorRole(roleCode) {
    document.listForm.roleCode.value = roleCode;
    document.listForm.action = "<c:url value='/sec/ram/EgovRole.do'/>";
    document.listForm.submit();     
}

function fncAddAuthorRoleInsert() {
	if(fncManageChecked()) {
	    if(confirm('<spring:message code="common.regist.msg" />')) {
            document.listForm.action = "<c:url value='/sec/ram/EgovAuthorRoleInsert.do'/>";
            document.listForm.submit();
	    }
	} else return;
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthorRoleList.do'/>";
    document.listForm.submit();
}


function press() {

    if (event.keyCode==13) {
    	fncSelectAuthorRoleList();
    }
}
-->
</script>

</head>

<body>

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
                                        <li><a href="">포털시스템관리</a></li>
                                        <li><a href="">사용자권한관리</a></li>
                                        <li>권한관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form name="listForm" action="<c:url value='/sec/ram/EgovAuthorRoleList.do'/>" method="post">

                                <h1 class="tit_1">포털시스템관리</h1>

                                <p class="txt_1">포털시스템의 사용자 및 권한에 대한 제반사항을 관리합니다.</p>

                                <h2 class="tit_2">사용자권한관리</h2>

                                <h3 class="tit_3">권한관리</h3>

                                <!-- 검색조건 -->
                                <div class="condition2">
                                    <label class="lb item" for="searchWord">권한코드: </label>

                                    <span class="item f_search">
                                        <input id="searchWord" class="f_input w_500" name="searchKeyword" type="text" value="<c:out value='${authorRoleManageVO.searchKeyword}'/>" title="검색" onkeypress="press();" readonly="readonly" />
                                    </span>
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <div class="board_list_top">
                                    <div class="left_col">
                                    </div>

                                    <div class="right_col">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fncSelectAuthorList()">목록(권한)</a><!-- 목록(권한) -->
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fncSelectAuthorRoleList()">새로고침</a><!-- 새로고침 -->
                                        <a href="#LINK" class="btn btn_blue_46 w_150" onclick="javascript:fncAddAuthorRoleInsert()">권한별 롤정보 저장</a><!-- 권한별 롤정보 저장 -->
                                    </div>
                                </div>

                                <div class="board_list">
                                    <table summary="권한 롤을 관리하는 테이블입니다.롤 ID,롤 명,롤 타입,롤 Sort,롤 설명,등록일자,등록여부의 내용을 담고 있습니다.">
                                    	<caption>권한별 롤 목록</caption>
                                        <colgroup>
                                            <col style="width: 70px;">
                                            <col style="width: 120px;">
                                            <col style="width: 120px;">
                                            <col style="width: 100px;">
                                            <col style="width: 100px;">
                                            <col style="width: auto;">
                                            <col style="width: 180px;">
                                            <col style="width: 120px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    <span class="f_chk_only chkAll">
                                                        <input type="checkbox" name="checkAll" title="전체선택" onclick="javascript:fncCheckAll()">
                                                    </span>
                                                </th>
                                                <th scope="col">롤ID</th>
                                                <th scope="col">롤명</th>
                                                <th scope="col">롤타입</th>
                                                <th scope="col">롤Sort</th>
                                                <th scope="col">롤 설명</th>
                                                <th scope="col">등록일자</th>
                                                <th scope="col">등록여부</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	
                                        	<c:if test="${fn:length(authorRoleList) == 0}">
                                        		<tr>
                                        			<td class="lt_text3" colspan="8"><spring:message code="common.nodata.msg" /></td>
                                        		</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach var="authorRole" items="${authorRoleList}" varStatus="status">
                                            <tr>
                                                <td>
                                                    <span class="f_chk_only">
                                                        <input type="checkbox" name="delYn" title="선택">
                                                        <input type="hidden" name="checkId" value="<c:out value="${authorRole.roleCode}"/>" />
                                                    </span>
                                                </td>
                                                <td><c:out value="${authorRole.roleCode}"/></td>
                                                <td><c:out value="${authorRole.roleNm}"/></td>
                                                <td><c:out value="${authorRole.roleTyp}"/></td>
                                                <td><c:out value="${authorRole.roleSort}"/></td>
                                                <td><c:out value="${authorRole.roleDc}"/></td>
                                                <td><c:out value="${authorRole.creatDt}"/></td>
                                                <td>
                                                    <label class="f_select" for="">
                                                        <select id="" name="regYn" title="등록여부">
                                                            <option value="Y" <c:if test="${authorRole.regYn == 'Y'}">selected</c:if> >등록</option>
                                                            <option value="N" <c:if test="${authorRole.regYn == 'N'}">selected</c:if> >미등록</option>
                                                        </select>
                                                    </label>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                </div>
                                
                                <!-- 페이지 네비게이션 시작 -->
                                <c:if test="${!empty authorRoleManageVO.pageIndex }">
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo = "${paginationInfo}" type="renew" jsFunction="linkPage" />
                                        </ul>
                                    </div>
                                </div>
                                </c:if>
                                <!-- // 페이지 네비게이션 끝 -->
                                <!--// 게시판 -->
                                
                                <input type="hidden" name="roleCodes"/>
								<input type="hidden" name="regYns"/>
								<input type="hidden" name="pageIndex" value="<c:out value='${authorRoleManageVO.pageIndex}'/>"/>
								<input type="hidden" name="authorCode" value="<c:out value="${authorRoleManageVO.searchKeyword}"/>"/>
								<input type="hidden" name="searchCondition"/>
								
								</form:form>
                                
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