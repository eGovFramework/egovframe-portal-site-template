<%--
  Class Name : EgovFileList.jsp
  Description : 파일 목록화면(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.26   이삼섭          최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.26 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>
<script type="text/javascript">
<!--
    function fn_egov_downFile(atchFileId, fileSn){
        var downloadUrl = "<c:url value='/cmm/fms/FileDown.do'/>";
        window.open(downloadUrl + "?atchFileId=" + encodeURIComponent(atchFileId) + "&fileSn=" + encodeURIComponent(fileSn));
    }   
    
    function fn_egov_deleteFile(atchFileId, fileSn) {
        // 동적으로 form 생성
        var form = document.createElement("form");
        form.method = "POST";
        form.action = "<c:url value='/cmm/fms/deleteFileInfs.do'/>";

        // hidden 필드 추가
        var fields = {
            "atchFileId": atchFileId,
            "fileSn": fileSn,
            "returnUrl": window.location.pathname + window.location.search
        };

        for (var key in fields) {
            var input = document.createElement("input");
            input.type = "hidden";
            input.name = key;
            input.value = fields[key];
            form.appendChild(input);
        }

        document.body.appendChild(form);
        form.submit();
    }
    
    function fn_egov_check_file(flag) {
        if (flag=="Y") {
            document.getElementById('file_upload_posbl').style.display = "block";
            document.getElementById('file_upload_imposbl').style.display = "none";          
        } else {
            document.getElementById('file_upload_posbl').style.display = "none";
            document.getElementById('file_upload_imposbl').style.display = "block";
        }
    }
//-->
</script>

<div>
<c:forEach var="fileVO" items="${fileList}" varStatus="status">
	<c:choose>
		<c:when test="${updateFlag=='Y'}">
			<c:out value='${fileVO.orignlFileNm}'/>&nbsp;<span>[<c:out value='${fileVO.fileMg}'/>&nbsp;byte]</span>
			<input type="button" value="삭제"
				data-atch-file-id="<c:out value='${atchFileId}'/>"
				data-file-sn="<c:out value='${fileVO.fileSn}'/>"
				onclick="fn_egov_deleteFile(this.dataset.atchFileId, this.dataset.fileSn);">
		</c:when>
		<c:otherwise>
			<a href="#LINK"
				data-atch-file-id="<c:out value='${fileVO.atchFileId}'/>"
				data-file-sn="<c:out value='${fileVO.fileSn}'/>"
				onclick="fn_egov_downFile(this.dataset.atchFileId, this.dataset.fileSn); return false;">
				<c:out value='${fileVO.orignlFileNm}'/>
			</a>
			&nbsp;[<c:out value='${fileVO.fileMg}'/>&nbsp;byte]
		</c:otherwise>
	</c:choose>
	<div style="padding: 3px;"></div>
</c:forEach>
<c:if test="${fn:length(fileList) == 0}">
</c:if>
</div>

<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
    var fileListCntInput = document.getElementById("fileListCnt");
    if (!fileListCntInput) {
        return;
    }

    var fileListCntValue = "<c:out value='${fileListCnt}'/>";
    if (!fileListCntValue) {
        fileListCntValue = "0";
    }
    fileListCntInput.value = fileListCntValue;

    var parentForm = fileListCntInput.form;
    if (!parentForm) {
        return;
    }

    var maxFileNumInput = parentForm.querySelector("input[name='posblAtchFileNumber']");
    var uploader = document.getElementById("egovComFileUploader");
    var listContainer = document.getElementById("egovComFileList");

    if (!maxFileNumInput || !uploader || !listContainer || typeof MultiSelector === "undefined") {
        return;
    }

    var existFileNum = parseInt(fileListCntValue, 10) || 0;
    var maxFileNum = parseInt(maxFileNumInput.value, 10) || 0;
    var uploadableFileNum = Math.max(0, maxFileNum - existFileNum);

    if (uploadableFileNum > 0) {
        fn_egov_check_file("Y");
        var multiSelector = new MultiSelector(listContainer, uploadableFileNum);
        multiSelector.addElement(uploader);
    } else {
        fn_egov_check_file("N");
    }
});
</script>