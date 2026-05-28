package egovframework.let.sec.ram.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.sec.ram.service.AuthorManage;
import egovframework.let.sec.ram.service.AuthorManageVO;

/**
 * 권한관리에 대한 Mapper 인터페이스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이문준          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@EgovMapper
public interface AuthorManageMapper {

    /**
     * 권한목록을 조회한다.
     * @param authorManageVO AuthorManageVO
     * @return List<AuthorManageVO>
     * @exception Exception
     */
    List<AuthorManageVO> selectAuthorList(AuthorManageVO authorManageVO) throws Exception;

    /**
     * 권한을 등록한다.
     * @param authorManage AuthorManage
     * @exception Exception
     */
    void insertAuthor(AuthorManage authorManage) throws Exception;

    /**
     * 권한을 수정한다.
     * @param authorManage AuthorManage
     * @exception Exception
     */
    void updateAuthor(AuthorManage authorManage) throws Exception;

    /**
     * 권한을 삭제한다.
     * @param authorManage AuthorManage
     * @exception Exception
     */
    void deleteAuthor(AuthorManage authorManage) throws Exception;

    /**
     * 권한을 조회한다.
     * @param authorManageVO AuthorManageVO
     * @return AuthorManageVO
     * @exception Exception
     */
    AuthorManageVO selectAuthor(AuthorManageVO authorManageVO) throws Exception;

    /**
     * 권한목록 총 갯수를 조회한다.
     * @param authorManageVO AuthorManageVO
     * @return int
     * @exception Exception
     */
    int selectAuthorListTotCnt(AuthorManageVO authorManageVO) throws Exception;

    /**
     * 모든 권한목록을 조회한다.
     * @param authorManageVO AuthorManageVO
     * @return List<AuthorManageVO>
     * @exception Exception
     */
    List<AuthorManageVO> selectAuthorAllList(AuthorManageVO authorManageVO) throws Exception;

}
