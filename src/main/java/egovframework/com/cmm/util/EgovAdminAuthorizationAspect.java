package egovframework.com.cmm.util;

import java.util.List;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import egovframework.com.cmm.EgovMessageSource;
import jakarta.annotation.Resource;

/**
 * {@code @RequireAdmin}이 붙은 컨트롤러 메소드 실행 전에 로그인 여부와
 * 관리자 권한(ROLE_ADMIN) 여부를 검증하는 Aspect.
 *
 * Spring Security의 URL 패턴 기반 접근통제(sqlRolesAndUrl 등)를 보완하는
 * 메소드 레벨 방어선으로, 실제 인증/권한 정보는 SecurityContext에서 조회한다.
 *
 * @see egovframework.com.cmm.annotation.RequireAdmin
 */
public class EgovAdminAuthorizationAspect {

	@Resource(name = "egovMessageSource")
	private EgovMessageSource egovMessageSource;

	public void assertAdmin() throws ModelAndViewDefiningException {
		if (!Boolean.TRUE.equals(EgovUserDetailsHelper.isAuthenticated())) {
			ModelAndView modelAndView = new ModelAndView("redirect:/uat/uia/egovLoginUsr.do");
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.login"));
			throw new ModelAndViewDefiningException(modelAndView);
		}

		List<String> authorities = EgovUserDetailsHelper.getAuthorities();
		if (authorities == null || !authorities.contains("ROLE_ADMIN")) {
			throw new ModelAndViewDefiningException(new ModelAndView("redirect:/sec/ram/accessDenied.do"));
		}
	}
}
