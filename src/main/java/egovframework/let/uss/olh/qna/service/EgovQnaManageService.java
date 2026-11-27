package egovframework.let.uss.olh.qna.service;

import java.util.List;

/**
 *
 * Q&A를 처리하는 서비스 클래스
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
 *
 * </pre>
 */
public interface EgovQnaManageService {

    /**
	 * Q&A 글을 조회한다.
	 * @param vo
	 * @return 조회한 글
	 */
	QnaManageVO selectQnaListDetail(QnaManageVO vo);

	/**
	 * Q&A 조회수를 수정한다.
	 * @param vo
	 */
    void updateQnaInqireCo(QnaManageVO vo);

    /**
	 * Q&A 글 목록을 조회한다.
	 * @param searchVO
	 * @return 글 목록
	 */
	List<?> selectQnaList(QnaManageDefaultVO searchVO);

    /**
	 * Q&A 글 총 갯수를 조회한다.
	 * @param searchVO
	 * @return 글 총 갯수
	 */
    int selectQnaListTotCnt(QnaManageDefaultVO searchVO);

	/**
	 * Q&A 글을 등록한다.
	 * @param vo
	 */
    void insertQnaCn(QnaManageVO vo);

    /**
	 * Q&A  작성비밀번호를 확인한다.
	 * @param vo
	 * @return 일치 여부
	 */
    boolean checkQnaPassword(QnaManageVO vo);

	/**
	 * Q&A 글을 수정한다.
	 * @param vo
	 */
    void updateQnaCn(QnaManageVO vo);

	/**
	 * Q&A 글을 삭제한다.
	 * @param vo
	 */
    void deleteQnaCn(QnaManageVO vo);


    /**
	 * Q&A 답변 글을 조회한다.
	 * @param vo
	 * @return 조회한 글
	 */
	QnaManageVO selectQnaAnswerListDetail(QnaManageVO vo);


    /**
	 * Q&A 답변 글 목록을 조회한다.
	 * @param searchVO
	 * @return 글 목록
	 */
	List<?> selectQnaAnswerList(QnaManageDefaultVO searchVO);

    /**
	 * Q&A 답변 글 총 갯수를 조회한다.
	 * @param searchVO
	 * @return 글 총 갯수
	 */
    int selectQnaAnswerListTotCnt(QnaManageDefaultVO searchVO);

	/**
	 * Q&A 답변 글을 수정한다.
	 * @param vo
	 */
    void updateQnaCnAnswer(QnaManageVO vo);


}

