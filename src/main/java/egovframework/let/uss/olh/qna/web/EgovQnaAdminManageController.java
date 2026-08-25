package egovframework.let.uss.olh.qna.web;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.annotation.RequireAdmin;
import egovframework.com.cmm.web.EgovFileMngController;
import egovframework.let.uss.olh.qna.service.EgovQnaManageService;
import egovframework.let.uss.olh.qna.service.QnaManageDefaultVO;
import egovframework.let.uss.olh.qna.service.QnaManageVO;
import egovframework.let.utl.sim.service.EgovFileScrty;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springmodules.validation.commons.DefaultBeanValidator;

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
 *
 * </pre>
 */
@Controller
public class EgovQnaAdminManageController {

	@Resource(name = "QnaManageService")
	private EgovQnaManageService qnaManageService;

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

	// Validation 관련
	@Autowired
	private DefaultBeanValidator beanValidator;

	/**
	 * 개별 배포시 메인메뉴를 조회한다.
	 * @param model
	 * @return	"/uss/olh/qna/admin/"
	 * @throws Exception
	 */
	@RequireAdmin
	@RequestMapping(value = "/uss/olh/qna/admin/EgovMain.do")
	public String EgovMain(ModelMap model) throws Exception {
		return "/uss/olh/qna/admin/EgovMain";
	}

	/**
	 * 메뉴를 조회한다.
	 * @param model
	 * @return	"/uss/olh/qna/admin/EgovLeft"
	 * @throws Exception
	 */
	@RequireAdmin
	@RequestMapping(value = "/uss/olh/qna/admin/EgovLeft.do")
	public String EgovLeft(ModelMap model) throws Exception {
		return "/uss/olh/qna/admin/EgovLeft";
	}

