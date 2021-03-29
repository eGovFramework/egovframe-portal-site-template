<%--
  Class Name : EgovAuthorInsert jsp
  Description : EgovAuthorInsert 화면
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
<c:set var="registerFlag" value="${empty groupManageVO.groupId ? 'INSERT' : 'UPDATE'}"/>
<c:set var="registerFlagName" value="${empty groupManageVO.groupId ? '그룹 등록' : '그룹 수정'}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<title>그룹 등록</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="groupManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

function fncSelectGroupList() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/sec/gmt/EgovGroupList.do'/>";
    varFrom.submit();       
}

function fncGroupInsert() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/sec/gmt/EgovGroupInsert.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateGroupManage(varFrom)){           
            return;
        }else{
            varFrom.submit();
        } 
    }
}

function fncGroupUpdate() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/sec/gmt/EgovGroupUpdate.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateGroupManage(varFrom)){           
            return;
        }else{
            varFrom.submit();
        } 
    }
}

function fncGroupDelete() {
    var varFrom = document.getElementById("groupManage");
    varFrom.action = "<c:url value='/sec/gmt/EgovGroupDelete.do'/>";
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
                            <li><strong>사용자그룹관리</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->
            <form:form commandName="groupManage" method="post" >
            <!-- sub title start -->
            <div><h2><c:out value="${registerFlagName}"/></h2></div>
            <!-- sub title end -->
            
            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">                  
                    <table summary="그룹등록">
                        <tr>
						    <td class="td_width">그룹 명
						        <img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/>
						    </td>
						    <td class="td_content">
						        <input name="groupNm" id="groupNm" type="text" value="<c:out value='${groupManage.groupNm}'/>" title="그룹명" maxLength="50" size="40" />
						        &nbsp;<form:errors path="groupNm" />
						    </td>
						</tr>
						<tr>    
						    <td class="td_width">설명</td>
						    <td class="td_content">
						        <input name="groupDc" id="groupDc" type="text" value="<c:out value='${groupManage.groupDc}'/>" title="설명" maxLength="50" size="50" />
						    </td>
						</tr>
						<tr>    
						    <td class="td_width">등록일자</td>
						    <td class="td_content">
						        <input name="groupCreatDe" id="groupCreatDe" type="text" value="<c:out value='${groupManage.groupCreatDe}'/>" title="등록일자" maxLength="50" size="20" readonly="readonly"/>
						    </td>
						</tr>
                    </table>
                </div>
            </div>
            <!--detail area end -->
            
            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
                <a href="#LINK" onclick="javascript:fncSelectGroupList()" style="selector-dummy:expression(this.hideFocus=false);">목록</a> 
			    <c:if test="${registerFlag == 'INSERT'}">
			    <a href="#LINK" onclick="javascript:fncGroupInsert()" style="selector-dummy:expression(this.hideFocus=false);">저장</a> 
                </c:if>
			    <c:if test="${registerFlag == 'UPDATE'}">
			    <a href="#LINK" onclick="javascript:fncGroupUpdate()" style="selector-dummy:expression(this.hideFocus=false);">저장</a> 
			    <a href="#LINK" onclick="javascript:fncGroupDelete()" style="selector-dummy:expression(this.hideFocus=false);">삭제</a> 
		        </c:if>
            </div>
            </td></tr></table>
            <!-- 목록/저장버튼  끝-->

			<!-- 검색조건 유지 -->
			<c:if test="${registerFlag == 'UPDATE'}">
			<input type="hidden" name="searchCondition" value="<c:out value='${groupManageVO.searchCondition}'/>"/>
			<input type="hidden" name="searchKeyword" value="<c:out value='${groupManageVO.searchKeyword}'/>"/>
			<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/>
			</c:if>
            
		    <div align="right">
		        <input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly="readonly" title="메시지"/>
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

