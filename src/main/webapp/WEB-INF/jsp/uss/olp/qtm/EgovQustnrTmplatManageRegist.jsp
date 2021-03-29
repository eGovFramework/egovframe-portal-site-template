<%--
  Class Name : EgovQustnrTmplatManageRegist.jsp
  Description : 설문템플릿 등록 페이지
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성
     2011.08.31  JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.09
   
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="ImgUrl" value="/images/egovframework/com/uss/olp/qtm/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>설문템플릿 등록</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link rel="stylesheet" href="<c:url value='/'/>css/default.css" type="text/css" >
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="qustnrTmplatManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">


/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrTmplatManage(){

}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_QustnrTmplatManage(){
	location.href = "<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageList.do'/>";
}
/* ********************************************************
* 저장처리화면
******************************************************** */
function fn_egov_save_QustnrTmplatManage(form){
   if(confirm("<spring:message code="common.save.msg" />")){
       if(!validateQustnrTmplatManageVO(form)){            
           return;
       }else{
       /*
           if(form.qestnrTmplatImage.value == ""){
               alert("템플릿유형 이미지를 선택해주세요!");
               form.focus();
               return;
           }
           */
           form.submit();
       }
   }
}
/* ********************************************************
 * 선택이미지 미리보기
 ******************************************************** */
function fnImgChange(obj){

	if(obj.value != "") {
		if(obj.value.search(/(gif)/)!=-1 || obj.value.search(/(jpg)/)!=-1 || obj.value.search(/(bmp)/)!=-1 || obj.value.search(/(GIF)/)!=-1 || obj.value.search(/(JPG)/)!=-1 ){
			document.getElementById("DIV_IMG_VIEW").style.display = "";
			document.getElementById("IMG_VIEW").src = obj.value;
		}else{
		   alert('GIF/JPG 형식의 이미지만 업로드 가능합니다!');
		   obj.select();
		   document.execCommand('Delete');
		   obj.focus();
		   return;
	 	}
	}{return;}
	
}
</script>
</head>
<body onLoad="fn_egov_init_QustnrTmplatManage();">
<!-- 자바스크립트 경고 태그  -->
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
<!-- login status start -->
<div id="login_area"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncTborder" /></div>
<!-- //login status end -->
<!-- wrap start -->
<div id="wrap"> 
    <!-- header start -->
    <div id="subheader"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>  
    <!-- //header end -->
    <!--  타이틀 이미지 시작 -->
    <div id="title_img_div"><img src="<c:url value='/'/>images/title_image/img_title05.gif" alt="" /></div>
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
                            <li>포털서비스관리</li>
                            <li>&gt;</li>
                            <li>설문관리</li>
                            <li>&gt;</li>
                            <li><strong>설문템플릿</strong></li>
                        </ul>
                    </div>
            </div>
            <div id="content_field"><!--contents start-->

			<!-- 상단타이틀 -->
			<form:form commandName="qustnrTmplatManageVO"  name="qustnrTmplatManageVO" action="${pageContext.request.contextPath}/uss/olp/qtm/EgovQustnrTmplatManageRegistActor.do" method="post" enctype="multipart/form-data">
            
            <!-- sub title start -->
            <div><h2>설문템플릿 등록</h2></div>
            <!-- sub title end -->
            
            <!--detail area start -->
            <div class="search_service">
                <div class="search_top_table">
					<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="등록 을 제공한다.">
					<caption>등록 을 제공한다</caption>
					  <tr> 
					    <td class="td_width"><label for="qestnrTmplatTy">템플릿유형<img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></label></td>
					    <td class="td_content">
					     <form:input path="qestnrTmplatTy" size="70" cssClass="txaIpt" maxlength="100" title="템플릿유형 입력" />
					      <form:errors path="qestnrTmplatTy"/>
					    </td>
					  </tr> 
					  <tr> 
					    <td class="td_width">템플릿유형 이미지
					    </td>
					    <td class="td_content">
					        <input type="file" id="qestnrTmplatImage" name="qestnrTmplatImage" title="템플릿유형이미지 선택" />
					        <br/><font color="red">가로:65px 세로:50px 포멧:GIF/JPG 형식으로로 업로드 해주세요</font>
					    </td>
					  </tr>
					  <tr> 
					    <td class="td_width"><label for="qestnrTmplatCn">템플릿설명</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					        <form:textarea path="qestnrTmplatCn" rows="8" cols="75" cssClass="txaClass" title="템플릿설명 입력"/>
					        <form:errors path="qestnrTmplatCn"/>
					    </td>
					  </tr>
					  <tr> 
					    <td class="td_width"><label for="qestnrTmplatCours">템플릿파일(경로)</label><img src="<c:url value='/'/>images/required.gif" alt="필수항목" title="필수항목" width="15" height="15"/></td>
					    <td class="td_content">
					      <form:input path="qestnrTmplatCours" size="70" cssClass="txaIpt" maxlength="100" title="템플릿경록 입력"/>
					      <form:errors path="qestnrTmplatCours"/>
					    </td>
					  </tr>
					</table>
                </div>
            </div>
            <!--detail area end -->
            
            <!-- 목록/저장버튼  시작-->
            <table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
            <div class="buttons" align="center" style="margin-bottom:100px">
			    <a href="<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageList.do'/>">목록</a>
			    <input type="submit" value="저장" onclick="fn_egov_save_QustnrTmplatManage(document.qustnrTmplatManageVO); return false;" />
            </div>
            </td></tr></table>
            <!-- 목록/저장버튼  끝-->

			<input name="cmd" type="hidden" value="<c:out value='save'/>">
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