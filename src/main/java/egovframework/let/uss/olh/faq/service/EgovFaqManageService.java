package egovframework.let.uss.olh.faq.service;

import java.util.List;

/**
 *
 * FAQ를 처리하는 서비스 클래스
 * 
 * @author 공통서비스 개발팀 박정규
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  박정규          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *   2024.08.13  이백행          시큐어코딩 Exception 제거
 *
 *      </pre>
 */
public interface EgovFaqManageService {

	/**
	 * FAQ 글을 조회한다.
	 * 
	 * @param vo
	 * @return 조회한 글
	 * @throws Exception
	 */
	FaqManageVO selectFaqListDetail(FaqManageVO vo) throws Exception;
// TODO: 실행환경EgovAbstractServiceImpl에 모든 Exception을 EgovBizException으로 수정하면 좋을 것 같음. BaseRuntimeException으로 수정하면 어떨까요?
//	FaqManageVO selectFaqListDetail(FaqManageVO vo) throws EgovBizException;

	/**
	 * 조회수를 수정한다.
	 * 
	 * @param vo
	 */
	void updateFaqInqireCo(FaqManageVO vo);

	/**
	 * FAQ 글 목록을 조회한다.
	 * 
	 * @param searchVO
	 * @return 글 목록
	 */
	List<?> selectFaqList(FaqManageDefaultVO searchVO);

	/**
	 * FAQ 글 총 갯수를 조회한다.
	 * 
	 * @param searchVO
	 * @return 글 총 갯수
	 */
	int selectFaqListTotCnt(FaqManageDefaultVO searchVO);

	/**
	 * FAQ글ㅇ르 등록한다.
	 * 
	 * @param vo
	 */
	void insertFaqCn(FaqManageVO vo);

	/**
	 * FAQ 글을 수정한다.
	 * 
	 * @param vo
	 */
	void updateFaqCn(FaqManageVO vo);

	/**
	 * FAQ 글을 삭제한다.
	 * 
	 * @param vo
	 */
	void deleteFaqCn(FaqManageVO vo);

}
