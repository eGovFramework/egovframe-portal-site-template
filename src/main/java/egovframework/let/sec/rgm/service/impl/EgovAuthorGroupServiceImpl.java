package egovframework.let.sec.rgm.service.impl;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.let.sec.rgm.service.AuthorGroup;
import egovframework.let.sec.rgm.service.AuthorGroupVO;
import egovframework.let.sec.rgm.service.EgovAuthorGroupService;
import lombok.RequiredArgsConstructor;

/**
 * 권한그룹에 관한 ServiceImpl 클래스를 정의한다.
 * 
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이문준          최초 생성
 *   2011.08.31  JJY           경량환경 템플릿 커스터마이징버전 생성
 *   2024.09.28  강동휘          컨트리뷰션 롬복 생성자 기반 종속성 주입
 *
 *      </pre>
 */

@Service
@RequiredArgsConstructor
public class EgovAuthorGroupServiceImpl extends EgovAbstractServiceImpl implements EgovAuthorGroupService {

	private final AuthorGroupDAO authorGroupDAO;

	/**
	 * 그룹별 할당된 권한 목록 조회
	 * 
	 * @param authorGroupVO AuthorGroupVO
	 * @return List<AuthorGroupVO>
	 * @exception Exception
	 */
	@Override
	public List<AuthorGroupVO> selectAuthorGroupList(AuthorGroupVO authorGroupVO) throws Exception {
		return authorGroupDAO.selectAuthorGroupList(authorGroupVO);
	}

	/**
	 * 그룹에 권한정보를 할당하여 데이터베이스에 등록
	 * 
	 * @param authorGroup AuthorGroup
	 * @exception Exception
	 */
	@Override
	public void insertAuthorGroup(AuthorGroup authorGroup) throws Exception {
		authorGroupDAO.insertAuthorGroup(authorGroup);
	}

	/**
	 * 화면에 조회된 그룹권한정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
	 * 
	 * @param authorGroup AuthorGroup
	 * @exception Exception
	 */
	@Override
	public void updateAuthorGroup(AuthorGroup authorGroup) throws Exception {
		authorGroupDAO.updateAuthorGroup(authorGroup);
	}

	/**
	 * 그룹별 할당된 시스템 메뉴 접근권한을 삭제
	 * 
	 * @param authorGroup AuthorGroup
	 * @exception Exception
	 */
	@Override
	public void deleteAuthorGroup(AuthorGroup authorGroup) throws Exception {
		authorGroupDAO.deleteAuthorGroup(authorGroup);
	}

	/**
	 * 목록조회 카운트를 반환한다
	 * 
	 * @param authorGroupVO AuthorGroupVO
	 * @return int
	 * @exception Exception
	 */
	@Override
	public int selectAuthorGroupListTotCnt(AuthorGroupVO authorGroupVO) throws Exception {
		return authorGroupDAO.selectAuthorGroupListTotCnt(authorGroupVO);
	}

}