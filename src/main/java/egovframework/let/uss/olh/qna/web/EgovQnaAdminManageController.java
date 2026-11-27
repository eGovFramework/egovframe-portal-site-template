package egovframework.let.uss.olh.qna.web;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.annotation.RequireAdmin;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.web.EgovFileMngController;
import egovframework.let.uss.olh.qna.service.EgovQnaManageService;
import egovframework.let.uss.olh.qna.service.QnaManageDefaultVO;
import egovframework.let.uss.olh.qna.service.QnaManageVO;
import egovframework.let.uss.olh.qna.util.EgovQnaAuthUtil;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;

/**
 *
 * Q&A를 처리하는 Controller 클래스
 * @author 공통서비스 개발팀 박정규
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  박정규          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *   2026.08.19  유지보수        관리자 화면도 암호화된 qaId를 전송하므로 복호화 처리 추가
 *
 * </pre>
 */
@Controller
public class EgovQnaAdminManageController {

	@Resource(name = "QnaManageService")
	private EgovQnaManageService qnaManageService;

	@Resource(name = "egovPasswordEncoder")
	private PasswordEncoder passwordEncoder;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/**
	 * 화면에 노출되는 qaId는 암호화되어 있으므로(egovc:encrypt), 요청으로 들어온 값을
	 * 실제 QA_ID로 복호화한다. 복호화에 실패하면 원본과 매칭되지 않는 값을 반환하여
	 * (조회결과 없음으로 안전하게 실패 처리됨).
	 *
	 * @param qnaManageVO
	 */
	private static void decryptQaId(QnaManageVO qnaManageVO) {
		qnaManageVO.setQaId(EgovFileMngController.decrypt(qnaManageVO.getQaId()));
	}

	/**
	 * 포털서비스관리 > QnA관리에서는 등록된 질문을 수정할 수 없다.
	 */
	private static void assertQnaNotModifiable() {
		throw new AccessDeniedException("등록된 질문은 관리자가 수정할 수 없습니다.");
	}

	/**
	 * 개별 배포시 메인메뉴를 조회한다.
	 * @param model
	 * @return	"/uss/olh/qna/admin/"
	 */
	@RequireAdmin
	@RequestMapping(value = "/uss/olh/qna/admin/EgovMain.do")
	public String EgovMain(ModelMap model) {
		return "/uss/olh/qna/admin/EgovMain";
	}

	/**
	 * 메뉴를 조회한다.
	 * @param model
	 * @return	"/uss/olh/qna/admin/EgovLeft"
	 */
	@RequireAdmin
	@RequestMapping(value = "/uss/olh/qna/admin/EgovLeft.do")
	public String EgovLeft(ModelMap model) {
		return "/uss/olh/qna/admin/EgovLeft";
	}

	/**
	 * Q&A정보 목록을 조회한다. (pageing)
	 * @param searchVO
	 * @param model
	 * @return	"/uss/olh/qna/admin/EgovQnaListInqire"
	 */
	@RequireAdmin
	@RequestMapping(value = "/uss/olh/qna/admin/QnaListInqire.do")
	public String selectQnaList(@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) {

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

		model.addAttribute("resultList", qnaManageService.selectQnaList(searchVO));
		
		// 인증여부 체크
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (!isAuthenticated) {

			model.addAttribute("certificationAt", "N");

		} else {

			model.addAttribute("certificationAt", "Y");

		}

		int totCnt = qnaManageService.selectQnaListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "/uss/olh/qna/admin/EgovQnaListInqire";
	}

