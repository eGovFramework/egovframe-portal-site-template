package egovframework.let.uat.uia.service.impl;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.LoginVO;

/**
 * 일반 로그인을 처리하는 Mapper 인터페이스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 */
@EgovMapper
public interface LoginMapper {

	LoginVO actionLogin(LoginVO vo) throws Exception;

	LoginVO searchId(LoginVO vo) throws Exception;

	LoginVO searchPassword(LoginVO vo) throws Exception;

	void updatePassword(LoginVO vo) throws Exception;

}
