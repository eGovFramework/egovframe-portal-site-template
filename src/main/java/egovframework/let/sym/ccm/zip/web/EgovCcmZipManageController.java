package egovframework.let.sym.ccm.zip.web;

import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import egovframework.com.cmm.LoginVO;
import egovframework.let.sym.ccm.zip.service.EgovCcmZipManageService;
import egovframework.let.sym.ccm.zip.service.Zip;
import egovframework.let.sym.ccm.zip.service.ZipVO;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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

/**
 * 
 * 우편번호에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한 Controller를 정의한다
 * @author 공통서비스 개발팀 이중호
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
@Controller
public class EgovCcmZipManageController {
	@Resource(name = "ZipManageService")
    private EgovCcmZipManageService zipManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	@Autowired
	private DefaultBeanValidator beanValidator;
	
	/**
	 * 우편번호 찾기 팝업 메인창을 호출한다.
	 * @param model
	 * @return "/cmm/sym/zip/EgovCcmZipSearchPopup"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/cmm/EgovCcmZipSearchPopup.do")
 	public String callNormalCalPopup (ModelMap model
 			) throws Exception {
		return "/cmm/sym/zip/EgovCcmZipSearchPopup";
	}    
    
    /**
	 * 우편번호 찾기 목록을 조회한다.
     * @param searchVO
     * @param model
     * @return "/cmm/sym/zip/EgovCcmZipSearchList"
     * @throws Exception
     */
    @RequestMapping(value="/sym/cmm/EgovCcmZipSearchList.do")
	public String selectZipSearchList (@ModelAttribute("searchVO") ZipVO searchVO
			, ModelMap model
			) throws Exception {
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
		
        model.addAttribute("resultList", zipManageService.selectZipList(searchVO));
        
        int totCnt = zipManageService.selectZipListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/cmm/sym/zip/EgovCcmZipSearchList";
	}
	
	/**
	 * 우편번호를 삭제한다.
	 * @param loginVO
	 * @param zip
	 * @param model
	 * @return "forward:/sym/ccm/zip/EgovCcmZipList.do"
	 * @throws Exception
	 */
    @RequestMapping(value="/sym/ccm/zip/EgovCcmZipRemove.do")
	public String deleteZip (@ModelAttribute("loginVO") LoginVO loginVO
			, Zip zip
			, ModelMap model
			) throws Exception {
    	zipManageService.deleteZip(zip);
        return "forward:/sym/ccm/zip/EgovCcmZipList.do";
	}

	/**
	 * 우편번호를 등록한다.
	 * @param loginVO
	 * @param zip
	 * @param bindingResult
	 * @param model
	 * @return "/cmm/sym/zip/EgovCcmZipRegist"
	 * @throws Exception
	 */
    @RequestMapping(value="/sym/ccm/zip/EgovCcmZipRegist.do")
	public String insertZip (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("zip") Zip zip
			, BindingResult bindingResult
			, ModelMap model
			) throws Exception {
    	if   (zip.getZip() == null
    		||zip.getZip().equals("")) {

            return "/cmm/sym/zip/EgovCcmZipRegist";
    	}
    	
        beanValidator.validate(zip, bindingResult);
		if (bindingResult.hasErrors()){
            return "/cmm/sym/zip/EgovCcmZipRegist";
		}

    	zip.setFrstRegisterId(loginVO.getUniqId());
    	zipManageService.insertZip(zip);
        return "forward:/sym/ccm/zip/EgovCcmZipList.do";
    }

	/**
	 * 엑셀파일을 업로드하여 우편번호를 등록한다.
	 * @param loginVO
	 * @param request
	 * @param commandMap
	 * @param model
	 * @return "/cmm/sym/zip/EgovCcmExcelZipRegist"
	 * @throws Exception
	 */
	@RequestMapping(value = "/sym/ccm/zip/EgovCcmExcelZipRegist.do")
	public String insertExcelZip(@ModelAttribute("loginVO") LoginVO loginVO
			, final HttpServletRequest request
			, @RequestParam Map <String, Object> commandMap
			, Model model) throws Exception {

		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
    	if (sCmd.equals("")) {
    		return "/cmm/sym/zip/EgovCcmExcelZipRegist";
    	}

    	final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		final Map<String, MultipartFile> files = multiRequest.getFileMap();

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;

		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
		
			file = entry.getValue();
			if (!"".equals(file.getOriginalFilename())) {
		    	//zipManageService.deleteAllZip();
				//excelZipService.uploadExcel("ZipManageDAO.insertExcelZip", file.getInputStream(), 2);
				zipManageService.insertExcelZip(file.getInputStream());
			}
			if(file.getInputStream()!=null){
				file.getInputStream().close();
	        }
		}
        
        return "forward:/sym/ccm/zip/EgovCcmZipList.do";
	}
    
	/**
	 * 우편번호 상세항목을 조회한다.
	 * @param loginVO
	 * @param zip
	 * @param model
	 * @return "/cmm/sym/zip/EgovCcmZipDetail"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/ccm/zip/EgovCcmZipDetail.do")
 	public String selectZipDetail (@ModelAttribute("loginVO") LoginVO loginVO
 			, Zip zip
 			, ModelMap model
 			) throws Exception {
    	Zip vo = zipManageService.selectZipDetail(zip);
		model.addAttribute("result", vo);
		
		return "/cmm/sym/zip/EgovCcmZipDetail";
	}

    /**
	 * 우편번호 목록을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/cmm/sym/zip/EgovCcmZipList"
     * @throws Exception
     */
    @RequestMapping(value="/sym/ccm/zip/EgovCcmZipList.do")
	public String selectZipList (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") ZipVO searchVO
			, ModelMap model
			) throws Exception {
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
		
        model.addAttribute("resultList", zipManageService.selectZipList(searchVO));
        
        int totCnt = zipManageService.selectZipListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/cmm/sym/zip/EgovCcmZipList";
	}

	/**
	 * 우편번호를 수정한다.
	 * @param loginVO
	 * @param zip
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/cmm/sym/zip/EgovCcmZipModify"
	 * @throws Exception
	 */
    @RequestMapping(value="/sym/ccm/zip/EgovCcmZipModify.do")
	public String updateZip (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("zip") Zip zip
			, BindingResult bindingResult
			, @RequestParam Map <String, Object> commandMap
			, ModelMap model
			) throws Exception {
		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
    	if (sCmd.equals("")) {
    		Zip vo = zipManageService.selectZipDetail(zip);
    		model.addAttribute("zip", vo);

    		return "/cmm/sym/zip/EgovCcmZipModify";
    	} else if (sCmd.equals("Modify")) {
	        beanValidator.validate(zip, bindingResult);
			if (bindingResult.hasErrors()){
	    		return "/cmm/sym/zip/EgovCcmZipModify";
			}

			zip.setLastUpdusrId(loginVO.getUniqId());
	    	zipManageService.updateZip(zip);

	    	return "forward:/sym/ccm/zip/EgovCcmZipList.do";
    	} else {
	    	return "forward:/sym/ccm/zip/EgovCcmZipList.do";
    	}
    }
}