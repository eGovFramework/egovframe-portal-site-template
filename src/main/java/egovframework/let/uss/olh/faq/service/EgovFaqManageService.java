package egovframework.let.uss.olh.faq.service;

import java.util.List;

/**
 *
 * FAQ를 처리하는 서비스 클래스
 * @author 공통서비스 개발팀 박정규
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  박정규          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
public interface EgovFaqManageService {

    /**
	 * FAQ 글을 조회한다.
	 * @param vo
	 * @return 조회한 글
	 * @exception Exception
	 */
	FaqManageVO selectFaqListDetail(FaqManageVO vo) throws Exception;

	/**
	 * 조회수를 수정한다.
	 * @param vo
	 * @exception Exception
	 */
    void updateFaqInqireCo(FaqManageVO vo) throws Exception;


    /**
	 * FAQ 글 목록을 조회한다.
	 * @param searchVO
	 * @return 글 목록
	 * @exception Exception
	 */
	List<?> selectFaqList(FaqManageDefaultVO searchVO) throws Exception;

    /**
	 * FAQ 글 총 갯수를 조회한다.
	 * @param searchVO
	 * @return 글 총 갯수
	 */
    int selectFaqListTotCnt(FaqManageDefaultVO searchVO);

	/**
	 * FAQ글ㅇ르 등록한다.
	 * @param vo
	 * @exception Exception
	 */
    void insertFaqCn(FaqManageVO vo) throws Exception;


	/**
	 * FAQ 글을 수정한다.
	 * @param vo
	 * @exception Exception
	 */
    void updateFaqCn(FaqManageVO vo) throws Exception;

	/**
	 * FAQ 글을 삭제한다.
	 * @param vo
	 * @exception Exception
	 */
    void deleteFaqCn(FaqManageVO vo) throws Exception;


}
