package egovframework.let.uss.olh.faq.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.let.uss.olh.faq.service.EgovFaqManageService;
import egovframework.let.uss.olh.faq.service.FaqManageDefaultVO;
import egovframework.let.uss.olh.faq.service.FaqManageVO;
import lombok.RequiredArgsConstructor;

/**
 *
 * FAQ내용을 처리하는 비즈니스 구현 클래스
 *
 * @author 공통서비스 개발팀 박정규
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *  2009.04.01  박정규           최초 생성
 *  2011.08.31  JJY           경량환경 템플릿 커스터마이징버전 생성
 *  2024.10.04  안단희           롬복 생성자 기반 종속성 주입
 *
 *      </pre>
 */
@Controller
@RequiredArgsConstructor
public class EgovFaqManageController {

	private final EgovFaqManageService egovFaqManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	// 첨부파일 관련
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	// Validation 관련
	@Autowired
	private DefaultBeanValidator beanValidator;

	/**
	 * 개별 배포시 메인메뉴를 조회한다.
	 *
	 * @param model
	 * @return "/uss/olh/faq/"
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/olh/faq/EgovMain.do")
	public String EgovMain(ModelMap model) throws Exception {
		model.addAttribute("mainContents", "mainContentsSampleValue");
		return "/uss/olh/faq/EgovMain";
	}

	/**
	 * 메뉴를 조회한다.
	 *
	 * @param model
	 * @return "/uss/olh/faq/EgovLeft"
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/olh/faq/EgovLeft.do")
	public String EgovLeft(ModelMap model) throws Exception {
		model.addAttribute("leftContents", "leftContentsSampleValue");
		return "/uss/olh/faq/EgovLeft";
	}

	/**
	 * FAQ 목록을 조회한다.
	 *
	 * @param searchVO
	 * @param model
	 * @return "/uss/olh/faq/EgovFaqListInqire"
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/olh/faq/FaqListInqire.do")
	public String selectFaqList(@ModelAttribute("searchVO") FaqManageDefaultVO searchVO, ModelMap model,
			HttpServletRequest request) throws Exception {
		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("menuNo", "4000000");

		/** EgovPropertyService.SiteList */
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

		model.addAttribute("resultList", egovFaqManageService.selectFaqList(searchVO));

