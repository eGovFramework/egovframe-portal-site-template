package egovframework.let.cop.bbs.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.cop.bbs.service.BoardMaster;
import egovframework.let.cop.bbs.service.BoardMasterVO;
import egovframework.let.cop.bbs.service.EgovBBSLoneMasterService;
import lombok.RequiredArgsConstructor;

/**
 * 게시판 속성관리를 위한 컨트롤러 클래스
 *
 * @author 공통 서비스 개발팀 한성곤
 * @since 2009.08.25
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.08.25  한성곤           최초 생성
 *  2011.08.31  JJY           경량환경 템플릿 커스터마이징버전 생성
 *  2024.10.08  안단희           롬복 생성자 기반 종속성 주입
 *
 *      </pre>
 */
@Controller
@RequiredArgsConstructor
public class EgovBBSLoneMasterController {

	private final EgovBBSLoneMasterService egovBBSLoneMasterService;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Autowired
	private DefaultBeanValidator beanValidator;

	/**
	 * 신규 게시판 마스터 등록을 위한 등록페이지로 이동한다.
	 *
	 * @param boardMasterVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cop/bbs/addBoardMaster.do")
	public String addBoardMaster(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {
		BoardMaster boardMaster = new BoardMaster();

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		vo.setCodeId("COM004");

		List<?> codeResult = cmmUseService.selectCmmCodeDetail(vo);

		model.addAttribute("typeList", codeResult);

		vo.setCodeId("COM009");

		codeResult = cmmUseService.selectCmmCodeDetail(vo);

		model.addAttribute("attrbList", codeResult);
		model.addAttribute("boardMaster", boardMaster);

		return "cop/bbs/EgovBBSLoneMstrRegist";
	}

	/**
	 * 신규 게시판 마스터 정보를 등록한다.
	 *
	 * @param boardMasterVO
	 * @param boardMaster
	 * @param status
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cop/bbs/insertBoardMaster.do")
	public String insertBoardMaster(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster,
			BindingResult bindingResult, SessionStatus status, ModelMap model) throws Exception {

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		beanValidator.validate(boardMaster, bindingResult);
		if (bindingResult.hasErrors()) {

			ComDefaultCodeVO vo = new ComDefaultCodeVO();

			vo.setCodeId("COM004");

			List<?> codeResult = cmmUseService.selectCmmCodeDetail(vo);

			model.addAttribute("typeList", codeResult);

			vo.setCodeId("COM009");

			codeResult = cmmUseService.selectCmmCodeDetail(vo);

			model.addAttribute("attrbList", codeResult);

			return "cop/bbs/EgovBBSLoneMstrRegist";
		}

		if (isAuthenticated) {
			boardMaster.setFrstRegisterId(user.getUniqId());
			boardMaster.setUseAt("Y");
			boardMaster.setTrgetId("SYSTEMDEFAULT_REGIST");

			egovBBSLoneMasterService.insertMaster(boardMaster);
		}

		return "forward:/cop/bbs/selectBoardMasterList.do";
	}

	/**
	 * 게시판 마스터 목록을 조회한다.
	 *
	 * @param boardMasterVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cop/bbs/selectBoardMasterList.do")
	public String selectBoardMasterList(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {
		boardMasterVO.setPageUnit(propertyService.getInt("pageUnit"));
		boardMasterVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(boardMasterVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardMasterVO.getPageUnit());
		paginationInfo.setPageSize(boardMasterVO.getPageSize());

		boardMasterVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardMasterVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardMasterVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> map = egovBBSLoneMasterService.selectMasterList(boardMasterVO);
		int totCnt = Integer.parseInt((String) map.get("resultCnt"));

		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "cop/bbs/EgovBBSLoneMstrList";
	}

	/**
	 * 게시판 마스터 상세내용을 조회한다.
	 *
	 * @param boardMasterVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cop/bbs/selectBoardMaster.do")
	public String selectBoardMaster(@ModelAttribute("searchVO") BoardMasterVO searchVO, ModelMap model) throws Exception {
		BoardMasterVO vo = egovBBSLoneMasterService.selectMaster(searchVO);

		model.addAttribute("result", vo);

		model.addAttribute("provdUrl", "/cop/bbs/selectBoardList.do?bbsId=" + vo.getBbsId());

		return "cop/bbs/EgovBBSLoneMstrUpdt";
	}

	/**
	 * 게시판 마스터 정보를 수정한다.
	 *
	 * @param boardMasterVO
	 * @param boardMaster
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cop/bbs/updateBoardMaster.do")
	public String updateBoardMaster(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster,
			BindingResult bindingResult, ModelMap model) throws Exception {

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		beanValidator.validate(boardMaster, bindingResult);
		if (bindingResult.hasErrors()) {
			BoardMasterVO vo = egovBBSLoneMasterService.selectMaster(boardMasterVO);

			model.addAttribute("result", vo);

			return "cop/bbs/EgovBBSLoneMstrUpdt";
		}

		if (isAuthenticated) {
			boardMaster.setLastUpdusrId(user.getUniqId());
			egovBBSLoneMasterService.updateMaster(boardMaster);
		}

		return "forward:/cop/bbs/selectBoardMasterList.do";
	}

	/**
	 * 게시판 마스터 정보를 삭제한다.
	 *
	 * @param boardMasterVO
	 * @param boardMaster
	 * @param status
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cop/bbs/deleteBoardMaster.do")
	public String deleteBoardMaster(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMaster boardMaster,
			SessionStatus status) throws Exception {

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (isAuthenticated) {
			boardMaster.setLastUpdusrId(user.getUniqId());
			egovBBSLoneMasterService.deleteMaster(boardMaster);
		}
		return "forward:/cop/bbs/selectBoardMasterList.do";
	}
}
