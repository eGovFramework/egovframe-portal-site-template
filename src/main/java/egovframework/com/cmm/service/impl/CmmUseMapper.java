package egovframework.com.cmm.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;

/**
 * 공통코드 등 전체 업무에서 공용으로 사용하는 Mapper 인터페이스
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009.03.11
 * @version 1.0
 */
@EgovMapper
public interface CmmUseMapper {

	List<CmmnDetailCode> selectCmmCodeDetail(ComDefaultCodeVO vo) throws Exception;

	List<CmmnDetailCode> selectOgrnztIdDetail(ComDefaultCodeVO vo) throws Exception;

	List<CmmnDetailCode> selectGroupIdDetail(ComDefaultCodeVO vo) throws Exception;

}
