package egovframework.let.utl.fcc.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;

/**
 * EgovNumberUtil 단위 테스트
 * 
 * @since 2026-05-21
 */
class EgovNumberUtilTest {

	@Test
	void testGetRandomNum() {
		int start = 10;
		int end = 20;
		for (int i = 0; i < 100; i++) {
			int rand = EgovNumberUtil.getRandomNum(start, end);
			assertTrue(rand >= start && rand <= end);
		}
	}

	@Test
	void testGetNumSearchCheck() {
		assertTrue(EgovNumberUtil.getNumSearchCheck(12345678, 7));
		assertFalse(EgovNumberUtil.getNumSearchCheck(12345678, 9));
	}

	@Test
	void testGetNumToStrCnvr() {
		assertEquals("20260521", EgovNumberUtil.getNumToStrCnvr(20260521));
	}

	@Test
	void testGetNumberValidCheck() {
		assertTrue(EgovNumberUtil.getNumberValidCheck("12345"));
		assertFalse(EgovNumberUtil.getNumberValidCheck("123a5"));
	}

	@Test
	void testGetNumberCnvr() {
		assertEquals(99945678, EgovNumberUtil.getNumberCnvr(12345678, 123, 999));
	}

	@Test
	void testCheckRlnoInteger() {
		assertEquals(-1, EgovNumberUtil.checkRlnoInteger(-5.5));
		assertEquals(1, EgovNumberUtil.checkRlnoInteger(5.5));
	}
}
