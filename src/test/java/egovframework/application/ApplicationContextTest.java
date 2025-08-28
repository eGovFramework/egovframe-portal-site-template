package egovframework.application;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;

import egovframework.test.EgovTestAbstractSpring;
import lombok.extern.slf4j.Slf4j;

/**
 * 애플리케이션 컨텍스트 로드 테스트
 * 
 * Spring 애플리케이션이 에러 없이 기동되는지 확인하는 테스트입니다.
 * 
 * @author Claude
 * @since 2025-01-30
 */
@Slf4j
public class ApplicationContextTest extends EgovTestAbstractSpring {

    @Autowired
    private ApplicationContext applicationContext;

    @Test
    @DisplayName("Spring 애플리케이션 컨텍스트가 정상적으로 로드되는지 테스트")
    public void testApplicationContextLoads() {
        // given & when
        // 애플리케이션 컨텍스트가 이미 @ExtendWith(SpringExtension.class)에 의해 로드됨
        
        // then
        assertNotNull(applicationContext, "애플리케이션 컨텍스트가 null이면 안됩니다.");
        
        log.info("Spring 애플리케이션 컨텍스트가 에러 없이 정상적으로 로드되었습니다.");
        log.info("로드된 Bean 개수: {}", applicationContext.getBeanDefinitionNames().length);
    }

    @Test
    @DisplayName("주요 컴포넌트들이 올바르게 로드되는지 테스트")
    public void testMainComponentsAreLoaded() {
        // given & when & then
        assertNotNull(applicationContext.getBean("EgovMainController"), 
                     "EgovMainController Bean이 로드되어야 합니다.");
        
        log.info("주요 컴포넌트들이 정상적으로 로드되었습니다.");
    }
}