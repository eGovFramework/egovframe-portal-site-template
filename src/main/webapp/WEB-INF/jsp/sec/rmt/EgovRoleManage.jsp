<%--
  Class Name : EgovRoleManage.jsp
  Description : EgovRoleManage 화면
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<title>롤 목록</title>

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
    var returnValue = "";
    var returnBoolean = false;
    var checkCount = 0;
    
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                	checkCount++;
                    checkField[i].value = checkId[i].value;
                    if(returnValue == "")
                        returnValue = checkField[i].value;
                    else 
                        returnValue = returnValue + ";" + checkField[i].value;
                }
            }
            if(checkCount > 0) 
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
                returnBoolean = true;
            }
        }
    } else {
    	alert("조회된 결과가 없습니다.");
    }

    document.listForm.roleCodes.value = returnValue;
    return returnBoolean;
}

function fncSelectRoleList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/rmt/EgovRoleList.do'/>";
    document.listForm.submit();
}

function fncSelectRole(roleCode) {
    document.listForm.roleCode.value = roleCode;
    document.listForm.action = "<c:url value='/sec/rmt/EgovRole.do'/>";
    document.listForm.submit();     
}

function fncAddRoleInsert() {
    location.replace("<c:url value='/sec/rmt/EgovRoleInsertView.do'/>"); 
}

function fncRoleListDelete() {
	if(fncManageChecked()) {
        if(confirm("삭제하시겠습니까?")) {
            document.listForm.action = "<c:url value='/sec/rmt/EgovRoleListDelete.do'/>";
            document.listForm.submit();
        }
    }
}

function fncAddRoleView() {
    document.listForm.action = "<c:url value='/sec/rmt/EgovRoleUpdate.do'/>";
    document.listForm.submit();     
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/rmt/EgovRoleList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
    	fncSelectRoleList('1');
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
                            <li><strong>롤관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
            <form:form name="listForm" action="<c:url value='/sec/rmt/EgovRoleList.do'/>" method="post">
            
            <!-- sub title start -->
            <div><h2>롤 관리</h2></div>
            <!-- sub title end -->
            
            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >롤 명 : 
                    <input name="searchKeyword" type="text" value="<c:out value='${roleManageVO.searchKeyword}'/>" size="25" title="검색" onkeypress="press();" />
                </div>
                    <div class="search_buttons">
				        <a href="#LINK" onclick="javascript:fncSelectRoleList('1')" style="selector-dummy:expression(this.hideFocus=false);">조회</a> 
				        <a href="#LINK" onclick="javascript:fncAddRoleInsert()" style="selector-dummy:expression(this.hideFocus=false);">등록</a> 
				        <a href="#LINK" onclick="javascript:fncRoleListDelete()" style="selector-dummy:expression(this.hideFocus=false);">삭제</a> 
                    </div>
                </div> 
            </div>
            <!-- search area end -->
            
            <!-- search result start -->
            <div class="search_result_div">
            
                <table width="98%" cellpadding="0" cellspacing="0" summary="롤 관리 테이블입니다.롤  ID,롤 명,롤 타입,롤 Sort,롤 설명,등록일자의 정보를 담고 있습니다.">
                <caption>롤목록</caption>
                
                <colgroup>
                    <col width="3%" > 
                    <col width="10%" >  
                    <col width="20%" >
                    <col width="10%" >
                    <col width="10%" >
                    <col width="30%" >
                    <col width="12%" >
                    <col width="5%" >
                </colgroup>
                
                <thead>
                <tr>      
                    <th><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()" title="전체선택"></th>  
				    <th>롤 ID</th>
				    <th>롤 명</th>
				    <th>롤 타입</th>
				    <th>롤 Sort</th>
				    <th>롤 설명</th>
				    <th>등록일자</th>
				    <th>롤정보</th>       
                </tr>
                </thead>
                
                <tbody>
                <c:if test="${fn:length(roleList) == 0}">
                <tr> 
                      <td class="lt_text3" colspan="8">
                          <spring:message code="common.nodata.msg" />
                      </td>
                </tr>                                                 
                </c:if>
                <c:forEach var="role" items="${roleList}" varStatus="status">
			    <tr>
				    <td class="lt_text3" ><input type="checkbox" name="delYn" class="check2" title="선택"><input type="hidden" name="checkId" value="<c:out value="${role.roleCode}"/>" /></td>
				    <td class="lt_text" ><a href="#LINK" onclick="javascript:fncSelectRole('<c:out value="${role.roleCode}"/>')"><c:out value="${role.roleCode}"/></a></td>
				    <td class="lt_text" ><c:out value="${role.roleNm}"/></td>
				    <td class="lt_text3" ><c:out value="${role.roleTyp}"/></td>
				    <td class="lt_text3" ><c:out value="${role.roleSort}"/></td>
				    <td class="lt_text3" ><c:out value="${role.roleDc}"/></td>
				    <td class="lt_text3" ><c:out value="${role.roleCreatDe}"/></td>
				    <td class="lt_text3" ><a href="#LINK" onclick="javascript:fncSelectRole('<c:out value="${role.roleCode}"/>')"><img src="<c:url value='/images/img_search.gif'/>" width="15" height="15" align="middle"  alt="상세조회"></a></td>
			    </tr>
			    </c:forEach>
                </tbody>
                  
                </table>
            </div>
            <!-- search result end -->
            
			<c:if test="${!empty roleManageVO.pageIndex }">
			<div id="paging_div">
			    <ul class="paging_align">
			        <ui:pagination paginationInfo = "${paginationInfo}"
			            type="image"
			            jsFunction="linkPage"
			            /></ul>
			    <div align="right">
			        <input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly="readonly" title="메시지" />
			    </div>     
			</div>
			</c:if>

			<input type="hidden" name="roleCode"/>
			<input type="hidden" name="roleCodes"/>
			<input type="hidden" name="pageIndex" value="<c:out value='${roleManageVO.pageIndex}'/>"/>
			<input type="hidden" name="searchCondition"/>
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
