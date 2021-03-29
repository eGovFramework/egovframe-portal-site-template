<%--
  Class Name : EgovAuthorManage.jsp
  Description : EgovAuthorManage List 화면
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
<title>권한 목록</title>

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
                    checkField[i].value = checkId[i].value;
                    if(returnValue == "")
                        returnValue = checkField[i].value;
                    else 
                	    returnValue = returnValue + ";" + checkField[i].value;
                    checkCount++;
                }
            }
            if(checkCount > 0) 
                returnBoolean = true;
            else {
                alert("선택된 권한이 없습니다.");
                returnBoolean = false;
            }
        } else {
            if(document.listForm.delYn.checked == false) {
                alert("선택된 권한이 없습니다.");
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

    document.listForm.authorCodes.value = returnValue;

    return returnBoolean;
}

function fncSelectAuthorList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthorList.do'/>";
    document.listForm.submit();
}

function fncSelectAuthor(author) {
    document.listForm.authorCode.value = author;
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthor.do'/>";
    document.listForm.submit();     
}

function fncAddAuthorInsert() {
    location.replace("<c:url value='/sec/ram/EgovAuthorInsertView.do'/>"); 
}

function fncAuthorDeleteList() {

    if(fncManageChecked()) {	
        if(confirm("삭제하시겠습니까?")) {
            document.listForm.action = "<c:url value='/sec/ram/EgovAuthorListDelete.do'/>";
            document.listForm.submit();
        } 
    }
}

function fncAddAuthorView() {
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthorUpdate.do'/>";
    document.listForm.submit();     
}

function fncSelectAuthorRole(author) {
    document.listForm.searchKeyword.value = author;
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthorRoleList.do'/>";
    document.listForm.submit();     
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/sec/ram/EgovAuthorList.do'/>";
    document.listForm.submit();
}


function press() {

    if (event.keyCode==13) {
    	fncSelectAuthorList('1');
    }
}


-->
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
                            <li><strong>권한관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            
            <!-- sub title start -->
            <div><h2>권한 관리</h2></div>
            <!-- sub title end -->
            
            <form:form name="listForm" action="<c:url value='/sec/ram/EgovAuthorList.do'/>" method="post">
            
            <!-- search area start-->
            <div class="search_service">
                <div class="search_area">
                <div class="search_conditions" >권한 명 : 
                    <input name="searchKeyword" type="text" value="<c:out value='${authorManageVO.searchKeyword}'/>" size="25" title="검색" onkeypress="press();" />
                </div>
                    <div class="search_buttons">
				      <a href="#LINK" onclick="javascript:fncSelectAuthorList('1')" style="selector-dummy:expression(this.hideFocus=false);">조회</a> 
				      <a href="#LINK" onclick="javascript:fncAddAuthorInsert()" style="selector-dummy:expression(this.hideFocus=false);">등록</a> 
				      <a href="#LINK" onclick="javascript:fncAuthorDeleteList()" style="selector-dummy:expression(this.hideFocus=false);">삭제</a> 
                    </div>
                </div> 
            </div>
            <!-- search area end -->
            
            <!-- search result start -->
            <div class="search_result_div">
            
                <table width="98%" cellpadding="0" cellspacing="0" summary="권한관리에  관한 테이블입니다.권한ID,권한 명,설명, 등록일자, 롤 정보의 내용을 담고 있습니다.">
                <caption>권한목록</caption>
                
                <colgroup>
                    <col width="5%" > 
                    <col width="20%" >
                    <col width="20%" >
                    <col width="30%" >
                    <col width="20%" >
                    <col width="5%" >
                </colgroup>
                
                <thead>
                <tr>      
                    <th><input type="checkbox" name="checkAll" title="선택여부" class="check2" onclick="javascript:fncCheckAll()"></th>  
				    <th>권한 코드</th>
				    <th>권한 명</th>
				    <th>설명</th>
				    <th>등록일자</th>
				    <th>롤 정보</th>          
                </tr>
                </thead>
                
                <tbody>
                <c:if test="${fn:length(authorList) == 0}">
                <tr> 
                      <td class="lt_text3" colspan="6">
                          <spring:message code="common.nodata.msg" />
                      </td>
                </tr>                                                 
                </c:if>
                <c:forEach var="author" items="${authorList}" varStatus="status">
				<tr>
				    <td class="lt_text3"><input type="checkbox" name="delYn" class="check2" title="선택"><input type="hidden" name="checkId" value="<c:out value="${author.authorCode}"/>" /></td>
				    <td class="lt_text"><a href="#LINK" onclick="javascript:fncSelectAuthor('<c:out value="${author.authorCode}"/>')"><c:out value="${author.authorCode}"/></a></td>
				    <td class="lt_text"><c:out value="${author.authorNm}"/></td>
				    <td class="lt_text3"><c:out value="${author.authorDc}"/></td>
				    <td class="lt_text3"><c:out value="${author.authorCreatDe}"/></td>
				    <td class="lt_text3"><a href="#LINK" onclick="javascript:fncSelectAuthorRole('<c:out value="${author.authorCode}"/>')"><img src="<c:url value='/images/img_search.gif'/>" width="15" height="15" align="middle" alt="롤 정보"></a></td>
				</tr>
				</c:forEach>
                </tbody>
                  
                </table>
            </div>
            <!-- search result end -->

			<c:if test="${!empty authorManageVO.pageIndex }">
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
			
			<input type="hidden" name="authorCode"/>
			<input type="hidden" name="authorCodes"/>
			<input type="hidden" name="pageIndex" value="<c:out value='${authorManageVO.pageIndex}'/>"/>
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
