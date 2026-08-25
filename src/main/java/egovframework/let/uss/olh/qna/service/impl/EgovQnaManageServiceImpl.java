package egovframework.let.uss.olh.qna.service.impl;

import java.util.List;

import egovframework.let.cop.bbs.util.EgovBBSAuthUtil;
import egovframework.let.uss.olh.qna.service.EgovQnaManageService;
import egovframework.let.uss.olh.qna.service.QnaManageDefaultVO;
import egovframework.let.uss.olh.qna.service.QnaManageVO;
import egovframework.let.utl.sim.service.EgovFileScrty;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

/**
 *
 * Q&A정보를 처리하는 비즈니스 구현 클래스
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
@Service("QnaManageService")
public class EgovQnaManageServiceImpl extends EgovAbstractServiceImpl implements
        EgovQnaManageService {

    @Resource(name="QnaManageDAO")
    private QnaManageDAO qnaManageDAO;

    /** ID Generation */
	@Resource(name="egovQnaManageIdGnrService")
	private EgovIdGnrService idgenService;


    /**
	 * Q&A 글을 조회한다.
	 * @param vo
	 * @return 조회한 글
	 * @exception Exception
	 */
    @Override
	public QnaManageVO selectQnaListDetail(QnaManageVO vo) throws Exception {
        QnaManageVO resultVO = qnaManageDAO.selectQnaListDetail(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

	/**
	 * Q&A 글을 수정한다.(조회수를 수정)
	 * @param vo
	 * @exception Exception
	 */
    @Override
	public void updateQnaInqireCo(QnaManageVO vo) throws Exception {

    	qnaManageDAO.updateQnaInqireCo(vo);
    }

    /**
	 * Q&A 글 목록을 조회한다.
	 * @param searchVO
	 * @return 글 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectQnaList(QnaManageDefaultVO searchVO) throws Exception {
        return qnaManageDAO.selectQnaList(searchVO);
    }

    /**
	 * Q&A 글 총 갯수를 조회한다.
	 * @param searchVO
	 * @return 글 총 갯수
	 */
    @Override
	public int selectQnaListTotCnt(QnaManageDefaultVO searchVO) {
		return qnaManageDAO.selectQnaListTotCnt(searchVO);
	}

	/**
	 * Q&A 글을 등록한다.
	 * @param vo
	 * @exception Exception
	 */
    @Override
	public void insertQnaCn(QnaManageVO vo) throws Exception {

		String	qaId = idgenService.getNextStringId();

		vo.setQaId(qaId);

		// 26.08.19 조치 : 작성비밀번호는 qaId를 salt로 사용해 해시한다.
		// salt가 되는 qaId가 이 시점에 채번되므로 해싱을 컨트롤러가 아닌 여기에서 수행한다.
		// deprecated된 EgovFileScrty.encryptPassword(String) 대신 salt 지정 버전을 사용한다.
		if (vo.getWritngPassword() != null) {
			vo.setWritngPassword(EgovFileScrty.encryptPassword(vo.getWritngPassword(), qaId));
		}

    	qnaManageDAO.insertQnaCn(vo);
    }

    /**
	 * 작성비밀번호를 확인한다.
	 * @param vo
	 * @return 글 총 갯수
	 */
    @Override
	public int selectQnaPasswordConfirmCnt(QnaManageVO vo) {
		return qnaManageDAO.selectQnaPasswordConfirmCnt(vo);
	}

	/**
	 * Q&A 글을 수정한다.
	 * @param vo
	 * @exception Exception
	 */
    @Override
	public void updateQnaCn(QnaManageVO vo) throws Exception {

		prepareMngrAt(vo);

    	qnaManageDAO.updateQnaCn(vo);
    }

	/**
	 * Q&A 글을 삭제한다.
	 * @param vo
	 * @exception Exception
	 */
    @Override
	public void deleteQnaCn(QnaManageVO vo) throws Exception {

		prepareMngrAt(vo);

    	qnaManageDAO.deleteQnaCn(vo);
    }

	/**
	 * 26.08.19 조치 : updateQnaCn/deleteQnaCn SQL에 추가된 소유자 방어 조건
	 * (AND FRST_REGISTER_ID = #{lastUpdusrId})은 관리자에게는 적용되면 안 된다.
	 * mngrAt이 설정되지 않으면 기본값 "N"이 유지되어 관리자도 타인 글을 수정/삭제할 수 없다.
	 *
	 * @param vo
	 */
	private void prepareMngrAt(QnaManageVO vo) {
		vo.setMngrAt(EgovBBSAuthUtil.isAdminUser() ? "Y" : "N");
	}


    /**
	 * Q&A 답변 글을 조회한다.
	 * @param vo
	 * @return 조회한 글
	 * @exception Exception
	 */
    @Override
	public QnaManageVO selectQnaAnswerListDetail(QnaManageVO vo) throws Exception {
        QnaManageVO resultVO = qnaManageDAO.selectQnaAnswerListDetail(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * Q&A 답변 글 목록을 조회한다.
	 * @param searchVO
	 * @return 글 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectQnaAnswerList(QnaManageDefaultVO searchVO) throws Exception {
        return qnaManageDAO.selectQnaAnswerList(searchVO);
    }

    /**
	 * Q&A 답변 글 총 갯수를 조회한다.
	 * @param searchVO
	 * @return 글 총 갯수
	 */
    @Override
	public int selectQnaAnswerListTotCnt(QnaManageDefaultVO searchVO) {
		return qnaManageDAO.selectQnaListTotCnt(searchVO);
	}

	/**
	 * Q&A 답변 글을 수정한다.
	 * @param vo
	 * @exception Exception
	 */
    @Override
	public void updateQnaCnAnswer(QnaManageVO vo) throws Exception {

    	qnaManageDAO.updateQnaCnAnswer(vo);
    }

}