	/**
	 * Q&A정보 목록에 대한 상세정보를 조회한다.
	 * @param qnaManageVO
	 * @param searchVO
	 * @param model
	 * @return	"/uss/olh/qna/admin/EgovQnaDetailInqire"
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/QnaDetailInqire.do")
	public String selectQnaListDetail(QnaManageVO qnaManageVO,
			@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) {

		decryptQaId(qnaManageVO);
		QnaManageVO vo = qnaManageService.selectQnaListDetail(qnaManageVO);


		// 작성비밀번호는 일방향 해시이므로 복호화하지 않음

		model.addAttribute("result", vo);
		// 등록된 질문은 관리자가 수정할 수 없으며, 삭제는 등록자 본인만 가능
		model.addAttribute("deleteAt", EgovQnaAuthUtil.canShowModifyButtons(vo) ? "Y" : "N");

		return "/uss/olh/qna/admin/EgovQnaDetailInqire";
	}

	/**
	 * Q&A 조회수를  수정처리한다.
	 * @param qnaManageVO
	 * @param searchVO
	 * @return	"forward:/uss/olh/qna/admin/QnaDetailInqire.do"
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/QnaInqireCoUpdt.do")
	public String updateQnaInqireCo(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO) {

		decryptQaId(qnaManageVO);
		qnaManageService.updateQnaInqireCo(qnaManageVO);

		return "forward:/uss/olh/qna/admin/QnaDetailInqire.do";

	}

	/**
	 * 로그인/실명확인 처리
	 * @param qnaManageVO
	 * @param searchVO
	 * @param model
	 * @return	/uss/olh/qna/admin/EgovLoginRealnmChoice
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/LoginRealnmChoice.do")
	public String selectLoginRealnmChoice(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO, Model model) {

		model.addAttribute("QnaManageVO", new QnaManageVO());

		return "/uss/olh/qna/admin/EgovQnaLoginRealnmChoice";
	}

	/**
	 * Q&A정보를 등록하기 위한 전 처리(인증체크)
	 * @param searchVO
	 * @param qnaManageVO
	 * @param model
	 * @return	"/uss/olh/qna/admin/EgovQnaCnRegist"
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/QnaCnRegistView.do")
	public String insertQnaCnView(@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, QnaManageVO qnaManageVO, Model model) {

		// 인증여부 체크
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (!isAuthenticated) {
			model.addAttribute("result", qnaManageVO);
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String wrterNm = loginVO.getName(); // 사용자명
		String emailAdres = loginVO.getEmail(); // email 주소

		qnaManageVO.setWrterNm(wrterNm); // 작성자명
		qnaManageVO.setEmailAdres(emailAdres); // email 주소

		model.addAttribute("result", qnaManageVO);
		model.addAttribute("qnaManageVO", qnaManageVO);

		return "/uss/olh/qna/admin/EgovQnaCnRegist";

	}

	/**
	 * Q&A정보를 등록한다.
	 * @param searchVO
	 * @param qnaManageVO
	 * @param bindingResult
	 * @return	"forward:/uss/olh/qna/admin/QnaListInqire.do"
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/QnaCnRegist.do")
	public String insertQnaCn(@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, @Valid @ModelAttribute("qnaManageVO") QnaManageVO qnaManageVO, BindingResult bindingResult,
			ModelMap model) {

		if (bindingResult.hasErrors()) {
			return "/uss/olh/qna/admin/EgovQnaCnRegist";
		}

		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String frstRegisterId = loginVO.getUniqId();

		qnaManageVO.setFrstRegisterId(frstRegisterId); // 최초등록자ID
		qnaManageVO.setLastUpdusrId(frstRegisterId); // 최종수정자ID

		// 작성비밀번호 해시는 insertQnaCn 에서 수행 (qaId 채번 후)
		qnaManageService.insertQnaCn(qnaManageVO);

		return "forward:/uss/olh/qna/admin/QnaListInqire.do";
	}

	/**
	 * Q&A정보를 수정하기 위한 전 처리(비밀번호 암호화)
	 * @param qnaManageVO
	 * @param searchVO
	 * @param model
	 * @return	"/uss/olh/qna/admin/EgovQnaCnUpdt
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/QnaCnUpdtView.do")
	public String updateQnaCnView(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) {

		// 등록된 질문은 관리자가 수정할 수 없음
		assertQnaNotModifiable();

		decryptQaId(qnaManageVO);
		QnaManageVO vo = qnaManageService.selectQnaListDetail(qnaManageVO);

		// 작성비밀번호는 일방향 해시이므로 복호화하지 않음

		// 복호화된 패스워드를 넘긴다..
		model.addAttribute("qnaManageVO", vo);

		// result에도 세팅(jstl 사용을 위해)
		// qaId 이중 복호화 방지 : 조회한 vo 사용
		model.addAttribute("result", vo);

		return "/uss/olh/qna/admin/EgovQnaCnUpdt";
	}

	/**
	 * Q&A정보를 수정처리한다.
	 * @param searchVO
	 * @param qnaManageVO
	 * @param bindingResult
	 * @return	"forward:/uss/olh/qna/admin/QnaListInqire.do"
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/QnaCnUpdt.do")
	public String updateQnaCn(@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, @Valid @ModelAttribute("qnaManageVO") QnaManageVO qnaManageVO, BindingResult bindingResult) {

		// 등록된 질문은 관리자가 수정할 수 없음
		assertQnaNotModifiable();

		if (bindingResult.hasErrors()) {
			return "/uss/olh/qna/admin/EgovQnaCnUpdt";
		}

		decryptQaId(qnaManageVO);
		QnaManageVO existing = qnaManageService.selectQnaListDetail(qnaManageVO);

		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String lastUpdusrId = loginVO.getUniqId();

		qnaManageVO.setLastUpdusrId(lastUpdusrId); // 최종수정자ID

		// 작성비밀번호를 암호화 하기 위해서 Get
		String writngPassword = qnaManageVO.getWritngPassword();

		// 입력 시 BCrypt 해시, 빈 값이면 기존 해시 보존
		if (writngPassword != null && !writngPassword.isEmpty()) {
			qnaManageVO.setWritngPassword(
					passwordEncoder.encode(writngPassword));
		} else {
			qnaManageVO.setWritngPassword(existing.getWritngPassword());
		}

		qnaManageService.updateQnaCn(qnaManageVO);

		return "forward:/uss/olh/qna/admin/QnaListInqire.do";

	}

	/**
	 * Q&A정보를 삭제처리한다.
	 * @param qnaManageVO
	 * @param searchVO
	 * @return	"forward:/uss/olh/qna/admin/QnaListInqire.do"
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/QnaCnDelete.do")
	public String deleteQnaCn(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO, Model model) {
		
		// 인증여부 체크
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (!isAuthenticated) {
			model.addAttribute("result", qnaManageVO);
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		decryptQaId(qnaManageVO);
		// 삭제는 등록자 본인만 가능
		QnaManageVO existing = qnaManageService.selectQnaListDetail(qnaManageVO);
		EgovQnaAuthUtil.assertCanModifyQna(existing, null);
		qnaManageService.deleteQnaCn(qnaManageVO);

		return "forward:/uss/olh/qna/admin/QnaListInqire.do";
	}

	/**
	 * Q&A답변정보 목록을 조회한다. (pageing)
	 * @param searchVO
	 * @param model
	 * @return	"/uss/olh/qna/admin/EgovQnaAnswerListInqire"
	 */
	@RequireAdmin
	@RequestMapping(value = "/uss/olh/qnm/admin/QnaAnswerListInqire.do")
	public String selectQnaAnswerList(@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) {

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

		model.addAttribute("resultList", qnaManageService.selectQnaAnswerList(searchVO));

		int totCnt = qnaManageService.selectQnaAnswerListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "/uss/olh/qna/admin/EgovQnaAnswerListInqire";
	}

