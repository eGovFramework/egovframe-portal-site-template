package egovframework.let.cop.bbs.service;

import java.util.Map;

/**
 * 게시물 관리를 위한 서비스 인터페이스 클래스
 * 
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009.03.19
 * @version 1.0
 * @see
 * 
 *      <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *   2009.03.19  이삼섭          최초 생성
 *   2011.08.31  JJY           경량환경 템플릿 커스터마이징버전 생성
 *   2024.08.20  이백행          시큐어코딩 Exception 제거
 * 
 *      </pre>
 */
public interface EgovBBSManageService {

	/**
	 * 게시물 한 건을 삭제 한다.
	 * 
	 * @param Board
	 */
	public void deleteBoardArticle(Board Board);

	/**
	 * 방명록 내용을 삭제 한다.
	 * 
	 * @param boardVO
	 */
	public void deleteGuestList(BoardVO boardVO);

	/**
	 * 방명록에 대한 패스워드를 조회 한다.
	 * 
	 * @return
	 * 
	 * @param Board
	 */
	public String getPasswordInf(Board Board);

	/**
	 * 게시판에 게시물 또는 답변 게시물을 등록 한다.
	 * 
	 * @param Board
	 */
	public void insertBoardArticle(Board Board);

	/**
	 * 게시물 대하여 상세 내용을 조회 한다.
	 * 
	 * @return
	 * 
	 * @param boardVO
	 */
	public BoardVO selectBoardArticle(BoardVO boardVO);

	/**
	 * 조건에 맞는 게시물 목록을 조회 한다.
	 * 
	 * @return
	 * 
	 * @param boardVO
	 * @param attrbFlag
	 */
	public Map<String, Object> selectBoardArticles(BoardVO boardVO, String attrbFlag);

	/**
	 * 방명록에 대한 목록을 조회 한다.
	 * 
	 * @return
	 * 
	 * @param boardVO
	 */
	public Map<String, Object> selectGuestList(BoardVO boardVO);

	/**
	 * 게시물 한 건의 내용을 수정 한다.
	 * 
	 * @param Board
	 */
	public void updateBoardArticle(Board Board);

}