package egovframework.let.main.web;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.slf4j.Slf4j;

/**
 * EgovMainController HTTP 응답 테스트
 */
@Slf4j
@ExtendWith(SpringExtension.class)
@ActiveProfiles("test")
@WebAppConfiguration
@ContextConfiguration({
    "classpath*:egovframework/spring/com/test-context-common.xml",
    "classpath*:egovframework/spring/com/test-context-egovuserdetailshelper.xml",
    "classpath*:egovframework/spring/com/context-crypto.xml",
    "classpath*:egovframework/spring/com/test-context-datasource.xml",
    "classpath*:egovframework/spring/com/context-mapper.xml",
    "classpath*:egovframework/spring/com/context-properties.xml",
    "classpath*:egovframework/spring/com/context-transaction.xml",
    "classpath*:egovframework/spring/com/test-context-whitelist.xml",
    "file:src/main/webapp/WEB-INF/config/egovframework/springmvc/egov-com-*.xml"
})
public class EgovMainControllerWebTest {

    @Autowired
    private WebApplicationContext webApplicationContext;

    private MockMvc mockMvc;

    @Test
    @DisplayName("루트 URL(/) 호출 시 HTTP 200 OK 응답 테스트")
    void testRootUrlReturns200() throws Exception {
        // given
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
        
        // when & then
        mockMvc.perform(get("/"))
                .andDo(print())
                .andExpect(status().isOk());
        
        log.info("✅ 루트 URL(/) 호출이 성공적으로 200 OK를 반환했습니다.");
    }

    @Test
    @DisplayName("메인 페이지 URL 호출 시 HTTP 200 응답 테스트")
    void testMainPageReturns200() throws Exception {
        // given
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
        
        // when & then
        mockMvc.perform(get("/cmm/main/mainPage.do"))
                .andDo(print())
                .andExpect(status().isOk());
        
        log.info("✅ 메인 페이지 URL이 성공적으로 200 OK를 반환했습니다.");
    }
}