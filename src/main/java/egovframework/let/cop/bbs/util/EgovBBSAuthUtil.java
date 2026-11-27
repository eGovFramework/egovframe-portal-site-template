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
	 * 상세 화면 수정/삭제 버튼 노출 여부 (관리자 또는 본인 답글, assertCanModifyArticle 과 동일 기준)
	 */
	public static boolean canShowModifyButtons(BoardVO article, LoginVO user) {
		return isAdminUser() || isOwnReply(article, user);
	}

	/**
	 * 게시글 수정/삭제 권한 검증 (관리자 또는 본인 답글)
	 */
	public static void assertCanModifyArticle(BoardVO article, LoginVO user) {
		if (user == null || user.getUniqId() == null || user.getUniqId().isEmpty()) {
			throw new AccessDeniedException("인증이 필요합니다.");
		}
		if (isAdminUser()) {
			return;
		}
		if (!isOwnReply(article, user)) {
			throw new AccessDeniedException("게시글 수정 권한이 없습니다.");
		}
	}

	/**
	 * 로그인 사용자가 작성한 답글인지 여부
	 */
	private static boolean isOwnReply(BoardVO article, LoginVO user) {
		return article != null && user != null && "Y".equals(article.getReplyAt())
				&& user.getUniqId() != null && user.getUniqId().equals(article.getFrstRegisterId());
	}
}
