package egovframework.let.uat.uia.filter;

import java.io.IOException;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import egovframework.com.cmm.LoginVO;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Spring Security 인증 컨텍스트와 HTTP 세션의 loginVO를 동기화한다.
 * Spring Security 필터 체인 직후·DispatcherServlet 이전에 실행되어야 한다.
 */
@Component("egovLoginSessionSyncFilter")
public class EgovLoginSessionSyncFilter extends OncePerRequestFilter {

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {

		syncLoginSession(request);

		filterChain.doFilter(request, response);

		if (request.getRequestURI().endsWith(".do")) {
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", 0);
		}
	}

	private static void syncLoginSession(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session == null) {
			return;
		}

		if (Boolean.TRUE.equals(EgovUserDetailsHelper.isAuthenticated())) {
			Object principal = EgovUserDetailsHelper.getAuthenticatedUser();
			if (principal instanceof LoginVO loginVO) {
				session.setAttribute("loginVO", loginVO);
			}
		} else {
			session.removeAttribute("loginVO");
			session.removeAttribute("accessUser");
		}
	}
}
