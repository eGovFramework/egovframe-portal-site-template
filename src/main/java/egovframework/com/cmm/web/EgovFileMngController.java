package egovframework.com.cmm.web;

import java.util.Base64;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cryptography.EgovCryptoService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.service.impl.EgovFileAuthServiceImpl;
import egovframework.com.cmm.util.EgovFileTokenUtil;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 파일 조회, 삭제, 다운로드 처리를 위한 컨트롤러 클래스
 * 
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일          수정자        수정내용
 *  ----------     --------    ---------------------------
 *  2009.03.25     이삼섭        최초 생성
 *  2016.10.13     장동한        deleteFileInf 메소드 return 방식 수정
 *  2022.12.02     윤창원        File ID 암호화 처리
 *  2022.12.22     신용호        JSTL 커스텀 태그 추가 및 기능 보완
 *
 *      </pre>
 */
@Controller
public class EgovFileMngController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovFileMngController.class);

	/** 암호화서비스 */
	private static EgovCryptoService cryptoService;

	@Resource(name = "egovARIACryptoService")
	public void setEgovCryptoService(EgovCryptoService cryptoService) {
		EgovFileMngController.cryptoService = cryptoService;
	}

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileService;

	@Resource(name = "EgovFileAuthService")
	private EgovFileAuthServiceImpl fileAuthService;

	// 주의 : 반드시 기본값 "egovframe"을 다른것으로 변경하여 사용하시기 바랍니다.
	public static final String ALGORITHM_KEY = EgovProperties.getProperty("Globals.File.algorithmKey");

	/**
	 * 첨부파일에 대한 목록을 조회한다.
	 *
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/cmm/fms/selectFileInfs.do")
	public String selectFileInfs(@ModelAttribute("searchVO") FileVO fileVO,
			HttpServletRequest request,
			@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		String param_atchFileId = (String) commandMap.get("param_atchFileId");
		byte[] encrypted_atchFileId = Base64.getDecoder().decode(param_atchFileId);
		String decodedAtchFileId = "";
		if (param_atchFileId != null && !"".equals(param_atchFileId)) {
			decodedAtchFileId = new String(cryptoService.decrypt(encrypted_atchFileId, ALGORITHM_KEY));
		}

		fileVO.setAtchFileId(decodedAtchFileId);
		List<FileVO> result = fileService.selectFileInfs(fileVO);

		// FileId를 유추하지 못하도록 세션ID와 함께 암호화하여 표시한다. (2022.12.06 추가) - 파일아이디가 유추 불가능하도록 조치
		for (FileVO file : result) {
			String sessionId = request.getSession().getId();
			String toEncrypt = sessionId + "|" + file.getAtchFileId();
			file.setAtchFileId(Base64.getEncoder().encodeToString(
					cryptoService.encrypt(toEncrypt.getBytes(), ALGORITHM_KEY)));
		}

		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "N");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", param_atchFileId);

		return "cmm/fms/EgovFileList";
	}

	/**
	 * 첨부파일 변경을 위한 수정페이지로 이동한다.
	 *
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cmm/fms/selectFileInfsForUpdate.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String selectFileInfsForUpdate(@ModelAttribute("searchVO") FileVO fileVO,
			@RequestParam Map<String, Object> commandMap,
			HttpServletRequest request,
			ModelMap model) throws Exception {

		String param_atchFileId = (String) commandMap.get("param_atchFileId");
		byte[] encrypted_atchFileId = Base64.getDecoder().decode(param_atchFileId);
		String decodedAtchFileId = "";
		if (param_atchFileId != null && !"".equals(param_atchFileId)) {
			decodedAtchFileId = new String(cryptoService.decrypt(encrypted_atchFileId, ALGORITHM_KEY));
		}

		fileVO.setAtchFileId(decodedAtchFileId);

		List<FileVO> result = fileService.selectFileInfs(fileVO);

		// FileId를 유추하지 못하도록 세션ID와 함께 암호화하여 표시한다. (2022.12.06 추가) - 파일아이디가 유추 불가능하도록 조치
		for (FileVO file : result) {
			String sessionId = request.getSession().getId();
			String toEncrypt = sessionId + "|" + file.getAtchFileId();
			file.setAtchFileId(Base64.getEncoder().encodeToString(
					cryptoService.encrypt(toEncrypt.getBytes(), ALGORITHM_KEY)));
		}

		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "Y");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", param_atchFileId);

		return "cmm/fms/EgovFileList";
	}

	/**
	 * 첨부파일에 대한 삭제를 처리한다.
	 *
	 * @param fileVO
	 * @param returnUrl
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/cmm/fms/deleteFileInfs.do")
	public String deleteFileInf(@ModelAttribute("searchVO") FileVO fileVO, @RequestParam("returnUrl") String returnUrl,
			HttpServletRequest request, ModelMap model)
			throws Exception {

		if (!EgovUserDetailsHelper.isAuthenticated()) {
			return "redirect:/uat/uia/egovLoginUsr.do";
		}

		// 첨부파일 소유자(또는 관리자)만 삭제할 수 있도록 검증한다 (IDOR 방지)
		EgovFileTokenUtil.DecodedFileToken token = EgovFileTokenUtil.decodeFileToken(
				fileVO.getAtchFileId(), request.getSession().getId(), cryptoService, ALGORITHM_KEY, false);
		fileVO.setAtchFileId(token.getAtchFileId());
		fileAuthService.assertFileAccess(token.getAtchFileId());
		fileService.deleteFileInf(fileVO);

		// 오픈 리다이렉트(CWE-601) 방지 - 외부 URL이나 프로토콜 상대경로가 아닌
		// 애플리케이션 내부의 절대경로만 리다이렉트 대상으로 허용한다.
		if (!isSafeInternalUrl(returnUrl)) {
			return "redirect:/cmm/main/mainPage.do";
		}

		// --------------------------------------------
		// contextRoot가 있는 경우 제외 시켜야 함
		// --------------------------------------------
		//// return "forward:/cmm/fms/selectFileInfs.do";
		// return "forward:" + returnUrl;

		String contextPath = request.getContextPath() == null ? "" : request.getContextPath();
		String redirectUrl = returnUrl;

		if (StringUtils.isBlank(contextPath) || "/".equals(contextPath)) {
			return "redirect:" + redirectUrl;
		}

		if (redirectUrl.startsWith(contextPath)) {
			redirectUrl = redirectUrl.substring(contextPath.length());
		}

		return "redirect:" + redirectUrl;
		//// ------------------------------------------
	}

	/**
	 * 이미지 첨부파일에 대한 목록을 조회한다.
	 *
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/cmm/fms/selectImageFileInfs.do")
	public String selectImageFileInfs(@ModelAttribute("searchVO") FileVO fileVO,
			@RequestParam Map<String, Object> commandMap,
			HttpServletRequest request,
			ModelMap model) throws Exception {

		String param_atchFileId = (String) commandMap.get("atchFileId");
		String decodedAtchFileId = "";
		if (param_atchFileId != null && !"".equals(param_atchFileId)) {
			byte[] encrypted_atchFileId = Base64.getDecoder().decode(param_atchFileId);
			decodedAtchFileId = new String(cryptoService.decrypt(encrypted_atchFileId, ALGORITHM_KEY));
			decodedAtchFileId = StringUtils.substringAfter(decodedAtchFileId, "|");
		}

		fileVO.setAtchFileId(decodedAtchFileId);
		List<FileVO> result = fileService.selectImageFileList(fileVO);

		// FileId를 유추하지 못하도록 세션ID와 함께 암호화하여 표시한다. (2022.12.06 추가) - 파일아이디가 유추 불가능하도록 조치
		for (FileVO file : result) {
			String sessionId = request.getSession().getId();
			String toEncrypt = sessionId + "|" + file.getAtchFileId();
			file.setAtchFileId(
					Base64.getEncoder().encodeToString(cryptoService.encrypt(toEncrypt.getBytes(), ALGORITHM_KEY)));
		}

		model.addAttribute("fileList", result);

		return "cmm/fms/EgovImgFileList";
	}

	/**
	 * 원본 문자열을 암호화 하는 메서드.
	 * 
	 * @param source 원본 문자열
	 * @return 암호화 문자열
	 */
	public static String encrypt(String atchFileId) {
		String returnVal = "-";
		returnVal = Base64.getEncoder().encodeToString(cryptoService.encrypt(atchFileId.getBytes(), ALGORITHM_KEY));
		return returnVal;
	}

	/**
	 * 원본 문자열을 암호화 하는 메서드.
	 * 
	 * @param source 원본 문자열
	 * @return 암호화 문자열
	 */
	public static String encryptSession(String atchFileId, String sessionId) {
		String returnVal = "-";
		String toEncrypt = sessionId + "|" + atchFileId;
		returnVal = Base64.getEncoder().encodeToString(cryptoService.encrypt(toEncrypt.getBytes(), ALGORITHM_KEY));
		return returnVal;
	}

	/**
	 * 암호화 문자열을 복호화 하는 메서드.
	 * 
	 * @param source 암호화 문자열
	 * @return 원본 문자열
	 */
	public static String decrypt(String base64AtchFileId) {
		String returnVal = "FILE_ID_DECRIPT_EXCEPTION_02";
		if (base64AtchFileId != null && !"".equals(base64AtchFileId)) {
			try {
				byte[] encrypted_atchFileId = Base64.getDecoder().decode(base64AtchFileId);
				returnVal = new String(cryptoService.decrypt(encrypted_atchFileId, ALGORITHM_KEY));
			} catch (IllegalArgumentException e) { // 26.03.06 KISA 보안취약점 조치 : 구체적 Exception 추가
				// Base64 디코딩 실패 또는 패스워드 불일치
				LOGGER.debug(e.getMessage());
			} catch (RuntimeException e) {
				// ARIACipher가 InvalidKeyException을 RuntimeException으로 래핑하여 throw
				LOGGER.debug(e.getMessage());
			}
		}
		return returnVal;
	}

	/**
	 * returnUrl이 리다이렉트 대상으로 사용되므로, 애플리케이션 내부의 절대경로("/"로 시작)만
	 * 허용하고 외부 URL(프로토콜 상대경로 포함)은 차단하여 오픈 리다이렉트(CWE-601)를 방지한다.
	 *
	 * @param url 검증할 리다이렉트 URL
	 * @return 내부 상대경로이면 true
	 */
	private boolean isSafeInternalUrl(String url) {
		if (url == null) {
			return false;
		}
		String trimmed = url.trim();
		if (trimmed.isEmpty()) {
			return false;
		}
		if (!trimmed.startsWith("/") || trimmed.startsWith("//") || trimmed.startsWith("/\\") || trimmed.contains(":")) {
			return false;
		}
		return true;
	}
}
