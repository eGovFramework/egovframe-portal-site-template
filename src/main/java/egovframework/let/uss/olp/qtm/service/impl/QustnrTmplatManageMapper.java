package egovframework.let.uss.olp.qtm.service.impl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.uss.olp.qtm.service.QustnrTmplatManageVO;

/**
 * 설문템플릿을 처리하는 Mapper 인터페이스
 * @author 공통서비스 장동한
 * @since 2009.03.20
 * @version 1.0
 */
@EgovMapper
public interface QustnrTmplatManageMapper {

	Map<?, ?> selectQustnrTmplatManageTmplatImagepathnm(QustnrTmplatManageVO qustnrTmplatManageVO);

	List<?> selectQustnrTmplatManage(ComDefaultVO searchVO);

	List<?> selectQustnrTmplatManageDetail(QustnrTmplatManageVO qustnrTmplatManageVO);

	int selectQustnrTmplatManageCnt(ComDefaultVO searchVO);

	void insertQustnrTmplatManage(QustnrTmplatManageVO qustnrTmplatManageVO);

	void updateQustnrTmplatManage(QustnrTmplatManageVO qustnrTmplatManageVO);

	void deleteQustnrRespondManage(QustnrTmplatManageVO qustnrTmplatManageVO);

	void deleteQustnrRespondInfo(QustnrTmplatManageVO qustnrTmplatManageVO);

	void deleteQustnrItemManage(QustnrTmplatManageVO qustnrTmplatManageVO);

	void deleteQustnrQestnManage(QustnrTmplatManageVO qustnrTmplatManageVO);

	void deleteQustnrManage(QustnrTmplatManageVO qustnrTmplatManageVO);

	void deleteQustnrTmplatManage(QustnrTmplatManageVO qustnrTmplatManageVO);

}
