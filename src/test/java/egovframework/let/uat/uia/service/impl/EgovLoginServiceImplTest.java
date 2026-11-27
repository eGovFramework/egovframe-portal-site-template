package egovframework.let.uat.uia.service.impl;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Stream;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.util.ReflectionTestUtils;

import egovframework.com.cmm.LoginVO;

/**
 * BCrypt 기반 로그인 검증 및 기초 데이터 비밀번호 해시 검증
 */
class EgovLoginServiceImplTest {

	private static final Pattern BCRYPT_HASH = Pattern.compile("'(\\$2[aby]\\$\\d{2}\\$[./A-Za-z0-9]{53})'");

	private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	private EgovLoginServiceImpl loginService;

	private LoginVO storedUser;

	@BeforeEach
	void setUp() {
		storedUser = new LoginVO();
		storedUser.setId("user1");
		storedUser.setUserSe("GNR");
		storedUser.setPassword(passwordEncoder.encode("1"));

		LoginDAO loginDAO = new LoginDAO() {
			@Override
			public LoginVO actionLogin(LoginVO vo) {
				return storedUser.getId().equals(vo.getId()) ? copy(storedUser) : null;
			}
		};

		loginService = new EgovLoginServiceImpl();
		ReflectionTestUtils.setField(loginService, "loginDAO", loginDAO);
		ReflectionTestUtils.setField(loginService, "passwordEncoder", passwordEncoder);
	}

	@Test
	void actionLoginSucceedsWithCorrectPassword() {
		LoginVO result = loginService.actionLogin(login("user1", "1"));

		assertThat(result.getId()).isEqualTo("user1");
		assertThat(result.getPassword()).as("비밀번호 해시는 반환하지 않는다").isNull();
	}

	@Test
	void actionLoginFailsWithWrongPasswordOrUnknownUser() {
		assertThat(loginService.actionLogin(login("user1", "wrong")).getId()).isNullOrEmpty();
		assertThat(loginService.actionLogin(login("nobody", "1")).getId()).isNullOrEmpty();
		assertThat(loginService.actionLogin(login("user1", null)).getId()).isNullOrEmpty();
	}

	@Test
	void seedAccountsUseBcryptHashOfInitialPassword() throws IOException {
		List<Path> scripts;
		try (Stream<Path> files = Files.walk(Path.of("DATABASE"))) {
			scripts = files.filter(p -> p.getFileName().toString().matches("all_pst_data_.*\\.sql")).toList();
		}
		assertThat(scripts).isNotEmpty();

		for (Path script : scripts) {
			String sql = Files.readString(script, StandardCharsets.UTF_8);
			Matcher matcher = BCRYPT_HASH.matcher(sql);
			int count = 0;
			while (matcher.find()) {
				assertThat(passwordEncoder.matches("1", matcher.group(1))).as(script + " : " + matcher.group(1)).isTrue();
				count++;
			}
			assertThat(count).as(script + " 에 BCrypt 계정 해시가 있어야 한다").isGreaterThan(0);
		}
	}

	private static LoginVO login(String id, String password) {
		LoginVO vo = new LoginVO();
		vo.setId(id);
		vo.setPassword(password);
		vo.setUserSe("GNR");
		return vo;
	}

	private static LoginVO copy(LoginVO source) {
		LoginVO vo = new LoginVO();
		vo.setId(source.getId());
		vo.setUserSe(source.getUserSe());
		vo.setPassword(source.getPassword());
		return vo;
	}
}
