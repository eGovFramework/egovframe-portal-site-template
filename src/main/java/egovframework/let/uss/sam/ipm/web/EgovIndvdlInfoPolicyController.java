package egovframework.let.uss.sam.ipm.web;

import java.util.Map;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.let.uss.sam.ipm.service.EgovIndvdlInfoPolicyService;
import egovframework.let.uss.sam.ipm.service.IndvdlInfoPolicy;
import lombok.RequiredArgsConstructor;

/**
 * 개인정보보호정책를 처리하는 Controller Class 구현
 * 
 * @author 공통서비스 장동한
 * @since 2009.07.03
 * @version 1.0
 * @see
 * 
 *      <pre>
 * &lt;&lt; 개정이력(Modification Information) &gt;&gt;
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.07.03  장동한          최초 생성
 *   2011.08.31  JJY           경량환경 템플릿 커스터마이징버전 생성
 *   2024.09.25  강동휘          컨트리뷰션 롬복 생성자 기반 종속성 주입 개정이력 수정
 *
 *      </pre>
 */
@Controller
@RequiredArgsConstructor
public class EgovIndvdlInfoPolicyController {

	private final DefaultBeanValidator beanValidator;

	/** EgovMessageSource */
	private final EgovMessageSource egovMessageSource;

	/** egovOnlinePollService */
	private final EgovIndvdlInfoPolicyService egovIndvdlInfoPolicyService;

	/** EgovPropertyService */
	private final EgovPropertyService propertiesService;

