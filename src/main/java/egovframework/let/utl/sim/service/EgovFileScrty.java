package egovframework.let.utl.sim.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.binary.Base64;
import org.egovframe.rte.fdl.cmmn.exception.BaseRuntimeException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Base64인코딩/디코딩 방식을 이용한 데이터를 암호화/복호화하는 Business Interface class
 * @author 공통서비스개발팀 박지욱
 * @since 2009.01.19
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.01.19  박지욱          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
public class EgovFileScrty {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovFileScrty.class);

	// 파일구분자
	static final char FILE_SEPARATOR = File.separatorChar;
	// 버퍼사이즈
	static final int BUFFER_SIZE = 1024;

	/**
	 * 파일을 암호화하는 기능
	 *
	 * @param String source 암호화할 파일
	 * @param String target 암호화된 파일
	 * @return boolean result 암호화여부 True/False
	 */
	public static boolean encryptFile(String source, String target) {

		// 암호화 여부
		boolean result = false;

		String sourceFile = source.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
		String targetFile = target.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
		File srcFile = new File(sourceFile);

		BufferedInputStream input = null;
		BufferedOutputStream output = null;

		byte[] buffer = new byte[BUFFER_SIZE];

		try {
			if (srcFile.exists() && srcFile.isFile()) {

				input = new BufferedInputStream(new FileInputStream(srcFile));
				output = new BufferedOutputStream(new FileOutputStream(targetFile));

				int length = 0;
				while ((length = input.read(buffer)) >= 0) {
					byte[] data = new byte[length];
					System.arraycopy(buffer, 0, data, 0, length);
					output.write(encodeBinary(data).getBytes());
					output.write(System.getProperty("line.separator").getBytes());
				}

				result = true;
			}
		} catch (IOException e) {
			throw new BaseRuntimeException(e);
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException ignore) {
					LOGGER.debug("IGNORE: {}", ignore);
				}
			}
			if (output != null) {
				try {
					output.close();
				} catch (IOException ignore) {
					LOGGER.debug("IGNORE: {}", ignore);
				}
			}
		}
		return result;
	}

	/**
	 * 파일을 복호화하는 기능
	 *
	 * @param String source 복호화할 파일
	 * @param String target 복호화된 파일
	 * @return boolean result 복호화여부 True/False
	 */
	public static boolean decryptFile(String source, String target) {

		// 복호화 여부
		boolean result = false;

		String sourceFile = source.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
		String targetFile = target.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
		File srcFile = new File(sourceFile);

		BufferedReader input = null;
		BufferedOutputStream output = null;

		//byte[] buffer = new byte[BUFFER_SIZE];
		String line = null;

		try {
			if (srcFile.exists() && srcFile.isFile()) {

				input = new BufferedReader(new InputStreamReader(new FileInputStream(srcFile)));
				output = new BufferedOutputStream(new FileOutputStream(targetFile));

				while ((line = input.readLine()) != null) {
					byte[] data = line.getBytes();
					output.write(decodeBinary(new String(data)));
				}

				result = true;
			}
		} catch (IOException e) {
			throw new BaseRuntimeException(e);
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException ignore) {
					LOGGER.debug("IGNORE: {}", ignore);
				}
			}
			if (output != null) {
				try {
					output.close();
				} catch (IOException ignore) {
					LOGGER.debug("IGNORE: {}", ignore);
				}
			}
		}
		return result;
	}

	/**
	 * 데이터를 암호화하는 기능
	 *
	 * @param byte[] data 암호화할 데이터
	 * @return String result 암호화된 데이터
	 */
	public static String encodeBinary(byte[] data) {
		if (data == null) {
			return "";
		}

		return new String(Base64.encodeBase64(data));
	}

	/**
	 * 데이터를 암호화하는 기능
	 *
	 * @param String data 암호화할 데이터
	 * @return String result 암호화된 데이터
	 */
	public static String encode(String data) {
		return encodeBinary(data.getBytes());
	}

	/**
	 * 데이터를 복호화하는 기능
	 *
	 * @param String data 복호화할 데이터
	 * @return String result 복호화된 데이터
	 */
	public static byte[] decodeBinary(String data) {
		return Base64.decodeBase64(data.getBytes());
	}

	/**
	 * 데이터를 복호화하는 기능
	 *
	 * @param String data 복호화할 데이터
	 * @return String result 복호화된 데이터
	 */
	public static String decode(String data) {
		return new String(decodeBinary(data));
	}

    /**
     * 비밀번호를 암호화하는 기능(복호화가 되면 안되므로 SHA-256 인코딩 방식 적용).
     * 
     * deprecated : 보안 강화를 위하여 salt로 ID를 지정하는 encryptPassword(password, id) 사용
     *
     * @param String data 암호화할 비밀번호
     * @return String result 암호화된 비밀번호
     */
    @Deprecated
    public static String encryptPassword(String data) {

		if (data == null) {
		    return "";
		}
	
		byte[] plainText = null; // 평문
		byte[] hashValue = null; // 해쉬값
		plainText = data.getBytes();
	
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("SHA-256");
		} catch (NoSuchAlgorithmException e) {
			throw new BaseRuntimeException(e);
		}
		
		// 변경 시 기존 hash 값에 검증 불가.. => deprecated 시키고 유지
		/*	
	    // Random 방식의 salt 추가
	    SecureRandom ng = new SecureRandom();
	    byte[] randomBytes = new byte[16];
	    ng.nextBytes(randomBytes);
	    
	    md.reset();
	    md.update(randomBytes);
	    
		*/		
		hashValue = md.digest(plainText);
		
		/*
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(hashValue);
		*/
		return new String(Base64.encodeBase64(hashValue));
    }
    
    /**
     * 비밀번호를 암호화하는 기능(복호화가 되면 안되므로 SHA-256 인코딩 방식 적용)
     * 
     * @param password 암호화될 패스워드
     * @param id salt로 사용될 사용자 ID 지정
     * @return
     */
    public static String encryptPassword(String password, String id) {

		if (password == null) {
		    return "";
		}
	
		byte[] hashValue = null; // 해쉬값
	
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("SHA-256");
		} catch (NoSuchAlgorithmException e) {
			throw new BaseRuntimeException(e);
		}
		
		md.reset();
		md.update(id.getBytes());
		
		hashValue = md.digest(password.getBytes());
	
		return new String(Base64.encodeBase64(hashValue));
    }
    
    /**
     * 비밀번호를 암호화하는 기능(복호화가 되면 안되므로 SHA-256 인코딩 방식 적용)
     * @param data 암호화할 비밀번호
     * @param salt Salt
     * @return 암호화된 비밀번호
     */
    public static String encryptPassword(String data, byte[] salt) {

		if (data == null) {
		    return "";
		}
	
		byte[] hashValue = null; // 해쉬값
	
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("SHA-256");
		} catch (NoSuchAlgorithmException e) {
			throw new BaseRuntimeException(e);
		}
		
		md.reset();
		md.update(salt);
		
		hashValue = md.digest(data.getBytes());
	
		return new String(Base64.encodeBase64(hashValue));
    }
    
    /**
     * 비밀번호를 암호화된 패스워드 검증(salt가 사용된 경우만 적용).
     * 
     * @param data 원 패스워드
     * @param encoded 해쉬처리된 패스워드(Base64 인코딩)
     * @return
     */
    public static boolean checkPassword(String data, String encoded, byte[] salt) {
    	byte[] hashValue = null; // 해쉬값
    	
    	MessageDigest md;
		try {
			md = MessageDigest.getInstance("SHA-256");
		} catch (NoSuchAlgorithmException e) {
			throw new BaseRuntimeException(e);
		}
    	
    	md.reset();
    	md.update(salt);
    	hashValue = md.digest(data.getBytes());
    	
    	return MessageDigest.isEqual(hashValue, Base64.decodeBase64(encoded.getBytes()));
    }
}