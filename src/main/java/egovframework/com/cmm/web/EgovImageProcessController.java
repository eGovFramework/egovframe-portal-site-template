package egovframework.com.cmm.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Map;

import java.util.Arrays;
import java.util.List;

import org.egovframe.rte.fdl.cryptography.EgovCryptoService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.service.impl.EgovFileAuthServiceImpl;
import egovframework.com.cmm.util.EgovFileTokenUtil;
import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Class Name : EgovImageProcessController.java
 * @Description :
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 4. 2.     이삼섭
 *    2011.08.31.     JJY        경량환경 템플릿 커스터마이징버전 생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 4. 2.
 * @version
 * @see
 *
 */
@Controller
public class EgovImageProcessController extends HttpServlet {

	/**
	 *  serialVersion UID
	 */
	private static final long serialVersionUID = -6339945210971171173L;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovImageProcessController.class);

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileService;

	@Resource(name = "EgovFileAuthService")
	private EgovFileAuthServiceImpl fileAuthService;

	/** 암호화서비스 */
	@Resource(name = "egovARIACryptoService")
	EgovCryptoService cryptoService;
	
	// 주의 : 반드시 기본값 "egovframe"을 다른것으로 변경하여 사용하시기 바랍니다.
	public static final String ALGORITHM_KEY = EgovProperties.getProperty("Globals.File.algorithmKey");

	/** getImage.do가 인라인(image/*)으로 제공할 수 있는 안전한 이미지 확장자 화이트리스트 */
	private static final List<String> SAFE_INLINE_IMAGE_EXTENSIONS =
			Arrays.asList("jpg", "jpeg", "png", "gif", "bmp", "webp");

	/**
	 * 첨부된 이미지에 대한 미리보기 기능을 제공한다.
	 *
	 * @param atchFileId
	 * @param fileSn
	 * @param sessionVO
	 * @param model
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/cmm/fms/getImage.do")
	public void getImageInf(SessionVO sessionVO, ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 사용자권한 처리
		if (!Boolean.TRUE.equals(EgovUserDetailsHelper.isAuthenticated())) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN);
			return;
		}

		String param_atchFileId = (String) commandMap.get("atchFileId");
		param_atchFileId = param_atchFileId.replaceAll(" ", "+");
		// 세션 바인딩 검증 - atchFileId 발급 당시의 세션ID와 현재 세션ID가 일치해야 한다.
		EgovFileTokenUtil.DecodedFileToken token = EgovFileTokenUtil.decodeAndValidateSession(
				param_atchFileId, request.getSession().getId(), cryptoService, ALGORITHM_KEY);
		String decodedFileId = token.getAtchFileId();
		// 첨부파일 소유자(또는 관리자)만 조회할 수 있도록 검증한다 (IDOR 방지)
		fileAuthService.assertFileAccess(decodedFileId);

		String fileSn = (String) commandMap.get("fileSn");

		FileVO vo = new FileVO();

		vo.setAtchFileId(decodedFileId);
		vo.setFileSn(fileSn);

		FileVO fvo = fileService.selectFileInf(vo);
		
		String fileStreCours = EgovWebUtil.filePathBlackList(fvo.getFileStreCours());
		String streFileNm = EgovWebUtil.filePathBlackList(fvo.getStreFileNm());
		
		File file = new File(fileStreCours, streFileNm);
		FileInputStream fis = null;

		BufferedInputStream in = null;
		ByteArrayOutputStream bStream = null;
		try {
			fis = new FileInputStream(file);
			in = new BufferedInputStream(fis);
			bStream = new ByteArrayOutputStream();
			int imgByte;
			while ((imgByte = in.read()) != -1) {
				bStream.write(imgByte);
			}

			String extsn = fvo.getFileExtsn() == null ? "" : fvo.getFileExtsn().toLowerCase();

			// 화이트리스트에 없는 확장자(svg, html 등)는 브라우저가 인라인으로 해석해
			// 저장형 XSS로 이어질 수 있으므로, image/* 콘텐츠 타입 대신 다운로드(attachment)로 처리한다.
			if (!SAFE_INLINE_IMAGE_EXTENSIONS.contains(extsn)) {
				response.setHeader("Content-Type", "application/octet-stream");
				response.setHeader("Content-Disposition", "attachment");
				response.setHeader("X-Content-Type-Options", "nosniff");
			} else {
				String type = "jpg".equals(extsn) ? "image/jpeg" : "image/" + extsn;
				response.setHeader("Content-Type", type);
				response.setHeader("X-Content-Type-Options", "nosniff");
			}

			response.setContentLength(bStream.size());
			bStream.writeTo(response.getOutputStream());
			response.getOutputStream().flush();
			response.getOutputStream().close();

		} catch (IOException e) {
			LOGGER.debug("{}", e);
		} finally {
			if (bStream != null) {
				try {
					bStream.close();
				} catch (IOException est) {
					LOGGER.debug("IGNORED: {}", est.getMessage());
				}
			}
			if (in != null) {
				try {
					in.close();
				} catch (IOException ei) {
					LOGGER.debug("IGNORED: {}", ei.getMessage());
				}
			}
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException efis) {
					LOGGER.debug("IGNORED: {}", efis.getMessage());
				}
			}
		}
	}
}
