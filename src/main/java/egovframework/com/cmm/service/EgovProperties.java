package egovframework.com.cmm.service;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *  Class Name : EgovProperties.java
 *  Description : properties값들을 파일로부터 읽어와   Globals클래스의 정적변수로 로드시켜주는 클래스로
 *   문자열 정보 기준으로 사용할 전역변수를 시스템 재시작으로 반영할 수 있도록 한다.
 *  Modification Information
 *
 *     수정일         수정자                   수정내용
 *   -------    --------    ---------------------------
 *   2009.01.19    박지욱          최초 생성
 *	 2011.07.20    서준식 	      Globals파일의 상대경로를 읽은 메서드 추가
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 *  @author 공통 서비스 개발팀 박지욱
 *  @since 2009. 01. 19
 *  @version 1.0
 *  @see
 *
 */

public class EgovProperties {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovProperties.class);

	//프로퍼티값 로드시 에러발생하면 반환되는 에러문자열
	public static final String ERR_CODE = " EXCEPTION OCCURRED";
	public static final String ERR_CODE_FNFE = " EXCEPTION(FNFE) OCCURRED";
	public static final String ERR_CODE_IOE = " EXCEPTION(IOE) OCCURRED";

	//파일구분자
	static final String FILE_SEPARATOR = System.getProperty("file.separator");

	//프로퍼티 파일의 물리적 위치
	public static final String RELATIVE_PATH_PREFIX = EgovProperties.class.getResource("").getPath()
			+ FILE_SEPARATOR + ".." + FILE_SEPARATOR + ".." + FILE_SEPARATOR + ".." + FILE_SEPARATOR;

	public static final String GLOBALS_PROPERTIES_FILE
	= RELATIVE_PATH_PREFIX + "egovProps" + System.getProperty("file.separator") + "globals.properties";

	/**
	 * 운영 환경에서 비밀값을 소스 밖에서 주입할 수 있도록 시스템 프로퍼티, 환경변수 순으로 조회한다.
	 * 환경변수명은 키를 대문자로 바꾸고 '.' 을 '_' 로 치환한다. (예: Globals.File.algorithmKey -> GLOBALS_FILE_ALGORITHMKEY)
	 */
	private static String getOverride(String keyName) {
		String value = System.getProperty(keyName);
		if (value == null) {
			value = System.getenv(keyName.toUpperCase(java.util.Locale.ROOT).replace('.', '_'));
		}
		return value;
	}

	/**
	 * 인자로 주어진 문자열을 Key값으로 하는 프로퍼티 값을 반환한다(Globals.java 전용).
	 * JVM 시스템 프로퍼티(-DGlobals.xxx) 또는 환경변수(GLOBALS_XXX)가 있으면 파일 값보다 우선한다.
	 * @param keyName String
	 * @return String
	*/
	public static String getProperty(String keyName) {
		String override = getOverride(keyName);
		if (override != null) {
			return override.trim();
		}
		String value = ERR_CODE;
		value = "99";
		debug(GLOBALS_PROPERTIES_FILE + " : " + keyName);
		FileInputStream fis = null;
		try {
			Properties props = new Properties();
			fis = new FileInputStream(GLOBALS_PROPERTIES_FILE);
			props.load(new BufferedInputStream(fis));
			value = props.getProperty(keyName).trim();
		} catch (FileNotFoundException fne) {
			debug(fne);
		} catch (IOException ioe) {
			debug(ioe);
		} finally {
			try {
				if (fis != null) {
					fis.close();
				}
			} catch (IOException ioe) {
				debug(ioe);
			}

		}
		return value;
	}

	/**
	 * 주어진 프로파일의 내용을 파싱하여 (key-value) 형태의 구조체 배열을 반환한다.
	 * @param property String
	 * @return ArrayList
	 */
	@SuppressWarnings("unused")
	public static ArrayList<Map<String, String>> loadPropertyFile(String property){

		// key - value 형태로 된 배열 결과
		ArrayList<Map<String, String>> keyList = new ArrayList<Map<String, String>>();

		String src = property.replace("\\", FILE_SEPARATOR).replace("/", FILE_SEPARATOR);
		FileInputStream fis = null;
		try {
			File srcFile = new File(src);
			if (srcFile.exists()) {

				Properties props = new Properties();
				fis = new FileInputStream(src);
				props.load(new BufferedInputStream(fis));
				fis.close();

				int i = 0;
				Enumeration<?> plist = props.propertyNames();
				if (plist != null) {
					while (plist.hasMoreElements()) {
						Map<String, String> map = new HashMap<String, String>();
						String key = (String) plist.nextElement();
						map.put(key, props.getProperty(key));
						keyList.add(map);
					}
				}
			}
		} catch (IOException ex) {
			debug("EX:" + ex);
		} finally {
			try {
				if (fis != null) fis.close();
			} catch (IOException ex) {
				debug("EX:" + ex);		//ex.printStackTrace();
			}
		}

		return keyList;
	}

	/**
	 * 시스템 로그를 출력한다.
	 * @param obj Object
	 */
	private static void debug(Object obj) {
		if (obj instanceof Exception) {
			LOGGER.debug("IGNORED: {}", ((Exception)obj).getMessage());
		}
	}
}

