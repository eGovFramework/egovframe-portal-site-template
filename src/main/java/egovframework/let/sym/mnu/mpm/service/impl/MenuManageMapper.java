package egovframework.let.sym.mnu.mpm.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.sym.mnu.mpm.service.MenuManageVO;

/**
 * 메뉴관리, 메뉴생성, 사이트맵 생성에 대한 Mapper 인터페이스를 정의한다.
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 */
@EgovMapper
public interface MenuManageMapper {

	List<?> selectMainMenuHead(MenuManageVO vo) throws Exception;

	List<?> selectMainMenuLeft(MenuManageVO vo) throws Exception;

	String selectLastMenuURL(MenuManageVO vo) throws Exception;

	int selectLastMenuNo(MenuManageVO vo) throws Exception;

	int selectLastMenuNoCnt(MenuManageVO vo) throws Exception;

	List<?> selectMainMenuHeadByAuthor(MenuManageVO vo) throws Exception;

	List<?> selectMainMenuLeftByAuthor(MenuManageVO vo) throws Exception;

}