	/**
	 * Q&A답변정보 목록에 대한 상세정보를 조회한다.
	 * @param qnaManageVO
	 * @param searchVO
	 * @param model
	 * @return	"/uss/olh/qna/admin/EgovQnaAnswerDetailInqire"
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qnm/admin/QnaAnswerDetailInqire.do")
	public String selectQnaAnswerListDetail(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) {

		decryptQaId(qnaManageVO);
		QnaManageVO vo = qnaManageService.selectQnaListDetail(qnaManageVO);

		model.addAttribute("result", vo);

		return "/uss/olh/qna/admin/EgovQnaAnswerDetailInqire";
	}

	/**
	 * Q&A답변정보를 수정하기 위한 전 처리(공통코드 처리)
	 * @param qnaManageVO
	 * @param searchVO
	 * @param model
	 * @return	"/uss/olh/qna/admin/EgovQnaCnAnswerUpdt"
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qnm/admin/QnaCnAnswerUpdtView.do")
	public String updateQnaCnAnswerView(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) {

		// 공통코드를 가져오기 위한 Vo
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM028");

		model.addAttribute("resultList", cmmUseService.selectCmmCodeDetail(vo));

		// 변수명은 CoC 에 따라
		model.addAttribute(selectQnaAnswerListDetail(qnaManageVO, searchVO, model));

		return "/uss/olh/qna/admin/EgovQnaCnAnswerUpdt";
	}

	/**
	 * Q&A답변정보를 수정처리한다.
	 * @param qnaManageVO
	 * @param searchVO
	 * @return	"forward:/uss/olh/qnm/admin/QnaAnswerListInqire.do"
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qnm/admin/QnaCnAnswerUpdt.do")
	public String updateQnaCnAnswer(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO) {

		decryptQaId(qnaManageVO);

		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String lastUpdusrId = loginVO.getUniqId();

		qnaManageVO.setLastUpdusrId(lastUpdusrId); // 최종수정자ID

		qnaManageService.updateQnaCnAnswer(qnaManageVO);

		return "forward:/uss/olh/qnm/admin/QnaAnswerListInqire.do";

	}

}
