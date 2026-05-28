package egovframework.let.uss.olp.qqm.service.impl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.uss.olp.qqm.service.QustnrQestnManageVO;

/**
 * 설문문항을 처리하는 Mapper 인터페이스
 * @author 공통서비스 장동한
 * @since 2009.03.20
 * @version 1.0
 */
@EgovMapper
public interface QustnrQestnManageMapper {

	List<?> selectQustnrManageStatistics2(Map<?, ?> map) throws Exception;

	List<?> selectQustnrManageStatistics(Map<?, ?> map) throws Exception;

	Map<?, ?> selectQustnrManageQestnrSj(Map<?, ?> map) throws Exception;

	List<?> selectQustnrQestnManage(ComDefaultVO searchVO) throws Exception;

	List<?> selectQustnrQestnManageDetail(QustnrQestnManageVO qustnrQestnManageVO) throws Exception;

	int selectQustnrQestnManageCnt(ComDefaultVO searchVO) throws Exception;

	void insertQustnrQestnManage(QustnrQestnManageVO qustnrQestnManageVO) throws Exception;

	void updateQustnrQestnManage(QustnrQestnManageVO qustnrQestnManageVO) throws Exception;

	void deleteQustnrRespondInfo(QustnrQestnManageVO qustnrQestnManageVO) throws Exception;

	void deleteQustnrItemManage(QustnrQestnManageVO qustnrQestnManageVO) throws Exception;

	void deleteQustnrQestnManage(QustnrQestnManageVO qustnrQestnManageVO) throws Exception;

}
