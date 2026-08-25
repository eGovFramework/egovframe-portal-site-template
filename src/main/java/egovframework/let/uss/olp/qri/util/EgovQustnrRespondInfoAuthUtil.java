package egovframework.let.uss.olp.qri.util;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.security.access.AccessDeniedException;

import egovframework.com.cmm.LoginVO;
import egovframework.let.cop.bbs.util.EgovBBSAuthUtil;
import egovframework.let.uss.olp.qri.service.QustnrRespondInfoVO;

/**
 * 설문 응답 객체 수준 권한 검증 유틸리티
 */
public final class EgovQustnrRespondInfoAuthUtil {

	private EgovQustnrRespondInfoAuthUtil() {
	}

	public static void assertCanModifyRespondInfo(QustnrRespondInfoVO respondInfo) {
		if (EgovBBSAuthUtil.isAdminUser()) {
			return;
		}
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if (user == null || user.getUniqId() == null || user.getUniqId().isEmpty()) {
			throw new AccessDeniedException("인증이 필요합니다.");
		}
		if (respondInfo == null || respondInfo.getFrstRegisterId() == null
				|| respondInfo.getFrstRegisterId().isEmpty()) {
			throw new AccessDeniedException("설문 응답을 찾을 수 없습니다.");
		}
		if (!user.getUniqId().equals(respondInfo.getFrstRegisterId())) {
			throw new AccessDeniedException("설문 응답 수정 권한이 없습니다.");
		}
	}
}
