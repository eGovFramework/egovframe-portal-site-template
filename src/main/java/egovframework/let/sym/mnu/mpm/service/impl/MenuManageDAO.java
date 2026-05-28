package egovframework.let.sym.mnu.mpm.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.springframework.stereotype.Repository;

import egovframework.let.sym.mnu.mpm.service.MenuManageVO;

/**
 * 메뉴관리, 메뉴생성, 사이트맵 생성에 대한 DAO 클래스를 정의한다.
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *   2011.07.01  서준식          selectUpperMenuNoByPk() 메서드 추가
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Repository("menuManageDAO")
public class MenuManageDAO {

	@Resource
	private MenuManageMapper menuManageMapper;

	/*### 메뉴관련 프로세스 ###*/
	/**
	 * MainMenu Head Menu 조회
	 * @param vo MenuManageVO
	 * @return List
	 * @exception Exception
	 */
	public List<?> selectMainMenuHead(MenuManageVO vo) throws Exception {
		return menuManageMapper.selectMainMenuHead(vo);
	}

	/**
	 * MainMenu Left Menu 조회
	 * @param vo MenuManageVO
	 * @return List
	 * @exception Exception
	 */
	public List<?> selectMainMenuLeft(MenuManageVO vo) throws Exception {
		return menuManageMapper.selectMainMenuLeft(vo);
	}

	/**
	 * MainMenu Head MenuURL 조회
	 * @param vo MenuManageVO
	 * @return String
	 * @exception Exception
	 */
	public String selectLastMenuURL(MenuManageVO vo) throws Exception {
		return menuManageMapper.selectLastMenuURL(vo);
	}

	/**
	 * MainMenu Left Menu 조회
	 * @param vo MenuManageVO
	 * @return int
	 * @exception Exception
	 */
	public int selectLastMenuNo(MenuManageVO vo) throws Exception {
		return menuManageMapper.selectLastMenuNo(vo);
	}

	/**
	 * MainMenu Left Menu 조회
	 * @param vo MenuManageVO
	 * @return int
	 * @exception Exception
	 */
	public int selectLastMenuNoCnt(MenuManageVO vo) throws Exception {
		return menuManageMapper.selectLastMenuNoCnt(vo);
	}

	/**
	 * MainMenu Head Menu 조회 - Anonymous
	 * @param vo MenuManageVO
	 * @return List
	 * @exception Exception
	 */
	public List<?> selectMainMenuHeadByAuthor(MenuManageVO vo) throws Exception {
		return menuManageMapper.selectMainMenuHeadByAuthor(vo);
	}

	/**
	 * MainMenu Left Menu 조회 - Anonymous
	 * @param vo MenuManageVO
	 * @return List
	 * @exception Exception
	 */
	public List<?> selectMainMenuLeftByAuthor(MenuManageVO vo) throws Exception {
		return menuManageMapper.selectMainMenuLeftByAuthor(vo);
	}

}