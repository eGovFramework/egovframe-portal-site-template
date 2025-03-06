package egovframework.let.cop.bbs.service.impl;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.context.annotation.ImportResource;
import org.springframework.test.context.ContextConfiguration;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.cop.bbs.service.BoardMaster;
import egovframework.let.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.let.cop.com.service.EgovUserInfManageService;
import egovframework.let.cop.com.service.impl.BBSUseInfoManageDAO;
import egovframework.let.cop.com.service.impl.EgovUserInfManageDAO;
import egovframework.test.EgovTestAbstractSpring;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * [게시판생성관리][EgovBBSAttributeManageServiceImpl.insertBBSMastetInf] ServiceImpl
 * 단위 테스트
 * 
 * @author 이백행
 * @since 2024-09-21
 *
 */

@ContextConfiguration(classes = { EgovBBSAttributeManageServiceImplTestInsertBBSMastetInfTest.class,
		EgovTestAbstractSpring.class })

@Configuration

@ImportResource({ "classpath*:egovframework/spring/com/context-idgen.xml", })

@ComponentScan(useDefaultFilters = false, basePackages = { "egovframework.let.cop.bbs.service.impl",
		"egovframework.let.cop.com.service.impl" }, includeFilters = {
				@Filter(type = FilterType.ASSIGNABLE_TYPE, classes = { EgovBBSAttributeManageServiceImpl.class,
						BBSAttributeManageDAO.class, BBSUseInfoManageDAO.class, EgovUserInfManageService.class,
						EgovUserInfManageDAO.class, BBSAddedOptionsDAO.class, }) })

@RequiredArgsConstructor
@Slf4j
class EgovBBSAttributeManageServiceImplTestInsertBBSMastetInfTest extends EgovTestAbstractSpring {

	/**
	 * 게시판 속성관리를 위한 서비스 인터페이스 클래스
	 */
	@Autowired
	private EgovBBSAttributeManageService egovBBSAttributeManageService;

	/**
	 * 신규 게시판 속성정보를 생성한다.
	 * 
	 * @throws Exception
	 */
	@Test
	void test() throws Exception {
		// given
		final BoardMaster boardMaster = new BoardMaster();

		// 게시판ID
		final LocalDateTime now = LocalDateTime.now();
		final String now2 = now.format(DateTimeFormatter.ofPattern("uuuu-MM-dd'T'HH:mm:ss"));
//		final String now3 = now.format(DateTimeFormatter.ofPattern("uuuuMMddHHmmssS"));
//		boardMaster.setBbsId("TEST_" + now3);

		// 게시판유형코드
		// SELECT A.* FROM LETTCCMMNDETAILCODE AS A WHERE A.CODE_ID = 'COM004';
		boardMaster.setBbsTyCode("BBST01");

		// SELECT A.* FROM LETTCCMMNDETAILCODE AS A WHERE A.CODE_ID = 'COM009';
		boardMaster.setBbsAttrbCode("BBSA03");

		// 게시판명
		boardMaster.setBbsNm("test 이백행 게시판명 " + now2);

		// 게시판소개
		boardMaster.setBbsIntrcn("test 이백행 게시판소개 " + now2);

		// 답장가능여부
		boardMaster.setReplyPosblAt("N");

		// 파일첨부가능여부
		boardMaster.setFileAtchPosblAt("Y");

		// 첨부가능파일숫자
		boardMaster.setPosblAtchFileNumber(3);

		// 첨부가능파일사이즈
		boardMaster.setPosblAtchFileSize("0");

		// 템플릿ID
		boardMaster.setTmplatId("TMPLAT_BOARD_DEFAULT");

		// 사용여부
		boardMaster.setUseAt("Y");

		final LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if (loginVO != null) {
			// 최초등록자ID
			boardMaster.setFrstRegisterId(loginVO.getUniqId());
		}

		// when
		final String result = egovBBSAttributeManageService.insertBBSMastetInf(boardMaster);

		// then
		if (log.isDebugEnabled()) {
			log.debug("boardMaster={}", boardMaster);
			log.debug("getBbsId={}, {}", boardMaster.getBbsId(), result);
		}

		assertEquals(boardMaster.getBbsId(), result, "신규 게시판 속성정보를 생성한다.");
	}

}