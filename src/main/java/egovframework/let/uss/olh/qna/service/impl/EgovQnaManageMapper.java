package egovframework.let.uss.olh.qna.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.uss.olh.qna.service.QnaManageDefaultVO;
import egovframework.let.uss.olh.qna.service.QnaManageVO;

/**
 * Q&A정보를 처리하는 매퍼 인터페이스
 *
 * @author 공통서비스 개발팀 박정규
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  박정규          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *   2025.05.28  표준프레임워크센터   @EgovMapper 어노테이션 방식으로 추가
 *
 * </pre>
 */
@EgovMapper("QnaManageDAO")
public interface EgovQnaManageMapper {

    /**
     * Q&A 글 목록에 대한 상세내용을 조회한다.
     * @param vo
     * @return 조회한 글
     * @exception Exception
     */
    QnaManageVO selectQnaListDetail(QnaManageVO vo) throws Exception;

    /**
     * Q&A 글을 수정한다.(조회수를 수정)
     * @param vo
     * @exception Exception
     */
    void updateQnaInqireCo(QnaManageVO vo) throws Exception;

    /**
     * Q&A 글 목록을 조회한다.
     * @param searchVO
     * @return 글 목록
     * @exception Exception
     */
    List<?> selectQnaList(QnaManageDefaultVO searchVO) throws Exception;

    /**
     * Q&A 글 총 갯수를 조회한다.
     * @param searchVO
     * @return 글 총 갯수
     */
    int selectQnaListTotCnt(QnaManageDefaultVO searchVO);

    /**
     * Q&A 글을 등록한다.
     * @param vo
     * @exception Exception
     */
    void insertQnaCn(QnaManageVO vo) throws Exception;

    /**
     * 작성비밀번호를 확인한다.
     * @param vo
     * @return 글 총 갯수
     */
    int selectQnaPasswordConfirmCnt(QnaManageVO vo);

    /**
     * Q&A 글을 수정한다.
     * @param vo
     * @exception Exception
     */
    void updateQnaCn(QnaManageVO vo) throws Exception;

    /**
     * Q&A 글을 삭제한다.
     * @param vo
     * @exception Exception
     */
    void deleteQnaCn(QnaManageVO vo) throws Exception;

    /**
     * Q&A 답변 글 목록에 대한 상세내용을 조회한다.
     * @param vo
     * @return 조회한 글
     * @exception Exception
     */
    QnaManageVO selectQnaAnswerListDetail(QnaManageVO vo) throws Exception;

    /**
     * Q&A 답변 글 목록을 조회한다.
     * @param searchVO
     * @return 글 목록
     * @exception Exception
     */
    List<?> selectQnaAnswerList(QnaManageDefaultVO searchVO) throws Exception;

    /**
     * Q&A 답변 글 총 갯수를 조회한다.
     * @param searchVO
     * @return 글 총 갯수
     */
    int selectQnaAnswerListTotCnt(QnaManageDefaultVO searchVO);

    /**
     * Q&A 답변 글을 수정한다.
     * @param vo
     * @exception Exception
     */
    void updateQnaCnAnswer(QnaManageVO vo) throws Exception;

}
