package egovframework.let.uss.umt.web;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import org.egovframe.rte.fdl.cmmn.exception.BaseRuntimeException;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.util.EgovOwnerAuthUtil;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.uss.umt.service.EgovMberManageService;
import egovframework.let.uss.umt.service.MberManageVO;
import egovframework.let.uss.umt.service.UserDefaultVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

/**
 * 일반회원관련 요청을  비지니스 클래스로 전달하고 처리된결과를  해당   웹 화면으로 전달하는  Controller를 정의한다
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.10  조재영          최초 생성
 *
 * </pre>
 */
@Controller
public class EgovMberManageController {

	/** mberManageService */
	@Resource(name = "mberManageService")
	private EgovMberManageService mberManageService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** 비밀번호 해시(BCrypt) */
	@Resource(name = "egovPasswordEncoder")
	private PasswordEncoder passwordEncoder;

	/**
	 * 일반회원목록을 조회한다. (pageing)
	 * @param userSearchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovMberManage
	 */
	@RequestMapping(value = "/uss/umt/mber/EgovMberManage.do")
	public String selectMberList(@ModelAttribute("userSearchVO") UserDefaultVO userSearchVO, ModelMap model, HttpServletRequest request) {
		
			// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
			request.getSession().setAttribute("menuNo", "6000000");
		
		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		/** EgovPropertyService */
		userSearchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		userSearchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(userSearchVO.getPageUnit());
		paginationInfo.setPageSize(userSearchVO.getPageSize());

		userSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		model.addAttribute("resultList", mberManageService.selectMberList(userSearchVO));

		int totCnt = mberManageService.selectMberListTotCnt(userSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		//일반회원 상태코드를 코드정보로부터 조회
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM013");
		model.addAttribute("entrprsMberSttus_result", cmmUseService.selectCmmCodeDetail(vo));
		
		return "cmm/uss/umt/EgovMberManage";
	}

	/**
	 * 일반회원등록화면으로 이동한다.
	 * @param userSearchVO 검색조건정보
	 * @param mberManageVO 일반회원초기화정보
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovMberInsert
	 */
	@RequestMapping("/uss/umt/mber/EgovMberInsertView.do")
	public String insertMberView(@ModelAttribute("userSearchVO") UserDefaultVO userSearchVO, @ModelAttribute("mberManageVO") MberManageVO mberManageVO, Model model) {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		//패스워드힌트목록을 코드정보로부터 조회
		vo.setCodeId("COM022");
		model.addAttribute("passwordHint_result", cmmUseService.selectCmmCodeDetail(vo));

		//성별구분코드를 코드정보로부터 조회
		vo.setCodeId("COM014");
		model.addAttribute("sexdstnCode_result", cmmUseService.selectCmmCodeDetail(vo));

		//사용자상태코드를 코드정보로부터 조회
		vo.setCodeId("COM013");
		model.addAttribute("mberSttus_result", cmmUseService.selectCmmCodeDetail(vo));

		//그룹정보를 조회 - GROUP_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("groupId_result", cmmUseService.selectGroupIdDetail(vo));

		return "cmm/uss/umt/EgovMberInsert";
	}

	/**
	 * 일반회원등록처리후 목록화면으로 이동한다.
	 * @param mberManageVO 일반회원등록정보
	 * @param bindingResult 입력값검증용 bindingResult
	 * @param model 화면모델
	 * @return forward:/uss/umt/mber/EgovMberManage.do
	 */
	@RequestMapping(value = "/uss/umt/mber/EgovMberInsert.do", method = RequestMethod.POST)
	public String insertMber(@Valid @ModelAttribute("mberManageVO") MberManageVO mberManageVO, BindingResult bindingResult, Model model) {
		
		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		if (bindingResult.hasErrors()) {
			ComDefaultCodeVO vo = new ComDefaultCodeVO();

			//패스워드힌트목록을 코드정보로부터 조회
			vo.setCodeId("COM022");
			model.addAttribute("passwordHint_result", cmmUseService.selectCmmCodeDetail(vo));

			//성별구분코드를 코드정보로부터 조회
			vo.setCodeId("COM014");
			model.addAttribute("sexdstnCode_result", cmmUseService.selectCmmCodeDetail(vo));

			//사용자상태코드를 코드정보로부터 조회
			vo.setCodeId("COM013");
			model.addAttribute("mberSttus_result", cmmUseService.selectCmmCodeDetail(vo));

			//그룹정보를 조회 - GROUP_ID정보
			vo.setTableNm("LETTNORGNZTINFO");
			model.addAttribute("groupId_result", cmmUseService.selectGroupIdDetail(vo));
			return "cmm/uss/umt/EgovMberInsert";
		} else {
			// 등록자 : 회원을 등록한 관리자
			mberManageVO.setFrstRegisterId(EgovOwnerAuthUtil.getLoginUniqId());
			mberManageService.insertMber(mberManageVO);
			//Exception 없이 진행시 등록 성공메시지
			model.addAttribute("resultMsg", "success.common.insert");
		}
		return "forward:/uss/umt/mber/EgovMberManage.do";
	}

	/**
	 * 일반회원정보 수정을 위해 일반회원정보를 상세조회한다.
	 * @param mberId 상세조회대상 일반회원아이디
	 * @param userSearchVO 검색조건
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovMberSelectUpdt
	 */
	@RequestMapping("/uss/umt/mber/EgovMberSelectUpdtView.do")
	public String updateMberView(@RequestParam("selectedId") String mberId, @ModelAttribute("userSearchVO") UserDefaultVO userSearchVO, Model model) {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		//패스워드힌트목록을 코드정보로부터 조회
		vo.setCodeId("COM022");
		model.addAttribute("passwordHint_result", cmmUseService.selectCmmCodeDetail(vo));

		//성별구분코드를 코드정보로부터 조회
		vo.setCodeId("COM014");
		model.addAttribute("sexdstnCode_result", cmmUseService.selectCmmCodeDetail(vo));

		//사용자상태코드를 코드정보로부터 조회
		vo.setCodeId("COM013");
		model.addAttribute("mberSttus_result", cmmUseService.selectCmmCodeDetail(vo));

		//그룹정보를 조회 - GROUP_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("groupId_result", cmmUseService.selectGroupIdDetail(vo));

		MberManageVO mberManageVO = mberManageService.selectMber(mberId);
		model.addAttribute("mberManageVO", mberManageVO);
		model.addAttribute("userSearchVO", userSearchVO);
		// 저장/삭제/암호변경 버튼은 등록자 본인에게만 노출
		model.addAttribute("ownerAt", EgovOwnerAuthUtil.ownerAt(mberManageVO == null ? null : mberManageVO.getFrstRegisterId()));

		return "cmm/uss/umt/EgovMberSelectUpdt";
	}

	/**
	 * 일반회원정보 수정후 목록조회 화면으로 이동한다.
	 * @param mberManageVO 일반회원수정정보
	 * @param bindingResult 입력값검증용 bindingResult
	 * @param model 화면모델
	 * @return forward:/uss/umt/mber/EgovMberManage.do
	 */
	@RequestMapping(value = "/uss/umt/mber/EgovMberSelectUpdt.do", method = RequestMethod.POST)
	// 검증 실패로 상세화면 재표시 시 목록 이동용 userSearchVO(pageIndex) 유지
	public String updateMber(@Valid @ModelAttribute("mberManageVO") MberManageVO mberManageVO, BindingResult bindingResult,
			@ModelAttribute("userSearchVO") UserDefaultVO userSearchVO, Model model) {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		// 등록자 본인만 수정 가능
		assertMberOwner(mberManageVO.getUniqId());
		model.addAttribute("ownerAt", "Y");

		if (bindingResult.hasErrors()) {

			ComDefaultCodeVO vo = new ComDefaultCodeVO();

			//패스워드힌트목록을 코드정보로부터 조회
			vo.setCodeId("COM022");
			model.addAttribute("passwordHint_result", cmmUseService.selectCmmCodeDetail(vo));

			//성별구분코드를 코드정보로부터 조회
			vo.setCodeId("COM014");
			model.addAttribute("sexdstnCode_result", cmmUseService.selectCmmCodeDetail(vo));

			//사용자상태코드를 코드정보로부터 조회
			vo.setCodeId("COM013");
			model.addAttribute("mberSttus_result", cmmUseService.selectCmmCodeDetail(vo));

			//그룹정보를 조회 - GROUP_ID정보
			vo.setTableNm("LETTNORGNZTINFO");
			model.addAttribute("groupId_result", cmmUseService.selectGroupIdDetail(vo));
			return "cmm/uss/umt/EgovMberSelectUpdt";
		} else {
			mberManageService.updateMber(mberManageVO);
			//Exception 없이 진행시 수정성공메시지
			model.addAttribute("resultMsg", "success.common.update");
			return "forward:/uss/umt/mber/EgovMberManage.do";
		}
	}

	/**
	 * 일반회원정보삭제후 목록조회 화면으로 이동한다.
	 * @param checkedIdForDel 삭제대상 아이디 정보
	 * @param userSearchVO 검색조건정보
	 * @param model 화면모델
	 * @return forward:/uss/umt/mber/EgovMberManage.do
	 */
	@RequestMapping(value = "/uss/umt/mber/EgovMberDelete.do", method = RequestMethod.POST)
	public String deleteMber(@RequestParam("checkedIdForDel") String checkedIdForDel, @ModelAttribute("userSearchVO") UserDefaultVO userSearchVO, Model model) {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		// 등록자 본인이 아닌 회원이 포함되어 있으면 삭제하지 않음 (형식 : 사용자유형:고유ID,...)
		for (String delId : checkedIdForDel.split(",")) {
			String[] id = delId.split(":");
			assertMberOwner(id.length > 1 ? id[1] : id[0]);
		}

		mberManageService.deleteMber(checkedIdForDel);
		//Exception 없이 진행시 삭제성공메시지
		model.addAttribute("resultMsg", "success.common.delete");
		return "forward:/uss/umt/mber/EgovMberManage.do";
	}

	/**
	 * 일반회원가입신청 등록화면으로 이동한다.
	 * @param userSearchVO 검색조건
	 * @param mberManageVO 일반회원가입신청정보
	 * @param commandMap 파라메터전달용 commandMap
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovMberSbscrb
	 */
	@RequestMapping("/uss/umt/cmm/EgovMberSbscrbView.do")
	public String sbscrbMberView(@ModelAttribute("userSearchVO") UserDefaultVO userSearchVO, @ModelAttribute("mberManageVO") MberManageVO mberManageVO,
			@RequestParam Map<String, Object> commandMap, Model model) {

		// 미인증 사용자에 대한 보안처리
		/*
		 * Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		 * if(!isAuthenticated) { model.addAttribute("message",
		 * egovMessageSource.getMessage("fail.common.login")); return
		 * "uat/uia/EgovLoginUsr"; }
		 */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		//패스워드힌트목록을 코드정보로부터 조회
		vo.setCodeId("COM022");
		model.addAttribute("passwordHint_result", cmmUseService.selectCmmCodeDetail(vo));

		//성별구분코드를 코드정보로부터 조회
		vo.setCodeId("COM014");
		model.addAttribute("sexdstnCode_result", cmmUseService.selectCmmCodeDetail(vo));

		if (!"".equals(commandMap.get("realname"))) {
			model.addAttribute("mberNm", commandMap.get("realname")); //실명인증된 이름 - 주민번호 인증
			model.addAttribute("ihidnum", commandMap.get("ihidnum")); //실명인증된 주민등록번호 - 주민번호 인증
		}
		if (!"".equals(commandMap.get("realName"))) {
			model.addAttribute("mberNm", commandMap.get("realName")); //실명인증된 이름 - ipin인증
		}

		mberManageVO.setGroupId("DEFAULT");
		mberManageVO.setMberSttus("DEFAULT");

		return "cmm/uss/umt/EgovMberSbscrb";
	}

	/**
	 * 일반회원가입신청등록처리후로그인화면으로 이동한다.
	 * @param mberManageVO 일반회원가입신청정보
	 * @return forward:/uat/uia/egovLoginUsr.do
	 */
	@RequestMapping(value = "/uss/umt/cmm/EgovMberSbscrb.do", method = RequestMethod.POST)
	public String sbscrbMber(@Valid @ModelAttribute("mberManageVO") MberManageVO mberManageVO, BindingResult bindingResult) {

		// 회원가입은 본인이 등록자 (insertMber 에서 설정)
		mberManageVO.setFrstRegisterId(null);
		//가입상태 초기화
		mberManageVO.setMberSttus("A");
		//그룹정보 초기화
		mberManageVO.setGroupId("GROUP_00000000000000"); //기본그룹
		//일반회원가입신청 등록시 일반회원등록기능을 사용하여 등록한다.
		mberManageService.insertMber(mberManageVO);
		return "forward:/uat/uia/egovLoginUsr.do";
	}

	/**
	 * 일반회원 약관확인
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovStplatCnfirm
	 */
	@RequestMapping("/uss/umt/cmm/EgovStplatCnfirmMber.do")
	public String sbscrbEntrprsMber(Model model) {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		//일반회원용 약관 아이디 설정
		String stplatId = "STPLAT_0000000000001";
		//회원가입유형 설정-일반회원
		String sbscrbTy = "USR01";
		//약관정보 조회
		model.addAttribute("stplatList", mberManageService.selectStplat(stplatId));
		model.addAttribute("sbscrbTy", sbscrbTy); //회원가입유형 포함

		return "cmm/uss/umt/EgovStplatCnfirm";
	}

	/**
	 * @param model 화면모델
	 * @param commandMap 파라메터전달용 commandMap
	 * @param userSearchVO 검색조건
	 * @param mberManageVO 일반회원수정정보(비밀번호)
	 * @return cmm/uss/umt/EgovMberPasswordUpdt
	 */
	@RequestMapping(value = "/uss/umt/mber/EgovMberPasswordUpdt.do", method = RequestMethod.POST)
	public String updatePassword(ModelMap model, @RequestParam Map<String, Object> commandMap, @ModelAttribute("userSearchVO") UserDefaultVO userSearchVO,
			@ModelAttribute("mberManageVO") MberManageVO mberManageVO) {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		String oldPassword = (String) commandMap.get("oldPassword");
		String newPassword = (String) commandMap.get("newPassword");
		String newPassword2 = (String) commandMap.get("newPassword2");
		String uniqId = (String) commandMap.get("uniqId");

		// 등록자 본인만 암호 변경 가능
		assertMberOwner(uniqId);

		boolean isCorrectPassword = false;
		MberManageVO resultVO = new MberManageVO();
		mberManageVO.setPassword(newPassword);
		mberManageVO.setOldPassword(oldPassword);
		mberManageVO.setUniqId(uniqId);

		String resultMsg = "";
		resultVO = mberManageService.selectPassword(mberManageVO);
		if (resultVO != null && oldPassword != null && resultVO.getPassword() != null
				&& passwordEncoder.matches(oldPassword, resultVO.getPassword())) {
			if (newPassword != null && !newPassword.isEmpty() && newPassword.equals(newPassword2)) {
				isCorrectPassword = true;
			} else {
				isCorrectPassword = false;
				resultMsg = "fail.user.passwordUpdate2";
			}
		} else {
			isCorrectPassword = false;
			resultMsg = "fail.user.passwordUpdate1";
		}

		if (isCorrectPassword) {
			mberManageVO.setPassword(passwordEncoder.encode(newPassword));
			mberManageService.updatePassword(mberManageVO);
			mberManageVO.setPassword(null);
			mberManageVO.setOldPassword(null);
			model.addAttribute("mberManageVO", mberManageVO);
			resultMsg = "success.common.update";
		} else {
			mberManageVO.setPassword(null);
			mberManageVO.setOldPassword(null);
			model.addAttribute("mberManageVO", mberManageVO);
		}
		model.addAttribute("userSearchVO", userSearchVO);
		model.addAttribute("resultMsg", resultMsg);

		return "cmm/uss/umt/EgovMberPasswordUpdt";
	}

	/**
	 * 일반회원 암호 수정 화면 이동
	 * @param model 화면모델
	 * @param commandMap 파라메터전달용 commandMap
	 * @param userSearchVO 검색조건
	 * @param mberManageVO 일반회원수정정보(비밀번호)
	 * @return cmm/uss/umt/EgovMberPasswordUpdt
	 */
	@RequestMapping(value = "/uss/umt/mber/EgovMberPasswordUpdtView.do")
	public String updatePasswordView(ModelMap model, @RequestParam Map<String, Object> commandMap, @ModelAttribute("userSearchVO") UserDefaultVO userSearchVO,
			@ModelAttribute("mberManageVO") MberManageVO mberManageVO) {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "uat/uia/EgovLoginUsr";
    	}

		// 등록자 본인만 암호 변경 가능
		assertMberOwner(mberManageVO.getUniqId());

		String userTyForPassword = (String) commandMap.get("userTyForPassword");
		mberManageVO.setUserTy(userTyForPassword);

		model.addAttribute("userSearchVO", userSearchVO);
		model.addAttribute("mberManageVO", mberManageVO);
		return "cmm/uss/umt/EgovMberPasswordUpdt";
	}

