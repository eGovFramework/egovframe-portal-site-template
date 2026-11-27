package egovframework.let.uss.olh.qna.web;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.annotation.RequireAdmin;
import egovframework.com.cmm.web.EgovFileMngController;
import egovframework.let.cop.bbs.util.EgovBBSAuthUtil;
import egovframework.let.uss.olh.qna.service.EgovQnaManageService;
import egovframework.let.uss.olh.qna.util.EgovQnaAuthUtil;
import egovframework.let.uss.olh.qna.service.QnaManageDefaultVO;
import egovframework.let.uss.olh.qna.service.QnaManageVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

/**
 *
 * Q&A를 처리하는 Controller 클래스
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
 *   2009.04.01  박정규          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 *      </pre>
 */
@Controller
public class EgovQnaManageController {

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
	 * 개별 배포시 메인메뉴를 조회한다.
	 * 
	 * @param model
	 * @return "/uss/olh/qna/"
	 */
	@RequestMapping(value = "/uss/olh/qna/EgovMain.do")
	public String EgovMain(ModelMap model) {
		return "/uss/olh/qna/EgovMain";
	}

	/**
	 * 메뉴를 조회한다.
	 * 
	 * @param model
	 * @return "/uss/olh/qna/EgovLeft"
	 */
	@RequestMapping(value = "/uss/olh/qna/EgovLeft.do")
	public String EgovLeft(ModelMap model) {
		return "/uss/olh/qna/EgovLeft";
	}

	/**
	 * Q&A정보 목록을 조회한다. (pageing)
	 * 
	 * @param searchVO
	 * @param model
	 * @return "/uss/olh/qna/EgovQnaListInqire"
	 */
	@RequestMapping(value = "/uss/olh/qna/QnaListInqire.do")
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

