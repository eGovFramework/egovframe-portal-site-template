package egovframework.let.sec.ram.web;

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
import egovframework.let.sec.ram.service.AuthorManage;
import egovframework.let.sec.ram.service.AuthorManageVO;
import egovframework.let.sec.ram.service.EgovAuthorManageService;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;

/**
 * 권한관리에 관한 controller 클래스를 정의한다.
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
public class EgovAuthorManageController {

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "egovAuthorManageService")
	private EgovAuthorManageService egovAuthorManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/**
	 * 권한 목록화면 이동
	 * @return String
	 */
	@RequestMapping("/sec/ram/EgovAuthorListView.do")
	public String selectAuthorListView() {
		return "/sec/ram/EgovAuthorManage";
	}

	/**
	 * 권한 목록을 조회한다
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 */
	@RequestMapping(value = "/sec/ram/EgovAuthorList.do")
	public String selectAuthorList(@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, ModelMap model) {

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(authorManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(authorManageVO.getPageUnit());
		paginationInfo.setPageSize(authorManageVO.getPageSize());

		authorManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		authorManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		authorManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorList(authorManageVO));
		model.addAttribute("authorList", authorManageVO.getAuthorManageList());

		int totCnt = egovAuthorManageService.selectAuthorListTotCnt(authorManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/sec/ram/EgovAuthorManage";
	}

	/**
	 * 권한 세부정보를 조회한다.
	 * @param authorCode String
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 */
	@RequestMapping(value = "/sec/ram/EgovAuthor.do")
	public String selectAuthor(@RequestParam("authorCode") String authorCode, @ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, ModelMap model) {

		authorManageVO.setAuthorCode(authorCode);

		AuthorManageVO authorManage = egovAuthorManageService.selectAuthor(authorManageVO);
		model.addAttribute("authorManage", authorManage);
		// 저장/삭제 버튼은 등록자 본인에게만 노출
		model.addAttribute("ownerAt", EgovOwnerAuthUtil.ownerAt(authorManage == null ? null : authorManage.getFrstRegisterId()));
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));
		return "/sec/ram/EgovAuthorUpdate";
	}

	/**
	 * 권한 등록화면 이동
	 * @return String
	 */
	@RequestMapping("/sec/ram/EgovAuthorInsertView.do")
	public String insertAuthorView() {
		return "/sec/ram/EgovAuthorInsert";
	}

	/**
	 * 권한 세부정보를 등록한다.
	 * @param authorManage AuthorManage
	 * @param bindingResult BindingResult
	 * @return String
	 */
	@RequestMapping(value = "/sec/ram/EgovAuthorInsert.do", method = RequestMethod.POST)
	public String insertAuthor(@Valid @ModelAttribute("authorManage") AuthorManage authorManage, BindingResult bindingResult, SessionStatus status, ModelMap model) {

		if (bindingResult.hasErrors()) {
			return "/sec/ram/EgovAuthorInsert";
		} else {
			authorManage.setFrstRegisterId(EgovOwnerAuthUtil.getLoginUniqId());
			egovAuthorManageService.insertAuthor(authorManage);
			status.setComplete();
			model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
			return "forward:/sec/ram/EgovAuthor.do";
		}
	}

	/**
	 * 권한 세부정보를 수정한다.
	 * @param authorManage AuthorManage
	 * @param bindingResult BindingResult
	 * @return String
	 */
	@RequestMapping(value = "/sec/ram/EgovAuthorUpdate.do", method = RequestMethod.POST)
	public String updateAuthor(@Valid @ModelAttribute("authorManage") AuthorManage authorManage, BindingResult bindingResult, SessionStatus status, Model model) {

		// 등록자 본인만 수정 가능
		assertAuthorOwner(authorManage.getAuthorCode());
		model.addAttribute("ownerAt", "Y");

		if (bindingResult.hasErrors()) {
			return "/sec/ram/EgovAuthorUpdate";
		} else {
			egovAuthorManageService.updateAuthor(authorManage);
			status.setComplete();
			model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));
			return "forward:/sec/ram/EgovAuthor.do";
		}
	}

	/**
	 * 권한 세부정보를 삭제한다.
	 * @param authorManage AuthorManage
	 * @return String
	 */
	@RequestMapping(value = "/sec/ram/EgovAuthorDelete.do", method = RequestMethod.POST)
	public String deleteAuthor(@ModelAttribute("authorManage") AuthorManage authorManage, SessionStatus status, Model model) {

		// 등록자 본인만 삭제 가능
		assertAuthorOwner(authorManage.getAuthorCode());

		egovAuthorManageService.deleteAuthor(authorManage);
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/sec/ram/EgovAuthorList.do";
	}

	/**
	 * 권한목록을 삭제한다.
	 * @param authorCodes String
	 * @param authorManage AuthorManage
	 * @return String
	 */
	@RequestMapping(value = "/sec/ram/EgovAuthorListDelete.do", method = RequestMethod.POST)
	public String deleteAuthorList(@RequestParam("authorCodes") String authorCodes, @ModelAttribute("authorManage") AuthorManage authorManage, SessionStatus status, Model model) {

		String[] strAuthorCodes = authorCodes.split(";");
		// 등록자 본인이 아닌 권한이 포함되어 있으면 삭제하지 않음
		for (int i = 0; i < strAuthorCodes.length; i++) {
			assertAuthorOwner(strAuthorCodes[i]);
		}
		for (int i = 0; i < strAuthorCodes.length; i++) {
			authorManage.setAuthorCode(strAuthorCodes[i]);
			egovAuthorManageService.deleteAuthor(authorManage);
		}
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/sec/ram/EgovAuthorList.do";
	}

	/**
	 * 권한제한 화면 이동
	 * @return String
	 */
	@RequestMapping("/sec/ram/accessDenied.do")
	public String accessDenied() {
		return "sec/accessDenied";
	}

	/**
	 * 권한의 등록자 본인 여부를 검증한다.
	 * @param authorCode String
	 */
	private void assertAuthorOwner(String authorCode) {
		AuthorManageVO searchVO = new AuthorManageVO();
		searchVO.setAuthorCode(authorCode);
		AuthorManageVO existing = egovAuthorManageService.selectAuthor(searchVO);
		EgovOwnerAuthUtil.assertOwner(existing == null ? null : existing.getFrstRegisterId());
	}
}
