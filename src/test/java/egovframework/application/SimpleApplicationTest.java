package egovframework.application;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import lombok.extern.slf4j.Slf4j;

/**
 * 간단한 애플리케이션 기동 테스트
 */
@Slf4j
@ExtendWith(SpringExtension.class)
@ActiveProfiles("test")
@ContextConfiguration({
    "classpath*:egovframework/spring/com/test-context-common.xml",
    "classpath*:egovframework/spring/com/test-context-egovuserdetailshelper.xml",
    "classpath*:egovframework/spring/com/context-crypto.xml",

    // ✅ 메인의 datasource 대신 테스트용 H2 datasource 사용
    "classpath*:egovframework/spring/com/test-context-datasource.xml",

    "classpath*:egovframework/spring/com/context-mapper.xml",
    "classpath*:egovframework/spring/com/context-properties.xml",
    "classpath*:egovframework/spring/com/context-transaction.xml"
})
public class SimpleApplicationTest {

    @Autowired
    private ApplicationContext applicationContext;

    @Test
    @DisplayName("Spring 애플리케이션이 에러 없이 기동되는지 테스트")
    void testApplicationStartsWithoutErrors() {
        assertNotNull(applicationContext, "애플리케이션 컨텍스트가 null이면 안됩니다.");
        assertTrue(applicationContext.getBeanDefinitionNames().length > 0,
                "적어도 하나 이상의 Bean이 로드되어야 합니다.");
        log.info("✅ Spring 애플리케이션이 에러 없이 정상 기동");
        log.info("Bean count: {}", applicationContext.getBeanDefinitionNames().length);
    }

    @Test
    @DisplayName("애플리케이션 컨텍스트 상태 검증")
    void testApplicationContextStatus() {
        assertNotNull(applicationContext, "애플리케이션 컨텍스트는 null이 아니어야 합니다.");
        String[] beanNames = applicationContext.getBeanDefinitionNames();
        assertTrue(beanNames.length > 0, "최소 하나 이상의 Bean이 정의되어 있어야 합니다.");
        for (int i = 0; i < Math.min(5, beanNames.length); i++) {
            log.info("Bean[{}]: {}", i, beanNames[i]);
        }
    }
}