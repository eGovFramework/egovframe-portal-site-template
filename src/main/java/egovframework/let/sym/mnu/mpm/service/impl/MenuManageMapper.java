package egovframework.let.sym.mnu.mpm.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.sym.mnu.mpm.service.MenuManageVO;

/**
 * 메뉴관리, 메뉴생성, 사이트맵 생성에 대한 MyBatis 매퍼 인터페이스를 정의한다.
 * @author 개발환경 개발팀
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
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */

@EgovMapper("menuManageMapper")
public interface MenuManageMapper {

    /**
     * MainMenu Head Menu 조회
     * @param vo MenuManageVO
     * @return List
     * @exception Exception
     */
    List<?> selectMainMenuHead(MenuManageVO vo) throws Exception;

    /**
     * MainMenu Left Menu 조회
     * @param vo MenuManageVO
     * @return List
     * @exception Exception
     */
    List<?> selectMainMenuLeft(MenuManageVO vo) throws Exception;

    /**
     * MainMenu Head MenuURL 조회
     * @param vo MenuManageVO
     * @return String
     * @exception Exception
     */
    String selectLastMenuURL(MenuManageVO vo) throws Exception;

    /**
     * MainMenu Left Menu 번호 조회
     * @param vo MenuManageVO
     * @return int
     * @exception Exception
     */
    int selectLastMenuNo(MenuManageVO vo) throws Exception;

    /**
     * MainMenu Left Menu 번호 카운트 조회
     * @param vo MenuManageVO
     * @return int
     * @exception Exception
     */
    int selectLastMenuNoCnt(MenuManageVO vo) throws Exception;

    /**
     * MainMenu Head Menu 조회 - Anonymous
     * @param vo MenuManageVO
     * @return List
     * @exception Exception
     */
    List<?> selectMainMenuHeadByAuthor(MenuManageVO vo) throws Exception;

    /**
     * MainMenu Left Menu 조회 - Anonymous
     * @param vo MenuManageVO
     * @return List
     * @exception Exception
     */
    List<?> selectMainMenuLeftByAuthor(MenuManageVO vo) throws Exception;

}
