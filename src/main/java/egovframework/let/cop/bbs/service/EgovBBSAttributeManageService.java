package egovframework.let.cop.bbs.service;

import java.util.List;
import java.util.Map;

/**
 * 게시판 속성관리를 위한 서비스 인터페이스 클래스
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009.03.12
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.12  이삼섭          최초 생성
 *  2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성 
 *  
 *  </pre>
 */
public interface EgovBBSAttributeManageService {

	/**
	 * 등록된 게시판 속성정보를 삭제한다.
	 * @param BoardMaster
	 * 
	 * @param boardMaster
	 */
	public void deleteBBSMasterInf(BoardMaster boardMaster);

	/**
	 * 신규 게시판 속성정보를 생성한다.
	 * @param BoardMaster
	 * 
	 * @param boardMaster
	 */
	public String insertBBSMastetInf(BoardMaster boardMaster);

	/**
	 * 유효한 게시판 마스터 정보를 호출한다.
	 * @param searchVO
	 * @return
	 * 
	 * @param vo
	 */
	public List<BoardMasterVO> selectAllBBSMasteInf(BoardMasterVO vo);

	/**
	 * 커뮤니티, 동호회에서 사용중인 게시판 속성 정보의 목록을 전체조회 한다.
	 * @return
	 * 
	 * @param vo
	 */
	public List<BoardMasterVO> selectAllBdMstrByTrget(BoardMasterVO vo);

	/**
	 * 게시판 속성정보 한 건을 상세조회한다.
	 * @param BoardMasterVO
	 * 
	 * @param searchVO
	 */
	public BoardMasterVO selectBBSMasterInf(BoardMaster searchVO);

	/**
	 * 게시판 속성 정보의 목록을 조회 한다.
	 * @param BoardMasterVO
	 * 
	 * @param searchVO
	 */
	public Map<String, Object> selectBBSMasterInfs(BoardMasterVO searchVO);

	/**
	 * 사용중인 게시판 속성 정보의 목록을 조회 한다.
	 * @param BoardMasterVO
	 * 
	 * @param vo
	 */
	public Map<String, Object> selectBdMstrListByTrget(BoardMasterVO vo);

	/**
	 * 사용중이지 않은 게시판 속성 정보의 목록을 조회 한다.
	 * @return
	 * 
	 * @param vo
	 */
	public Map<String, Object> selectNotUsedBdMstrList(BoardMasterVO vo);

	/**
	 * 게시판 속성정보를 수정한다.
	 * @param BoardMaster
	 * 
	 * @param boardMaster
	 */
	public void updateBBSMasterInf(BoardMaster boardMaster);

	/**
	 * 템플릿의 유효여부를 점검한다.
	 * @param BoardMasterVO
	 * 
	 * @param searchVO
	 */
	public void validateTemplate(BoardMasterVO searchVO);

}