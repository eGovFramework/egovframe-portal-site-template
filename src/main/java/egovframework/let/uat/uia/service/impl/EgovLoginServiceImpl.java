package egovframework.let.uat.uia.service.impl;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import egovframework.com.cmm.LoginVO;
import egovframework.let.uat.uia.service.EgovLoginService;
import jakarta.annotation.Resource;

/**
 * 일반 로그인을 처리하는 비즈니스 구현 클래스
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
 *  2026.10.26  유지보수          BCrypt(PasswordEncoder) 비밀번호 검증 적용, 미사용 아이디/비밀번호 찾기 제거
 *
 *  </pre>
 */
@Service("loginService")
public class EgovLoginServiceImpl extends EgovAbstractServiceImpl implements EgovLoginService {

	@Resource(name = "loginDAO")
	private LoginDAO loginDAO;

	@Resource(name = "egovPasswordEncoder")
	private PasswordEncoder passwordEncoder;

	/**
	 * 일반 로그인을 처리한다. 아이디로 사용자를 조회한 뒤 BCrypt 해시와 입력 비밀번호를 비교한다.
	 * @param vo LoginVO
	 * @return 인증 성공 시 사용자 정보, 실패 시 빈 LoginVO
	 */
	@Override
	public LoginVO actionLogin(LoginVO vo) {
		LoginVO loginVO = loginDAO.actionLogin(vo);

		if (loginVO != null && StringUtils.hasText(loginVO.getId()) && StringUtils.hasText(loginVO.getPassword())
				&& vo.getPassword() != null && passwordEncoder.matches(vo.getPassword(), loginVO.getPassword())) {
			loginVO.setPassword(null);
			return loginVO;
		}

		return new LoginVO();
	}
}