		int totCnt = egovFaqManageService.selectFaqListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "/uss/olh/faq/EgovFaqListInqire";
	}

	/**
	 * FAQ 목록에 대한 상세정보를 조회한다.
	 *
	 * @param faqManageVO
	 * @param searchVO
	 * @param model
	 * @return "/uss/olh/faq/EgovFaqDetailInqire"
	 * @throws Exception
	 */
	@RequestMapping("/uss/olh/faq/FaqListDetailInqire.do")
	public String selectFaqListDetail(FaqManageVO faqManageVO, @ModelAttribute("searchVO") FaqManageDefaultVO searchVO,
			ModelMap model) throws Exception {

		FaqManageVO vo = egovFaqManageService.selectFaqListDetail(faqManageVO);

		model.addAttribute("result", vo);

		return "/uss/olh/faq/EgovFaqDetailInqire";
	}

	/**
	 * FAQ 조회수를 수정처리
	 *
	 * @param faqManageVO
	 * @param searchVO
	 * @return "forward:/uss/olh/faq/FaqListDetailInqire.do"
	 * @throws Exception
	 */
	@RequestMapping("/uss/olh/faq/FaqInqireCoUpdt.do")
	public String updateFaqInqireCo(FaqManageVO faqManageVO, @ModelAttribute("searchVO") FaqManageDefaultVO searchVO)
			throws Exception {
		LoginVO loginVO;
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			loginVO = new LoginVO();
			loginVO.setUniqId("_aunonymous");
		} else {
			loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		}
		// 로그인VO에서 사용자 정보 가져오기

		String lastUpdusrId = loginVO.getUniqId();

		faqManageVO.setLastUpdusrId(lastUpdusrId); // 최종수정자ID

		egovFaqManageService.updateFaqInqireCo(faqManageVO);

		return "forward:/uss/olh/faq/FaqListDetailInqire.do";

	}

	/**
	 * FAQ를 등록하기 위한 전 처리
	 *
	 * @param searchVO
	 * @param model
	 * @return "/uss/olh/faq/EgovFaqCnRegist"
	 * @throws Exception
	 */
	@RequestMapping("/uss/olh/faq/FaqCnRegistView.do")
	public String insertFaqCnView(@ModelAttribute("searchVO") FaqManageDefaultVO searchVO, Model model)
			throws Exception {
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}
		model.addAttribute("faqManageVO", new FaqManageVO());

		return "/uss/olh/faq/EgovFaqCnRegist";

	}

	/**
	 * FAQ를 등록한다.
	 *
	 * @param multiRequest
	 * @param searchVO
	 * @param faqManageVO
	 * @param bindingResult
	 * @return "forward:/uss/olh/faq/FaqListInqire.do"
	 * @throws Exception
	 */
	@RequestMapping("/uss/olh/faq/FaqCnRegist.do")
	public String insertFaqCn(final MultipartHttpServletRequest multiRequest, // 첨부파일을 위한...
			@ModelAttribute("searchVO") FaqManageDefaultVO searchVO,
			@ModelAttribute("faqManageVO") FaqManageVO faqManageVO, BindingResult bindingResult) throws Exception {

		beanValidator.validate(faqManageVO, bindingResult);

		if (bindingResult.hasErrors()) {

			return "/uss/olh/wor/EgovFaqCnRegist";

		}

		// 첨부파일 관련 첨부파일ID 생성
		List<FileVO> _result = null;
		String _atchFileId = "";

		final Map<String, MultipartFile> files = multiRequest.getFileMap();

		if (!files.isEmpty()) {
			_result = fileUtil.parseFileInf(files, "FAQ_", 0, "", "");
			_atchFileId = fileMngService.insertFileInfs(_result); // 파일이 생성되고나면 생성된 첨부파일 ID를 리턴한다.
		}

		// 리턴받은 첨부파일ID를 셋팅한다..
		faqManageVO.setAtchFileId(_atchFileId); // 첨부파일 ID

		// 로그인VO에서 사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String frstRegisterId = loginVO.getUniqId();

		faqManageVO.setFrstRegisterId(frstRegisterId); // 최초등록자ID
		faqManageVO.setLastUpdusrId(frstRegisterId); // 최종수정자ID

		egovFaqManageService.insertFaqCn(faqManageVO);

		return "forward:/uss/olh/faq/FaqListInqire.do";
	}

	/**
	 * FAQ를 수정하기 위한 전 처리
	 *
	 * @param faqId
	 * @param searchVO
	 * @param model
	 * @return "/uss/olh/faq/EgovFaqCnUpdt"
	 * @throws Exception
	 */
	@RequestMapping("/uss/olh/faq/FaqCnUpdtView.do")
	public String updateFaqCnView(@RequestParam("faqId") String faqId,
			@ModelAttribute("searchVO") FaqManageDefaultVO searchVO, ModelMap model) throws Exception {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		FaqManageVO faqManageVO = new FaqManageVO();

		// Primary Key 값 세팅
		faqManageVO.setFaqId(faqId);

		// 변수명은 CoC 에 따라
		model.addAttribute(selectFaqListDetail(faqManageVO, searchVO, model));

		// 변수명은 CoC 에 따라 JSTL사용을 위해
		model.addAttribute("faqManageVO", egovFaqManageService.selectFaqListDetail(faqManageVO));

		return "/uss/olh/faq/EgovFaqCnUpdt";
	}

	/**
	 * FAQ를 수정처리한다.
	 *
	 * @param atchFileAt
	 * @param multiRequest
	 * @param searchVO
	 * @param faqManageVO
	 * @param bindingResult
	 * @param model
	 * @return "forward:/uss/olh/faq/FaqListInqire.do"
	 * @throws Exception
	 */
	@RequestMapping("/uss/olh/faq/FaqCnUpdt.do")
	public String updateFaqCn(@RequestParam("atchFileAt") String atchFileAt,
			final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") FaqManageDefaultVO searchVO,
			@ModelAttribute("faqManageVO") FaqManageVO faqManageVO, BindingResult bindingResult, ModelMap model)
			throws Exception {

		// Validation
		beanValidator.validate(faqManageVO, bindingResult);

		if (bindingResult.hasErrors()) {

			return "/uss/olh/wor/EgovFaqCnUpdt";

		}

		// 첨부파일 관련 ID 생성 start....
		String _atchFileId = faqManageVO.getAtchFileId();

		final Map<String, MultipartFile> files = multiRequest.getFileMap();

		if (!files.isEmpty()) {

			if ("N".equals(atchFileAt)) {
				List<FileVO> _result = fileUtil.parseFileInf(files, "FAQ_", 0, _atchFileId, "");
				_atchFileId = fileMngService.insertFileInfs(_result);

				// 첨부파일 ID 셋팅
				faqManageVO.setAtchFileId(_atchFileId); // 첨부파일 ID

			} else {
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(_atchFileId);
				int _cnt = fileMngService.getMaxFileSN(fvo);
				List<FileVO> _result = fileUtil.parseFileInf(files, "FAQ_", _cnt, _atchFileId, "");
				fileMngService.updateFileInfs(_result);
			}
		}
		// 첨부파일 관련 ID 생성 end

		// 로그인VO에서 사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String lastUpdusrId = loginVO.getUniqId();

		faqManageVO.setLastUpdusrId(lastUpdusrId); // 최종수정자ID

		egovFaqManageService.updateFaqCn(faqManageVO);

		return "forward:/uss/olh/faq/FaqListInqire.do";

	}

	/**
	 * FAQ를 삭제처리한다.
	 *
	 * @param faqManageVO
	 * @param searchVO
	 * @return "forward:/uss/olh/faq/FaqListInqire.do"
	 * @throws Exception
	 */
	@RequestMapping("/uss/olh/faq/FaqCnDelete.do")
	public String deleteFaqCn(FaqManageVO faqManageVO, @ModelAttribute("searchVO") FaqManageDefaultVO searchVO)
			throws Exception {

		// 첨부파일 삭제를 위한 ID 생성 start....
		String _atchFileId = faqManageVO.getAtchFileId();

		egovFaqManageService.deleteFaqCn(faqManageVO);

		// 첨부파일을 삭제하기 위한 Vo
		FileVO fvo = new FileVO();
		fvo.setAtchFileId(_atchFileId);

		fileMngService.deleteAllFileInf(fvo);
		// 첨부파일 삭제 End

		return "forward:/uss/olh/faq/FaqListInqire.do";
	}

}
