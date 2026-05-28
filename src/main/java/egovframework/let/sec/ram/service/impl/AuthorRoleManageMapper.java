package egovframework.let.sec.ram.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.sec.ram.service.AuthorRoleManage;
import egovframework.let.sec.ram.service.AuthorRoleManageVO;

/**
 * 권한별 롤관리에 대한 Mapper 인터페이스를 정의한다.
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
public interface AuthorRoleManageMapper {

    /**
     * 권한 롤 관계정보 목록 조회
     * @param authorRoleManageVO AuthorRoleManageVO
     * @return List<AuthorRoleManageVO>
     * @exception Exception
     */
    List<AuthorRoleManageVO> selectAuthorRoleList(AuthorRoleManageVO authorRoleManageVO) throws Exception;

    /**
     * 목록조회 카운트를 반환한다
     * @param authorRoleManageVO AuthorRoleManageVO
     * @return int
     * @exception Exception
     */
    int selectAuthorRoleListTotCnt(AuthorRoleManageVO authorRoleManageVO) throws Exception;

    /**
     * 권한 롤 관계정보를 화면에서 입력하여 입력항목의 정합성을 체크하고 데이터베이스에 저장
     * @param authorRoleManage AuthorRoleManage
     * @exception Exception
     */
    void insertAuthorRole(AuthorRoleManage authorRoleManage) throws Exception;

    /**
     * 권한 롤 관계정보를 화면에 조회하여 데이터베이스에서 삭제
     * @param authorRoleManage AuthorRoleManage
     * @exception Exception
     */
    void deleteAuthorRole(AuthorRoleManage authorRoleManage) throws Exception;

}
