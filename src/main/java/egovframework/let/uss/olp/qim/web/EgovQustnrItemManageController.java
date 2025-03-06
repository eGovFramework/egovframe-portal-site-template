package egovframework.let.uss.olp.qim.web;

import java.util.Map;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.let.uss.olp.qim.service.EgovQustnrItemManageService;
import egovframework.let.uss.olp.qim.service.QustnrItemManageVO;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;
/**
 * 설문항목관리를 처리하는 Controller Class 구현
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
public class EgovQustnrItemManageController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovQustnrItemManageController.class);

	@Autowired
	private DefaultBeanValidator beanValidator;

	/** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	@Resource(name = "egovQustnrItemManageService")
	private EgovQustnrItemManageService egovQustnrItemManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	/**
	 * 설문항목 팝업 목록을 조회한다.
	 * @param searchVO
	 * @param commandMap
	 * @param qustnrItemManageVO
	 * @param model
	 * @return "/uss/olp/qim/EgovQustnrItemManageListPopup"
	 * @throws Exception
	 */
	@RequestMapping(value="/uss/olp/qim/EgovQustnrItemManageListPopup.do")
	public String EgovQustnrItemManageListPopup(
			@ModelAttribute("searchVO") ComDefaultVO searchVO,
			@RequestParam Map <String, Object> commandMap,
			QustnrItemManageVO qustnrItemManageVO,
    		ModelMap model)
    throws Exception {

		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
		if(sCmd.equals("del")){
			egovQustnrItemManageService.deleteQustnrItemManage(qustnrItemManageVO);
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

        model.addAttribute("resultList", egovQustnrItemManageService.selectQustnrItemManageList(searchVO));

        model.addAttribute("searchKeyword", commandMap.get("searchKeyword") == null ? "" : (String)commandMap.get("searchKeyword"));
        model.addAttribute("searchCondition", commandMap.get("searchCondition") == null ? "" : (String)commandMap.get("searchCondition"));

        int totCnt = (Integer)egovQustnrItemManageService.selectQustnrItemManageListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

		return "/uss/olp/qim/EgovQustnrItemManageListPopup";
	}

	/**
	 * 설문항목 목록을 조회한다.
	 * @param searchVO
	 * @param commandMap
	 * @param qustnrItemManageVO
	 * @param model
	 * @return "/uss/olp/qim/EgovQustnrItemManageList"
	 * @throws Exception
	 */
	@RequestMapping(value="/uss/olp/qim/EgovQustnrItemManageList.do")
	public String EgovQustnrItemManageList(
			@ModelAttribute("searchVO") ComDefaultVO searchVO,
			@RequestParam Map <String, Object> commandMap,
			QustnrItemManageVO qustnrItemManageVO,
    		ModelMap model)
    throws Exception {

		String sSearchMode = commandMap.get("searchMode") == null ? "" : (String)commandMap.get("searchMode");

		//설문문항에 넘어온 건에 대해 조회
		if(sSearchMode.equals("Y")){
			searchVO.setSearchCondition("QUSTNR_QESITM_ID");//qestnrQesitmId
			searchVO.setSearchKeyword(qustnrItemManageVO.getQestnrQesitmId());
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

        model.addAttribute("resultList", egovQustnrItemManageService.selectQustnrItemManageList(searchVO));

        model.addAttribute("searchKeyword", commandMap.get("searchKeyword") == null ? "" : (String)commandMap.get("searchKeyword"));
        model.addAttribute("searchCondition", commandMap.get("searchCondition") == null ? "" : (String)commandMap.get("searchCondition"));

        int totCnt = (Integer)egovQustnrItemManageService.selectQustnrItemManageListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

		return "/uss/olp/qim/EgovQustnrItemManageList";
	}

	/**
	 * 설문항목 목록을 상세조회 조회한다.
	 * @param searchVO
	 * @param qustnrItemManageVO
	 * @param commandMap
	 * @param model
	 * @return  "/uss/olp/qim/EgovQustnrItemManageDetail"
	 * @throws Exception
	 */
	@RequestMapping(value="/uss/olp/qim/EgovQustnrItemManageDetail.do")
	public String EgovQustnrItemManageDetail(
			@ModelAttribute("searchVO") ComDefaultVO searchVO,
			QustnrItemManageVO qustnrItemManageVO,
			@RequestParam Map <String, Object> commandMap,
    		ModelMap model)
    throws Exception {

		String sLocationUrl = "/uss/olp/qim/EgovQustnrItemManageDetail";

		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");

		if(sCmd.equals("del")){
			egovQustnrItemManageService.deleteQustnrItemManage(qustnrItemManageVO);
			sLocationUrl = "redirect:/uss/olp/qim/EgovQustnrItemManageList.do";
		}else{
	        model.addAttribute("resultList", egovQustnrItemManageService.selectQustnrItemManageDetail(qustnrItemManageVO));
		}

		return sLocationUrl;
	}

	/**
	 * 설문항목를 수정한다.
	 * @param searchVO
	 * @param commandMap
	 * @param qustnrItemManageVO
	 * @param bindingResult
	 * @param model
	 * @return "/uss/olp/qim/EgovQustnrItemManageModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/uss/olp/qim/EgovQustnrItemManageModify.do")
	public String QustnrItemManageModify(
			@ModelAttribute("searchVO") ComDefaultVO searchVO,
			@RequestParam Map <String, Object> commandMap,
			@ModelAttribute("qustnrItemManageVO") QustnrItemManageVO qustnrItemManageVO,
			BindingResult bindingResult,
    		ModelMap model)
    throws Exception {
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		//로그인 객체 선언
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

		String sLocationUrl = "/uss/olp/qim/EgovQustnrItemManageModify";

		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");

        if(sCmd.equals("save")){

    		//서버  validate 체크
            beanValidator.validate(qustnrItemManageVO, bindingResult);
    		if(bindingResult.hasErrors()){
            	//설문항목(을)를  정보 불러오기
                model.addAttribute("listQustnrTmplat", egovQustnrItemManageService.selectQustnrTmplatManageList(qustnrItemManageVO));
            	//게시물 불러오기
                model.addAttribute("resultList", egovQustnrItemManageService.selectQustnrItemManageDetail(qustnrItemManageVO));

                return "/uss/olp/qim/EgovQustnrItemManageModify";
    		}

    		//아이디 설정
    		qustnrItemManageVO.setFrstRegisterId((String)loginVO.getUniqId());
    		qustnrItemManageVO.setLastUpdusrId((String)loginVO.getUniqId());

        	egovQustnrItemManageService.updateQustnrItemManage(qustnrItemManageVO);
        	sLocationUrl = "redirect:/uss/olp/qim/EgovQustnrItemManageList.do";
        }else{
            model.addAttribute("resultList", egovQustnrItemManageService.selectQustnrItemManageDetail(qustnrItemManageVO));

        	//설문항목(을)를  정보 불러오기
            model.addAttribute("listQustnrTmplat", egovQustnrItemManageService.selectQustnrTmplatManageList(qustnrItemManageVO));
        }

		return sLocationUrl;
	}

	/**
	 * 설문항목를 등록한다.
	 * @param searchVO
	 * @param commandMap
	 * @param qustnrItemManageVO
	 * @param bindingResult
	 * @param model
	 * @return "/uss/olp/qim/EgovQustnrItemManageRegist"
	 * @throws Exception
	 */
	@RequestMapping(value="/uss/olp/qim/EgovQustnrItemManageRegist.do")
	public String QustnrItemManageRegist(
			@ModelAttribute("searchVO") ComDefaultVO searchVO,
			@RequestParam Map <String, Object> commandMap,
			@ModelAttribute("qustnrItemManageVO") QustnrItemManageVO qustnrItemManageVO,
			BindingResult bindingResult,
    		ModelMap model)
    throws Exception {
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		//로그인 객체 선언
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

		String sLocationUrl = "/uss/olp/qim/EgovQustnrItemManageRegist";

		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
		LOGGER.info("cmd => {}", sCmd);

        if(sCmd.equals("save")){

    		//서버  validate 체크
            beanValidator.validate(qustnrItemManageVO, bindingResult);
    		if(bindingResult.hasErrors()){
            	//설문항목(을)를  정보 불러오기
                model.addAttribute("listQustnrTmplat", egovQustnrItemManageService.selectQustnrTmplatManageList(qustnrItemManageVO));
                return "/uss/olp/qim/EgovQustnrItemManageRegist";
    		}

    		//아이디 설정
    		qustnrItemManageVO.setFrstRegisterId((String)loginVO.getUniqId());
    		qustnrItemManageVO.setLastUpdusrId((String)loginVO.getUniqId());

        	egovQustnrItemManageService.insertQustnrItemManage(qustnrItemManageVO);
        	sLocationUrl = "redirect:/uss/olp/qim/EgovQustnrItemManageList.do";
        }else{
        	//설문항목(을)를  정보 불러오기
            model.addAttribute("listQustnrTmplat", egovQustnrItemManageService.selectQustnrTmplatManageList(qustnrItemManageVO));
        }

		return sLocationUrl;
	}

}


