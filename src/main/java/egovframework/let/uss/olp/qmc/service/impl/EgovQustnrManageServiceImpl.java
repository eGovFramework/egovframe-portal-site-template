package egovframework.let.uss.olp.qmc.service.impl;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.uss.olp.qmc.service.EgovQustnrManageService;
import egovframework.let.uss.olp.qmc.service.QustnrManageVO;
import lombok.RequiredArgsConstructor;

/**
 * 설문관리를 처리하는 ServiceImpl Class 구현
 * 
 * @author 공통서비스 장동한
 * @since 2009.03.20
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  장동한          최초 생성
 *
 *      </pre>
 */
@Service
@RequiredArgsConstructor
public class EgovQustnrManageServiceImpl extends EgovAbstractServiceImpl implements EgovQustnrManageService {

	private final QustnrManageDao qustnrManageDao;

	private final EgovIdGnrService egovQustnrManageIdGnrService;

	/**
	 * 설문템플릿 목록을 조회한다.
	 * 
	 * @param qustnrManageVO - 설문관리 정보 담김 VO
	 * @return List
	 * @throws Exception
	 */
	@Override
	public List<?> selectQustnrTmplatManageList(QustnrManageVO qustnrManageVO) throws Exception {
		return qustnrManageDao.selectQustnrTmplatManageList(qustnrManageVO);
	}

	/**
	 * 설문관리 목록을 조회한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return List
	 * @throws Exception
	 */
	@Override
	public List<?> selectQustnrManageList(ComDefaultVO searchVO) throws Exception {
		return qustnrManageDao.selectQustnrManageList(searchVO);
	}

	/**
	 * 설문관리를 상세조회(Model) 한다.
	 * 
	 * @param qustnrManageVO - 설문관리 정보 담김 VO
	 * @return List
	 * @throws Exception
	 */
	@Override
	public QustnrManageVO selectQustnrManageDetailModel(QustnrManageVO qustnrManageVO) throws Exception {
		return qustnrManageDao.selectQustnrManageDetailModel(qustnrManageVO);
	}

	/**
	 * 설문관리를(을) 상세조회 한다.
	 * 
	 * @param QustnrManage - 회정정보가 담김 VO
	 * @return List
	 * @throws Exception
	 */
	@Override
	public List<?> selectQustnrManageDetail(QustnrManageVO qustnrManageVO) throws Exception {
		return qustnrManageDao.selectQustnrManageDetail(qustnrManageVO);
	}

	/**
	 * 설문관리를(을) 목록 전체 건수를(을) 조회한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return int
	 * @throws Exception
	 */
	@Override
	public int selectQustnrManageListCnt(ComDefaultVO searchVO) throws Exception {
		return qustnrManageDao.selectQustnrManageListCnt(searchVO);
	}

	/**
	 * 설문관리를(을) 등록한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @throws Exception
	 */
	@Override
	public void insertQustnrManage(QustnrManageVO qustnrManageVO) throws Exception {
		String sMakeId = egovQustnrManageIdGnrService.getNextStringId();

		qustnrManageVO.setQestnrId(sMakeId);

		qustnrManageDao.insertQustnrManage(qustnrManageVO);
	}

	/**
	 * 설문관리를(을) 수정한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @throws Exception
	 */
	@Override
	public void updateQustnrManage(QustnrManageVO qustnrManageVO) throws Exception {
		qustnrManageDao.updateQustnrManage(qustnrManageVO);
	}

	/**
	 * 설문관리를(을) 삭제한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @throws Exception
	 */
	@Override
	public void deleteQustnrManage(QustnrManageVO qustnrManageVO) throws Exception {
		qustnrManageDao.deleteQustnrManage(qustnrManageVO);
	}
}
