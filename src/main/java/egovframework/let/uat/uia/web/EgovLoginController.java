package egovframework.let.uat.uia.web;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 일반 로그인을 처리하는 컨트롤러 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성
 *  2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *  2026.06.15  유지보수          Spring Security 로그인/로그아웃 필터 분리 (인증 우회 조치)
 *
 *  </pre>
 */
@Controller
public class EgovLoginController {

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/**
	 * 로그인 화면으로 들어간다
	 */
	@RequestMapping(value = "/uat/uia/egovLoginUsr.do")
	public String loginUsrView(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {
		String message = request.getParameter("loginMessage");
		if (message != null) {
			if ("expired".equals(message)) {
				model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			} else {
				model.addAttribute("message", message);
			}
		}
		return "uat/uia/EgovLoginUsr";
	}

	/**
	 * 로그인 요청 폴백 처리.
	 * 실제 로그인은 EgovSpringSecurityLoginFilter가 선행 처리한다.
	 */
	@RequestMapping(value = "/uat/uia/actionLogin.do")
	public String actionLogin() {
		return "redirect:/uat/uia/actionMain.do";
	}

	/**
	 * 로그인 후 메인화면으로 들어간다
	 */
	@RequestMapping(value = "/uat/uia/actionMain.do")
	public String actionMain(ModelMap model) throws Exception {
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		return "redirect:/cmm/main/mainPage.do";
	}

	/**
	 * 로그아웃한다.
	 * 실제 로그아웃은 EgovSpringSecurityLogoutFilter가 선행 처리한다.
	 */
	@RequestMapping(value = "/uat/uia/actionLogout.do", method = RequestMethod.POST)
	public String actionLogout(HttpServletRequest request) {
		request.getSession().setAttribute("loginVO", null);
		request.getSession().setAttribute("accessUser", null);
		return "redirect:/uat/uia/actionSecurityLogout.do";
	}

}
