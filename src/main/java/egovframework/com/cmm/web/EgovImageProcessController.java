package egovframework.com.cmm.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cryptography.EgovCryptoService;
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
	
	/** 암호화서비스 */
	@Resource(name = "egovARIACryptoService")
	EgovCryptoService cryptoService;
	
	// 주의 : 반드시 기본값 "egovframe"을 다른것으로 변경하여 사용하시기 바랍니다.
	public static final String ALGORITHM_KEY = EgovProperties.getProperty("Globals.File.algorithmKey");

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
	public void getImageInf(SessionVO sessionVO, ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletResponse response) throws Exception {

		String param_atchFileId = (String) commandMap.get("atchFileId");
		param_atchFileId = param_atchFileId.replaceAll(" ", "+");
		byte[] decodedBytes = Base64.getDecoder().decode(param_atchFileId);
		String decodedString = new String(cryptoService.decrypt(decodedBytes, ALGORITHM_KEY));
		String decodedFileId = StringUtils.substringAfter(decodedString, "|");

		String fileSn = (String) commandMap.get("fileSn");

		FileVO vo = new FileVO();

		vo.setAtchFileId(decodedFileId);
		vo.setFileSn(fileSn);

		FileVO fvo = fileService.selectFileInf(vo);
		
		String fileStreCours = EgovWebUtil.filePathBlackList(fvo.getFileStreCours());
		String streFileNm = EgovWebUtil.filePathBlackList(fvo.getStreFileNm());
		
		File file = new File(fileStreCours, streFileNm);
		FileInputStream fis = null;
//		new FileInputStream(file);

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

			String type = "";

			if (fvo.getFileExtsn() != null && !"".equals(fvo.getFileExtsn())) {
				if ("jpg".equals(fvo.getFileExtsn().toLowerCase())) {
					type = "image/jpeg";
				} else {
					type = "image/" + fvo.getFileExtsn().toLowerCase();
				}
				type = "image/" + fvo.getFileExtsn().toLowerCase();

			} else {
				LOGGER.debug("Image fileType is null.");
			}

			response.setHeader("Content-Type", type);
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
