package egovframework.let.uss.ion.bnr.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.service.FileVO;
import egovframework.let.uss.ion.bnr.service.Banner;
import egovframework.let.uss.ion.bnr.service.BannerVO;

/**
 * 배너에 대한 Mapper 인터페이스를 정의한다.
 * @author 공통서비스개발팀 lee.m.j
 * @since 2009.08.03
 * @version 1.0
 */
@EgovMapper
public interface BannerMapper {

	List<BannerVO> selectBannerList(BannerVO bannerVO) throws Exception;

	int selectBannerListTotCnt(BannerVO bannerVO) throws Exception;

	BannerVO selectBanner(BannerVO bannerVO) throws Exception;

	void insertBanner(Banner banner) throws Exception;

	void updateBanner(Banner banner) throws Exception;

	void deleteBanner(Banner banner) throws Exception;

	FileVO selectBannerFile(Banner banner) throws Exception;

	List<BannerVO> selectBannerResult(BannerVO bannerVO) throws Exception;

}
