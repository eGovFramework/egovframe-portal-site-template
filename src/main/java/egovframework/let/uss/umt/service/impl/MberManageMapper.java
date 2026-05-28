package egovframework.let.uss.umt.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.uss.umt.service.MberManageVO;
import egovframework.let.uss.umt.service.UserDefaultVO;

/**
 * 일반회원관리에 관한 Mapper 인터페이스를 정의한다.
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 */
@EgovMapper
public interface MberManageMapper {

	List<MberManageVO> selectMberList(UserDefaultVO userSearchVO);

	int selectMberListTotCnt(UserDefaultVO userSearchVO);

	void deleteMber_S(String delId);

	int insertMber_S(MberManageVO mberManageVO);

	MberManageVO selectMber_S(String mberId);

	void updateMber_S(MberManageVO mberManageVO);

	List<?> selectStplat_S(String stplatId);

	void updatePassword_S(MberManageVO passVO);

	MberManageVO selectPassword_S(MberManageVO mberManageVO);

	int checkIdDplct_S(String checkId);

}
