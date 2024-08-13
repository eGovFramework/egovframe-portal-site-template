package egovframework.let.uss.olp.qri.service;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.ComDefaultVO;

/**
 * 설문조사 Service Class 구현
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
public interface EgovQustnrRespondInfoService {

	/**
	 * 설문템플릿을 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return List
	 */
	public List<?> selectQustnrTmplatManage(Map<?, ?> map);

	/**
	 * 객관식 통계를 조회 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return List
	 */
	public List<?> selectQustnrRespondInfoManageStatistics1(Map<?, ?> map);

	/**
	 * 주관식 통계를 조회 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return List
	 */
	public List<?> selectQustnrRespondInfoManageStatistics2(Map<?, ?> map);

	/**
	 * 회원정보를 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return List
	 */
	public Map<?, ?> selectQustnrRespondInfoManageEmplyrinfo(Map<?, ?> map);

	/**
	 * 설문정보를 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return List
	 */
	public List<?> selectQustnrRespondInfoManageComtnqestnrinfo(Map<?, ?> map);

	/**
	 * 문항정보를 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return List
	 */
	public List<?> selectQustnrRespondInfoManageComtnqustnrqesitm(Map<?, ?> map);

	/**
	 * 항목정보를 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return List
	 */
	public List<?> selectQustnrRespondInfoManageComtnqustnriem(Map<?, ?> map);

	/**
	 * 설문조사(설문등록)를(을) 목록을 조회한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return List
	 */
	public List<?> selectQustnrRespondInfoManageList(ComDefaultVO searchVO);

	/**
	 * 설문조사(설문등록)를(을) 목록 전체 건수를(을) 조회한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return
	 */
	public int selectQustnrRespondInfoManageListCnt(ComDefaultVO searchVO);

	/**
	 * 응답자결과(설문조사) 목록을 조회한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return List
	 */
	public List<?> selectQustnrRespondInfoList(ComDefaultVO searchVO);

	/**
	 * 응답자결과(설문조사)를(을) 상세조회 한다.
	 * 
	 * @param qustnrRespondInfoVO - 응답자결과(설문조사) 정보 담김 VO
	 * @return List
	 */
	public List<?> selectQustnrRespondInfoDetail(QustnrRespondInfoVO qustnrRespondInfoVO);

	/**
	 * 응답자결과(설문조사)를(을) 목록 전체 건수를(을) 조회한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return int
	 */
	public int selectQustnrRespondInfoListCnt(ComDefaultVO searchVO);

	/**
	 * 응답자결과(설문조사)를(을) 등록한다.
	 * 
	 * @param qustnrRespondInfoVO - 응답자결과(설문조사) 정보 담김 VO
	 */
	void insertQustnrRespondInfo(QustnrRespondInfoVO qustnrRespondInfoVO);

	/**
	 * 응답자결과(설문조사)를(을) 수정한다.
	 * 
	 * @param qustnrRespondInfoVO - 응답자결과(설문조사) 정보 담김 VO
	 */
	void updateQustnrRespondInfo(QustnrRespondInfoVO qustnrRespondInfoVO);

	/**
	 * 응답자결과(설문조사)를(을) 삭제한다.
	 * 
	 * @param qustnrRespondInfoVO - 응답자결과(설문조사) 정보 담김 VO
	 */
	void deleteQustnrRespondInfo(QustnrRespondInfoVO qustnrRespondInfoVO);

}
