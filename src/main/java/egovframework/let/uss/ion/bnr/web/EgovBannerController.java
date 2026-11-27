package egovframework.let.uss.ion.bnr.web;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.egovframe.rte.fdl.cmmn.exception.BaseRuntimeException;
import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.util.EgovOwnerAuthUtil;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.annotation.RequireAdmin;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.let.uss.ion.bnr.service.Banner;
import egovframework.let.uss.ion.bnr.service.BannerVO;
import egovframework.let.uss.ion.bnr.service.EgovBannerService;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;

/**
 * 배너에 대한 controller 클래스를 정의한다.
 * 배너에 대한 등록, 수정, 삭제, 조회, 반영확인 기능을 제공한다.
 * 배너의 조회기능은 목록조회, 상세조회로 구분된다.
 * 
 * @author 공통서비스개발팀 lee.m.j
 * @since 2009.08.03
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.08.03  lee.m.j        최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 *      </pre>
 */
@Controller
public class EgovBannerController {

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

	@Resource(name = "egovBannerService")
	private EgovBannerService egovBannerService;

	/** Message ID Generation */
	@Resource(name = "egovBannerIdGnrService")
	private EgovIdGnrService egovBannerIdGnrService;

	/**
	 * 배너 목록화면 이동
	 * 
	 * @return String
	 */
	@RequestMapping("/uss/ion/bnr/selectBannerListView.do")
	public String selectBannerListView() {

		return "/uss/ion/bnr/EgovBannerList";
	}

	/**
	 * 배너를 관리하기 위해 등록된 배너목록을 조회한다.
	 * 
	 * @param bannerVO - 배너 VO
	 * @return String - 리턴 URL
	 */
	@RequestMapping(value = "/uss/ion/bnr/selectBannerList.do")
	public String selectBannerList(@ModelAttribute("bannerVO") BannerVO bannerVO, ModelMap model) {

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bannerVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bannerVO.getPageUnit());
		paginationInfo.setPageSize(bannerVO.getPageSize());

		bannerVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bannerVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bannerVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		bannerVO.setBannerList(egovBannerService.selectBannerList(bannerVO));

		model.addAttribute("bannerList", bannerVO.getBannerList());

		int totCnt = egovBannerService.selectBannerListTotCnt(bannerVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/uss/ion/bnr/EgovBannerList";
	}

	/**
	 * 등록된 배너의 상세정보를 조회한다.
	 * 
	 * @param bannerVO - 배너 Vo
	 * @return String - 리턴 Url
	 */
	@RequestMapping(value = "/uss/ion/bnr/getBanner.do")
	public String selectBanner(@RequestParam("bannerId") String bannerId, @ModelAttribute("bannerVO") BannerVO bannerVO,
			ModelMap model) {

		bannerVO.setBannerId(bannerId);

		BannerVO banner = egovBannerService.selectBanner(bannerVO);
		model.addAttribute("banner", banner);
		// 저장/삭제 버튼은 등록자 본인에게만 노출
		model.addAttribute("ownerAt", EgovOwnerAuthUtil.ownerAt(banner == null ? null : banner.getUserId()));
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/uss/ion/bnr/EgovBannerUpdt";
	}

	/**
	 * 배너등록 화면으로 이동한다.
	 * 
	 * @param banner - 배너 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping(value = "/uss/ion/bnr/addViewBanner.do")
	public String insertViewBanner(@ModelAttribute("bannerVO") BannerVO bannerVO, ModelMap model) {

		model.addAttribute("banner", bannerVO);
		return "/uss/ion/bnr/EgovBannerRegist";
	}

	/**
	 * 배너정보를 신규로 등록한다.
	 * 
	 * @param banner - 배너 model
	 * @return String - 리턴 Url
	 */
	@RequireAdmin
	@RequestMapping(value = "/uss/ion/bnr/addBanner.do")
	public String insertBanner(final MultipartHttpServletRequest multiRequest,
			@Valid @ModelAttribute("banner") Banner banner, BindingResult bindingResult,
			@ModelAttribute("bannerVO") BannerVO bannerVO, SessionStatus status, ModelMap model) {

		if (bindingResult.hasErrors()) {
			model.addAttribute("bannerVO", bannerVO);
			return "/uss/ion/bnr/EgovBannerRegist";
		} else {
			List<FileVO> result = null;

			String uploadFolder = "";
			String bannerImage = "";
			String atchFileId = "";

			final Map<String, MultipartFile> files = multiRequest.getFileMap();

			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "BNR_", 0, "", uploadFolder);
				atchFileId = fileMngService.insertFileInfs(result);

				FileVO vo = result.get(0);
				Iterator<FileVO> iter = result.iterator();

				while (iter.hasNext()) {
					vo = iter.next();
					bannerImage = vo.getOrignlFileNm();
				}
			}

			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

			try {
				banner.setBannerId(egovBannerIdGnrService.getNextStringId());
			} catch (FdlException e) {
				throw new BaseRuntimeException(e);
			}
			banner.setBannerImage(bannerImage);
			banner.setBannerImageFile(atchFileId);
			// 등록자 본인 여부 판단을 위해 고유ID(uniqId)로 저장
			banner.setUserId(user.getUniqId());
			bannerVO.setBannerId(banner.getBannerId());
			status.setComplete();
			model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
			model.addAttribute("banner", egovBannerService.insertBanner(banner, bannerVO));
			model.addAttribute("ownerAt", "Y");

