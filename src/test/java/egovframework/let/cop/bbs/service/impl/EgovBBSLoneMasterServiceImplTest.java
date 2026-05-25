package egovframework.let.cop.bbs.service.impl;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.context.annotation.ImportResource;
import org.springframework.test.context.ContextConfiguration;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.cop.bbs.service.BoardMaster;
import egovframework.let.cop.bbs.service.BoardMasterVO;
import egovframework.let.cop.bbs.service.EgovBBSLoneMasterService;
import egovframework.let.cop.com.service.impl.BBSUseInfoManageDAO;
import egovframework.test.EgovTestAbstractSpring;
import lombok.RequiredArgsConstructor;

/**
 * [단일 마스터 게시판][EgovBBSLoneMasterServiceImpl] 서비스 단위 테스트
 *
 * @author 표준프레임워크센터
 * @since 2024-10-01
 */

@ContextConfiguration(classes = { EgovBBSLoneMasterServiceImplTest.class,
        EgovTestAbstractSpring.class })

@Configuration

@ImportResource({ "classpath*:egovframework/spring/com/context-idgen.xml", })

@ComponentScan(useDefaultFilters = false, basePackages = { "egovframework.let.cop.bbs.service.impl",
        "egovframework.let.cop.com.service.impl" }, includeFilters = {
                @Filter(type = FilterType.ASSIGNABLE_TYPE, classes = { EgovBBSLoneMasterServiceImpl.class,
                        BBSLoneMasterDAO.class, BBSUseInfoManageDAO.class, }) })

@RequiredArgsConstructor
class EgovBBSLoneMasterServiceImplTest extends EgovTestAbstractSpring {

    private static final Logger log = LoggerFactory.getLogger(EgovBBSLoneMasterServiceImplTest.class);

    /**
     * 단일 마스터 게시판 서비스 인터페이스
     */
    @Autowired
    private EgovBBSLoneMasterService egovBBSLoneMasterService;

    /**
     * 신규 게시판 속성정보를 생성하고 반환된 ID를 검증한다.
     *
     * @throws Exception
     */
    @Test
    void testInsertMaster() throws Exception {
        // given
        final BoardMaster boardMaster = new BoardMaster();
        final String suffix = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("uuuu-MM-dd'T'HH:mm:ss"));

        boardMaster.setBbsTyCode("BBST01");
        boardMaster.setBbsAttrbCode("BBSA03");
        boardMaster.setBbsNm("테스트 단일마스터 게시판 " + suffix);
        boardMaster.setBbsIntrcn("단위 테스트용 게시판 소개 " + suffix);
        boardMaster.setReplyPosblAt("N");
        boardMaster.setFileAtchPosblAt("Y");
        boardMaster.setPosblAtchFileNumber(3);
        boardMaster.setPosblAtchFileSize("0");
        boardMaster.setTmplatId("TMPLAT_BOARD_DEFAULT");
        boardMaster.setUseAt("Y");

        final LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (loginVO != null) {
            boardMaster.setFrstRegisterId(loginVO.getUniqId());
        }

        // when
        final String bbsId = egovBBSLoneMasterService.insertMaster(boardMaster);

        // then
        if (log.isDebugEnabled()) {
            log.debug("boardMaster={}", boardMaster);
            log.debug("bbsId={}", bbsId);
        }

