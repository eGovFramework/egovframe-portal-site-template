package egovframework.let.utl.fcc.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;

/**
 * EgovStringUtil 단위 테스트
 * 
 * @since 2026-05-21
 */
class EgovStringUtilTest {

	@Test
	void testIsEmpty() {
		assertTrue(EgovStringUtil.isEmpty(null));
		assertTrue(EgovStringUtil.isEmpty(""));
		assertFalse(EgovStringUtil.isEmpty(" "));
		assertFalse(EgovStringUtil.isEmpty("abc"));
	}

	@Test
	void testRemove() {
		assertNull(EgovStringUtil.remove(null, 'u'));
		assertEquals("", EgovStringUtil.remove("", 'u'));
		assertEquals("qeed", EgovStringUtil.remove("queued", 'u'));
		assertEquals("queued", EgovStringUtil.remove("queued", 'z'));
	}

	@Test
	void testRemoveCommaChar() {
		assertNull(EgovStringUtil.removeCommaChar(null));
		assertEquals("asdfgqweqe", EgovStringUtil.removeCommaChar("asdfg,qweqe"));
	}

	@Test
	void testRemoveMinusChar() {
		assertNull(EgovStringUtil.removeMinusChar(null));
		assertEquals("asdfgqweqe", EgovStringUtil.removeMinusChar("a-sdfg-qweqe"));
	}

	@Test
	void testCutString() {
		assertEquals("abc...", EgovStringUtil.cutString("abcdefg", "...", 3));
		assertEquals("abcdefg", EgovStringUtil.cutString("abcdefg", "...", 10));
		assertNull(EgovStringUtil.cutString(null, "...", 3));
	}

	@Test
	void testReplace() {
		assertEquals("a_c", EgovStringUtil.replace("abc", "b", "_"));
	}
}
