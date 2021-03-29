<%--
  Class Name : EgovRoleUpdate.jsp
  Description : EgovRoleUpdate 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01    lee.m.j          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스개발팀 lee.m.j
    since    : 2009.02.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<c:set var="registerFlag" value="${empty roleManageVO.roleCode ? 'INSERT' : 'UPDATE'}"/>
<c:set var="registerFlagName" value="${empty roleManageVO.roleCode ? '롤 등록' : '롤 수정'}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<title>롤 수정</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="roleManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

function fncSelectRoleList() {
    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/sec/rmt/EgovRoleList.do'/>";
    varFrom.submit();       
}

function fncRoleInsert() {

    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/sec/rmt/EgovRoleInsert.do'/>";

    if(!validateRoleManage(varFrom)){           
        return;
    }else{
        if(confirm("저장 하시겠습니까?")){
            varFrom.submit();
        }
    } 
}

function fncRoleUpdate() {
    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/sec/rmt/EgovRoleUpdate.do'/>";

    if(!validateRoleManage(varFrom)){           
        return;
    }else{
        if(confirm("저장 하시겠습니까?")){
            varFrom.submit();
        }
    } 
}

function fncRoleDelete() {
    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/sec/rmt/EgovRoleDelete.do'/>";
    if(confirm("삭제 하시겠습니까?")){
        varFrom.submit();
    }
}

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
            
            <!-- sub title start -->
            <div><h2><c:out value="${registerFlagName}"/></h2></div>
            <!-- sub title end -->
            
            <form:form commandName="roleManage" method="post" >  

            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">                  
                    <table summary="롤을 수정하는 테이블입니다.롤 코드,롤 명,롤 패턴,설명,롤 타입,롤 Sort,등록일자 정보를 담고 있습니다.">
						<tr>
						    <td class="td_width">롤  코드<img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
						    <td class="td_content"><input name="roleCode" id="roleCode" type="text" value="<c:out value='${roleManage.roleCode}'/>" size="30" readonly="readonly" title="롤 코드" /></td>
						</tr>
						<tr>
						    <td class="td_width">롤 명<img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
						    <td class="td_content"><input name="roleNm" id="roleNm" type="text" value="<c:out value='${roleManage.roleNm}'/>" maxLength="50" size="30" title="롤명" />&nbsp;<form:errors path="roleNm" /></td>
						</tr>
						<tr>
						    <td class="td_width">롤 패턴<img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
						    <td class="td_content"><input name="rolePtn" id="rolePtn" type="text" value="<c:out value='${roleManage.rolePtn}'/>" maxLength="50" size="50" title="롤패턴" />&nbsp;<form:errors path="rolePtn" /></td>
						</tr>
						<tr>
						    <td class="td_width">설명<img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
						    <td class="td_content"><input name="roleDc" id="roleDc" type="text" value="<c:out value='${roleManage.roleDc}'/>" maxLength="50" size="50" title="설명" /></td>
						</tr>
						<tr>
						    <td class="td_width">롤 타입<img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
						    <td class="td_content">
						      <select name="roleTyp" title="롤타입">
						        <c:forEach var="cmmCodeDetail" items="${cmmCodeDetailList}" varStatus="status">
						          <option value="<c:out value="${cmmCodeDetail.code}"/>" <c:if test="${cmmCodeDetail.code == roleManage.roleTyp}">selected</c:if> ><c:out value="${cmmCodeDetail.codeNm}"/></option>
						        </c:forEach>
						      </select>
						   </td> 
						</tr>  
						<tr>
						    <td class="td_width">롤 Sort<img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
						    <td class="td_content"><input name="roleSort" id="roleSort" type="text" value="<c:out value='${roleManage.roleSort}'/>" maxLength="50" size="30" title="롤sort" /></td>
						</tr>  
						<tr>
						    <td class="td_width">등록일자</td>
						    <td class="td_content"><input name="roleCreatDe" id="roleCreatDe" type="text" value="<c:out value='${roleManage.roleCreatDe}'/>" maxLength="50" size="20" title="등록일자" readonly="readonly"/></td>
						</tr>
						</table>
                </div>
            </div>
            <!--detail area end -->

            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
		        <a href="#LINK" onclick="javascript:fncSelectRoleList()" style="selector-dummy:expression(this.hideFocus=false);">목록</a> 
		        <c:if test="${registerFlag == 'INSERT'}">
			    <a href="#LINK" onclick="javascript:fncRoleInsert()" style="selector-dummy:expression(this.hideFocus=false);">저장</a> 
			    </c:if>
			    <c:if test="${registerFlag == 'UPDATE'}">
			    <a href="#LINK" onclick="javascript:fncRoleUpdate()" style="selector-dummy:expression(this.hideFocus=false);">저장</a> 
			    <a href="#LINK" onclick="javascript:fncRoleDelete()" style="selector-dummy:expression(this.hideFocus=false);">삭제</a> 
			    </c:if>
            </div>
            </td></tr></table>
            <!-- 목록/저장버튼  끝-->
            
			<!-- 검색조건 유지 -->
			<c:if test="${registerFlag == 'UPDATE'}">
			<input type="hidden" name="searchCondition" value="<c:out value='${roleManageVO.searchCondition}'/>"/>
			<input type="hidden" name="searchKeyword" value="<c:out value='${roleManageVO.searchKeyword}'/>"/>
			<input type="hidden" name="pageIndex" value="<c:out value='${roleManageVO.pageIndex}'/>"/>
			</c:if>

		    <div align="right">
		        <input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly="readonly" title="메시지" />
		    </div>
		    
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

