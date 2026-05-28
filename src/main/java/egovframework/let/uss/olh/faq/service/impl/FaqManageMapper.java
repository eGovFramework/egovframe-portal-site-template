package egovframework.let.uss.olh.faq.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.uss.olh.faq.service.FaqManageDefaultVO;
import egovframework.let.uss.olh.faq.service.FaqManageVO;

/**
 * FAQ를 처리하는 Mapper 인터페이스
 * @author 공통서비스 개발팀 박정규
 * @since 2009.04.01
 * @version 1.0
 */
@EgovMapper
public interface FaqManageMapper {

	FaqManageVO selectFaqListDetail(FaqManageVO vo) throws Exception;

	void updateFaqInqireCo(FaqManageVO vo) throws Exception;

	List<?> selectFaqList(FaqManageDefaultVO searchVO) throws Exception;

	int selectFaqListTotCnt(FaqManageDefaultVO searchVO);

	void insertFaqCn(FaqManageVO vo) throws Exception;

	void updateFaqCn(FaqManageVO vo) throws Exception;

	void deleteFaqCn(FaqManageVO vo) throws Exception;

}
