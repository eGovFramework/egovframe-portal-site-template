package egovframework.let.uss.olh.qna.service.impl;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.cmmn.exception.BaseRuntimeException;
import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import egovframework.let.cop.bbs.util.EgovBBSAuthUtil;
import egovframework.let.uss.olh.qna.service.EgovQnaManageService;
import egovframework.let.uss.olh.qna.service.QnaManageDefaultVO;
import egovframework.let.uss.olh.qna.service.QnaManageVO;
import jakarta.annotation.Resource;

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

	/** 작성비밀번호 해시(BCrypt) */
	@Resource(name="egovPasswordEncoder")
	private PasswordEncoder passwordEncoder;


    /**
	 * Q&A 글을 조회한다.
	 * @param vo
	 * @return 조회한 글
	 */
    @Override
	public QnaManageVO selectQnaListDetail(QnaManageVO vo) {
        QnaManageVO resultVO = qnaManageDAO.selectQnaListDetail(vo);
        if (resultVO == null) {
            throw new BaseRuntimeException(processException("info.nodata.msg"));
        }
        return resultVO;
    }

	/**
	 * Q&A 글을 수정한다.(조회수를 수정)
	 * @param vo
	 */
    @Override
	public void updateQnaInqireCo(QnaManageVO vo) {

    	qnaManageDAO.updateQnaInqireCo(vo);
    }

    /**
	 * Q&A 글 목록을 조회한다.
	 * @param searchVO
	 * @return 글 목록
	 */
	@Override
	public List<?> selectQnaList(QnaManageDefaultVO searchVO) {
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
	 */
    @Override
	public void insertQnaCn(QnaManageVO vo) {

		String qaId;
		try {
			qaId = idgenService.getNextStringId();
		} catch (FdlException e) {
			throw new BaseRuntimeException(e);
		}

		vo.setQaId(qaId);

		if (vo.getWritngPassword() != null && !vo.getWritngPassword().isEmpty()) {
			vo.setWritngPassword(passwordEncoder.encode(vo.getWritngPassword()));
		}

    	qnaManageDAO.insertQnaCn(vo);
    }

    /**
	 * 작성비밀번호를 확인한다.
	 * @param vo
	 * @return 일치 여부
	 */
    @Override
	public boolean checkQnaPassword(QnaManageVO vo) {
		QnaManageVO stored = qnaManageDAO.selectQnaListDetail(vo);
		return stored != null && vo.getWritngPassword() != null && stored.getWritngPassword() != null
				&& passwordEncoder.matches(vo.getWritngPassword(), stored.getWritngPassword());
	}

	/**
	 * Q&A 글을 수정한다.
	 * @param vo
	 */
    @Override
	public void updateQnaCn(QnaManageVO vo) {

		prepareMngrAt(vo);
    	qnaManageDAO.updateQnaCn(vo);
    }

	/**
	 * Q&A 글을 삭제한다.
	 * @param vo
	 */
    @Override
	public void deleteQnaCn(QnaManageVO vo) {

		prepareMngrAt(vo);
    	qnaManageDAO.deleteQnaCn(vo);
    }

	/**
	 * 관리자는 updateQnaCn/deleteQnaCn 의 소유자 조건(FRST_REGISTER_ID)을 면제한다.
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
	 */
    @Override
	public QnaManageVO selectQnaAnswerListDetail(QnaManageVO vo) {
        QnaManageVO resultVO = qnaManageDAO.selectQnaAnswerListDetail(vo);
        if (resultVO == null) {
            throw new BaseRuntimeException(processException("info.nodata.msg"));
        }
        return resultVO;
    }

    /**
	 * Q&A 답변 글 목록을 조회한다.
	 * @param searchVO
	 * @return 글 목록
	 */
	@Override
	public List<?> selectQnaAnswerList(QnaManageDefaultVO searchVO) {
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
	 */
    @Override
	public void updateQnaCnAnswer(QnaManageVO vo) {

    	qnaManageDAO.updateQnaCnAnswer(vo);
    }

}
