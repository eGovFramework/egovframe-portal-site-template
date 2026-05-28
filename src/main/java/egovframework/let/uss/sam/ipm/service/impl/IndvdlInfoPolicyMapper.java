package egovframework.let.uss.sam.ipm.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.uss.sam.ipm.service.IndvdlInfoPolicy;

/**
 * 개인정보보호정책를 처리하는 Mapper 인터페이스
 * @author 공통서비스 장동한
 * @since 2009.07.03
 * @version 1.0
 */
@EgovMapper
public interface IndvdlInfoPolicyMapper {

	List<?> selectIndvdlInfoPolicy(ComDefaultVO searchVO) throws Exception;

	int selectIndvdlInfoPolicyCnt() throws Exception;

	IndvdlInfoPolicy selectIndvdlInfoPolicyDetail(IndvdlInfoPolicy indvdlInfoPolicy) throws Exception;

	void insertIndvdlInfoPolicy(IndvdlInfoPolicy indvdlInfoPolicy) throws Exception;

	void updateIndvdlInfoPolicy(IndvdlInfoPolicy indvdlInfoPolicy) throws Exception;

	void deleteIndvdlInfoPolicy(IndvdlInfoPolicy indvdlInfoPolicy) throws Exception;

}
