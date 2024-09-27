package egovframework.let.uss.olp.qtm.service.impl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.uss.olp.qtm.service.QustnrTmplatManageVO;

/**
 * 설문템플릿 Dao Class 구현
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
 *   2024.09.24  이백행          컨트리뷰션 롬복 생성자 기반 종속성 주입
 *
 *      </pre>
 */
//@Repository("qustnrTmplatManageDao")
@Repository
public class QustnrTmplatManageDao extends EgovAbstractMapper {

	/**
	 * 템플릿파일명을 조회한다.
	 * 
	 * @param qustnrTmplatManageVO - 조회할 정보가 담긴 VO
	 * @return List
	 * @throws Exception
	 */
	public Map<?, ?> selectQustnrTmplatManageTmplatImagepathnm(QustnrTmplatManageVO qustnrTmplatManageVO) {
		return (Map<?, ?>) selectOne("QustnrTmplatManage.selectQustnrTmplatManageTmplatImagepathnm",
				qustnrTmplatManageVO);
	}

	/**
	 * 설문템플릿 목록을 조회한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return List
	 * @throws Exception
	 */
	public List<?> selectQustnrTmplatManageList(ComDefaultVO searchVO) {
		return selectList("QustnrTmplatManage.selectQustnrTmplatManage", searchVO);
	}

	/**
	 * 설문템플릿를(을) 상세조회 한다.
	 * 
	 * @param QustnrTmplatManage - 회정정보가 담김 VO
	 * @return List
	 * @throws Exception
	 */
	public List<?> selectQustnrTmplatManageDetail(QustnrTmplatManageVO qustnrTmplatManageVO) {
		return selectList("QustnrTmplatManage.selectQustnrTmplatManageDetail", qustnrTmplatManageVO);
	}

	/**
	 * 설문템플릿를(을) 목록 전체 건수를(을) 조회한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return int
	 * @throws Exception
	 */
	public int selectQustnrTmplatManageListCnt(ComDefaultVO searchVO) {
		return (Integer) selectOne("QustnrTmplatManage.selectQustnrTmplatManageCnt", searchVO);
	}

	/**
	 * 설문템플릿를(을) 등록한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @throws Exception
	 */
	public void insertQustnrTmplatManage(QustnrTmplatManageVO qustnrTmplatManageVO) {
		insert("QustnrTmplatManage.insertQustnrTmplatManage", qustnrTmplatManageVO);
	}

	/**
	 * 설문템플릿를(을) 수정한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @throws Exception
	 */
	public void updateQustnrTmplatManage(QustnrTmplatManageVO qustnrTmplatManageVO) {
		insert("QustnrTmplatManage.updateQustnrTmplatManage", qustnrTmplatManageVO);
	}

	/**
	 * 설문템플릿를(을) 삭제한다.
	 * 
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @throws Exception
	 */
	public void deleteQustnrTmplatManage(QustnrTmplatManageVO qustnrTmplatManageVO) {
		// 설문응답자 삭제
		delete("QustnrTmplatManage.deleteQustnrRespondManage", qustnrTmplatManageVO);
		// 설문조사(설문결과) 삭제
		delete("QustnrTmplatManage.deleteQustnrRespondInfo", qustnrTmplatManageVO);
		// 설문항목 삭제
		delete("QustnrTmplatManage.deleteQustnrItemManage", qustnrTmplatManageVO);
		// 설문문항 삭제
		delete("QustnrTmplatManage.deleteQustnrQestnManage", qustnrTmplatManageVO);
		// 설문관리 삭제
		delete("QustnrTmplatManage.deleteQustnrManage", qustnrTmplatManageVO);

		// 설문템플릿삭제
		delete("QustnrTmplatManage.deleteQustnrTmplatManage", qustnrTmplatManageVO);
	}
}
