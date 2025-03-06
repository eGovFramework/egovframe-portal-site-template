package egovframework.let.uss.olp.qqm.web;

import java.util.HashMap;
import java.util.Map;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.uss.olp.qqm.service.EgovQustnrQestnManageService;
import egovframework.let.uss.olp.qqm.service.QustnrQestnManageVO;

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
 * 설문문항을 처리하는 Controller Class 구현
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
public class EgovQustnrQestnManageController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovQustnrQestnManageController.class);

	@Autowired
	private DefaultBeanValidator beanValidator;

	/** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	@Resource(name = "egovQustnrQestnManageService")
	private EgovQustnrQestnManageService egovQustnrQestnManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	@Resource(name="EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

    /**
     * 설문항목 통계를 조회한다.
     * @param searchVO
     * @param qustnrQestnManageVO
     * @param commandMap
     * @param model
     * @return "/uss/olp/qqm/EgovQustnrQestnManageStatistics"
     * @throws Exception
     */
    @RequestMapping(value="/uss/olp/qqm/EgovQustnrQestnManageStatistics.do")
	public String EgovQustnrQestnManageStatistics(
			@ModelAttribute("searchVO") ComDefaultVO searchVO,
			QustnrQestnManageVO qustnrQestnManageVO,
			@RequestParam Map <String, Object> commandMap,
    		ModelMap model)
    throws Exception {

		String sLocationUrl = "/uss/olp/qqm/EgovQustnrQestnManageStatistics";

        //List sampleList = egovQustnrQestnManageService.selectQustnrQestnManageDetail(qustnrQestnManageVO);
        model.addAttribute("resultList", egovQustnrQestnManageService.selectQustnrQestnManageDetail(qustnrQestnManageVO));
        // 객관식설문통계
        HashMap<String,String> mapParam = new HashMap<String,String>();
        mapParam.put("qestnrQesitmId", (String)qustnrQestnManageVO.getQestnrQesitmId());
        //List statisticsList = egovQustnrQestnManageService.selectQustnrManageStatistics(mapParam);
        model.addAttribute("statisticsList", egovQustnrQestnManageService.selectQustnrManageStatistics(mapParam));
        // 주관식설문통계
        //List statisticsList2 = egovQustnrQestnManageService.selectQustnrManageStatistics2(mapParam);
        model.addAttribute("statisticsList2", egovQustnrQestnManageService.selectQustnrManageStatistics2(mapParam));
		return sLocationUrl;
	}

	/**
	 * 설문문항 팝업 록을 조회한다.
	 * @param searchVO
	 * @param qustnrQestnManageVO
	 * @param commandMap
	 * @param model
	 * @return "/uss/olp/qqm/EgovQustnrQestnManageListPopup"
	 * @throws Exception
	 */
	@RequestMapping(value="/uss/olp/qqm/EgovQustnrQestnManageListPopup.do")
	public String EgovQustnrQestnManageListPopup(
			@ModelAttribute("searchVO") ComDefaultVO searchVO,
			@ModelAttribute("qustnrQestnManageVO") QustnrQestnManageVO qustnrQestnManageVO,
			@RequestParam Map <String, Object> commandMap,
    		ModelMap model)
    throws Exception {

		String sSearchMode = commandMap.get("searchMode") == null ? "" : (String)commandMap.get("searchMode");

		//설문지정보에서 넘어오면 자동검색 설정
		if(sSearchMode.equals("Y")){
			searchVO.setSearchCondition("QESTNR_ID");
			searchVO.setSearchKeyword(qustnrQestnManageVO.getQestnrId());
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

        model.addAttribute("resultList", egovQustnrQestnManageService.selectQustnrQestnManageList(searchVO));

        int totCnt = (Integer)egovQustnrQestnManageService.selectQustnrQestnManageListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

		return "/uss/olp/qqm/EgovQustnrQestnManageListPopup";
	}

	/**
	 * 설문문항 목록을 조회한다.
	 * @param searchVO
	 * @param qustnrQestnManageVO
	 * @param commandMap
	 * @param model
	 * @return "/uss/olp/qqm/EgovQustnrQestnManageList"
	 * @throws Exception
	 */
	@RequestMapping(value="/uss/olp/qqm/EgovQustnrQestnManageList.do")
	public String EgovQustnrQestnManageList(
			@ModelAttribute("searchVO") ComDefaultVO searchVO,
			@ModelAttribute("qustnrQestnManageVO") QustnrQestnManageVO qustnrQestnManageVO,
			@RequestParam Map <String, Object> commandMap,
    		ModelMap model)
    throws Exception {
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
		String sSearchMode = commandMap.get("searchMode") == null ? "" : (String)commandMap.get("searchMode");

		if(sCmd.equals("del")){
			egovQustnrQestnManageService.deleteQustnrQestnManage(qustnrQestnManageVO);
		}

		//설문지정보에서 넘어오면 자동검색 설정
		if(sSearchMode.equals("Y")){
			searchVO.setSearchCondition("QESTNR_ID");
			searchVO.setSearchKeyword(qustnrQestnManageVO.getQestnrId());
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

        model.addAttribute("resultList", egovQustnrQestnManageService.selectQustnrQestnManageList(searchVO));

        int totCnt = (Integer)egovQustnrQestnManageService.selectQustnrQestnManageListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

		return "/uss/olp/qqm/EgovQustnrQestnManageList";
	}

	/**
	 * 설문문항 목록을 상세조회 조회한다.
	 * @param searchVO
	 * @param qustnrQestnManageVO
	 * @param commandMap
	 * @param model
	 * @return "/uss/olp/qqm/EgovQustnrQestnManageDetail"
	 * @throws Exception
	 */
	@RequestMapping(value="/uss/olp/qqm/EgovQustnrQestnManageDetail.do")
	public String EgovQustnrQestnManageDetail(
			@ModelAttribute("searchVO") ComDefaultVO searchVO,
			@ModelAttribute("qustnrQestnManageVO") QustnrQestnManageVO qustnrQestnManageVO,
			@RequestParam Map <String, Object> commandMap,
    		ModelMap model)
    throws Exception {

		String sLocationUrl = "/uss/olp/qqm/EgovQustnrQestnManageDetail";

		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");

		if(sCmd.equals("del")){
			egovQustnrQestnManageService.deleteQustnrQestnManage(qustnrQestnManageVO);
			/** 목록으로갈때 검색조건 유지 */
			sLocationUrl = "redirect:/uss/olp/qqm/EgovQustnrQestnManageList.do?";
        	sLocationUrl = sLocationUrl + "searchMode=" + qustnrQestnManageVO.getSearchMode();
        	sLocationUrl = sLocationUrl + "&qestnrId=" + qustnrQestnManageVO.getQestnrId();
        	sLocationUrl = sLocationUrl + "&qestnrTmplatId=" +qustnrQestnManageVO.getQestnrTmplatId();
		}else{
	     	//공통코드 질문유형 조회
	    	ComDefaultCodeVO voComCode = new ComDefaultCodeVO();
	    	voComCode.setCodeId("COM018");
	    	model.addAttribute("cmmCode018", cmmUseService.selectCmmCodeDetail(voComCode));

	        model.addAttribute("resultList", egovQustnrQestnManageService.selectQustnrQestnManageDetail(qustnrQestnManageVO));
		}

		return sLocationUrl;
	}

	/**
	 * 설문문항를 수정한다.
	 * @param searchVO
	 * @param commandMap
	 * @param qustnrQestnManageVO
	 * @param bindingResult
	 * @param model
	 * @return "/uss/olp/qqm/EgovQustnrQestnManageModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/uss/olp/qqm/EgovQustnrQestnManageModify.do")
	public String QustnrQestnManageModify(
			@ModelAttribute("searchVO") ComDefaultVO searchVO,
			@RequestParam Map <String, Object> commandMap,
			@ModelAttribute("qustnrQestnManageVO") QustnrQestnManageVO qustnrQestnManageVO,
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

		String sLocationUrl = "/uss/olp/qqm/EgovQustnrQestnManageModify";

		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");

     	//공통코드 질문유형 조회
    	ComDefaultCodeVO voComCode = new ComDefaultCodeVO();
    	voComCode.setCodeId("COM018");
    	model.addAttribute("cmmCode018", cmmUseService.selectCmmCodeDetail(voComCode));

        if(sCmd.equals("save")){
    		//서버  validate 체크
            beanValidator.validate(qustnrQestnManageVO, bindingResult);
    		if (bindingResult.hasErrors()){
            	//설문제목가져오기
            	String sQestnrId = commandMap.get("qestnrId") == null ? "" : (String)commandMap.get("qestnrId");
            	String sQestnrTmplatId = commandMap.get("qestnrTmplatId") == null ? "" : (String)commandMap.get("qestnrTmplatId");

            	LOGGER.info("sQestnrId => {}", sQestnrId);
            	LOGGER.info("sQestnrTmplatId => {}", sQestnrTmplatId);
            	if(!sQestnrId.equals("") && !sQestnrTmplatId.equals("")){

            		Map<String,String> mapQustnrManage = new HashMap<String,String>();
            		mapQustnrManage.put("qestnrId", sQestnrId);
            		mapQustnrManage.put("qestnrTmplatId", sQestnrTmplatId);

            		model.addAttribute("qestnrInfo", egovQustnrQestnManageService.selectQustnrManageQestnrSj(mapQustnrManage));
            	}

                model.addAttribute("resultList", egovQustnrQestnManageService.selectQustnrQestnManageDetail(qustnrQestnManageVO));
            	return "/uss/olp/qqm/EgovQustnrQestnManageModify";
    		}

    		//아이디 설정
    		qustnrQestnManageVO.setFrstRegisterId((String)loginVO.getUniqId());
    		qustnrQestnManageVO.setLastUpdusrId((String)loginVO.getUniqId());

        	egovQustnrQestnManageService.updateQustnrQestnManage(qustnrQestnManageVO);
        	/** 목록으로갈때 검색조건 유지 */
        	sLocationUrl = "redirect:/uss/olp/qqm/EgovQustnrQestnManageList.do?";
        	sLocationUrl = sLocationUrl + "searchMode=" + qustnrQestnManageVO.getSearchMode();
        	sLocationUrl = sLocationUrl + "&qestnrId=" + qustnrQestnManageVO.getQestnrId();
        	sLocationUrl = sLocationUrl + "&qestnrTmplatId=" +qustnrQestnManageVO.getQestnrTmplatId();
        }else{
            model.addAttribute("resultList", egovQustnrQestnManageService.selectQustnrQestnManageDetail(qustnrQestnManageVO));

        }

		return sLocationUrl;
	}

	/**
	 * 설문문항를 등록한다.
	 * @param searchVO
	 * @param commandMap
	 * @param qustnrQestnManageVO
	 * @param bindingResult
	 * @param model
	 * @return "/uss/olp/qqm/EgovQustnrQestnManageRegist"
	 * @throws Exception
	 */
	@RequestMapping(value="/uss/olp/qqm/EgovQustnrQestnManageRegist.do")
	public String QustnrQestnManageRegist(
			@ModelAttribute("searchVO") ComDefaultVO searchVO,
			@RequestParam Map <String, Object> commandMap,
			@ModelAttribute("qustnrQestnManageVO") QustnrQestnManageVO qustnrQestnManageVO,
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

		String sLocationUrl = "/uss/olp/qqm/EgovQustnrQestnManageRegist";

		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
		LOGGER.info("cmd => {}", sCmd);

     	//공통코드 질문유형 조회
    	ComDefaultCodeVO voComCode = new ComDefaultCodeVO();
    	voComCode.setCodeId("COM018");
    	model.addAttribute("cmmCode018", cmmUseService.selectCmmCodeDetail(voComCode));

        if(sCmd.equals("save")){

    		//서버  validate 체크
            beanValidator.validate(qustnrQestnManageVO, bindingResult);
    		if (bindingResult.hasErrors()){
            	//설문제목가져오기
            	String sQestnrId = commandMap.get("qestnrId") == null ? "" : (String)commandMap.get("qestnrId");
            	String sQestnrTmplatId = commandMap.get("qestnrTmplatId") == null ? "" : (String)commandMap.get("qestnrTmplatId");

            	LOGGER.info("sQestnrId => {}", sQestnrId);
            	LOGGER.info("sQestnrTmplatId => {}", sQestnrTmplatId);
            	if(!sQestnrId.equals("") && !sQestnrTmplatId.equals("")){

            		Map<String,String> mapQustnrManage = new HashMap<String,String>();
            		mapQustnrManage.put("qestnrId", sQestnrId);
            		mapQustnrManage.put("qestnrTmplatId", sQestnrTmplatId);

            		model.addAttribute("qestnrInfo", egovQustnrQestnManageService.selectQustnrManageQestnrSj(mapQustnrManage));
            	}

    			return "/uss/olp/qqm/EgovQustnrQestnManageRegist";
    		}

    		//아이디 설정
    		qustnrQestnManageVO.setFrstRegisterId((String)loginVO.getUniqId());
    		qustnrQestnManageVO.setLastUpdusrId((String)loginVO.getUniqId());
    		/** 목록으로갈때 검색조건 유지 */
        	egovQustnrQestnManageService.insertQustnrQestnManage(qustnrQestnManageVO);
        	sLocationUrl = "redirect:/uss/olp/qqm/EgovQustnrQestnManageList.do?";
        	sLocationUrl = sLocationUrl + "searchMode=" + qustnrQestnManageVO.getSearchMode();
        	sLocationUrl = sLocationUrl + "&qestnrId=" + qustnrQestnManageVO.getQestnrId();
        	sLocationUrl = sLocationUrl + "&qestnrTmplatId=" +qustnrQestnManageVO.getQestnrTmplatId();

        }else{

        	//설문제목가져오기
        	String sQestnrId = commandMap.get("qestnrId") == null ? "" : (String)commandMap.get("qestnrId");
        	String sQestnrTmplatId = commandMap.get("qestnrTmplatId") == null ? "" : (String)commandMap.get("qestnrTmplatId");

        	LOGGER.info("sQestnrId => {}", sQestnrId);
        	LOGGER.info("sQestnrTmplatId => {}", sQestnrTmplatId);
        	if(!sQestnrId.equals("") && !sQestnrTmplatId.equals("")){

        		Map<String,String> mapQustnrManage = new HashMap<String,String>();
        		mapQustnrManage.put("qestnrId", sQestnrId);
        		mapQustnrManage.put("qestnrTmplatId", sQestnrTmplatId);

        		model.addAttribute("qestnrInfo", egovQustnrQestnManageService.selectQustnrManageQestnrSj(mapQustnrManage));
        	}

        }

		return sLocationUrl;
	}
}


