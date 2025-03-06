package egovframework.let.uat.uia.web;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * [로그인] 셀레늄 단위 테스트
 * 
 * @author 이백행
 * @since 2024-08-31
 *
 */
@Slf4j
@NoArgsConstructor
class EgovLoginControllerTestSelenium {

	/**
	 * 웹 드라이버
	 */
	private WebDriver driver;

	/**
	 * 설정
	 */
	@BeforeEach
	public void setup() {
		driver = new ChromeDriver();
	}

	@Test
	void test() {
		if (log.isDebugEnabled()) {
			log.debug("[로그인] 셀레늄 단위 테스트");
		}

		// given
		if (log.isDebugEnabled()) {
			log.debug("로그인 화면 이동");
		}
		driver.get("http://localhost:8080/pst_webapp/uat/uia/egovLoginUsr.do");

		final JavascriptExecutor executor = (JavascriptExecutor) driver;

		// 새로고침
		sleep();
		executor.executeScript("location.reload();");

		// 아이디 입력
		sleep();
		final WebElement idWebElement = driver.findElement(By.id("id"));
		idWebElement.sendKeys("admin");

		// 비밀번호 입력
		sleep();
		final WebElement passwordElement = driver.findElement(By.id("password"));
		passwordElement.sendKeys("1");

		// when
		// 로그인 버튼 클릭
		sleep();
		executor.executeScript("actionLogin();");

		// then
		final WebElement spanWebElement = driver
				.findElement(By.cssSelector("body > div > div.header > div > div.top_menu > span.t > span"));

		assertEquals("관리자님", spanWebElement.getText(), "로그인 실패");
	}

	private void sleep() {
		try {
			Thread.sleep(3000);
		} catch (InterruptedException e) {
			fail("InterruptedException: Thread.sleep");
		}
	}

}