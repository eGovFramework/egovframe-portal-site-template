<%--
  Class Name : EgovQustnrTmplatManageModify.jsp
  Description : 설문템플릿 수정 페이지
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
<c:set var="ImgUrl" value="/images_old/egovframework/com/uss/olp/qtm/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>샘플 포털 > 포털서비스관리 > 설문관리 > 설문템플릿</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="qustnrTmplatManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">


/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_QustnrTmplatManage(){
	document.getElementById("qestnrTmplatTy").value = "${resultList[0].qestnrTmplatTy}";
	document.getElementById("qestnrTmplatCours").value = "${resultList[0].qestnrTmplatCours}";
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
	if(confirm("<spring:message code='common.save.msg' />")){
		if(!validateQustnrTmplatManageVO(form)){ 			
			return;
		}else{
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
			var file = obj.files;
			//document.getElementById("IMG_VIEW").src = obj.value;
			if(file[0].size > (1024 * 63.9)) {
				alert("65,535 Byte 용량 이하 파일만 업로드 가능합니다!");
				obj.outerHTML = obj.outerHTML;
				return;
			}
		} else {
		   alert('GIF/JPG 형식의 이미지만 업로드 가능합니다!');
// 		   obj.select();
// 		   document.execCommand('Delete');
// 		   obj.focus();
			obj.outerHTML = obj.outerHTML;
		   return;
	 	}
	}{return;}
}
</script>
</head>
<body onLoad="fn_egov_init_QustnrTmplatManage();">

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
                                        <li><a href="">포털서비스관리</a></li>
                                        <li><a href="">설문관리</a></li>
                                        <li>설문템플릿</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="qustnrTmplatManageVO" name="qustnrTmplatManageVO" action="${pageContext.request.contextPath}/uss/olp/qtm/EgovQustnrTmplatManageModifyActor.do" method="post" enctype="multipart/form-data">

                                <h1 class="tit_1">포털서비스관리</h1>

                                <p class="txt_1">포털시스템에서 제공되는 서비스들에 대한 컨텐츠를 관리합니다.</p>

                                <h2 class="tit_2">설문관리</h2>

                                <h3 class="tit_3">설문템플릿</h3>

                                <div class="board_view2">
                                    <table>
                                    	<caption>설문템플릿 수정정보</caption>
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="qestnrTmplatTy">템플릿유형</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input id="qestnrTmplatTy" path="qestnrTmplatTy" size="70" class="f_txt w_full" title="템플릿유형 입력"/>
                                                <form:errors path="qestnrTmplatTy"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="qestnrTmplatImage">템플릿유형 이미지정보</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	<c:if test="${resultList[0].qestnrTmplatImagepathnm ne null}">
                                            		<c:if test="${resultList[0].qestnrTmplatImagepathnm ne ''}">
                                            			<img src="${pageContext.request.contextPath}/uss/olp/qtm/EgovQustnrTmplatManageImg.do?qestnrTmplatId=${resultList[0].qestnrTmplatId}" id="IMG_VIEW" class="vam mr5" name="IMG_VIEW" alt="이미지미리보기" title="이미지미리보기" align="middle" style="width: 65px; height: 50px;">
                                            		</c:if>
                                            	</c:if>
                                            	<input type="file" id="qestnrTmplatImage" class="f_file" name="qestnrTmplatImage" onChange="fnImgChange(this)" title="템플릿유형이미지 첨부" />
                                                <p class="txt_3">가로 : 65px, 세로 : 50px, 포멧 : JPEG 형식으로로 업로드 해주세요</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="qestnrTmplatCn">템플릿 설명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <textarea id="qestnrTmplatCn" name="qestnrTmplatCn" class="f_txtar w_full h_80" cols="30" rows="10" title="템플릿설명" style="width:99%;">${resultList[0].qestnrTmplatCn}</textarea>
                                                <form:errors path="qestnrTmplatCn"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="qestnrTmplatCours">템플릿파일(경로)</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="qestnrTmplatCours" size="70" class="f_txt w_full" title="템플릿파일 경로 입력"/>
                                                <form:errors path="qestnrTmplatCours"/>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  시작-->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_save_QustnrTmplatManage(document.qustnrTmplatManageVO); return false;">저장</a><!-- 저장 -->
                                        <a href="<c:url value='/uss/olp/qtm/EgovQustnrTmplatManageList.do'/>" class="btn btn_blue_46 w_100">목록</a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- 목록/저장버튼  끝-->
                                
                                <input name="qestnrTmplatId" type="hidden" value="<c:out value='${resultList[0].qestnrTmplatId}'/>">
								<input name="cmd" type="hidden" value="<c:out value='save'/>">
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