<%--
  Class Name : EgovIncFooter.jsp
  Description : 화면하단 Footer(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="footer_link"><img src="<c:url value='/'/>images/footer/img_plus.gif" alt="">
	<label for="goaction">관련사이트</label>
	<form name="action" method="post" action="http://www.mois.go.kr/">
    	<select id="goaction" name="goaction" onchange="this.form.action=this.options[this.selectedIndex].value;">
        	<option value="http://www.mois.go.kr/" >행정안전부</option>
        	<option value="http://www.nia.or.kr/" >한국정보화진흥원</option>
    	</select>
    	<input type="submit" value="이동" >
	</form>
</div>
<div id="footer_copyright">
	<div class="mp_loc"><img src="<c:url value='/'/>images/footer/img_mois.png" alt="행정안전부" /></div>
	<div class="nia_loc"><img src="<c:url value='/images/footer/img_nia_2020.png' />" width="168" height="48" alt="NIA 한국지능정보사회진흥원" /></div>
	<div class="line_loc"><img src="<c:url value='/'/>images/footer/img_line.gif" /></div>
	<div class="text_loc">대구광역시 동구 첨단로 53 (41068)<br/>© MINISTRY OF THE INTERIOR AND SAFETY. ALL RIGHTS RESERVED.</div>
</div>