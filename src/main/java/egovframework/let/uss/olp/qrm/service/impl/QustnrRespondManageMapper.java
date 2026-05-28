package egovframework.let.uss.olp.qrm.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.uss.olp.qrm.service.QustnrRespondManageVO;

/**
 * 설문응답자관리를 처리하는 Mapper 인터페이스
 * @author 공통서비스 장동한
 * @since 2009.03.20
 * @version 1.0
 */
@EgovMapper
public interface QustnrRespondManageMapper {

	List<?> selectQustnrRespondManage(ComDefaultVO searchVO) throws Exception;

	List<?> selectQustnrRespondManageDetail(QustnrRespondManageVO qustnrRespondManageVO) throws Exception;

	int selectQustnrRespondManageCnt(ComDefaultVO searchVO) throws Exception;

	void insertQustnrRespondManage(QustnrRespondManageVO qustnrRespondManageVO) throws Exception;

	void updateQustnrRespondManage(QustnrRespondManageVO qustnrRespondManageVO) throws Exception;

	void deleteQustnrRespondManage(QustnrRespondManageVO qustnrRespondManageVO) throws Exception;

}
