package egovframework.let.uss.olp.qri.service.impl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.uss.olp.qri.service.QustnrRespondInfoVO;

/**
 * 설문조사를 처리하는 Mapper 인터페이스
 * @author 공통서비스 장동한
 * @since 2009.03.20
 * @version 1.0
 */
@EgovMapper
public interface QustnrRespondInfoMapper {

	List<?> selectQustnrTmplatManages(Map<?, ?> map) throws Exception;

	List<?> selectQustnrRespondInfoManageStatistics1(Map<?, ?> map) throws Exception;

	List<?> selectQustnrRespondInfoManageStatistics2(Map<?, ?> map) throws Exception;

	Map<?, ?> selectQustnrRespondInfoManageEmplyrinfo(Map<?, ?> map) throws Exception;

	List<?> selectQustnrRespondInfoManageComtnqestnrinfo(Map<?, ?> map) throws Exception;

	List<?> selectQustnrRespondInfoManageComtnqustnrqesitm(Map<?, ?> map) throws Exception;

	List<?> selectQustnrRespondInfoManageComtnqustnriem(Map<?, ?> map) throws Exception;

	List<?> selectQustnrRespondInfoManage(ComDefaultVO searchVO) throws Exception;

	int selectQustnrRespondInfoManageCnt(ComDefaultVO searchVO) throws Exception;

	List<?> selectQustnrTmplatManage(QustnrRespondInfoVO qustnrRespondInfoVO) throws Exception;

	void deleteQustnrRespondInfo(QustnrRespondInfoVO qustnrRespondInfoVO) throws Exception;

	void updateQustnrRespondInfo(QustnrRespondInfoVO qustnrRespondInfoVO) throws Exception;

	List<?> selectQustnrRespondInfoDetail(QustnrRespondInfoVO qustnrRespondInfoVO) throws Exception;

	List<?> selectQustnrRespondInfo(ComDefaultVO searchVO) throws Exception;

	int selectQustnrRespondInfoCnt(ComDefaultVO searchVO) throws Exception;

	void insertQustnrRespondInfo(QustnrRespondInfoVO qustnrRespondInfoVO) throws Exception;

}
