package egovframework.let.cop.bbs.web;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;

import egovframework.test.EgovTestAbstractSpringMvc;
import lombok.extern.slf4j.Slf4j;

/**
 * [게시판생성관리][EgovBBSAdminManageController.insertBBSMasterInf] Controller 단위 테스트
 * 
 * @author 이백행
 * @since 2024-09-21
 *
 */

@Slf4j
class EgovBBSAttributeManageControllerTestInsertBBSMasterInfTest extends EgovTestAbstractSpringMvc {

	// TODO 이백행 2026-09-18 1.더미(Dummy) 인증
	// EgovUserDetailsHelper.getAuthenticatedUser()
	// /egovframe-common-components/src/main/resources/egovframework/spring/com/context-egovuserdetailshelper.xml
	// egovframework.com.cmm.service.impl.EgoDummyUserDetailsServiceImpl

	/**
	 * 신규 게시판 마스터 정보를 등록한다. 성공
	 */
	@Test
	void test() {
		// given
		// bbsId는 서비스에서 생성한다.
		// posblAtchFileSize, useAt, frstRegisterId는 컨트롤러에서 설정한다.
		// 등록일시는 INSERT SQL의 SYSDATE()로 설정한다.

		// when
		assertDoesNotThrow(() ->

		mockMvc.perform(post("/cop/bbs/insertBBSMasterInf.do")

				.param("bbsTyCode", "BBST01") // 게시판유형코드
				.param("bbsAttrbCode", "BBSA03") // 게시판속성코드
				.param("bbsNm", "테스트 게시판") // 게시판명
				.param("bbsIntrcn", "테스트 게시판 소개") // 게시판소개
				.param("replyPosblAt", "N") // 답장가능여부
				.param("fileAtchPosblAt", "Y") // 파일첨부가능여부
				.param("posblAtchFileNumber", "3") // 첨부가능파일숫자
				.param("tmplatId", "TMPLAT_BOARD_DEFAULT")) // 템플릿ID

				.andExpect(status().isOk())

		);

		// then
		log.debug("then");
	}

}
