package egovframework.com.cmm.util;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.security.access.AccessDeniedException;

import egovframework.com.cmm.LoginVO;

/**
 * 등록자 본인 여부 검증 유틸리티
 * 포털서비스관리, 포털시스템관리에서 등록한 글은 등록자(FRST_REGISTER_ID)와
 * 로그인 사용자(uniqId)가 동일한 경우에만 수정/삭제할 수 있다.
 */
public final class EgovOwnerAuthUtil {

	private EgovOwnerAuthUtil() {
	}

	/**
	 * 로그인 사용자의 고유ID(uniqId)를 반환한다. 미인증이면 null.
	 */
	public static String getLoginUniqId() {
		if (!Boolean.TRUE.equals(EgovUserDetailsHelper.isAuthenticated())) {
			return null;
		}
		Object user = EgovUserDetailsHelper.getAuthenticatedUser();
		return user instanceof LoginVO ? ((LoginVO) user).getUniqId() : null;
	}

	/**
	 * 로그인 사용자가 등록자 본인인지 여부
	 */
	public static boolean isOwner(String frstRegisterId) {
		String uniqId = getLoginUniqId();
		return uniqId != null && !uniqId.isEmpty() && uniqId.equals(frstRegisterId);
	}

	/**
	 * 화면의 수정/삭제 버튼 노출 여부 ("Y"/"N")
	 */
	public static String ownerAt(String frstRegisterId) {
		return isOwner(frstRegisterId) ? "Y" : "N";
	}

	/**
	 * 상세조회 결과(List/Map, egovMap)에서 등록자ID(frstRegisterId)를 꺼낸다.
	 */
	public static String frstRegisterIdOf(Object result) {
		Object row = result;
		if (row instanceof List) {
			List<?> list = (List<?>) row;
			row = list.isEmpty() ? null : list.get(0);
		}
		if (row instanceof Map) {
			Object value = ((Map<?, ?>) row).get("frstRegisterId");
			return value == null ? null : value.toString();
		}
		return null;
	}

	/**
	 * 등록자 본인이 아니면 AccessDeniedException 을 던진다.
	 */
	public static void assertOwner(String frstRegisterId) {
		if (getLoginUniqId() == null) {
			throw new AccessDeniedException("인증이 필요합니다.");
		}
		if (!isOwner(frstRegisterId)) {
			throw new AccessDeniedException("등록자 본인만 수정/삭제할 수 있습니다.");
		}
	}
}
