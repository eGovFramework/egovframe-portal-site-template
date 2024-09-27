package egovframework.let.uss.olp.qrm.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.uss.olp.qrm.service.QustnrRespondManageVO;

/**
 * 설문응답자관리 Dao Class 구현
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
 *   2011.08.31  JJY           경량환경 템플릿 커스터마이징버전 생성
 *   2024.08.10  이백행          이클립스 문제(Problems) 제거
 *   2024.09.26  이백행          컨트리뷰션 롬복 생성자 기반 종속성 주입
 *
 *      </pre>
 */
@Repository
public class QustnrRespondManageDao extends EgovAbstractMapper {

	/**
	 * 응답자정보 목록을 조회한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return List
	 * @throws Exception
	 */
	public List<?> selectQustnrRespondManageList(ComDefaultVO searchVO) throws Exception {
		return selectList("QustnrRespondManage.selectQustnrRespondManage", searchVO);
	}

	/**
	 * 응답자정보를(을) 상세조회 한다.
	 * 
	 * @param qustnrRespondManageVO - 응답자정보 정보 담김 VO
	 * @return List
	 * @throws Exception
	 */
	public List<?> selectQustnrRespondManageDetail(QustnrRespondManageVO qustnrRespondManageVO) throws Exception {
		return selectList("QustnrRespondManage.selectQustnrRespondManageDetail", qustnrRespondManageVO);
	}

	/**
	 * 응답자정보를(을) 목록 전체 건수를(을) 조회한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return int
	 * @throws Exception
	 */
	public int selectQustnrRespondManageListCnt(ComDefaultVO searchVO) throws Exception {
		return (Integer) selectOne("QustnrRespondManage.selectQustnrRespondManageCnt", searchVO);
	}

	/**
	 * 응답자정보를(을) 등록한다.
	 * 
	 * @param qqustnrRespondManageVO - 응답자정보 정보 담김 VO
	 * @throws Exception
	 */
	public void insertQustnrRespondManage(QustnrRespondManageVO qustnrRespondManageVO) throws Exception {
		insert("QustnrRespondManage.insertQustnrRespondManage", qustnrRespondManageVO);
	}

	/**
	 * 응답자정보를(을) 수정한다.
	 * 
	 * @param qustnrRespondManageVO - 응답자정보 정보 담김 VO
	 * @throws Exception
	 */
	public void updateQustnrRespondManage(QustnrRespondManageVO qustnrRespondManageVO) throws Exception {
		insert("QustnrRespondManage.updateQustnrRespondManage", qustnrRespondManageVO);
	}

	/**
	 * 응답자정보를(을) 삭제한다.
	 * 
	 * @param qustnrRespondManageVO - 응답자정보 정보 담김 VO
	 * @throws Exception
	 */
	public void deleteQustnrRespondManage(QustnrRespondManageVO qustnrRespondManageVO) throws Exception {
		insert("QustnrRespondManage.deleteQustnrRespondManage", qustnrRespondManageVO);
	}
}
