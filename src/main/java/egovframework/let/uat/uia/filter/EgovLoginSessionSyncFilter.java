package egovframework.let.uat.uia.filter;

import java.io.IOException;
import java.util.Locale;
import java.util.Properties;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import egovframework.com.cmm.LoginVO;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Spring Security 인증 컨텍스트와 HTTP 세션의 loginVO를 동기화하고, 보안 응답 헤더를 화면 처리 전에 기록한다.
 * Spring Security 필터 체인 직후·DispatcherServlet 이전에 실행되어야 한다.
 * <p>
 * Spring Security 는 보안 헤더를 응답 커밋 시점에 기록하는데, JSP 가 {@code <c:import url="/xxx.do"/>} 로
 * 내부 화면을 포함하면 include 처리 중에 기록이 시도되어 서블릿 컨테이너가 이를 무시한다(include 중 헤더 설정 불가).
 * 그 결과 헤더가 누락되므로 include 가 시작되기 전인 이 필터에서 동일한 헤더를 먼저 기록한다.
 * 값은 egov-security-config.properties 의 sniff, xframeOptions, xssProtection 설정을 따른다.
 * </p>
 */
@Component("egovLoginSessionSyncFilter")
public class EgovLoginSessionSyncFilter extends OncePerRequestFilter {

	private static final String SECURITY_CONFIG = "egovframework/egovProps/conf/egov-security-config.properties";

	/** X-Content-Type-Options: nosniff 기록 여부 (sniff) */
	private boolean contentTypeOptions = true;
	/** X-Frame-Options 값 (xframeOptions), null 이면 기록하지 않음 */
	private String frameOptions = "DENY";
	/** X-XSS-Protection: 0 기록 여부 (xssProtection) */
	private boolean xssProtection = true;

	@Override
	protected void initFilterBean() throws ServletException {
		try {
			Properties props = PropertiesLoaderUtils.loadAllProperties(SECURITY_CONFIG);
			contentTypeOptions = Boolean.parseBoolean(props.getProperty("sniff", "true").trim());
			xssProtection = Boolean.parseBoolean(props.getProperty("xssProtection", "true").trim());
			// 표준프레임워크 보안 설정과 동일한 해석 : SAMEORIGIN, DISABLE(미기록), 그 외는 DENY
			String xframe = props.getProperty("xframeOptions", "").trim().toUpperCase(Locale.ROOT);
			if ("SAMEORIGIN".equals(xframe)) {
				frameOptions = "SAMEORIGIN";
			} else if ("DISABLE".equals(xframe)) {
				frameOptions = null;
			} else {
				frameOptions = "DENY";
			}
		} catch (IOException e) {
			throw new ServletException("보안 설정 파일을 읽을 수 없습니다: " + SECURITY_CONFIG, e);
		}
	}

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {

		syncLoginSession(request);

		// 화면 처리(응답 커밋·include) 전에 기록해야 적용된다.
		writeSecurityHeaders(request, response);

		filterChain.doFilter(request, response);
	}

	private void writeSecurityHeaders(HttpServletRequest request, HttpServletResponse response) {
		if (contentTypeOptions) {
			response.setHeader("X-Content-Type-Options", "nosniff");
		}
		if (frameOptions != null) {
			response.setHeader("X-Frame-Options", frameOptions);
		}
		if (xssProtection) {
			response.setHeader("X-XSS-Protection", "0");
		}
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
