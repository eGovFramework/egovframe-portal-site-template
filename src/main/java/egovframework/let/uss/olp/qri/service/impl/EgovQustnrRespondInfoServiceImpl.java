package egovframework.let.uss.olp.qri.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.cmmn.exception.BaseRuntimeException;
import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.uss.olp.qri.service.EgovQustnrRespondInfoService;
import egovframework.let.uss.olp.qri.service.QustnrRespondInfoVO;

/**
 * 설문조사 ServiceImpl Class 구현
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
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *   2024.08.13  이백행          시큐어코딩 Exception 제거
 *
 *      </pre>
 */
@Service("egovQustnrRespondInfoService")
public class EgovQustnrRespondInfoServiceImpl extends EgovAbstractServiceImpl implements EgovQustnrRespondInfoService {

	@Resource(name = "qustnrRespondInfoDao")
	private QustnrRespondInfoDao dao;

	@Resource(name = "qustnrRespondInfoIdGnrService")
	private EgovIdGnrService idgenService;

	/**
	 * 설문템플릿을 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return List
	 */
	@Override
	public List<?> selectQustnrTmplatManage(Map<?, ?> map) {
		return dao.selectQustnrTmplatManage(map);
	}

	/**
	 * 객관식 통계를 조회 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return List
	 */
	@Override
	public List<?> selectQustnrRespondInfoManageStatistics1(Map<?, ?> map) {
		return dao.selectQustnrRespondInfoManageStatistics1(map);
	}

	/**
	 * 주관식 통계를 조회 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return List
	 */
	@Override
	public List<?> selectQustnrRespondInfoManageStatistics2(Map<?, ?> map) {
		return dao.selectQustnrRespondInfoManageStatistics2(map);
	}

	/**
	 * 회원정보를 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return List
	 */
	@Override
	public Map<?, ?> selectQustnrRespondInfoManageEmplyrinfo(Map<?, ?> map) {
		return dao.selectQustnrRespondInfoManageEmplyrinfo(map);
	}

	/**
	 * 설문정보를 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return List
	 */
	@Override
	public List<?> selectQustnrRespondInfoManageComtnqestnrinfo(Map<?, ?> map) {
		return dao.selectQustnrRespondInfoManageComtnqestnrinfo(map);
	}

	/**
	 * 문항정보를 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return List
	 */
	@Override
	public List<?> selectQustnrRespondInfoManageComtnqustnrqesitm(Map<?, ?> map) {
		return dao.selectQustnrRespondInfoManageComtnqustnrqesitm(map);
	}

	/**
	 * 항목정보를 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return List
	 */
	@Override
	public List<?> selectQustnrRespondInfoManageComtnqustnriem(Map<?, ?> map) {
		return dao.selectQustnrRespondInfoManageComtnqustnriem(map);
	}

	/**
	 * 설문조사(설문등록)를(을) 목록을 조회한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return List
	 */
	@Override
	public List<?> selectQustnrRespondInfoManageList(ComDefaultVO searchVO) {
		return dao.selectQustnrRespondInfoManageList(searchVO);
	}

	/**
	 * 설문조사(설문등록)를(을) 목록 전체 건수를(을) 조회한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return
	 */
	@Override
	public int selectQustnrRespondInfoManageListCnt(ComDefaultVO searchVO) {
		return dao.selectQustnrRespondInfoManageListCnt(searchVO);
	}

	/**
	 * 응답자결과(설문조사) 목록을 조회한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return List
	 */
	@Override
	public List<?> selectQustnrRespondInfoList(ComDefaultVO searchVO) {
		return dao.selectQustnrRespondInfoList(searchVO);
	}

	/**
	 * 응답자결과(설문조사)를(을) 상세조회 한다.
	 * 
	 * @param QustnrRespondInfo - 회정정보가 담김 VO
	 * @return List
	 */
	@Override
	public List<?> selectQustnrRespondInfoDetail(QustnrRespondInfoVO qustnrRespondInfoVO) {
		return dao.selectQustnrRespondInfoDetail(qustnrRespondInfoVO);
	}

	/**
	 * 응답자결과(설문조사)를(을) 목록 전체 건수를(을) 조회한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return int
	 */
	@Override
	public int selectQustnrRespondInfoListCnt(ComDefaultVO searchVO) {
		return dao.selectQustnrRespondInfoListCnt(searchVO);
	}

	/**
	 * 응답자결과(설문조사)를(을) 등록한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 */
	@Override
	public void insertQustnrRespondInfo(QustnrRespondInfoVO qustnrRespondInfoVO) {
		String sMakeId;
		try {
			sMakeId = idgenService.getNextStringId();
		} catch (FdlException e) {
			throw new BaseRuntimeException("FdlException: qustnrRespondInfoIdGnrService", e);
		}

		qustnrRespondInfoVO.setQestnrQesrspnsId(sMakeId);

		dao.insertQustnrRespondInfo(qustnrRespondInfoVO);
	}

	/**
	 * 응답자결과(설문조사)를(을) 수정한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 */
	@Override
	public void updateQustnrRespondInfo(QustnrRespondInfoVO qustnrRespondInfoVO) {
		dao.updateQustnrRespondInfo(qustnrRespondInfoVO);
	}

	/**
	 * 응답자결과(설문조사)를(을) 삭제한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 */
	@Override
	public void deleteQustnrRespondInfo(QustnrRespondInfoVO qustnrRespondInfoVO) {
		dao.deleteQustnrRespondInfo(qustnrRespondInfoVO);
	}
}