	/**
	 * 입력한 사용자아이디의 중복확인화면 이동
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovIdDplctCnfirm
	 */
	@RequestMapping(value = "/uss/umt/EgovIdDplctCnfirmView.do")
	public String checkIdDplct(ModelMap model) {
		/*
		 * // 미인증 사용자에 대한 보안처리 Boolean isAuthenticated =
		 * EgovUserDetailsHelper.isAuthenticated(); if(!isAuthenticated) {
		 * model.addAttribute("message",
		 * egovMessageSource.getMessage("fail.common.login")); return
		 * "uat/uia/EgovLoginUsr"; }
		 */
		model.addAttribute("checkId", "");
		model.addAttribute("usedCnt", "-1");
		return "cmm/uss/umt/EgovIdDplctCnfirm";
	}

	/**
	 * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인
	 * @param commandMap 파라메터전달용 commandMap
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovIdDplctCnfirm
	 */
	@RequestMapping(value = "/uss/umt/cmm/EgovIdDplctCnfirm.do")
	public String checkIdDplct(@RequestParam Map<String, Object> commandMap, ModelMap model) {
		/*
		 * // 미인증 사용자에 대한 보안처리 Boolean isAuthenticated =
		 * EgovUserDetailsHelper.isAuthenticated(); if(!isAuthenticated) {
		 * model.addAttribute("message",
		 * egovMessageSource.getMessage("fail.common.login")); return
		 * "uat/uia/EgovLoginUsr"; }
		 */
		String checkId = (String) commandMap.get("checkId");
		try {
			checkId = new String(checkId.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			throw new BaseRuntimeException(e);
		}

		if (checkId == null || checkId.equals(""))
			return "forward:/uss/umt/EgovIdDplctCnfirmView.do";

		int usedCnt = mberManageService.checkIdDplct(checkId);
		model.addAttribute("usedCnt", usedCnt);
		model.addAttribute("checkId", checkId);

		return "cmm/uss/umt/EgovIdDplctCnfirm";
	}

	/**
	 * 회원정보의 등록자 본인 여부를 검증한다.
	 * @param uniqId 대상 회원 고유아이디
	 */
	private void assertMberOwner(String uniqId) {
		MberManageVO existing = mberManageService.selectMber(uniqId);
		EgovOwnerAuthUtil.assertOwner(existing == null ? null : existing.getFrstRegisterId());
	}
}