	/**
	 * 개인정보보호정책 목록을 조회한다.
	 * 
	 * @param searchVO
	 * @param commandMap
	 * @param indvdlInfoPolicy
	 * @param model
	 * @return "/uss/sam/ipm/EgovOnlinePollList"
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	@RequestMapping(value = "/uss/sam/ipm/listIndvdlInfoPolicy.do")
	public String EgovIndvdlInfoPolicyList(@ModelAttribute("searchVO") ComDefaultVO searchVO,
			@RequestParam Map<String, Object> commandMap, IndvdlInfoPolicy indvdlInfoPolicy, ModelMap model)
			throws Exception {

		String sSearchMode = commandMap.get("searchMode") == null ? "" : (String) commandMap.get("searchMode");

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

		model.addAttribute("resultList", egovIndvdlInfoPolicyService.selectIndvdlInfoPolicyList(searchVO));

		model.addAttribute("searchKeyword",
				commandMap.get("searchKeyword") == null ? "" : (String) commandMap.get("searchKeyword"));
		model.addAttribute("searchCondition",
				commandMap.get("searchCondition") == null ? "" : (String) commandMap.get("searchCondition"));

		int totCnt = egovIndvdlInfoPolicyService.selectIndvdlInfoPolicyListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		return "/uss/sam/ipm/EgovIndvdlInfoPolicyList";
	}

	/**
	 * 개인정보보호정책 목록을 상세조회 조회한다.
	 * 
	 * @param searchVO
	 * @param indvdlInfoPolicy
	 * @param commandMap
	 * @param model
	 * @return "/uss/sam/ipm/EgovOnlinePollDetail"
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/sam/ipm/detailIndvdlInfoPolicy.do")
	public String EgovIndvdlInfoPolicyDetail(@ModelAttribute("searchVO") ComDefaultVO searchVO,
			IndvdlInfoPolicy indvdlInfoPolicy, @RequestParam Map<String, Object> commandMap, ModelMap model)
			throws Exception {

		String sLocationUrl = "/uss/sam/ipm/EgovIndvdlInfoPolicyDetail";

		String sCmd = commandMap.get("cmd") == null ? "" : (String) commandMap.get("cmd");

		if (sCmd.equals("del")) {
			egovIndvdlInfoPolicyService.deleteIndvdlInfoPolicy(indvdlInfoPolicy);
			sLocationUrl = "forward:/uss/sam/ipm/listIndvdlInfoPolicy.do";
		} else {
			IndvdlInfoPolicy indvdlInfoPolicyVO = egovIndvdlInfoPolicyService
					.selectIndvdlInfoPolicyDetail(indvdlInfoPolicy);
			model.addAttribute("indvdlInfoPolicy", indvdlInfoPolicyVO);
		}

		return sLocationUrl;
	}

	/**
	 * 개인정보보호정책를 수정한다.
	 * 
	 * @param searchVO
	 * @param commandMap
	 * @param indvdlInfoPolicy
	 * @param bindingResult
	 * @param model
	 * @return "/uss/sam/ipm/EgovOnlinePollUpdt"
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/sam/ipm/updtIndvdlInfoPolicy.do")
	public String EgovIndvdlInfoPolicyModify(@ModelAttribute("searchVO") ComDefaultVO searchVO,
			@RequestParam Map<String, Object> commandMap,
			@ModelAttribute("indvdlInfoPolicy") IndvdlInfoPolicy indvdlInfoPolicy, BindingResult bindingResult,
			ModelMap model) throws Exception {
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		// 로그인 객체 선언
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String sLocationUrl = "/uss/sam/ipm/EgovIndvdlInfoPolicyUpdt";

		String sCmd = commandMap.get("cmd") == null ? "" : (String) commandMap.get("cmd");

		if (sCmd.equals("save")) {
			// 서버 validate 체크
			beanValidator.validate(indvdlInfoPolicy, bindingResult);
			if (bindingResult.hasErrors()) {
				return sLocationUrl;
			}
			// 아이디 설정
			indvdlInfoPolicy.setFrstRegisterId(loginVO.getUniqId());
			indvdlInfoPolicy.setLastUpdusrId(loginVO.getUniqId());

			egovIndvdlInfoPolicyService.updateIndvdlInfoPolicy(indvdlInfoPolicy);
			sLocationUrl = "forward:/uss/sam/ipm/listIndvdlInfoPolicy.do";
		} else {
			IndvdlInfoPolicy indvdlInfoPolicyVO = egovIndvdlInfoPolicyService
					.selectIndvdlInfoPolicyDetail(indvdlInfoPolicy);
			model.addAttribute("indvdlInfoPolicy", indvdlInfoPolicyVO);
		}

		return sLocationUrl;
	}

	/**
	 * 개인정보보호정책를 등록한다.
	 * 
	 * @param searchVO
	 * @param commandMap
	 * @param indvdlInfoPolicy
	 * @param bindingResult
	 * @param model
	 * @return "/uss/sam/ipm/EgovOnlinePollRegist"
	 * @throws Exception
	 */
	@RequestMapping(value = "/uss/sam/ipm/registIndvdlInfoPolicy.do")
	public String EgovIndvdlInfoPolicyRegist(@ModelAttribute("searchVO") ComDefaultVO searchVO,
			@RequestParam Map<String, Object> commandMap,
			@ModelAttribute("indvdlInfoPolicy") IndvdlInfoPolicy indvdlInfoPolicy, BindingResult bindingResult,
			ModelMap model) throws Exception {
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		// 로그인 객체 선언
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String sLocationUrl = "/uss/sam/ipm/EgovIndvdlInfoPolicyRegist";

		String sCmd = commandMap.get("cmd") == null ? "" : (String) commandMap.get("cmd");

		if (sCmd.equals("save")) {
			// 서버 validate 체크
			beanValidator.validate(indvdlInfoPolicy, bindingResult);
			if (bindingResult.hasErrors()) {
				return sLocationUrl;
			}
			// 아이디 설정
			indvdlInfoPolicy.setFrstRegisterId(loginVO.getUniqId());
			indvdlInfoPolicy.setLastUpdusrId(loginVO.getUniqId());
			// 저장
			egovIndvdlInfoPolicyService.insertIndvdlInfoPolicy(indvdlInfoPolicy);
			sLocationUrl = "forward:/uss/sam/ipm/listIndvdlInfoPolicy.do";
		}

		return sLocationUrl;
	}

}
