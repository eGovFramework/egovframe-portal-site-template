<%--
  Class Name : EgovIncLeftmenu.jsp
  Description : 좌메뉴 화면(include)
  Modification Information
 
       수정일              수정자              수정내용
    ----------  ----------   ---------------------------
    2011.08.31  JJY          경량환경 버전 생성
    2021.08.13  신용호               신규 디자인 적용 및 스크립트 수정
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     

<div class="nav">
    <div class="inner">
<script type="text/javascript">
	// 메뉴 목록 추출
	var menuList = new Array;
	if(document.menuListForm.tmp_menuNm != null){
		
		for (var j = 0; j < document.menuListForm.tmp_menuNm.length; j++) {
			menuList[j] = document.menuListForm.tmp_menuNm[j].value;			
		}
	}
	var leftStartMenuValue = document.getElementById("menuNo").value;
	if (leftStartMenuValue==null || leftStartMenuValue=="" || leftStartMenuValue=="null") leftStartMenuValue = '1000000';
	console.log("leftStartMenuValue = "+leftStartMenuValue);
	
	// 서브 메뉴 생성
	function subMenuTag(menuList, mainMenuNo) {
		var subMenuTag = "";
		menuList.forEach(function(item,index){
			var itemList = item.split('|');
			
			if ( mainMenuNo == itemList[1] ) {				
				subMenuTag += '<li><a href="<c:url value='/'/>'+itemList[5].substr(1)+'">'+itemList[2]+'</a></li>';				
			}
		});
		if (subMenuTag != "") subMenuTag = "<ul>"+subMenuTag+"</ul>";
		return subMenuTag;
	}

	var topMenuTag = "";
	var mainMenuTag = "";
	
	menuList.forEach(function(item,index){
		console.log(item,index);
		var itemList = item.split('|');
		switch(leftStartMenuValue) {
		case itemList[0]:
			topMenuTag = "<h2>"+itemList[2]+"</h2>";
		    break;
		case itemList[1]:
			mainMenuTag += '<li><a href="<c:url value='/'/>'+itemList[5].substr(1)+'">'+itemList[2]+'</a>'
							+ subMenuTag(menuList, itemList[0])
							+ '</li>';
		    break;
		default:
		    break;
		}
	});

	document.write(topMenuTag + '<ul>' + mainMenuTag + '</ul>');
	
</script>
    
    </div>
</div>