		return "/uss/olh/qna/EgovQnaListInqire";
	}

	/**
	 * Q&A정보 목록에 대한 상세정보를 조회한다.
	 * 
	 * @param passwordConfirmAt
	 * @param qnaManageVO
	 * @param searchVO
	 * @param model
	 * @return "/uss/olh/qna/EgovQnaDetailInqire"
	 */
	@RequestMapping("/uss/olh/qna/QnaDetailInqire.do")
	public String selectQnaListDetail(@RequestParam(value = "passwordConfirmAt", required = false) String passwordConfirmAt,
			QnaManageVO qnaManageVO,
			@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) {

		decryptQaId(qnaManageVO);
		QnaManageVO vo = qnaManageService.selectQnaListDetail(qnaManageVO);
		vo.setWritngPassword(null);

		model.addAttribute("result", vo);
		// 작성 비밀번호 확인 실패 시에만 안내 문구 표시
		model.addAttribute("passwordFailAt",
				passwordConfirmAt != null && passwordConfirmAt.startsWith("N") ? "Y" : "N");
		// 수정/삭제 버튼 노출 여부 (등록자 본인)
		model.addAttribute("modifyAt", EgovQnaAuthUtil.canShowModifyButtons(vo) ? "Y" : "N");
		// 관리자는 작성 비밀번호 확인 없이 수정화면으로 이동
		model.addAttribute("adminAt", EgovBBSAuthUtil.isAdminUser() ? "Y" : "N");

		return "/uss/olh/qna/EgovQnaDetailInqire";
	}

	/**
	 * Q&A 조회수를 수정처리한다.
	 * 
	 * @param qnaManageVO
	 * @param searchVO
	 * @return "forward:/uss/olh/qna/QnaDetailInqire.do"
	 */
	@RequestMapping("/uss/olh/qna/QnaInqireCoUpdt.do")
	public String updateQnaInqireCo(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO) {

		decryptQaId(qnaManageVO);
		qnaManageService.updateQnaInqireCo(qnaManageVO);

		return "forward:/uss/olh/qna/QnaDetailInqire.do";

	}

	/**
	 * 로그인/실명확인 처리
	 * 
	 * @param qnaManageVO
	 * @param searchVO
	 * @param model
	 * @return /uss/olh/qna/EgovLoginRealnmChoice
	 */
	@RequestMapping("/uss/olh/qna/LoginRealnmChoice.do")
	public String selectLoginRealnmChoice(QnaManageVO qnaManageVO,
			@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, Model model) {

		model.addAttribute("QnaManageVO", new QnaManageVO());

		return "/uss/olh/qna/EgovQnaLoginRealnmChoice";
	}

	/**
	 * Q&A정보를 등록하기 위한 전 처리(인증체크)
	 * 
	 * @param searchVO
	 * @param qnaManageVO
	 * @param model
	 * @return "/uss/olh/qna/EgovQnaCnRegist"
	 */
	@RequestMapping("/uss/olh/qna/QnaCnRegistView.do")
	public String insertQnaCnView(@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, QnaManageVO qnaManageVO,
			Model model) {

		// 인증여부 체크
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (!isAuthenticated) {
			model.addAttribute("result", qnaManageVO);
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		// 로그인VO에서 사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String wrterNm = loginVO.getName(); // 사용자명
		String emailAdres = loginVO.getEmail(); // email 주소

		qnaManageVO.setWrterNm(wrterNm); // 작성자명
		qnaManageVO.setEmailAdres(emailAdres); // email 주소

		model.addAttribute("result", qnaManageVO);
		model.addAttribute("qnaManageVO", qnaManageVO);

		return "/uss/olh/qna/EgovQnaCnRegist";

	}

	/**
	 * Q&A정보를 등록한다.
	 * 
	 * @param searchVO
	 * @param qnaManageVO
	 * @param bindingResult
	 * @return "forward:/uss/olh/qna/QnaListInqire.do"
	 */
	@RequestMapping("/uss/olh/qna/QnaCnRegist.do")
	public String insertQnaCn(@ModelAttribute("searchVO") QnaManageDefaultVO searchVO,
			@Valid @ModelAttribute("qnaManageVO") QnaManageVO qnaManageVO, BindingResult bindingResult,
			ModelMap model) {

		if (bindingResult.hasErrors()) {
			return "/uss/olh/qna/EgovQnaCnRegist";
		}

		// 로그인VO에서 사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String frstRegisterId = loginVO.getUniqId();

		qnaManageVO.setFrstRegisterId(frstRegisterId); // 최초등록자ID
		qnaManageVO.setLastUpdusrId(frstRegisterId); // 최종수정자ID

		// 작성비밀번호 BCrypt 해시는 insertQnaCn 에서 수행
		qnaManageService.insertQnaCn(qnaManageVO);

		return "forward:/uss/olh/qna/QnaListInqire.do";
	}

	/**
	 * 작성 비밀번호를 확인하기 위한 전 처리
	 * 
	 * @param qnaManageVO
	 * @param searchVO
	 * @param model
	 * @return "/uss/olh/qna/EgovQnaPasswordConfirm"
	 */
	@RequestMapping("/uss/olh/qna/QnaPasswordConfirmView.do")
	public String selectPasswordConfirmView(QnaManageVO qnaManageVO,
			@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, Model model) {

		model.addAttribute("QnaManageVO", new QnaManageVO());

		return "/uss/olh/qna/EgovQnaPasswordConfirm";
	}

	/**
	 * 작성 비밀번호를 확인한다.
	 * 
	 * @param qnaManageVO
	 * @param searchVO
	 * @return "forward:/uss/olh/qna/QnaDetailInqire.do"
	 */
	@RequestMapping("/uss/olh/qna/QnaPasswordConfirm.do")
	public String selectPasswordConfirm(QnaManageVO qnaManageVO,
			@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, Model model, HttpSession session) {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (!isAuthenticated) {
			model.addAttribute("result", qnaManageVO);
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		} else {
			decryptQaId(qnaManageVO);

			if (qnaManageService.checkQnaPassword(qnaManageVO)) {
				EgovQnaAuthUtil.markPasswordConfirmed(session, qnaManageVO.getQaId());
				return "forward:/uss/olh/qna/QnaCnUpdtView.do";
			} else {
				return "forward:/uss/olh/qna/QnaDetailInqire.do?passwordConfirmAt=N";
			}
		}
	}

	/**
	 * Q&A정보를 수정하기 위한 전 처리(비밀번호 암호화)
	 * 
	 * @param qnaManageVO
	 * @param searchVO
	 * @param model
	 * @return "/uss/olh/qna/EgovQnaCnUpdt
	 */
	@RequestMapping("/uss/olh/qna/QnaCnUpdtView.do")
	public String updateQnaCnView(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO,
			ModelMap model, HttpSession session) {

		decryptQaId(qnaManageVO);
		QnaManageVO vo = qnaManageService.selectQnaListDetail(qnaManageVO);
		EgovQnaAuthUtil.assertCanModifyQna(vo, session);
		vo.setWritngPassword(null);

		model.addAttribute("qnaManageVO", vo);
		model.addAttribute("result", vo);

		return "/uss/olh/qna/EgovQnaCnUpdt";
	}

	/**
	 * Q&A정보를 수정처리한다.
	 * 
	 * @param searchVO
	 * @param qnaManageVO
	 * @param bindingResult
	 * @return "forward:/uss/olh/qna/QnaListInqire.do"
	 */
	@RequestMapping("/uss/olh/qna/QnaCnUpdt.do")
	public String updateQnaCn(@ModelAttribute("searchVO") QnaManageDefaultVO searchVO,
			@Valid @ModelAttribute("qnaManageVO") QnaManageVO qnaManageVO, BindingResult bindingResult,
			HttpSession session) {

		if (bindingResult.hasErrors()) {
			return "/uss/olh/qna/EgovQnaCnUpdt";
		}

		decryptQaId(qnaManageVO);
		QnaManageVO existing = qnaManageService.selectQnaListDetail(qnaManageVO);
		EgovQnaAuthUtil.assertCanModifyQna(existing, session);

		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		qnaManageVO.setLastUpdusrId(loginVO.getUniqId());
		qnaManageVO.setFrstRegisterId(existing.getFrstRegisterId());

		String writngPassword = qnaManageVO.getWritngPassword();
		if (writngPassword != null && !writngPassword.isEmpty()) {
			// BCrypt 해시
			qnaManageVO.setWritngPassword(
					passwordEncoder.encode(writngPassword));
		} else {
			qnaManageVO.setWritngPassword(existing.getWritngPassword());
		}

		qnaManageService.updateQnaCn(qnaManageVO);

		return "forward:/uss/olh/qna/QnaListInqire.do";

	}

	/**
	 * Q&A정보를 삭제처리한다.
	 * 
	 * @param qnaManageVO
	 * @param searchVO
	 * @return "forward:/uss/olh/qna/QnaListInqire.do"
	 */
	@RequestMapping("/uss/olh/qna/QnaCnDelete.do")
	public String deleteQnaCn(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO,
			Model model, HttpSession session) {

		if (!EgovUserDetailsHelper.isAuthenticated()) {
			model.addAttribute("result", qnaManageVO);
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		decryptQaId(qnaManageVO);
		QnaManageVO existing = qnaManageService.selectQnaListDetail(qnaManageVO);
		EgovQnaAuthUtil.assertCanModifyQna(existing, session);
		qnaManageVO.setLastUpdusrId(((LoginVO) EgovUserDetailsHelper.getAuthenticatedUser()).getUniqId());
		qnaManageVO.setFrstRegisterId(existing.getFrstRegisterId());
		qnaManageService.deleteQnaCn(qnaManageVO);

		return "forward:/uss/olh/qna/QnaListInqire.do";
	}

	/**
	 * Q&A답변정보 목록을 조회한다. (pageing)
	 * 
	 * @param searchVO
	 * @param model
	 * @return "/uss/olh/qna/EgovQnaAnswerListInqire"
	 */
	@RequestMapping(value = "/uss/olh/qnm/QnaAnswerListInqire.do")
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

		return "/uss/olh/qna/EgovQnaAnswerListInqire";
	}

	/**
	 * Q&A답변정보 목록에 대한 상세정보를 조회한다.
	 * 
	 * @param qnaManageVO
	 * @param searchVO
	 * @param model
	 * @return "/uss/olh/qna/EgovQnaAnswerDetailInqire"
	 */
	@RequestMapping("/uss/olh/qnm/QnaAnswerDetailInqire.do")
	public String selectQnaAnswerListDetail(QnaManageVO qnaManageVO,
			@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) {

		decryptQaId(qnaManageVO);
		QnaManageVO vo = qnaManageService.selectQnaListDetail(qnaManageVO);

		model.addAttribute("result", vo);
		// 답변 버튼은 관리자에게만 노출
		model.addAttribute("adminAt", EgovBBSAuthUtil.isAdminUser() ? "Y" : "N");

		return "/uss/olh/qna/EgovQnaAnswerDetailInqire";
	}

	/**
	 * Q&A답변정보를 수정하기 위한 전 처리(공통코드 처리)
	 * 
	 * @param qnaManageVO
	 * @param searchVO
	 * @param model
	 * @return "/uss/olh/qna/EgovQnaCnAnswerUpdt"
	 */
	// 답변 작성·수정은 관리자 전용
	@RequireAdmin
	@RequestMapping("/uss/olh/qnm/QnaCnAnswerUpdtView.do")
	public String updateQnaCnAnswerView(QnaManageVO qnaManageVO,
			@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) {

		// 공통코드를 가져오기 위한 Vo
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM028");

		model.addAttribute("resultList", cmmUseService.selectCmmCodeDetail(vo));

		// 변수명은 CoC 에 따라
		model.addAttribute(selectQnaAnswerListDetail(qnaManageVO, searchVO, model));

		return "/uss/olh/qna/EgovQnaCnAnswerUpdt";
	}

	/**
	 * Q&A답변정보를 수정처리한다.
	 * 
	 * @param qnaManageVO
	 * @param searchVO
	 * @return "forward:/uss/olh/qnm/QnaAnswerListInqire.do"
	 */
	// 답변 작성·수정은 관리자 전용
	@RequireAdmin
	@RequestMapping("/uss/olh/qnm/QnaCnAnswerUpdt.do")
	public String updateQnaCnAnswer(@ModelAttribute("qnaManageVO") QnaManageVO qnaManageVO,
			BindingResult bindingResult, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) {

		// 답변 저장은 답변내용·처리상태만 수정하므로 해당 항목만 검증한다.
		// (QnaManageVO 전체를 @Valid 로 검증하면 화면에 없는 작성비밀번호 등 질문 항목 때문에 저장되지 않음)
		validateQnaAnswer(qnaManageVO, bindingResult);

		if (bindingResult.hasErrors()) {
			ComDefaultCodeVO vo = new ComDefaultCodeVO();
			vo.setCodeId("COM028");
			model.addAttribute("resultList", cmmUseService.selectCmmCodeDetail(vo));
			selectQnaAnswerListDetail(qnaManageVO, searchVO, model);
			return "/uss/olh/qna/EgovQnaCnAnswerUpdt";
		}

		decryptQaId(qnaManageVO);

		// 로그인VO에서 사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String lastUpdusrId = loginVO.getUniqId();

		qnaManageVO.setLastUpdusrId(lastUpdusrId); // 최종수정자ID

		qnaManageService.updateQnaCnAnswer(qnaManageVO);

		return "forward:/uss/olh/qnm/QnaAnswerListInqire.do";

	}

	/**
	 * Q&A답변 저장 항목(답변내용, 처리상태)을 검증한다.
	 * 
	 * @param qnaManageVO
	 * @param bindingResult
	 */
	private void validateQnaAnswer(QnaManageVO qnaManageVO, BindingResult bindingResult) {

		String answerCn = qnaManageVO.getAnswerCn();
		DefaultMessageSourceResolvable answerCnLabel = new DefaultMessageSourceResolvable(
				new String[] { "qnaManageVO.answerCn" }, "답변내용");

		if (answerCn == null || answerCn.trim().isEmpty()) {
			bindingResult.rejectValue("answerCn", "errors.required", new Object[] { answerCnLabel }, "답변내용은(는) 필수 입력값입니다.");
		} else if (answerCn.length() > 2500) {
			bindingResult.rejectValue("answerCn", "errors.maxlength", new Object[] { answerCnLabel, 2500 }, "답변내용은(는) 2500자 이상 입력할수 없습니다.");
		}

		// 처리상태는 공통코드(COM028)에 등록된 값만 허용
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("COM028");
		boolean validSttus = false;
		for (CmmnDetailCode code : cmmUseService.selectCmmCodeDetail(codeVO)) {
			if (code.getCode().equals(qnaManageVO.getQnaProcessSttusCode())) {
				validSttus = true;
				break;
			}
		}
		if (!validSttus) {
			DefaultMessageSourceResolvable sttusLabel = new DefaultMessageSourceResolvable(
					new String[] { "qnaManageVO.qnaProcessSttusCode" }, "진행처리상태");
			bindingResult.rejectValue("qnaProcessSttusCode", "errors.invalid", new Object[] { sttusLabel }, "진행처리상태은(는) 유효하지 않은 값입니다.");
		}
	}

}
