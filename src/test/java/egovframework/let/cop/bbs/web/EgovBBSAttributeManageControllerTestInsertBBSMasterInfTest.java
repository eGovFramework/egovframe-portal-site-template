package egovframework.let.cop.bbs.web;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;

import egovframework.test.EgovTestAbstractSpringMvc;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * [게시판생성관리][EgovBBSAdminManageController.insertBBSMasterInf] Controller 단위 테스트
 * 
 * @author 이백행
 * @since 2024-09-21
 *
 */

@RequiredArgsConstructor
@Slf4j
class EgovBBSAttributeManageControllerTestInsertBBSMasterInfTest extends EgovTestAbstractSpringMvc {

	/**
	 * 신규 게시판 마스터 정보를 등록한다.
	 * 
	 * @throws Exception
	 */
	@Test
	void test() throws Exception {
		// given

		// when
		mockMvc.perform(post("/cop/bbs/insertBBSMasterInf.do")).andExpect(status().isOk());

		// then
		if (log.isDebugEnabled()) {
			log.debug("test");
		}

		assertEquals("", "", "신규 게시판 속성정보를 생성한다.");
	}

}