package egovframework.let.uss.olh.qna.util;

import java.util.HashSet;
import java.util.Set;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.security.access.AccessDeniedException;

import egovframework.com.cmm.LoginVO;
import egovframework.let.uss.olh.qna.service.QnaManageVO;
import jakarta.servlet.http.HttpSession;

/**
 * QnA 객체 수준 권한 검증 유틸리티
 */
public final class EgovQnaAuthUtil {

	public static final String SESSION_PASSWORD_CONFIRMED_IDS = "qnaPasswordConfirmedIds";

	private EgovQnaAuthUtil() {
	}

	@SuppressWarnings("unchecked")
	public static void markPasswordConfirmed(HttpSession session, String qaId) {
		if (session == null || qaId == null || qaId.isBlank()) {
			return;
		}
		Set<String> ids = (Set<String>) session.getAttribute(SESSION_PASSWORD_CONFIRMED_IDS);
		if (ids == null) {
			ids = new HashSet<>();
			session.setAttribute(SESSION_PASSWORD_CONFIRMED_IDS, ids);
		}
		ids.add(qaId);
	}

	@SuppressWarnings("unchecked")
	public static boolean isPasswordConfirmed(HttpSession session, String qaId) {
		if (session == null || qaId == null || qaId.isBlank()) {
			return false;
		}
		Set<String> ids = (Set<String>) session.getAttribute(SESSION_PASSWORD_CONFIRMED_IDS);
		return ids != null && ids.contains(qaId);
	}

	/**
	 * QnA 수정/삭제 권한 검증 (등록자 본인만 가능)
	 */
	public static void assertCanModifyQna(QnaManageVO article, HttpSession session) {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if (user == null || user.getUniqId() == null || user.getUniqId().isEmpty()) {
			throw new AccessDeniedException("인증이 필요합니다.");
		}
		if (article == null || article.getQaId() == null || article.getQaId().isEmpty()) {
			throw new AccessDeniedException("QnA를 찾을 수 없습니다.");
		}
		if (!isWriter(article)) {
			throw new AccessDeniedException("QnA 수정 권한이 없습니다.");
		}
	}

	/**
	 * 상세 화면에서 수정/삭제 버튼 표시 여부 (등록자 본인)
	 */
	public static boolean canShowModifyButtons(QnaManageVO article) {
		return isWriter(article);
	}

	/**
	 * 로그인 사용자가 QnA 등록자인지 여부
	 */
	public static boolean isWriter(QnaManageVO article) {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		return user != null && article != null && user.getUniqId() != null
				&& user.getUniqId().equals(article.getFrstRegisterId());
	}
}
