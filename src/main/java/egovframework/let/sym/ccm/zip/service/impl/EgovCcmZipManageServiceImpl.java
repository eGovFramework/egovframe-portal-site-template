package egovframework.let.sym.ccm.zip.service.impl;

import java.io.InputStream;
import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.let.sym.ccm.zip.service.EgovCcmZipManageService;
import egovframework.let.sym.ccm.zip.service.Zip;
import egovframework.let.sym.ccm.zip.service.ZipVO;
import jakarta.annotation.Resource;



/**
 *
 * 우편번호에 대한 서비스 구현클래스를 정의한다
 * @author 공통서비스 개발팀 이중호.
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Service("ZipManageService")
public class EgovCcmZipManageServiceImpl extends EgovAbstractServiceImpl implements EgovCcmZipManageService {

    @Resource(name="ZipManageDAO")
    private ZipManageDAO zipManageDAO;

    //@Resource(name = "excelZipService")

	/**
	 * 우편번호를 삭제한다.
	 */
	@Override
	public void deleteZip(Zip zip) {
		zipManageDAO.deleteZip(zip);
	}

	/**
	 * 우편번호 전체를 삭제한다.
	 */
	@Override
	public void deleteAllZip() {
		zipManageDAO.deleteAllZip();
	}

	/**
	 * 우편번호를 등록한다.
	 */
	@Override
	public void insertZip(Zip zip) {
    	zipManageDAO.insertZip(zip);
	}

	/**
	 * 우편번호 엑셀파일을 등록한다.
	 * @param zip
	 */

	@Override
	public void insertExcelZip(InputStream file) {
	}


	/**
	 * 우편번호 상세항목을 조회한다.
	 */
	@Override
	public Zip selectZipDetail(Zip zip) {
    	Zip ret = zipManageDAO.selectZipDetail(zip);
    	return ret;
	}

	/**
	 * 우편번호 목록을 조회한다.
	 */
	@Override
	public List<?> selectZipList(ZipVO searchVO) {
        return zipManageDAO.selectZipList(searchVO);
	}

	/**
	 * 우편번호 총 갯수를 조회한다.
	 */
	@Override
	public int selectZipListTotCnt(ZipVO searchVO) {
        return zipManageDAO.selectZipListTotCnt(searchVO);
	}

	/**
	 * 우편번호를 수정한다.
	 */
	@Override
	public void updateZip(Zip zip) {
		zipManageDAO.updateZip(zip);
	}

}
