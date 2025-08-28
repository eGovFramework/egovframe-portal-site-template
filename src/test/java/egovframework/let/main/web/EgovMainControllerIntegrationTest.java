package egovframework.let.main.web;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import egovframework.test.EgovTestAbstractSpringMvc;
import lombok.extern.slf4j.Slf4j;

/**
 * EgovMainController 통합 테스트
 * 
 * Spring MVC 통합 테스트로 애플리케이션 컨텍스트 로드 및 HTTP 요청 응답을 테스트합니다.
 * 
 * @author Claude
 * @since 2025-01-30
 */
@Slf4j
public class EgovMainControllerIntegrationTest extends EgovTestAbstractSpringMvc {

    @Test
    @DisplayName("애플리케이션 컨텍스트 로드 테스트")
    public void testApplicationContextLoads() {
        log.info("애플리케이션 컨텍스트가 에러 없이 로드되었습니다.");
        // 이미 setUp()에서 WebApplicationContext가 로드되고 MockMvc가 설정됨
        // 테스트가 실행되면 애플리케이션이 정상적으로 기동되었다는 의미
    }

    @Test
    @DisplayName("루트 URL(/) 호출 시 HTTP 200 응답 테스트")
    public void testRootUrlReturns200() throws Exception {
        // when & then
        mockMvc.perform(get("/"))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.content().contentTypeCompatibleWith("text/html"));
        
        log.info("루트 URL(/) 호출이 성공적으로 200 OK를 반환했습니다.");
    }

    @Test
    @DisplayName("메인 페이지 URL(/cmm/main/mainPage.do) 호출 시 HTTP 200 응답 테스트")
    public void testMainPageReturns200() throws Exception {
        // when & then
        mockMvc.perform(get("/cmm/main/mainPage.do"))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(view().name("main/EgovMainView"));
        
        log.info("메인 페이지 URL이 성공적으로 200 OK를 반환했습니다.");
    }

    @Test
    @DisplayName("헤더 페이지 URL 호출 시 HTTP 200 응답 테스트")
    public void testHeaderPageReturns200() throws Exception {
        // when & then
        mockMvc.perform(get("/sym/mms/EgovHeader.do"))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(view().name("main/inc/EgovIncHeader"));
        
        log.info("헤더 페이지 URL이 성공적으로 200 OK를 반환했습니다.");
    }

    @Test
    @DisplayName("푸터 페이지 URL 호출 시 HTTP 200 응답 테스트")
    public void testFooterPageReturns200() throws Exception {
        // when & then
        mockMvc.perform(get("/sym/mms/EgovFooter.do"))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(view().name("main/inc/EgovIncFooter"));
        
        log.info("푸터 페이지 URL이 성공적으로 200 OK를 반환했습니다.");
    }
}