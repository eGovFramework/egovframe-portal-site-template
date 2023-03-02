package egovframework.com.cmm.web;

import java.beans.PropertyEditorSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * atchFileId 파라미터 복호화 클래스
 * 
 * @author 표준프레임워크팀 신용호
 * @since 2022.12.22
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일      	수정자           수정내용
 *  ------------   --------    ---------------------------
 *   2022.12.22  	신용호          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 *      </pre>
 */

public class EgovAtchFileIdPropertyEditor extends PropertyEditorSupport {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovAtchFileIdPropertyEditor.class);
	
	public void setAsText(String text) throws IllegalArgumentException {
		LOGGER.debug("===>>> setText : "+text);
		String decryptText = "";
		if (text != null && !"".equals(text) ) {
			try {
				decryptText = EgovFileMngController.decrypt(text);
			} catch (Exception e) {
				LOGGER.debug(e.getMessage());
				decryptText = "FILE_ID_DECRIPT_EXCEPTION_01";
			}
		}
		this.setValue(decryptText);

	}


	public String getAsText() {
		LOGGER.debug("===>>> getText : "+getValue());
		return String.valueOf(getValue());

	}

}
