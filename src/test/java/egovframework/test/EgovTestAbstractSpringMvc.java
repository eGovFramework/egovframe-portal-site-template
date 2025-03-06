package egovframework.test;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.util.StopWatch;
import org.springframework.web.context.WebApplicationContext;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * Spring MVC 테스트
 * 
 * @author 이백행
 * @since 2024-09-21
 */

@ActiveProfiles({ "mysql", "dummy" })
//@ActiveProfiles({ "oracle", "dummy" })
//@ActiveProfiles({ "altibase", "dummy" })
//@ActiveProfiles({ "tibero", "dummy" })
//@ActiveProfiles({ "cubrid", "dummy" })
//@ActiveProfiles({ "maria", "dummy" })
//@ActiveProfiles({ "postgres", "dummy" })
//@ActiveProfiles({ "goldilocks", "dummy" })

@ExtendWith(SpringExtension.class)
@TestMethodOrder(MethodOrderer.MethodName.class)

@WebAppConfiguration

@ContextConfiguration({

		"classpath*:egovframework/spring/com/context-*.xml",

//		"classpath*:egovframework/spring/com/idgn/context-*.xml",

//		"classpath*:egovframework/spring/com/scheduling/context-*.xml",

		"file:src/main/webapp/WEB-INF/config/egovframework/springmvc/egov-com-*.xml",

})

@RequiredArgsConstructor
@Slf4j

public class EgovTestAbstractSpringMvc {

	/**
	 * BeforeClass AfterClass
	 */
	private static final StopWatch STOP_WATCH = new StopWatch();

	/**
	 * Before After
	 */
	private final StopWatch stopWatch = new StopWatch();

	/**
	 * beanDefinitionNames
	 */
	private static String[] beanDefinitionNames;

	/**
	 * ApplicationContext
	 */
	@Autowired
	private WebApplicationContext context;

	/**
	 * 서버 측 Spring MVC 테스트 지원을 위한 주요 진입점입니다.
	 */
	protected MockMvc mockMvc;

	/**
	 * setUpBeforeClass
	 */
	@BeforeAll
	static void setUpBeforeClass() {
		STOP_WATCH.start();

		log.debug("setUpBeforeClass start");
	}

	/**
	 * tearDownAfterClass
	 */
	@AfterAll
	static void tearDownAfterClass() {
		STOP_WATCH.stop();

		if (log.isDebugEnabled()) {
			log.debug("tearDownAfterClass stop");

			log.debug("totalTimeMillis={}", STOP_WATCH.getTotalTimeMillis());
			log.debug("totalTimeSeconds={}", STOP_WATCH.getTotalTimeSeconds());
		}
	}

	/**
	 * setUp
	 */
	@BeforeEach
	void setUp() {
		stopWatch.start();

		log.debug("setUp start");

		if (beanDefinitionNames == null) {
			beanDefinitionNames = context.getBeanDefinitionNames();
			for (final String beanDefinitionName : beanDefinitionNames) {
				log.debug("beanDefinitionName={}", beanDefinitionName);
			}
			if (log.isDebugEnabled()) {
				log.debug("length={}", beanDefinitionNames.length);
			}

			mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
		}
	}

	/**
	 * tearDown
	 */
	@AfterEach
	void tearDown() {
		stopWatch.stop();

		if (log.isDebugEnabled()) {
			log.debug("tearDown stop");

			log.debug("totalTimeMillis={}", stopWatch.getTotalTimeMillis());
			log.debug("totalTimeSeconds={}", stopWatch.getTotalTimeSeconds());
		}
	}

}