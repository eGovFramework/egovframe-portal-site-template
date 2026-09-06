package egovframework.test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatCode;

import org.junit.jupiter.api.Test;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;

import egovframework.com.cmm.EgovMessageSource;

/**
 * {@code @Pattern(message = "{validation.integer.check}")} 가 참조하는 메시지 키가
 * 실제 메시지 번들에 정의돼 있는지 검증한다.
 *
 * <p>배선은 context-common.xml 의 messageSource 빈과 동일한 basenames 를 쓰고,
 * 조회는 EgovValidationControllerAdvice.replaceMessageKeys 가 부르는 것과 같은
 * 프로덕션 경로 EgovMessageSource#getMessage(String) 를 그대로 태운다.
 */
class EgovValidationMessageKeyTest {

	private EgovMessageSource egovMessageSource() {
		ReloadableResourceBundleMessageSource source = new ReloadableResourceBundleMessageSource();
		// context-common.xml 의 messageSource 빈과 동일하게 basenames 만 지정(defaultEncoding 미설정)
		source.setBasenames(
				"classpath:/egovframework/message/com/message-common",
				"classpath:/egovframework/message/com/message-validation");

		EgovMessageSource egov = new EgovMessageSource();
		egov.setReloadableResourceBundleMessageSource(source);
		return egov;
	}

	@Test
	void 형제_검증키는_번들에서_해석된다() {
		EgovMessageSource egov = egovMessageSource();
		// 번들이 실제로 로드됐고 형제 키들이 정상 해석됨을 먼저 못 박는다
		assertThat(egov.getMessage("validation.required")).isNotBlank();
		assertThat(egov.getMessage("validation.english.check")).isNotBlank();
		assertThat(egov.getMessage("validation.korean.check")).isNotBlank();
	}

	@Test
	void validation_integer_check_키가_정의돼_있다() {
		EgovMessageSource egov = egovMessageSource();
		// 수정 전에는 이 키가 어느 번들에도 없어 NoSuchMessageException 이 나고,
		// EgovValidationControllerAdvice 는 이를 삼켜 화면에 리터럴 {validation.integer.check} 를 남긴다.
		assertThatCode(() -> egov.getMessage("validation.integer.check"))
				.doesNotThrowAnyException();
		assertThat(egov.getMessage("validation.integer.check")).isNotBlank();
	}
}
