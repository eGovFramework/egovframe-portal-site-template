package egovframework.let.uat.uia.filter;

import java.io.IOException;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.let.uat.uia.service.EgovLoginService;
import jakarta.annotation.Resource;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 로그인 폼(id/password)을 검증한 뒤 Spring Security 폼 파라미터(username/uniqId)로 변환하는 브리지 필터.
 * 비밀번호 검증 없이 Spring Security 인증 컨텍스트가 생성되는 것을 방지한다.
 */
@Component("egovSpringSecurityLoginFilter")
public class EgovSpringSecurityLoginFilter extends OncePerRequestFilter {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovSpringSecurityLoginFilter.class);

	private static final String LOGIN_PATH = "/uat/uia/egovLoginUsr.do";
	private static final String ACTION_LOGIN_PATH = "/uat/uia/actionLogin.do";

	@Resource(name = "loginService")
	private EgovLoginService loginService;

	@Resource(name = "egovMessageSource")
	private EgovMessageSource egovMessageSource;

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {

		if (!isActionLoginUri(request)) {
			filterChain.doFilter(request, response);
			return;
		}

		String id = request.getParameter("id");
		String password = request.getParameter("password");
		if (!StringUtils.hasText(id) || !StringUtils.hasText(password)) {
			forwardLoginFailure(request, response);
			return;
		}

		String userSe = request.getParameter("userSe");
		if (!StringUtils.hasText(userSe)) {
			userSe = "GNR";
		}

		LoginVO loginVO = new LoginVO();
		loginVO.setId(id.trim());
		loginVO.setPassword(password);
		loginVO.setUserSe(userSe);

		try {
			SecurityContextHolder.clearContext();

			LoginVO resultVO = loginService.actionLogin(loginVO);
			if (resultVO == null || !StringUtils.hasText(resultVO.getId())) {
				forwardLoginFailure(request, response);
				return;
			}

			String securityUser = resultVO.getUserSe().concat(resultVO.getId());
			String securityPass = password;
			if (!StringUtils.hasText(securityPass)) {
				LOGGER.warn("Login succeeded but uniqId is empty for user {}", securityUser);
				forwardLoginFailure(request, response);
				return;
			}

			HttpServletRequest wrapped = new LoginFormSpringSecurityParameterWrapper(request, securityUser, securityPass);
			filterChain.doFilter(wrapped, response);

			var session = request.getSession(false);
			if (session != null && !Boolean.TRUE.equals(EgovUserDetailsHelper.isAuthenticated())) {
				session.removeAttribute("loginVO");
				session.removeAttribute("accessUser");
			}
		} catch (IllegalArgumentException e) {
			LOGGER.error("Login bridge processing failed", e);
			forwardLoginFailure(request, response);
		} catch (Exception e) {
			LOGGER.error("Login bridge processing failed", e);
			forwardLoginFailure(request, response);
		}
	}

	private void forwardLoginFailure(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		var session = request.getSession(false);
		if (session != null) {
			session.removeAttribute("loginVO");
			session.removeAttribute("accessUser");
		}
		request.setAttribute("message", egovMessageSource.getMessage("fail.common.login"));
		request.getRequestDispatcher(LOGIN_PATH).forward(request, response);
	}

	private static boolean isActionLoginUri(HttpServletRequest request) {
		return "POST".equalsIgnoreCase(request.getMethod())
				&& ACTION_LOGIN_PATH.equals(normalizeRequestUri(request));
	}

	private static String normalizeRequestUri(HttpServletRequest request) {
		String uri = stripContextPath(request);
		int semicolonIndex = uri.indexOf(';');
		if (semicolonIndex > -1) {
			uri = uri.substring(0, semicolonIndex);
		}
		return uri;
	}

	private static String stripContextPath(HttpServletRequest request) {
		String contextPath = request.getContextPath();
		String uri = request.getRequestURI();
		if (StringUtils.hasText(contextPath) && uri.startsWith(contextPath)) {
			return uri.substring(contextPath.length());
		}
		return uri;
	}

	private static final class LoginFormSpringSecurityParameterWrapper extends HttpServletRequestWrapper {

		private final String securityUsername;
		private final String securityPassword;
		private Map<String, String[]> cachedParameterMap;

		LoginFormSpringSecurityParameterWrapper(HttpServletRequest request, String securityUsername,
				String securityPassword) {
			super(request);
			this.securityUsername = securityUsername;
			this.securityPassword = securityPassword;
		}

		@Override
		public String getParameter(String name) {
			if ("username".equals(name)) {
				return securityUsername;
			}
			if ("password".equals(name)) {
				return securityPassword;
			}
			return super.getParameter(name);
		}

		@Override
		public String[] getParameterValues(String name) {
			if ("username".equals(name)) {
				return new String[] { securityUsername };
			}
			if ("password".equals(name)) {
				return new String[] { securityPassword };
			}
			return super.getParameterValues(name);
		}

		@Override
		public Map<String, String[]> getParameterMap() {
			if (cachedParameterMap == null) {
				Map<String, String[]> map = new HashMap<>(super.getParameterMap());
				map.put("username", new String[] { securityUsername });
				map.put("password", new String[] { securityPassword });
				cachedParameterMap = Collections.unmodifiableMap(map);
			}
			return cachedParameterMap;
		}

		@Override
		public Enumeration<String> getParameterNames() {
			Vector<String> names = new Vector<>(Collections.list(super.getParameterNames()));
			if (!names.contains("username")) {
				names.add("username");
			}
			if (!names.contains("password")) {
				names.add("password");
			}
			return names.elements();
		}
	}
}
