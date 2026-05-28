package egovframework.let.uss.olp.qmc.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.uss.olp.qmc.service.QustnrManageVO;

/**
 * 설문관리를 처리하는 Mapper 인터페이스
 * @author 공통서비스 장동한
 * @since 2009.03.20
 * @version 1.0
 */
@EgovMapper
public interface QustnrManageMapper {

	List<?> selectQustnrTmplatManage(QustnrManageVO qustnrManageVO) throws Exception;

	List<?> selectQustnrManage(ComDefaultVO searchVO) throws Exception;

	QustnrManageVO selectQustnrManageDetailModel(QustnrManageVO qustnrManageVO) throws Exception;

	List<?> selectQustnrManageDetail(QustnrManageVO qustnrManageVO) throws Exception;

	int selectQustnrManageCnt(ComDefaultVO searchVO) throws Exception;

	void insertQustnrManage(QustnrManageVO qustnrManageVO) throws Exception;

	void updateQustnrManage(QustnrManageVO qustnrManageVO) throws Exception;

	void deleteQustnrRespondManage(QustnrManageVO qustnrManageVO) throws Exception;

	void deleteQustnrRespondInfo(QustnrManageVO qustnrManageVO) throws Exception;

	void deleteQustnrItemManage(QustnrManageVO qustnrManageVO) throws Exception;

	void deleteQustnrQestnManage(QustnrManageVO qustnrManageVO) throws Exception;

	void deleteQustnrManage(QustnrManageVO qustnrManageVO) throws Exception;

}
