package egovframework.let.uss.olh.faq.service.impl;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.springframework.stereotype.Service;

import egovframework.let.uss.olh.faq.service.EgovFaqManageService;
import egovframework.let.uss.olh.faq.service.FaqManageDefaultVO;
import egovframework.let.uss.olh.faq.service.FaqManageVO;
import lombok.RequiredArgsConstructor;

/**
 *
 * FAQ를 처리하는 비즈니스 구현 클래스
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
 *  2009.04.01  박정규           최초 생성
 *  2011.08.31  JJY           경량환경 템플릿 커스터마이징버전 생성
 *  2024.10.04  안단희           롬복 생성자 기반 종속성 주입
 *
 *      </pre>
 */
@Service
@RequiredArgsConstructor
public class EgovFaqManageServiceImpl extends EgovAbstractServiceImpl implements EgovFaqManageService {

	private final FaqManageDAO faqManageDAO;

	/** ID Generation */
	private final EgovIdGnrService egovFaqManageIdGnrService;

	/**
	 * FAQ 글을 조회한다.
	 *
	 * @param vo - 조회할 정보가 담긴 FaqManageVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	@Override
	public FaqManageVO selectFaqListDetail(FaqManageVO vo) throws Exception {
		FaqManageVO resultVO = faqManageDAO.selectFaqListDetail(vo);
		if (resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}

	/**
	 * FAQ 조회수를 수정한다.
	 *
	 * @param vo
	 * @exception Exception
	 */
	@Override
	public void updateFaqInqireCo(FaqManageVO vo) throws Exception {

		faqManageDAO.updateFaqInqireCo(vo);
	}

	/**
	 * FAQ 글 목록을 조회한다.
	 *
	 * @param searchVO
	 * @return 글 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectFaqList(FaqManageDefaultVO searchVO) throws Exception {
		return faqManageDAO.selectFaqList(searchVO);
	}

	/**
	 * FAQ 글 총 갯수를 조회한다.
	 *
	 * @param searchVO
	 * @return 글 총 갯수
	 * @exception
	 */
	@Override
	public int selectFaqListTotCnt(FaqManageDefaultVO searchVO) {
		return faqManageDAO.selectFaqListTotCnt(searchVO);
	}

	/**
	 * FAQ 글을 등록한다.
	 *
	 * @param vo
	 * @exception Exception
	 */
	@Override
	public void insertFaqCn(FaqManageVO vo) throws Exception {

		String newsId = egovFaqManageIdGnrService.getNextStringId();

		vo.setFaqId(newsId);

		faqManageDAO.insertFaqCn(vo);
	}

	/**
	 * FAQ 글을 수정한다.
	 *
	 * @param vo
	 * @exception Exception
	 */
	@Override
	public void updateFaqCn(FaqManageVO vo) throws Exception {

		faqManageDAO.updateFaqCn(vo);
	}

	/**
	 * FAQ 글을 삭제한다.
	 *
	 * @param vo
	 * @exception Exception
	 */
	@Override
	public void deleteFaqCn(FaqManageVO vo) throws Exception {

		faqManageDAO.deleteFaqCn(vo);
	}

}
