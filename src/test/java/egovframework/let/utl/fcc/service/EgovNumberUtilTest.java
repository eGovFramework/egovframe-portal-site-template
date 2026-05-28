package egovframework.let.utl.fcc.service;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * EgovNumberUtil 단위 테스트
 */
class EgovNumberUtilTest {

    // ── getNumSearchCheck ──────────────────────────────────────

    @Test
    @DisplayName("getNumSearchCheck: 숫자 집합에 검색 숫자가 포함되면 true")
    void getNumSearchCheck_found() {
        assertTrue(EgovNumberUtil.getNumSearchCheck(12345678, 7));
    }

    @Test
    @DisplayName("getNumSearchCheck: 숫자 집합에 검색 숫자가 없으면 false")
    void getNumSearchCheck_notFound() {
        assertFalse(EgovNumberUtil.getNumSearchCheck(12345678, 9));
    }

    // ── getNumToStrCnvr ────────────────────────────────────────

    @Test
    @DisplayName("getNumToStrCnvr: 숫자를 문자열로 변환")
    void getNumToStrCnvr() {
        assertEquals("20081212", EgovNumberUtil.getNumToStrCnvr(20081212));
    }

    @Test
    @DisplayName("getNumToStrCnvr: 0은 '0' 문자열로 변환")
    void getNumToStrCnvr_zero() {
        assertEquals("0", EgovNumberUtil.getNumToStrCnvr(0));
    }

    // ── getNumToDateCnvr ───────────────────────────────────────

    @Test
    @DisplayName("getNumToDateCnvr: 8자리 숫자를 날짜 형식(yyyy-MM-dd)으로 변환")
    void getNumToDateCnvr_8digits() {
        assertEquals("2008-12-12", EgovNumberUtil.getNumToDateCnvr(20081212));
    }

    @Test
    @DisplayName("getNumToDateCnvr: 8자리/14자리 외 입력 시 IllegalArgumentException")
    void getNumToDateCnvr_invalidLength() {
        assertThrows(IllegalArgumentException.class,
                () -> EgovNumberUtil.getNumToDateCnvr(2008121));
    }

    // ── getNumberValidCheck ────────────────────────────────────

    @Test
    @DisplayName("getNumberValidCheck: 숫자 문자열이면 true")
    void getNumberValidCheck_numeric() {
        assertTrue(EgovNumberUtil.getNumberValidCheck("12345"));
    }

    @Test
    @DisplayName("getNumberValidCheck: 알파벳 포함 시 false")
    void getNumberValidCheck_alpha() {
        assertFalse(EgovNumberUtil.getNumberValidCheck("123a5"));
    }

    @Test
    @DisplayName("getNumberValidCheck: 단일 숫자 문자는 true")
    void getNumberValidCheck_singleDigit() {
        assertTrue(EgovNumberUtil.getNumberValidCheck("0"));
    }

    // ── getNumberCnvr ──────────────────────────────────────────

    @Test
    @DisplayName("getNumberCnvr: 숫자 내 특정 부분을 다른 숫자로 치환")
    void getNumberCnvr_basic() {
        assertEquals(99945678, EgovNumberUtil.getNumberCnvr(12345678, 123, 999));
    }

    @Test
    @DisplayName("getNumberCnvr: 치환 대상 없으면 원본 반환")
    void getNumberCnvr_noMatch() {
        assertEquals(12345678, EgovNumberUtil.getNumberCnvr(12345678, 999, 111));
    }

    // ── checkRlnoInteger ───────────────────────────────────────

    @Test
    @DisplayName("checkRlnoInteger: 음수이면 -1 반환")
    void checkRlnoInteger_negative() {
        assertEquals(-1, EgovNumberUtil.checkRlnoInteger(-1.0));
    }

    @Test
    @DisplayName("checkRlnoInteger: double 5.0은 String.valueOf 시 '5.0'이 되어 소수점 포함 → 1 반환")
    void checkRlnoInteger_doubleRepresentation() {
        // String.valueOf(5.0) == "5.0" → indexOf('.') != -1 → 1(실수)
        assertEquals(1, EgovNumberUtil.checkRlnoInteger(5.0));
    }

    @Test
    @DisplayName("checkRlnoInteger: 실수 3.14이면 1 반환")
    void checkRlnoInteger_real() {
        assertEquals(1, EgovNumberUtil.checkRlnoInteger(3.14));
    }
}
