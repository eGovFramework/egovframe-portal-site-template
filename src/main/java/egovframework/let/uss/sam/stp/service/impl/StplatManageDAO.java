package egovframework.let.uss.sam.stp.service.impl;

import java.util.List;

import egovframework.let.uss.sam.stp.service.StplatManageDefaultVO;
import egovframework.let.uss.sam.stp.service.StplatManageVO;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;

import org.springframework.stereotype.Repository;


/**
 *
 * 약관내용을 처리하는 DAO 클래스
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
@Repository("StplatManageDAO")
public class StplatManageDAO extends EgovAbstractMapper {


    /**
	 * 약관정보 글 목록에 대한 상세내용을 조회한다.
	 * @param vo
	 * @return 조회한 글
	 * @exception Exception
	 */
    public StplatManageVO selectStplatDetail(StplatManageVO vo) throws Exception {

        return (StplatManageVO) selectOne("StplatManageDAO.selectStplatDetail", vo);

    }

    /**
	 * 약관정보 글 목록을 조회한다.
	 * @param searchVO
	 * @return 글 목록
	 * @exception Exception
	 */
    public List<?> selectStplatList(StplatManageDefaultVO searchVO) throws Exception {

        return list("StplatManageDAO.selectStplatList", searchVO);

    }

    /**
	 * 약관정보 글 총 갯수를 조회한다.
	 * @param searchVO
	 * @return 글 총 갯수
	 */
    public int selectStplatListTotCnt(StplatManageDefaultVO searchVO) {

        return (Integer)selectOne("StplatManageDAO.selectStplatListTotCnt", searchVO);

    }

	/**
	 * 약관정보 글을 등록한다.
	 * @param vo
	 * @exception Exception
	 */
    public void insertStplatCn(StplatManageVO vo) throws Exception {

        insert("StplatManageDAO.insertStplatCn", vo);

    }

	/**
	 * 약관정보 글을 수정한다.
	 * @param vo
	 * @exception Exception
	 */
    public void updateStplatCn(StplatManageVO vo) throws Exception {

        update("StplatManageDAO.updateStplatCn", vo);

    }

	/**
	 * 약관정보 글을 삭제한다.
	 * @param vo
	 * @exception Exception
	 */
    public void deleteStplatCn(StplatManageVO vo) throws Exception {

        delete("StplatManageDAO.deleteStplatCn", vo);

    }

}
