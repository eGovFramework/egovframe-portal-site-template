package egovframework.let.uss.olh.qna.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.uss.olh.qna.service.QnaManageDefaultVO;
import egovframework.let.uss.olh.qna.service.QnaManageVO;

/**
 * Q&A정보를 처리하는 Mapper 인터페이스
 * @author 공통서비스 개발팀 박정규
 * @since 2009.04.01
 * @version 1.0
 */
@EgovMapper
public interface QnaManageMapper {

	QnaManageVO selectQnaListDetail(QnaManageVO vo) throws Exception;

	void updateQnaInqireCo(QnaManageVO vo) throws Exception;

	List<?> selectQnaList(QnaManageDefaultVO searchVO) throws Exception;

	int selectQnaListTotCnt(QnaManageDefaultVO searchVO);

	void insertQnaCn(QnaManageVO vo) throws Exception;

	int selectQnaPasswordConfirmCnt(QnaManageVO vo);

	void updateQnaCn(QnaManageVO vo) throws Exception;

	void deleteQnaCn(QnaManageVO vo) throws Exception;

	QnaManageVO selectQnaAnswerListDetail(QnaManageVO vo) throws Exception;

	List<?> selectQnaAnswerList(QnaManageDefaultVO searchVO) throws Exception;

	int selectQnaAnswerListTotCnt(QnaManageDefaultVO searchVO);

	void updateQnaCnAnswer(QnaManageVO vo) throws Exception;

}
