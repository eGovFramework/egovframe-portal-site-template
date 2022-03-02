package egovframework.let.uss.olh.faq.service.impl;

import java.util.List;

import egovframework.let.uss.olh.faq.service.FaqManageDefaultVO;
import egovframework.let.uss.olh.faq.service.FaqManageVO;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;

import org.springframework.stereotype.Repository;
/**
 *
 * FAQ를 처리하는 DAO 클래스
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
@Repository("FaqManageDAO")
public class FaqManageDAO extends EgovAbstractMapper {


    /**
	 * FAQ 글 목록에 대한 상세내용을 조회한다.
	 * @param vo
	 * @return 조회한 글
	 * @exception Exception
	 */
    public FaqManageVO selectFaqListDetail(FaqManageVO vo) throws Exception {

        return (FaqManageVO) selectOne("FaqManageDAO.selectFaqListDetail", vo);

    }

	/**
	 * FAQ 조회수를 수정한다.
	 * @param vo
	 * @exception Exception
	 */
    public void updateFaqInqireCo(FaqManageVO vo) throws Exception {

        update("FaqManageDAO.updateFaqInqireCo", vo);

    }

    /**
	 * FAQ 글 목록을 조회한다.
	 * @param searchVO
	 * @return 글 목록
	 * @exception Exception
	 */
	public List<?> selectFaqList(FaqManageDefaultVO searchVO) throws Exception {

        return list("FaqManageDAO.selectFaqList", searchVO);

    }

    /**
	 * FAQ 글 총 갯수를 조회한다.
	 * @param searchVO
	 * @return 글 총 갯수
	 */
    public int selectFaqListTotCnt(FaqManageDefaultVO searchVO) {

        return (Integer)selectOne("FaqManageDAO.selectFaqListTotCnt", searchVO);

    }

	/**
	 * FAQ 글을 등록한다.
	 * @param vo
	 * @exception Exception
	 */
    public void insertFaqCn(FaqManageVO vo) throws Exception {

        insert("FaqManageDAO.insertFaqCn", vo);

    }

	/**
	 * FAQ 글을 수정한다.
	 * @param vo
	 * @exception Exception
	 */
    public void updateFaqCn(FaqManageVO vo) throws Exception {

        update("FaqManageDAO.updateFaqCn", vo);

    }

	/**
	 * FAQ 글을 삭제한다.
	 * @param vo
	 * @exception Exception
	 */
    public void deleteFaqCn(FaqManageVO vo) throws Exception {

        delete("FaqManageDAO.deleteFaqCn", vo);

    }

}
