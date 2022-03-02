package egovframework.let.uss.olp.qtm.web;

import java.util.Map;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.let.uss.olp.qtm.service.EgovQustnrTmplatManageService;
import egovframework.let.uss.olp.qtm.service.QustnrTmplatManageVO;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

/**
 * 설문템플릿 Controller Class 구현
 * @author 공통서비스 장동한
 * @since 2009.03.20
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  장동한          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Controller
public class EgovQustnrTmplatManageController {

	@Autowired
	private DefaultBeanValidator beanValidator;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "egovQustnrTmplatManageService")
	private EgovQustnrTmplatManageService egovQustnrTmplatManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@RequestMapping(value = "/uss/olp/qtm/EgovQustnrTmplatManageMain.do")
	public String EgovQustnrTmplatManageMain(ModelMap model) throws Exception {
		return "/uss/olp/qtm/EgovQustnrTmplatManageMain";
	}

	@RequestMapping(value = "/uss/olp/qtm/EgovQustnrTmplatManageLeft.do")
	public String EgovQustnrTmplatManageLeft(ModelMap model) throws Exception {
		return "/uss/olp/qtm/EgovQustnrTmplatManageLeft";
	}

	/**
	 * 개별 배포시 메인메뉴를 조회한다.
	 * @param model
	 * @return	"/uss/sam/cpy/"
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/olp/EgovMain.do")
	public String EgovMain(ModelMap model) throws Exception {
		return "/uss/olp/qtm/EgovMain";
	}

	/**
	 * 메뉴를 조회한다.
	 * @param model
	 * @return	"/uss/sam/cpy/EgovLeft"
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/olp/EgovLeft.do")
	public String EgovLeft(ModelMap model) throws Exception {
		return "/uss/olp/qtm/EgovLeft";
	}

	/**
	 * 설문템플릿 목록을 조회한다.
	 * @param searchVO
	 * @param commandMap
	 * @param qustnrTmplatManageVO
	 * @param model
	 * @return "/uss/olp/qtm/EgovQustnrTmplatManageList"
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/olp/qtm/EgovQustnrTmplatManageList.do")
	public String EgovQustnrTmplatManageList(@ModelAttribute("searchVO") ComDefaultVO searchVO, @RequestParam Map<String, Object> commandMap,
			QustnrTmplatManageVO qustnrTmplatManageVO, ModelMap model) throws Exception {

		String sCmd = commandMap.get("cmd") == null ? "" : (String) commandMap.get("cmd");

		if (sCmd.equals("del")) {
			egovQustnrTmplatManageService.deleteQustnrTmplatManage(qustnrTmplatManageVO);
		}

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		model.addAttribute("resultList", egovQustnrTmplatManageService.selectQustnrTmplatManageList(searchVO));

		model.addAttribute("searchKeyword", commandMap.get("searchKeyword") == null ? "" : (String) commandMap.get("searchKeyword"));
		model.addAttribute("searchCondition", commandMap.get("searchCondition") == null ? "" : (String) commandMap.get("searchCondition"));

		int totCnt = egovQustnrTmplatManageService.selectQustnrTmplatManageListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "/uss/olp/qtm/EgovQustnrTmplatManageList";
	}

	/**
	 * 설문템플릿 목록을 상세조회 조회한다.
	 * @param request
	 * @param response
	 * @param qustnrTmplatManageVO
	 * @param commandMap
	 * @return "/uss/olp/qtm/EgovQustnrTmplatManageImg"
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	@RequestMapping(value = "/uss/olp/qtm/EgovQustnrTmplatManageImg.do")
	public void EgovQustnrTmplatManageImg(HttpServletRequest request, HttpServletResponse response, QustnrTmplatManageVO qustnrTmplatManageVO,
			@RequestParam Map<String, Object> commandMap) throws Exception {
		
		Map<?, ?> mapResult = egovQustnrTmplatManageService.selectQustnrTmplatManageTmplatImagepathnm(qustnrTmplatManageVO);
		byte[] img = (byte[]) mapResult.get("QUSTNR_TMPLAT_IMAGE_INFOPATHNM");
		String imgtype = "jpeg";
		String type = "";
		
		if (imgtype != null && !"".equals(imgtype)) {
			type = "image/" + imgtype;
		}

		response.setHeader("Content-Type", imgtype);
		response.setHeader("Content-Length", "" + img.length);
		response.getOutputStream().write(img);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	/**
	 * 설문템플릿 목록을 상세조회 조회한다.
	 * @param searchVO
	 * @param qustnrTmplatManageVO
	 * @param commandMap
	 * @param model
	 * @return "/uss/olp/qtm/EgovQustnrTmplatManageDetail"
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/olp/qtm/EgovQustnrTmplatManageDetail.do")
	public String EgovQustnrTmplatManageDetail(@ModelAttribute("searchVO") ComDefaultVO searchVO, QustnrTmplatManageVO qustnrTmplatManageVO,
			@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		String sLocationUrl = "/uss/olp/qtm/EgovQustnrTmplatManageDetail";

		String sCmd = commandMap.get("cmd") == null ? "" : (String) commandMap.get("cmd");

		if (sCmd.equals("del")) {
			egovQustnrTmplatManageService.deleteQustnrTmplatManage(qustnrTmplatManageVO);
			sLocationUrl = "redirect:/uss/olp/qtm/EgovQustnrTmplatManageList.do";
		} else {
			model.addAttribute("resultList", egovQustnrTmplatManageService.selectQustnrTmplatManageDetail(qustnrTmplatManageVO));
		}

		return sLocationUrl;
	}

	/**
	 * 설문템플릿를 수정한다.
	 * @param searchVO
	 * @param commandMap
	 * @param qustnrTmplatManageVO
	 * @param model
	 * @return "/uss/olp/qtm/EgovQustnrTmplatManageModify"
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	@RequestMapping(value = "/uss/olp/qtm/EgovQustnrTmplatManageModify.do")
	public String QustnrTmplatManageModify(@ModelAttribute("searchVO") ComDefaultVO searchVO, @RequestParam Map<String, Object> commandMap,
			QustnrTmplatManageVO qustnrTmplatManageVO, ModelMap model) throws Exception {
		String sLocationUrl = "/uss/olp/qtm/EgovQustnrTmplatManageModify";

		String sCmd = commandMap.get("cmd") == null ? "" : (String) commandMap.get("cmd");

		model.addAttribute("resultList", egovQustnrTmplatManageService.selectQustnrTmplatManageDetail(qustnrTmplatManageVO));

		return sLocationUrl;
	}

	/**
	 * 설문템플릿를 수정처리 한다.
	 * @param multiRequest
	 * @param searchVO
	 * @param commandMap
	 * @param qustnrTmplatManageVO
	 * @param bindingResult
	 * @param model
	 * @return "/uss/olp/qtm/EgovQustnrTmplatManageModifyActor"
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/olp/qtm/EgovQustnrTmplatManageModifyActor.do")
	public String QustnrTmplatManageModifyActor(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") ComDefaultVO searchVO,
			@RequestParam Map<String, Object> commandMap, @ModelAttribute("qustnrTmplatManageVO") QustnrTmplatManageVO qustnrTmplatManageVO, BindingResult bindingResult,
			ModelMap model) throws Exception {

		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		//로그인 객체 선언
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		//서버  validate 체크
		beanValidator.validate(qustnrTmplatManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			model.addAttribute("resultList", egovQustnrTmplatManageService.selectQustnrTmplatManageDetail(qustnrTmplatManageVO));
			return "/uss/olp/qtm/EgovQustnrTmplatManageModify";
		}

		//아이디 설정
		qustnrTmplatManageVO.setFrstRegisterId(loginVO.getUniqId());
		qustnrTmplatManageVO.setLastUpdusrId(loginVO.getUniqId());

		final Map<String, MultipartFile> files = multiRequest.getFileMap();

		if (!files.isEmpty()) {
			for (MultipartFile file : files.values()) {
				System.out.println("getName =>" + file.getName());
				System.out.println("getOriginalFilename =>" + file.getOriginalFilename());
				if (file.getName().equals("qestnrTmplatImage") && !file.getOriginalFilename().equals("")) {
					qustnrTmplatManageVO.setQestnrTmplatImagepathnm(file.getBytes());
				}
			}
		}
		egovQustnrTmplatManageService.updateQustnrTmplatManage(qustnrTmplatManageVO);

		return "redirect:/uss/olp/qtm/EgovQustnrTmplatManageList.do";
	}

	/**
	 * 설문템플릿를 등록한다. / 초기등록페이지
	 * @param searchVO
	 * @param commandMap
	 * @param qustnrTmplatManageVO
	 * @param model
	 * @return "/uss/olp/qtm/EgovQustnrTmplatManageRegist"
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/olp/qtm/EgovQustnrTmplatManageRegist.do")
	public String QustnrTmplatManageRegist(@ModelAttribute("searchVO") ComDefaultVO searchVO, @RequestParam Map<String, Object> commandMap,
			@ModelAttribute("qustnrTmplatManageVO") QustnrTmplatManageVO qustnrTmplatManageVO, ModelMap model) throws Exception {

		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		//로그인 객체 선언
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String sLocationUrl = "/uss/olp/qtm/EgovQustnrTmplatManageRegist";

		//아이디 설정
		qustnrTmplatManageVO.setFrstRegisterId(loginVO.getUniqId());
		qustnrTmplatManageVO.setLastUpdusrId(loginVO.getUniqId());

		return sLocationUrl;
	}

	/**
	 * 설문템플릿를 등록 처리 한다.  / 등록처리
	 * @param multiRequest
	 * @param searchVO
	 * @param qustnrTmplatManageVO
	 * @param model
	 * @return "/uss/olp/qtm/EgovQustnrTmplatManageRegistActor"
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/olp/qtm/EgovQustnrTmplatManageRegistActor.do")
	public String QustnrTmplatManageRegistActor(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") ComDefaultVO searchVO,
			QustnrTmplatManageVO qustnrTmplatManageVO, ModelMap model) throws Exception {
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		//로그인 객체 선언
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		//아이디 설정
		qustnrTmplatManageVO.setFrstRegisterId(loginVO.getUniqId());
		qustnrTmplatManageVO.setLastUpdusrId(loginVO.getUniqId());

		final Map<String, MultipartFile> files = multiRequest.getFileMap();

		if (!files.isEmpty()) {
			for (MultipartFile file : files.values()) {
				if (file.getName().equals("qestnrTmplatImage")) {
					qustnrTmplatManageVO.setQestnrTmplatImagepathnm(file.getBytes());
				}
			}
		}

		egovQustnrTmplatManageService.insertQustnrTmplatManage(qustnrTmplatManageVO);

		return "redirect:/uss/olp/qtm/EgovQustnrTmplatManageList.do";
	}

}
