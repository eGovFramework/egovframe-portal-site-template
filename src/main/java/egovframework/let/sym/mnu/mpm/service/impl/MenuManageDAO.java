package egovframework.let.sym.mnu.mpm.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.let.sym.mnu.mpm.service.MenuManageVO;

/**
 * 메뉴관리, 메뉴생성, 사이트맵 생성에 대한 DAO 클래스를 정의한다.
 * 
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용         최초 생성
 *   2011.07.01  서준식          자기 메뉴 정보를 상위메뉴 정보로 참조하는 메뉴정보가 있는지 조회하는
 *                            selectUpperMenuNoByPk() 메서드 추가
 *   2011.08.31  JJY          경량환경 템플릿 커스터마이징버전 생성
 *   2024.08.10  이백행          이클립스 문제(Problems) 제거
 *   2024.08.20  이백행          시큐어코딩 Exception 제거
 *
 *      </pre>
 */

@Repository("menuManageDAO")
public class MenuManageDAO extends EgovAbstractMapper {

	/* ### 메뉴관련 프로세스 ### */
	/**
	 * MainMenu Head Menu 조회
	 * 
	 * @param vo MenuManageVO
	 * @return List
	 */
	public List<?> selectMainMenuHead(MenuManageVO vo) {
		return selectList("menuManageDAO.selectMainMenuHead", vo);
	}

	/**
	 * MainMenu Left Menu 조회
	 * 
	 * @param vo MenuManageVO
	 * @return List
	 */
	public List<?> selectMainMenuLeft(MenuManageVO vo) {
		return selectList("menuManageDAO.selectMainMenuLeft", vo);
	}

	/**
	 * MainMenu Head MenuURL 조회
	 * 
	 * @param vo MenuManageVO
	 * @return String
	 */
	public String selectLastMenuURL(MenuManageVO vo) {
		return (String) selectOne("menuManageDAO.selectLastMenuURL", vo);
	}

	/**
	 * MainMenu Left Menu 조회
	 * 
	 * @param vo MenuManageVO
	 * @return int
	 */
	public int selectLastMenuNo(MenuManageVO vo) {
		return (Integer) selectOne("menuManageDAO.selectLastMenuNo", vo);
	}

	/**
	 * MainMenu Left Menu 조회
	 * 
	 * @param vo MenuManageVO
	 * @return int
	 */
	public int selectLastMenuNoCnt(MenuManageVO vo) {
		return (Integer) selectOne("menuManageDAO.selectLastMenuNoCnt", vo);
	}

	/**
	 * MainMenu Head Menu 조회 - Anonymous
	 * 
	 * @param vo MenuManageVO
	 * @return List
	 */
	public List<?> selectMainMenuHeadByAuthor(MenuManageVO vo) {
		return selectList("menuManageDAO.selectMainMenuHeadByAuthor", vo);
	}

	/**
	 * MainMenu Left Menu 조회 - Anonymous
	 * 
	 * @param vo MenuManageVO
	 * @return List
	 */
	public List<?> selectMainMenuLeftByAuthor(MenuManageVO vo) {
		return selectList("menuManageDAO.selectMainMenuLeftByAuthor", vo);
	}

}