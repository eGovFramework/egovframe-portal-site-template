package egovframework.let.sec.gmt.web;

import org.egovframe.rte.fdl.cmmn.exception.BaseRuntimeException;
import org.egovframe.rte.fdl.cmmn.exception.FdlException;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.com.cmm.util.EgovOwnerAuthUtil;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.let.sec.gmt.service.EgovGroupManageService;
import egovframework.let.sec.gmt.service.GroupManage;
import egovframework.let.sec.gmt.service.GroupManageVO;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;

/**
 * 그룹관리에 관한 controller 클래스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이문준          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성 
 *
 * </pre>
 */

@Controller
public class EgovGroupManageController {
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name = "egovGroupManageService")
    private EgovGroupManageService egovGroupManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /** Message ID Generation */
    @Resource(name="egovGroupIdGnrService")    
    private EgovIdGnrService egovGroupIdGnrService;
    
    /**
	 * 그룹 목록화면 이동
	 * @return String
	 */
    @RequestMapping("/sec/gmt/EgovGroupListView.do")
    public String selectGroupListView() {
        return "/sec/gmt/EgovGroupManage";
    }   

	/**
	 * 시스템사용 목적별 그룹 목록 조회
	 * @param groupManageVO GroupManageVO
	 * @return String
	 */
    @RequestMapping(value="/sec/gmt/EgovGroupList.do")
	public String selectGroupList(@ModelAttribute("groupManageVO") GroupManageVO groupManageVO, ModelMap model) {
    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(groupManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(groupManageVO.getPageUnit());
		paginationInfo.setPageSize(groupManageVO.getPageSize());
		
		groupManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		groupManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		groupManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		groupManageVO.setGroupManageList(egovGroupManageService.selectGroupList(groupManageVO));
        model.addAttribute("groupList", groupManageVO.getGroupManageList());
        
        int totCnt = egovGroupManageService.selectGroupListTotCnt(groupManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

        return "/sec/gmt/EgovGroupManage";
	}

	/**
	 * 검색조건에 따른 그룹정보를 조회
	 * @param groupManageVO GroupManageVO
	 * @return String
	 */
    @RequestMapping(value="/sec/gmt/EgovGroup.do")
	public String selectGroup(@ModelAttribute("groupManageVO") GroupManageVO groupManageVO, ModelMap model) {
	    GroupManageVO groupManage = egovGroupManageService.selectGroup(groupManageVO);
	    model.addAttribute("groupManage", groupManage);
	    // 저장/삭제 버튼은 등록자 본인에게만 노출
	    model.addAttribute("ownerAt", EgovOwnerAuthUtil.ownerAt(groupManage == null ? null : groupManage.getFrstRegisterId()));
	    return "/sec/gmt/EgovGroupUpdate";
	}

    /**
	 * 그룹 등록화면 이동
	 * @return String
	 */     
    @RequestMapping(value="/sec/gmt/EgovGroupInsertView.do")
    public String insertGroupView() {
        return "/sec/gmt/EgovGroupInsert";
    }

	/**
	 * 그룹 기본정보를 화면에서 입력하여 항목의 정합성을 체크하고 데이터베이스에 저장
	 * @param groupManage GroupManage
	 * @param groupManageVO GroupManageVO
	 * @return String
	 */ 
    @RequestMapping(value="/sec/gmt/EgovGroupInsert.do", method = RequestMethod.POST)
	public String insertGroup(@Valid @ModelAttribute("groupManage") GroupManage groupManage, 
			                   BindingResult bindingResult,
			                  @ModelAttribute("groupManageVO") GroupManageVO groupManageVO, 
			                   SessionStatus status, 
			                   ModelMap model) {
    	
    	// zzz validation 처리 필요
    	if (bindingResult.hasErrors()) { 
			return "/sec/gmt/EgovGroupInsert";
		} else {
	    	try {
				groupManage.setGroupId(egovGroupIdGnrService.getNextStringId());
			} catch (FdlException e) {
				throw new BaseRuntimeException(e);
			}
	        groupManageVO.setGroupId(groupManage.getGroupId());
	        groupManage.setFrstRegisterId(EgovOwnerAuthUtil.getLoginUniqId());
	        model.addAttribute("ownerAt", "Y");
	        
	        status.setComplete();
	        model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
	        model.addAttribute("groupManage", egovGroupManageService.insertGroup(groupManage, groupManageVO));
	        return "/sec/gmt/EgovGroupUpdate";
		}
	}
    
	/**
	 * 화면에 조회된 그룹의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
	 * @param groupManage GroupManage
	 * @return String
	 */     
    @RequestMapping(value="/sec/gmt/EgovGroupUpdate.do", method = RequestMethod.POST)
	public String updateGroup(@Valid @ModelAttribute("groupManage") GroupManage groupManage, 
			                   BindingResult bindingResult,
                               SessionStatus status, 
                               Model model) {
    	
    	// 등록자 본인만 수정 가능
    	assertGroupOwner(groupManage.getGroupId());
    	model.addAttribute("ownerAt", "Y");

    	// zzz validation 처리 필요
    	if (bindingResult.hasErrors()) { 
			return "/sec/gmt/EgovGroupUpdate";
		} else {
    	    egovGroupManageService.updateGroup(groupManage);
            status.setComplete();
            model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));
    	    return "forward:/sec/gmt/EgovGroup.do";
		}
	}	
	
	/**
	 * 불필요한 그룹정보를 화면에 조회하여 데이터베이스에서 삭제
	 * @param groupManage GroupManage
	 * @return String
	 */
	@RequestMapping(value="/sec/gmt/EgovGroupDelete.do", method = RequestMethod.POST)
	public String deleteGroup(@ModelAttribute("groupManage") GroupManage groupManage, 
                             SessionStatus status, 
                             Model model) {
		// 등록자 본인만 삭제 가능
		assertGroupOwner(groupManage.getGroupId());
		egovGroupManageService.deleteGroup(groupManage);
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/sec/gmt/EgovGroupList.do";
	}

	/**
	 * 불필요한 그룹정보 목록을 화면에 조회하여 데이터베이스에서 삭제
	 * @param groupIds String
	 * @param groupManage GroupManage
	 * @return String
	 */   
	@RequestMapping(value="/sec/gmt/EgovGroupListDelete.do", method = RequestMethod.POST)
	public String deleteGroupList(@RequestParam("groupIds") String groupIds,
			                      @ModelAttribute("groupManage") GroupManage groupManage, 
	                               SessionStatus status, 
	                               Model model) {
    	String [] strGroupIds = groupIds.split(";");
    	// 등록자 본인이 아닌 그룹이 포함되어 있으면 삭제하지 않음
    	for(int i=0; i<strGroupIds.length;i++) {
    		assertGroupOwner(strGroupIds[i]);
    	}
    	for(int i=0; i<strGroupIds.length;i++) {
    		groupManage.setGroupId(strGroupIds[i]);
    		egovGroupManageService.deleteGroup(groupManage);
    	}
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/sec/gmt/EgovGroupList.do";
	}
	
    /**
	 * 그룹팝업 화면 이동
	 * @return String
	 */
    @RequestMapping("/sec/gmt/EgovGroupSearchView.do")
    public String selectGroupSearchView() {
        return "/sec/gmt/EgovGroupSearch";
    }   
	    
	/**
	 * 시스템사용 목적별 그룹 목록 조회
	 * @param groupManageVO GroupManageVO
	 * @return String
	 */
    @RequestMapping(value="/sec/gmt/EgovGroupSearchList.do")
	public String selectGroupSearchList(@ModelAttribute("groupManageVO") GroupManageVO groupManageVO, 
                                   ModelMap model) {
    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(groupManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(groupManageVO.getPageUnit());
		paginationInfo.setPageSize(groupManageVO.getPageSize());
		
		groupManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		groupManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		groupManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		groupManageVO.setGroupManageList(egovGroupManageService.selectGroupList(groupManageVO));
        model.addAttribute("groupList", groupManageVO.getGroupManageList());
        
        int totCnt = egovGroupManageService.selectGroupListTotCnt(groupManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

        return "/sec/gmt/EgovGroupSearch";
	}

	/**
	 * 그룹의 등록자 본인 여부를 검증한다.
	 * @param groupId String
	 */
	private void assertGroupOwner(String groupId) {
		GroupManageVO searchVO = new GroupManageVO();
		searchVO.setGroupId(groupId);
		GroupManageVO existing = egovGroupManageService.selectGroup(searchVO);
		EgovOwnerAuthUtil.assertOwner(existing == null ? null : existing.getFrstRegisterId());
	}
}
