package egovframework.let.uss.olh.faq.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.cmmn.exception.BaseRuntimeException;
import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.springframework.stereotype.Service;

import egovframework.let.uss.olh.faq.service.EgovFaqManageService;
import egovframework.let.uss.olh.faq.service.FaqManageDefaultVO;
import egovframework.let.uss.olh.faq.service.FaqManageVO;

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
 *   2009.04.01  박정규          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *   2024.08.13  이백행          시큐어코딩 Exception 제거
 *
 *      </pre>
 */
@Service("FaqManageService")
public class EgovFaqManageServiceImpl extends EgovAbstractServiceImpl implements EgovFaqManageService {

	@Resource(name = "FaqManageDAO")
	private FaqManageDAO faqManageDAO;

	/** ID Generation */
	@Resource(name = "egovFaqManageIdGnrService")
	private EgovIdGnrService idgenService;

	/**
	 * FAQ 글을 조회한다.
	 * 
	 * @param vo - 조회할 정보가 담긴 FaqManageVO
	 * @return 조회한 글
	 * @throws Exception
	 */
	@Override
	public FaqManageVO selectFaqListDetail(FaqManageVO vo) throws Exception {
// TODO: 실행환경EgovAbstractServiceImpl에 모든 Exception을 EgovBizException으로 수정하면 좋을 것 같음. BaseRuntimeException으로 수정하면 어떨까요?
//	public FaqManageVO selectFaqListDetail(FaqManageVO vo) throws EgovBizException {
		FaqManageVO resultVO = faqManageDAO.selectFaqListDetail(vo);
		if (resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}

	/**
	 * FAQ 조회수를 수정한다.
	 * 
	 * @param vo
	 */
	@Override
	public void updateFaqInqireCo(FaqManageVO vo) {

		faqManageDAO.updateFaqInqireCo(vo);
	}

	/**
	 * FAQ 글 목록을 조회한다.
	 * 
	 * @param searchVO
	 * @return 글 목록
	 */
	@Override
	public List<?> selectFaqList(FaqManageDefaultVO searchVO) {
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
	 */
	@Override
	public void insertFaqCn(FaqManageVO vo) {

		String newsId;
		try {
			newsId = idgenService.getNextStringId();
		} catch (FdlException e) {
			throw new BaseRuntimeException("FdlException: egovFaqManageIdGnrService", e);
		}

		vo.setFaqId(newsId);

		faqManageDAO.insertFaqCn(vo);
	}

	/**
	 * FAQ 글을 수정한다.
	 * 
	 * @param vo
	 */
	@Override
	public void updateFaqCn(FaqManageVO vo) {

		faqManageDAO.updateFaqCn(vo);
	}

	/**
	 * FAQ 글을 삭제한다.
	 * 
	 * @param vo
	 */
	@Override
	public void deleteFaqCn(FaqManageVO vo) {

		faqManageDAO.deleteFaqCn(vo);
	}

}