        assertNotNull(bbsId, "생성된 게시판 ID는 null이 아니어야 한다.");
        assertEquals(boardMaster.getBbsId(), bbsId, "반환된 ID와 boardMaster의 bbsId가 동일해야 한다.");
    }

    /**
     * 게시판 속성정보 단건 조회를 검증한다.
     *
     * @throws Exception
     */
    @Test
    void testSelectMaster() throws Exception {
        // given
        final BoardMaster boardMaster = new BoardMaster();
        final String suffix = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("uuuu-MM-dd'T'HH:mm:ss"));

        boardMaster.setBbsTyCode("BBST01");
        boardMaster.setBbsAttrbCode("BBSA03");
        boardMaster.setBbsNm("조회 테스트 게시판 " + suffix);
        boardMaster.setBbsIntrcn("단건 조회 테스트 게시판 소개 " + suffix);
        boardMaster.setReplyPosblAt("N");
        boardMaster.setFileAtchPosblAt("N");
        boardMaster.setPosblAtchFileNumber(0);
        boardMaster.setPosblAtchFileSize("0");
        boardMaster.setTmplatId("TMPLAT_BOARD_DEFAULT");
        boardMaster.setUseAt("Y");

        final LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (loginVO != null) {
            boardMaster.setFrstRegisterId(loginVO.getUniqId());
        }

        final String bbsId = egovBBSLoneMasterService.insertMaster(boardMaster);

        // when
        final BoardMaster searchVO = new BoardMaster();
        searchVO.setBbsId(bbsId);
        final BoardMasterVO result = egovBBSLoneMasterService.selectMaster(searchVO);

        // then
        if (log.isDebugEnabled()) {
            log.debug("bbsId={}", bbsId);
            log.debug("result={}", result);
        }

        assertNotNull(result, "조회된 게시판 정보는 null이 아니어야 한다.");
        assertEquals(bbsId, result.getBbsId(), "조회된 게시판 ID가 일치해야 한다.");
    }

    /**
     * 게시판 속성정보 목록 조회를 검증한다.
     *
     * @throws Exception
     */
    @Test
    void testSelectMasterList() throws Exception {
        // given
        final BoardMasterVO searchVO = new BoardMasterVO();
        searchVO.setPageIndex(1);
        searchVO.setRecordCountPerPage(10);
        searchVO.setFirstIndex(1);
        searchVO.setLastIndex(10);

        // when
        final Map<String, Object> resultMap = egovBBSLoneMasterService.selectMasterList(searchVO);

        // then
        if (log.isDebugEnabled()) {
            log.debug("resultMap={}", resultMap);
        }

        assertNotNull(resultMap, "목록 조회 결과는 null이 아니어야 한다.");
        assertNotNull(resultMap.get("resultList"), "resultList 키가 존재해야 한다.");
        assertNotNull(resultMap.get("resultCnt"), "resultCnt 키가 존재해야 한다.");

        @SuppressWarnings("unchecked")
        final List<BoardMasterVO> resultList = (List<BoardMasterVO>) resultMap.get("resultList");
        assertNotNull(resultList, "resultList는 null이 아니어야 한다.");
    }

    /**
     * 게시판 속성정보 수정을 검증한다.
     *
     * @throws Exception
     */
    @Test
    void testUpdateMaster() throws Exception {
        // given
        final BoardMaster boardMaster = new BoardMaster();
        final String suffix = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("uuuu-MM-dd'T'HH:mm:ss"));

        boardMaster.setBbsTyCode("BBST01");
        boardMaster.setBbsAttrbCode("BBSA03");
        boardMaster.setBbsNm("수정 전 게시판명 " + suffix);
        boardMaster.setBbsIntrcn("수정 테스트 소개 " + suffix);
        boardMaster.setReplyPosblAt("N");
        boardMaster.setFileAtchPosblAt("Y");
        boardMaster.setPosblAtchFileNumber(5);
        boardMaster.setPosblAtchFileSize("0");
        boardMaster.setTmplatId("TMPLAT_BOARD_DEFAULT");
        boardMaster.setUseAt("Y");

        final LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (loginVO != null) {
            boardMaster.setFrstRegisterId(loginVO.getUniqId());
            boardMaster.setLastUpdusrId(loginVO.getUniqId());
        }

        final String bbsId = egovBBSLoneMasterService.insertMaster(boardMaster);

        // when
        boardMaster.setBbsNm("수정 후 게시판명 " + suffix);
        egovBBSLoneMasterService.updateMaster(boardMaster);

        // then — 수정 후 다시 조회하여 변경 반영 여부 확인
        final BoardMaster searchVO = new BoardMaster();
        searchVO.setBbsId(bbsId);
        final BoardMasterVO updated = egovBBSLoneMasterService.selectMaster(searchVO);

        if (log.isDebugEnabled()) {
            log.debug("bbsId={}", bbsId);
            log.debug("updated={}", updated);
        }

        assertNotNull(updated, "수정 후 조회 결과는 null이 아니어야 한다.");
        assertEquals("수정 후 게시판명 " + suffix, updated.getBbsNm(), "게시판명이 수정된 값으로 반영되어야 한다.");
    }

    /**
     * 게시판 속성정보 삭제를 검증한다.
     *
     * @throws Exception
     */
    @Test
    void testDeleteMaster() throws Exception {
        // given
        final BoardMaster boardMaster = new BoardMaster();
        final String suffix = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("uuuu-MM-dd'T'HH:mm:ss"));

        boardMaster.setBbsTyCode("BBST01");
        boardMaster.setBbsAttrbCode("BBSA03");
        boardMaster.setBbsNm("삭제 테스트 게시판 " + suffix);
        boardMaster.setBbsIntrcn("삭제 테스트 소개 " + suffix);
        boardMaster.setReplyPosblAt("N");
        boardMaster.setFileAtchPosblAt("N");
        boardMaster.setPosblAtchFileNumber(0);
        boardMaster.setPosblAtchFileSize("0");
        boardMaster.setTmplatId("TMPLAT_BOARD_DEFAULT");
        boardMaster.setUseAt("Y");

        final LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (loginVO != null) {
            boardMaster.setFrstRegisterId(loginVO.getUniqId());
            boardMaster.setLastUpdusrId(loginVO.getUniqId());
        }

        final String bbsId = egovBBSLoneMasterService.insertMaster(boardMaster);

        // when
        egovBBSLoneMasterService.deleteMaster(boardMaster);

        // then — 삭제 후 단건 조회 시 null 반환 확인
        final BoardMaster searchVO = new BoardMaster();
        searchVO.setBbsId(bbsId);
        final BoardMasterVO deleted = egovBBSLoneMasterService.selectMaster(searchVO);

        if (log.isDebugEnabled()) {
            log.debug("bbsId={}", bbsId);
            log.debug("deleted={}", deleted);
        }

        assertNull(deleted, "삭제된 게시판은 조회 시 null이어야 한다.");
    }

}
