package egovframework.let.uss.sam.stp.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.uss.sam.stp.service.StplatManageDefaultVO;
import egovframework.let.uss.sam.stp.service.StplatManageVO;

/**
 * 약관내용을 처리하는 Mapper 인터페이스
 * @author 공통서비스 개발팀 박정규
 * @since 2009.04.01
 * @version 1.0
 */
@EgovMapper
public interface StplatManageMapper {

	StplatManageVO selectStplatDetail(StplatManageVO vo) throws Exception;

	List<?> selectStplatList(StplatManageDefaultVO searchVO) throws Exception;

	int selectStplatListTotCnt(StplatManageDefaultVO searchVO);

	void insertStplatCn(StplatManageVO vo) throws Exception;

	void updateStplatCn(StplatManageVO vo) throws Exception;

	void deleteStplatCn(StplatManageVO vo) throws Exception;

}