	/**
	 * Q&A정보 목록을 조회한다. (pageing)
	 * @param searchVO
	 * @param model
	 * @return	"/uss/olh/qna/admin/EgovQnaListInqire"
	 * @throws Exception
	 */
	@RequireAdmin
	@RequestMapping(value = "/uss/olh/qna/admin/QnaListInqire.do")
	public String selectQnaList(@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) throws Exception {

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
	 * @throws Exception
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/QnaDetailInqire.do")
	public String selectQnaListDetail(QnaManageVO qnaManageVO,
			@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) throws Exception {

		decryptQaId(qnaManageVO);
		QnaManageVO vo = qnaManageService.selectQnaListDetail(qnaManageVO);

		// 26.08.24 조치 : passwordConfirmAt 은 관리자 비밀번호 확인 흐름에서만 쓰이던 값이다.
		// 그 흐름을 제거했으므로 필수 요청 파라미터 선언과 모델 전달을 함께 없앤다.

		// 26.07.20 KISA 보안취약점 조치: 작성비밀번호는 일방향 해시로 저장되어 복호화할 수 없다.
		vo.setWritngPassword(null);

		model.addAttribute("result", vo);

		return "/uss/olh/qna/admin/EgovQnaDetailInqire";
	}

	/**
	 * Q&A 조회수를  수정처리한다.
	 * @param qnaManageVO
	 * @param searchVO
	 * @return	"forward:/uss/olh/qna/admin/QnaDetailInqire.do"
	 * @throws Exception
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/QnaInqireCoUpdt.do")
	public String updateQnaInqireCo(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO) throws Exception {

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
	 * @throws Exception
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/LoginRealnmChoice.do")
	public String selectLoginRealnmChoice(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO, Model model) throws Exception {

		model.addAttribute("QnaManageVO", new QnaManageVO());

		return "/uss/olh/qna/admin/EgovQnaLoginRealnmChoice";
	}

	/**
	 * Q&A정보를 등록하기 위한 전 처리(인증체크)
	 * @param searchVO
	 * @param qnaManageVO
	 * @param model
	 * @return	"/uss/olh/qna/admin/EgovQnaCnRegist"
	 * @throws Exception
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/QnaCnRegistView.do")
	public String insertQnaCnView(@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, QnaManageVO qnaManageVO, Model model) throws Exception {

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
	 * @throws Exception
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/QnaCnRegist.do")
	public String insertQnaCn(@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, @ModelAttribute("qnaManageVO") QnaManageVO qnaManageVO, BindingResult bindingResult,
			ModelMap model) throws Exception {

		beanValidator.validate(qnaManageVO, bindingResult);

		if (bindingResult.hasErrors()) {
			return "/uss/olh/qna/admin/EgovQnaCnRegist";
		}

		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String frstRegisterId = loginVO.getUniqId();

		qnaManageVO.setFrstRegisterId(frstRegisterId); // 최초등록자ID
		qnaManageVO.setLastUpdusrId(frstRegisterId); // 최종수정자ID

		// 26.08.19 조치 : 작성비밀번호 해싱은 salt로 쓰이는 qaId가 채번되는
		// EgovQnaManageServiceImpl.insertQnaCn에서 수행한다.
		qnaManageService.insertQnaCn(qnaManageVO);

		return "forward:/uss/olh/qna/admin/QnaListInqire.do";
	}

	/*
	 * 26.08.24 조치 : admin/QnaPasswordConfirmView.do 와 admin/QnaPasswordConfirm.do 를 제거했다.
	 * 관리자에게 타인 글의 작성 비밀번호를 요구하던 흐름으로, 관리자는 그 값을 알 방법이 없어
	 * 실제로는 수정화면에 진입할 수 없었다. 관리자 상세화면이 QnaCnUpdtView.do 로 직행하도록
	 * 바꾸면서 화면에서 호출되지 않는 엔드포인트가 되었으므로 함께 정리한다.
	 * 관리자 권한 판정은 @RequireAdmin(AOP)이, 소유권 판정은 EgovQnaAuthUtil 이 담당한다.
	 * 사용자 화면의 QnaPasswordConfirm.do 는 비로그인 작성자를 위해 그대로 유지된다.
	 */

	/**
	 * Q&A정보를 수정하기 위한 전 처리(비밀번호 암호화)
	 * @param qnaManageVO
	 * @param searchVO
	 * @param model
	 * @return	"/uss/olh/qna/admin/EgovQnaCnUpdt
	 * @throws Exception
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/QnaCnUpdtView.do")
	public String updateQnaCnView(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) throws Exception {

		decryptQaId(qnaManageVO);
		QnaManageVO vo = qnaManageService.selectQnaListDetail(qnaManageVO);

		// 26.07.20 KISA 보안취약점 조치: 작성비밀번호는 일방향 해시로 저장되어 복호화할 수 없다.
		vo.setWritngPassword(null);

		model.addAttribute("qnaManageVO", vo);
		// 26.08.19 조치 : selectQnaListDetail()로 위임하면 이미 복호화된 qaId를 한 번 더
		// 복호화하게 되어 조회에 실패한다. 사용자 컨트롤러와 동일하게 위에서 조회한 vo를 사용한다.
		model.addAttribute("result", vo);

		return "/uss/olh/qna/admin/EgovQnaCnUpdt";
	}

	/**
	 * Q&A정보를 수정처리한다.
	 * @param searchVO
	 * @param qnaManageVO
	 * @param bindingResult
	 * @return	"forward:/uss/olh/qna/admin/QnaListInqire.do"
	 * @throws Exception
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/QnaCnUpdt.do")
	public String updateQnaCn(@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, @ModelAttribute("qnaManageVO") QnaManageVO qnaManageVO, BindingResult bindingResult)
			throws Exception {

		// Validation
		beanValidator.validate(qnaManageVO, bindingResult);

		if (bindingResult.hasErrors()) {
			return "/uss/olh/qna/admin/EgovQnaCnUpdt";
		}

		decryptQaId(qnaManageVO);
		QnaManageVO existing = qnaManageService.selectQnaListDetail(qnaManageVO);

		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String lastUpdusrId = loginVO.getUniqId();

		qnaManageVO.setLastUpdusrId(lastUpdusrId); // 최종수정자ID

		String writngPassword = qnaManageVO.getWritngPassword();

		// 26.08.19 조치 : 가역 encode() 대신 qaId를 salt로 쓰는 단방향 해시를 사용한다.
		// 빈 값이 들어오면 기존 해시를 보존한다. (보존하지 않으면 hash("")로 덮어써진다)
		if (writngPassword != null && !writngPassword.isEmpty()) {
			qnaManageVO.setWritngPassword(
					EgovFileScrty.encryptPassword(writngPassword, qnaManageVO.getQaId()));
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
	 * @throws Exception
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qna/admin/QnaCnDelete.do")
	public String deleteQnaCn(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO, Model model) throws Exception {
		
		// 인증여부 체크
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (!isAuthenticated) {
			model.addAttribute("result", qnaManageVO);
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		decryptQaId(qnaManageVO);
		qnaManageService.deleteQnaCn(qnaManageVO);

		return "forward:/uss/olh/qna/admin/QnaListInqire.do";
	}

	/**
	 * Q&A답변정보 목록을 조회한다. (pageing)
	 * @param searchVO
	 * @param model
	 * @return	"/uss/olh/qna/admin/EgovQnaAnswerListInqire"
	 * @throws Exception
	 */
	@RequireAdmin
	@RequestMapping(value = "/uss/olh/qnm/admin/QnaAnswerListInqire.do")
	public String selectQnaAnswerList(@ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) throws Exception {

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
	 * @throws Exception
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qnm/admin/QnaAnswerDetailInqire.do")
	public String selectQnaAnswerListDetail(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) throws Exception {

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
	 * @throws Exception
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qnm/admin/QnaCnAnswerUpdtView.do")
	public String updateQnaCnAnswerView(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO, ModelMap model) throws Exception {

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
	 * @throws Exception
	 */
	@RequireAdmin
	@RequestMapping("/uss/olh/qnm/admin/QnaCnAnswerUpdt.do")
	public String updateQnaCnAnswer(QnaManageVO qnaManageVO, @ModelAttribute("searchVO") QnaManageDefaultVO searchVO) throws Exception {

		decryptQaId(qnaManageVO);

		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String lastUpdusrId = loginVO.getUniqId();

		qnaManageVO.setLastUpdusrId(lastUpdusrId); // 최종수정자ID

		qnaManageService.updateQnaCnAnswer(qnaManageVO);

		return "forward:/uss/olh/qnm/admin/QnaAnswerListInqire.do";

	}

}
