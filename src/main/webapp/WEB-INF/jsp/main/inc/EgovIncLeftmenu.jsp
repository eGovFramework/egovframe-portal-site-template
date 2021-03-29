<%--
  Class Name : EgovIncLeftmenu.jsp
  Description : 좌메뉴 화면(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<script type="text/javascript" src="<c:url value="/js/EgovMainMenu.js"/>"></script>
<script type="text/javascript">
<!--
/* ********************************************************
 * 상세내역조회 함수
 ******************************************************** */
function fn_MovePage(nodeNum) {
    var nodeValues = treeNodes[nodeNum].split("|");
    //parent.main_right.location.href = nodeValues[5];
    document.menuListForm.action = "${pageContext.request.contextPath}"+nodeValues[5];
    //alert(document.menuListForm.action);
    document.menuListForm.submit();
}
//-->
</script>
<div class="left_wrap">
	<div class="top"><img src="<c:url value='/'/>images/title_image/img_menu_title01.gif" alt="서브메뉴" /></div>             
	<div class="nav_style" >
		<script type="text/javascript">
         var Tree = new Array;
         if(document.menuListForm.tmp_menuNm != null){
	         for (var j = 0; j < document.menuListForm.tmp_menuNm.length; j++) {
	             Tree[j] = document.menuListForm.tmp_menuNm[j].value;
	         }
         }
         var leftStartMenuValue = document.getElementById("menuNo").value;
         if (leftStartMenuValue==null || leftStartMenuValue=="" || leftStartMenuValue=="null") leftStartMenuValue = '1000000';
         createTree(Tree, true, leftStartMenuValue);
         </script>
	</div>	
</div>
