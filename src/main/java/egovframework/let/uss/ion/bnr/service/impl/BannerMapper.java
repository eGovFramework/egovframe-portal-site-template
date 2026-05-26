package egovframework.let.uss.ion.bnr.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.service.FileVO;
import egovframework.let.uss.ion.bnr.service.Banner;
import egovframework.let.uss.ion.bnr.service.BannerVO;

/**
 * 배너에 대한 Mapper 인터페이스를 정의한다.
 * 배너에 대한 등록, 수정, 삭제, 조회, 반영확인 기능을 제공한다.
 * @author 공통서비스개발팀 lee.m.j
 * @since 2009.08.03
 * @version 2.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.08.03  lee.m.j        최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *   2024.11.01  표준프레임워크센터  @EgovMapper 어노테이션 방식으로 전환
 *
 * </pre>
 */
@EgovMapper("bannerMapper")
public interface BannerMapper {

	/**
	 * 배너를 관리하기 위해 등록된 배너목록을 조회한다.
	 * @param bannerVO - 배너 VO
	 * @return List - 배너 목록
	 * @exception Exception
	 */
	List<BannerVO> selectBannerList(BannerVO bannerVO) throws Exception;

	/**
	 * 배너목록 총 갯수를 조회한다.
	 * @param bannerVO BannerVO
	 * @return int
	 * @exception Exception
	 */
	int selectBannerListTotCnt(BannerVO bannerVO) throws Exception;

	/**
	 * 등록된 배너의 상세정보를 조회한다.
	 * @param bannerVO - 배너 VO
	 * @return BannerVO - 배너 VO
	 * @exception Exception
	 */
	BannerVO selectBanner(BannerVO bannerVO) throws Exception;

	/**
	 * 배너정보를 신규로 등록한다.
	 * @param banner - 배너 model
	 * @exception Exception
	 */
	void insertBanner(Banner banner) throws Exception;

	/**
	 * 기 등록된 배너정보를 수정한다.
	 * @param banner - 배너 model
	 * @exception Exception
	 */
	void updateBanner(Banner banner) throws Exception;

	/**
	 * 기 등록된 배너정보를 삭제한다.
	 * @param banner - 배너 model
	 * @exception Exception
	 */
	void deleteBanner(Banner banner) throws Exception;

	/**
	 * 기 등록된 배너정보의 이미지파일을 삭제하기 위해 파일정보를 조회한다.
	 * @param banner - 배너 model
	 * @return FileVO - 파일 VO
	 * @exception Exception
	 */
	FileVO selectBannerFile(Banner banner) throws Exception;

	/**
	 * 배너가 특정화면에 반영된 결과를 조회한다.
	 * @param bannerVO - 배너 VO
	 * @return List - 배너 목록
	 * @exception Exception
	 */
	List<BannerVO> selectBannerResult(BannerVO bannerVO) throws Exception;

}
