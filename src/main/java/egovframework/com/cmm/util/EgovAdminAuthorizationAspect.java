package egovframework.com.cmm.util;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

/**
 * {@code @RequireAdmin}이 붙은 컨트롤러 메소드 실행 전에 로그인 여부와
 * 관리자 권한(ROLE_ADMIN) 여부를 검증하는 Aspect.
 *
 * Spring Security의 URL 패턴 기반 접근통제(sqlRolesAndUrl 등)를 보완하는
 * 메소드 레벨 방어선으로, 실제 인증/권한 정보는 SecurityContext에서 조회한다.
 * <p>
 * 권한이 없으면 대상 메소드를 실행하지 않고 로그인 화면(미로그인) 또는 접근 거부 화면(관리자 아님)으로 이동시킨다.
 * 대상 메소드가 체크 예외를 선언하지 않으므로 예외를 던지는 대신(500 오류 발생) 이동할 뷰를 직접 반환한다.
 * </p>
 *
 */
public class EgovAdminAuthorizationAspect {

	/** 미로그인 시 이동 경로 (egov-security-config.properties 의 loginUrl) */
	private static final String LOGIN_PATH = "/uat/uia/egovLoginUsr.do";

	/** 관리자가 아닐 때 이동 경로 (egov-security-config.properties 의 accessDeniedUrl) */
	private static final String ACCESS_DENIED_PATH = "/sec/ram/accessDenied.do";

	/**
	 * 관리자인 경우에만 대상 메소드를 실행한다.
	 *
	 * @param joinPoint {@code @RequireAdmin} 컨트롤러 메소드
	 * @return 대상 메소드의 반환값, 권한이 없으면 이동할 뷰
	 * @throws Throwable 대상 메소드에서 발생한 예외
	 */
	public Object requireAdmin(ProceedingJoinPoint joinPoint) throws Throwable {
		String deniedPath = resolveDeniedPath();
		if (deniedPath == null) {
			return joinPoint.proceed();
		}

		Class<?> returnType = ((MethodSignature) joinPoint.getSignature()).getReturnType();
		if (String.class.equals(returnType)) {
			return "redirect:" + deniedPath;
		}
		if (ModelAndView.class.equals(returnType)) {
			return new ModelAndView("redirect:" + deniedPath);
		}

		// 뷰를 반환하지 않는 메소드(void 등) : 응답으로 직접 이동시킨다.
		RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
		if (attributes instanceof ServletRequestAttributes) {
			HttpServletRequest request = ((ServletRequestAttributes) attributes).getRequest();
			HttpServletResponse response = ((ServletRequestAttributes) attributes).getResponse();
			if (response != null && !response.isCommitted()) {
				response.sendRedirect(request.getContextPath() + deniedPath);
				return null;
			}
		}
		throw new AccessDeniedException("관리자 권한이 필요합니다.");
	}

	/**
	 * @return 권한이 있으면 null, 없으면 이동할 경로
	 */
	private String resolveDeniedPath() {
		if (!Boolean.TRUE.equals(EgovUserDetailsHelper.isAuthenticated())) {
			return LOGIN_PATH;
		}
		List<String> authorities = EgovUserDetailsHelper.getAuthorities();
		if (authorities == null || !authorities.contains("ROLE_ADMIN")) {
			return ACCESS_DENIED_PATH;
		}
		return null;
	}
}
