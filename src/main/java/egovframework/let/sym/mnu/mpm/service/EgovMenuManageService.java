package egovframework.let.sym.mnu.mpm.service;

import java.util.List;

/**
 * 메뉴관리에 관한 서비스 인터페이스 클래스를 정의한다.
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
 *   2009.03.20  이  용          최초 생성
 *   2011.07.01  서준식			자기 메뉴 정보를 상위메뉴 정보로 참조하는 메뉴정보가 있는지 조회하는
 *   							selectUpperMenuNoByPk() 메서드 추가
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *   2024.08.13  이백행          시큐어코딩 Exception 제거
 *
 *      </pre>
 */

public interface EgovMenuManageService {

	/* ### 메뉴관련 프로세스 ### */
	/**
	 * MainMenu Head Menu 조회
	 * 
	 * @param vo MenuManageVO
	 * @return List
	 */
	List<?> selectMainMenuHead(MenuManageVO vo);

	/**
	 * MainMenu Head Left 조회
	 * 
	 * @param vo MenuManageVO
	 * @return List
	 */
	List<?> selectMainMenuLeft(MenuManageVO vo);

	/**
	 * MainMenu Head MenuURL 조회
	 * 
	 * @param iMenuNo int
	 * @param sUniqId String
	 * @return String
	 */
	String selectLastMenuURL(int iMenuNo, String sUniqId);

	/**
	 * MainMenu Head Menu 조회 - Anonymous
	 * 
	 * @param vo MenuManageVO
	 * @return List
	 */
	List<?> selectMainMenuHeadByAuthor(MenuManageVO vo);

	/**
	 * MainMenu Head Left 조회 - Anonymous
	 * 
	 * @param vo MenuManageVO
	 * @return List
	 */
	List<?> selectMainMenuLeftByAuthor(MenuManageVO vo);

}