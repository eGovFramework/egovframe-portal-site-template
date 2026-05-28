package egovframework.let.cop.bbs.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.cop.bbs.service.Board;
import egovframework.let.cop.bbs.service.BoardVO;

/**
 * 게시물 관리를 위한 Mapper 인터페이스
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009.03.19
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.19  이삼섭          최초 생성
 *  2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 *  </pre>
 */
@EgovMapper
public interface BBSManageMapper {

	/**
	 * 게시판에 대한 현재 게시물 번호의 최대값을 구한다.
	 *
	 * @return
	 * @throws Exception
	 */
	long selectMaxNttId() throws Exception;

	/**
	 * 게시판에 게시물을 등록 한다.
	 *
	 * @param board
	 * @throws Exception
	 */
	void insertBoardArticle(Board board) throws Exception;

	/**
	 * 게시판에 답변 게시물을 등록 한다.
	 *
	 * @param board
	 * @throws Exception
	 */
	void replyBoardArticle(Board board) throws Exception;

	/**
	 * 부모 게시물의 NTT_NO를 조회한다.
	 *
	 * @param board
	 * @return
	 * @throws Exception
	 */
	long getParentNttNo(Board board) throws Exception;

	/**
	 * 현재 글 이후 게시물에 대한 NTT_NO를 증가한다.
	 *
	 * @param board
	 * @throws Exception
	 */
	void updateOtherNttNo(Board board) throws Exception;

	/**
	 * 게시물의 NTT_NO를 수정한다.
	 *
	 * @param board
	 * @throws Exception
	 */
	void updateNttNo(Board board) throws Exception;

	/**
	 * 게시물 한 건에 대하여 상세 내용을 조회 한다.
	 *
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	BoardVO selectBoardArticle(BoardVO boardVO) throws Exception;

	/**
	 * 조건에 맞는 게시물 목록을 조회 한다.
	 *
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	List<BoardVO> selectBoardArticleList(BoardVO boardVO) throws Exception;

	/**
	 * 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
	 *
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	int selectBoardArticleListCnt(BoardVO boardVO) throws Exception;

	/**
	 * 게시물 한 건의 내용을 수정 한다.
	 *
	 * @param board
	 * @throws Exception
	 */
	void updateBoardArticle(Board board) throws Exception;

	/**
	 * 게시물 한 건을 삭제 한다.
	 *
	 * @param board
	 * @throws Exception
	 */
	void deleteBoardArticle(Board board) throws Exception;

	/**
	 * 게시물에 대한 조회 건수를 수정 한다.
	 *
	 * @param boardVO
	 * @throws Exception
	 */
	void updateInqireCo(BoardVO boardVO) throws Exception;

	/**
	 * 게시물에 대한 현재 조회 건수를 조회 한다.
	 *
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	int selectMaxInqireCo(BoardVO boardVO) throws Exception;

	/**
	 * 게시판에 대한 목록을 정렬 순서로 조회 한다.
	 *
	 * @param board
	 * @return
	 * @throws Exception
	 */
	List<BoardVO> selectNoticeListForSort(Board board) throws Exception;

	/**
	 * 게시판에 대한 정렬 순서를 수정 한다.
	 *
	 * @param vo
	 * @throws Exception
	 */
	void updateSortOrder(BoardVO vo) throws Exception;

	/**
	 * 게시판에 대한 현재 게시물 번호의 최대값을 구한다.
	 *
	 * @param board
	 * @return
	 * @throws Exception
	 */
	long selectNoticeItemForSort(Board board) throws Exception;

	/**
	 * 방명록에 대한 목록을 조회 한다.
	 *
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	List<BoardVO> selectGuestList(BoardVO boardVO) throws Exception;

	/**
	 * 방명록에 대한 목록 건수를 조회 한다.
	 *
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	int selectGuestListCnt(BoardVO boardVO) throws Exception;

	/**
	 * 방명록 내용을 삭제 한다.
	 *
	 * @param boardVO
	 * @throws Exception
	 */
	void deleteGuestList(BoardVO boardVO) throws Exception;

	/**
	 * 방명록에 대한 패스워드를 조회 한다.
	 *
	 * @param board
	 * @return
	 * @throws Exception
	 */
	String getPasswordInf(Board board) throws Exception;

}
