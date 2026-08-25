package egovframework.let.cop.bbs.util;

import java.util.List;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.security.access.AccessDeniedException;

import egovframework.com.cmm.LoginVO;
import egovframework.let.cop.bbs.service.BoardVO;

/**
 * 게시판 객체 수준 권한 검증 유틸리티
 */
public final class EgovBBSAuthUtil {

	private EgovBBSAuthUtil() {
	}

	public static boolean isAdminUser() {
		List<String> authorities = EgovUserDetailsHelper.getAuthorities();
		return authorities != null && authorities.contains("ROLE_ADMIN");
	}

	public static void assertAdminUser() {
		if (!EgovUserDetailsHelper.isAuthenticated() || !isAdminUser()) {
			throw new AccessDeniedException("관리자 권한이 필요합니다.");
		}
	}

	/**
	 * 상세 화면에서 수정/삭제 버튼 표시 여부 (관리자 또는 작성자)
	 * 26.08.20 조치 : 화면 노출 조건이 작성자 한정이라 관리자가 타인 글을 관리할 수 없었다.
	 * 판정 기준을 assertCanModifyArticle()과 동일하게 맞춘다.
	 */
	public static boolean canShowModifyButtons(BoardVO article, LoginVO user) {
		if (isAdminUser()) {
			return true;
		}
		return user != null && article != null && user.getUniqId() != null
				&& user.getUniqId().equals(article.getFrstRegisterId());
	}

	public static void assertCanModifyArticle(BoardVO article, LoginVO user) {
		if (user == null || user.getUniqId() == null || user.getUniqId().isEmpty()) {
			throw new AccessDeniedException("인증이 필요합니다.");
		}
		if (isAdminUser()) {
			return;
		}
		if (article == null || article.getFrstRegisterId() == null || article.getFrstRegisterId().isEmpty()) {
			throw new AccessDeniedException("게시글을 찾을 수 없습니다.");
		}
		if (!user.getUniqId().equals(article.getFrstRegisterId())) {
			throw new AccessDeniedException("게시글 수정 권한이 없습니다.");
		}
	}
}
