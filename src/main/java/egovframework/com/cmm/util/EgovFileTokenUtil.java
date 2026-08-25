package egovframework.com.cmm.util;

import java.util.Base64;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cryptography.EgovCryptoService;

/**
 * 암호화된 첨부파일 토큰 복호화 및 세션 바인딩 검증
 */
public final class EgovFileTokenUtil {

	private EgovFileTokenUtil() {
	}

	public static final class DecodedFileToken {
		private final String atchFileId;
		private final boolean sessionBound;

		public DecodedFileToken(String atchFileId, boolean sessionBound) {
			this.atchFileId = atchFileId;
			this.sessionBound = sessionBound;
		}

		public String getAtchFileId() {
			return atchFileId;
		}

		public boolean isSessionBound() {
			return sessionBound;
		}
	}

	public static DecodedFileToken decodeFileToken(String encryptedToken, String currentSessionId,
			EgovCryptoService cryptoService, String algorithmKey, boolean requireSessionMatch) {
		if (encryptedToken == null || encryptedToken.trim().isEmpty()) {
			throw new SecurityException("유효하지 않은 파일 토큰입니다.");
		}
		if (encryptedToken.startsWith("FILE_")) {
			throw new SecurityException("암호화되지 않은 파일 ID는 허용되지 않습니다.");
		}

		String normalized = encryptedToken.replaceAll(" ", "+");
		byte[] decodedBytes = Base64.getDecoder().decode(normalized);
		String decodedString = new String(cryptoService.decrypt(decodedBytes, algorithmKey));

		if (decodedString.contains("|")) {
			String tokenSessionId = StringUtils.substringBefore(decodedString, "|");
			String fileId = StringUtils.substringAfter(decodedString, "|");
			if (requireSessionMatch && (currentSessionId == null || !currentSessionId.equals(tokenSessionId))) {
				throw new SecurityException("파일 토큰 세션이 일치하지 않습니다.");
			}
			if (fileId == null || fileId.trim().isEmpty()) {
				throw new SecurityException("유효하지 않은 파일 토큰입니다.");
			}
			return new DecodedFileToken(fileId, true);
		}

		if (decodedString == null || decodedString.trim().isEmpty()) {
			throw new SecurityException("유효하지 않은 파일 토큰입니다.");
		}
		return new DecodedFileToken(decodedString, false);
	}

	public static DecodedFileToken decodeAndValidateSession(String encryptedToken, String currentSessionId,
			EgovCryptoService cryptoService, String algorithmKey) {
		return decodeFileToken(encryptedToken, currentSessionId, cryptoService, algorithmKey, true);
	}
}