			return "/uss/ion/bnr/EgovBannerUpdt";

		}
	}

	/**
	 * 기 등록된 배너정보를 수정한다.
	 * 
	 * @param banner - 배너 model
	 * @return String - 리턴 Url
	 */
	@RequireAdmin
	@RequestMapping(value = "/uss/ion/bnr/updtBanner.do")
	public String updateBanner(final MultipartHttpServletRequest multiRequest,
			@Valid @ModelAttribute("banner") Banner banner, BindingResult bindingResult, SessionStatus status,
			ModelMap model) {

		// 등록자 본인만 수정 가능
		assertBannerOwner(banner.getBannerId());

		if (bindingResult.hasErrors()) {
			model.addAttribute("bannerVO", banner);
			model.addAttribute("ownerAt", "Y");
			return "/uss/ion/bnr/EgovBannerUpdt";
		} else {

			List<FileVO> result = null;

			String uploadFolder = "";
			String bannerImage = "";
			String atchFileId = "";

			final Map<String, MultipartFile> files = multiRequest.getFileMap();

			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "BNR_", 0, "", uploadFolder);
				atchFileId = fileMngService.insertFileInfs(result);

				FileVO vo = null;
				Iterator<FileVO> iter = result.iterator();

				while (iter.hasNext()) {
					vo = iter.next();
					bannerImage = vo.getOrignlFileNm();
				}

				if (vo == null) {
					banner.setAtchFile(false);
				} else {
					banner.setBannerImage(bannerImage);
					banner.setBannerImageFile(atchFileId);
					banner.setAtchFile(true);
				}
			} else {
				banner.setAtchFile(false);
			}

			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			banner.setUserId(user.getUniqId());

			egovBannerService.updateBanner(banner);

			return "forward:/uss/ion/bnr/getBanner.do";

		}
	}

	/**
	 * 기 등록된 배너정보를 삭제한다.
	 * 
	 * @param banner Banner
	 * @return String
	 */
	@RequireAdmin
	@RequestMapping(value = "/uss/ion/bnr/removeBanner.do")
	public String deleteBanner(@RequestParam("bannerId") String bannerId, @ModelAttribute("banner") Banner banner,
			SessionStatus status, ModelMap model) {

		// 등록자 본인만 삭제 가능
		assertBannerOwner(bannerId);

		banner.setBannerId(bannerId);
		egovBannerService.deleteBanner(banner);
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));

		return "forward:/uss/ion/bnr/selectBannerList.do";
	}

	/**
	 * 기 등록된 배너정보목록을 일괄 삭제한다.
	 * 
	 * @param banners String
	 * @param banner  Banner
	 * @return String
	 */
	@RequireAdmin
	@RequestMapping(value = "/uss/ion/bnr/removeBannerList.do")
	public String deleteBannerList(@RequestParam("bannerIds") String bannerIds, @ModelAttribute("banner") Banner banner,
			SessionStatus status, ModelMap model) {

		// null 방어
		String[] strBannerIds = bannerIds != null ? bannerIds.split(";") : new String[0];

		if (strBannerIds.length == 0) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.delete"));
			return "forward:/uss/ion/bnr/selectBannerList.do";
		}

		// 등록자 본인이 아닌 배너가 포함되어 있으면 삭제하지 않음
		for (int i = 0; i < strBannerIds.length; i++) {
			assertBannerOwner(strBannerIds[i]);
		}

		for (int i = 0; i < strBannerIds.length; i++) {
			banner.setBannerId(strBannerIds[i]);
			egovBannerService.deleteBanner(banner);
		}

		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));

		return "forward:/uss/ion/bnr/selectBannerList.do";
	}

	/**
	 * 배너가 특정화면에 반영된 결과를 조회한다.
	 * 
	 * @param bannerVO - 배너 VO
	 * @return String - 리턴 Url
	 */
	@RequestMapping(value = "/uss/ion/bnr/getBannerImage.do")
	public String selectBannerResult(@ModelAttribute("bannerVO") BannerVO bannerVO, ModelMap model) {

		List<BannerVO> fileList = egovBannerService.selectBannerResult(bannerVO);
		model.addAttribute("fileList", fileList);
		model.addAttribute("resultType", bannerVO.getResultType());

		return "/uss/ion/bnr/EgovBannerView";
	}

	/**
	 * MyPage에 배너정보를 제공하기 위해 목록을 조회한다.
	 * 
	 * @param bannerVO - 배너 VO
	 * @return String - 리턴 URL
	 */
	@RequestMapping(value = "/uss/ion/bnr/selectBannerMainList.do")
	public String selectBannerMainList(@ModelAttribute("bannerVO") BannerVO bannerVO, ModelMap model) {

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bannerVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(5);
		paginationInfo.setPageSize(bannerVO.getPageSize());

		bannerVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bannerVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bannerVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		bannerVO.setBannerList(egovBannerService.selectBannerList(bannerVO));

		model.addAttribute("bannerList", bannerVO.getBannerList());

		return "/uss/ion/bnr/EgovBannerMainList";
	}

	/**
	 * 배너의 등록자 본인 여부를 검증한다.
	 * 
	 * @param bannerId 배너ID
	 */
	private void assertBannerOwner(String bannerId) {
		BannerVO searchVO = new BannerVO();
		searchVO.setBannerId(bannerId);
		BannerVO existing = egovBannerService.selectBanner(searchVO);
		EgovOwnerAuthUtil.assertOwner(existing == null ? null : existing.getUserId());
	}
}
