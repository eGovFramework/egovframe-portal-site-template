package egovframework.let.sym.ccm.zip.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.let.sym.ccm.zip.service.Zip;
import egovframework.let.sym.ccm.zip.service.ZipVO;

/**
 * 우편번호에 대한 Mapper 인터페이스를 정의한다.
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 */
@EgovMapper
public interface ZipManageMapper {

	void deleteZip(Zip zip) throws Exception;

	void deleteAllZip() throws Exception;

	void insertZip(Zip zip) throws Exception;

	void insertExcelZip() throws Exception;

	Zip selectZipDetail(Zip zip) throws Exception;

	List<?> selectZipList(ZipVO searchVO) throws Exception;

	int selectZipListTotCnt(ZipVO searchVO) throws Exception;

	void updateZip(Zip zip) throws Exception;

}
