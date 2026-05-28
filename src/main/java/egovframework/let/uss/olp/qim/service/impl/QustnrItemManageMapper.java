package egovframework.let.uss.olp.qim.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.uss.olp.qim.service.QustnrItemManageVO;

/**
 * 설문항목관리를 처리하는 Mapper 인터페이스
 * @author 공통서비스 장동한
 * @since 2009.03.20
 * @version 1.0
 */
@EgovMapper
public interface QustnrItemManageMapper {

	List<?> selectQustnrTmplatManage(QustnrItemManageVO qustnrItemManageVO) throws Exception;

	List<?> selectQustnrItemManage(ComDefaultVO searchVO) throws Exception;

	List<?> selectQustnrItemManageDetail(QustnrItemManageVO qustnrItemManageVO) throws Exception;

	int selectQustnrItemManageCnt(ComDefaultVO searchVO) throws Exception;

	void insertQustnrItemManage(QustnrItemManageVO qustnrItemManageVO) throws Exception;

	void updateQustnrItemManage(QustnrItemManageVO qustnrItemManageVO) throws Exception;

	void deleteQustnrRespondInfo(QustnrItemManageVO qustnrItemManageVO) throws Exception;

	void deleteQustnrItemManage(QustnrItemManageVO qustnrItemManageVO) throws Exception;

}
