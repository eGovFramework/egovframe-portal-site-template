package egovframework.let.utl.fcc.service;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * EgovStringUtil 단위 테스트
 */
class EgovStringUtilTest {

    // ── isEmpty ────────────────────────────────────────────────

    @Test
    @DisplayName("isEmpty: null 입력 시 true 반환")
    void isEmpty_null() {
        assertTrue(EgovStringUtil.isEmpty(null));
    }

    @Test
    @DisplayName("isEmpty: 빈 문자열 시 true 반환")
    void isEmpty_emptyString() {
        assertTrue(EgovStringUtil.isEmpty(""));
    }

    @Test
    @DisplayName("isEmpty: 공백 문자열은 false 반환")
    void isEmpty_whitespace() {
        assertFalse(EgovStringUtil.isEmpty(" "));
    }

    @Test
    @DisplayName("isEmpty: 일반 문자열은 false 반환")
    void isEmpty_normalString() {
        assertFalse(EgovStringUtil.isEmpty("hello"));
    }

    // ── cutString ──────────────────────────────────────────────

    @Test
    @DisplayName("cutString(source, output, slength): 길이 초과 시 잘라서 suffix 추가")
    void cutString_withSuffix_exceedsLength() {
        assertEquals("hello...", EgovStringUtil.cutString("hello world", "...", 5));
    }

    @Test
    @DisplayName("cutString(source, output, slength): 길이 이하 시 원본 반환")
    void cutString_withSuffix_withinLength() {
        assertEquals("hi", EgovStringUtil.cutString("hi", "...", 10));
    }

    @Test
    @DisplayName("cutString(source, slength): 길이 초과 시 잘라냄")
    void cutString_noSuffix_exceedsLength() {
        assertEquals("hello", EgovStringUtil.cutString("hello world", 5));
    }

    @Test
    @DisplayName("cutString: null 입력 시 null 반환")
    void cutString_null() {
        assertNull(EgovStringUtil.cutString(null, "...", 5));
    }

    // ── remove / removeCommaChar / removeMinusChar ──────────────

    @Test
    @DisplayName("remove: 지정 문자 제거")
    void remove_char() {
        assertEquals("qeed", EgovStringUtil.remove("queued", 'u'));
    }

    @Test
    @DisplayName("removeCommaChar: 콤마 제거")
    void removeCommaChar() {
        assertEquals("asdfgqweqe", EgovStringUtil.removeCommaChar("asdfg,qweqe"));
    }

    @Test
    @DisplayName("removeMinusChar: 마이너스 제거")
    void removeMinusChar() {
        assertEquals("asdfgqweqe", EgovStringUtil.removeMinusChar("a-sdfg-qweqe"));
    }

    // ── replace ────────────────────────────────────────────────

    @Test
    @DisplayName("replace: 모든 대상 문자열 치환")
    void replace_allOccurrences() {
        assertEquals("a_b_c", EgovStringUtil.replace("a-b-c", "-", "_"));
    }

    @Test
    @DisplayName("replaceOnce: 첫 번째 발생만 치환")
    void replaceOnce_firstOnly() {
        assertEquals("a_b-c", EgovStringUtil.replaceOnce("a-b-c", "-", "_"));
    }

    // ── lowerCase / upperCase ──────────────────────────────────

    @Test
    @DisplayName("lowerCase: 소문자 변환")
    void lowerCase() {
        assertEquals("abc", EgovStringUtil.lowerCase("aBc"));
    }

    @Test
    @DisplayName("lowerCase: null 입력 시 null 반환")
    void lowerCase_null() {
        assertNull(EgovStringUtil.lowerCase(null));
    }

    @Test
    @DisplayName("upperCase: 대문자 변환")
    void upperCase() {
        assertEquals("ABC", EgovStringUtil.upperCase("aBc"));
    }

    // ── indexOf ────────────────────────────────────────────────

    @Test
    @DisplayName("indexOf: 일치 시 위치 반환")
    void indexOf_found() {
        assertEquals(2, EgovStringUtil.indexOf("aabaabaa", "b"));
    }

    @Test
    @DisplayName("indexOf: null 입력 시 -1 반환")
    void indexOf_null() {
        assertEquals(-1, EgovStringUtil.indexOf(null, "b"));
        assertEquals(-1, EgovStringUtil.indexOf("abc", null));
    }

    // ── decode ─────────────────────────────────────────────────

    @Test
    @DisplayName("decode(4인자): sourceStr == compareStr 이면 returnStr 반환")
    void decode_match() {
        assertEquals("foo", EgovStringUtil.decode("하이", "하이", "foo", "bar"));
    }

    @Test
    @DisplayName("decode(4인자): 불일치 시 defaultStr 반환")
    void decode_noMatch() {
        assertEquals("bar", EgovStringUtil.decode("하이", "바이", "foo", "bar"));
    }

    @Test
    @DisplayName("decode(4인자): 양쪽 모두 null 이면 returnStr 반환")
    void decode_bothNull() {
        assertEquals("foo", EgovStringUtil.decode(null, null, "foo", "bar"));
    }

    // ── isNullToString / nullConvert ───────────────────────────

    @Test
    @DisplayName("isNullToString: null 이면 빈 문자열 반환")
    void isNullToString_null() {
        assertEquals("", EgovStringUtil.isNullToString(null));
    }

    @Test
    @DisplayName("isNullToString: 비null 이면 trim된 문자열 반환")
    void isNullToString_nonNull() {
        assertEquals("hello", EgovStringUtil.isNullToString("  hello  "));
    }

    // ── removeWhitespace ───────────────────────────────────────

    @Test
    @DisplayName("removeWhitespace: 모든 공백 제거")
    void removeWhitespace() {
        assertEquals("abc", EgovStringUtil.removeWhitespace("   ab  c  "));
    }

    @Test
    @DisplayName("removeWhitespace: 공백 없는 문자열은 그대로 반환")
    void removeWhitespace_noChange() {
        assertEquals("abc", EgovStringUtil.removeWhitespace("abc"));
    }

    // ── addMinusChar ───────────────────────────────────────────

    @Test
    @DisplayName("addMinusChar: 8자리 날짜에 하이픈 추가")
    void addMinusChar_valid() {
        assertEquals("2010-09-01", EgovStringUtil.addMinusChar("20100901"));
    }

    @Test
    @DisplayName("addMinusChar: 8자리 아닌 경우 빈 문자열 반환")
    void addMinusChar_invalid() {
        assertEquals("", EgovStringUtil.addMinusChar("2010090"));
    }

    // ── getSpclStrCnvr ─────────────────────────────────────────

    @Test
    @DisplayName("getSpclStrCnvr: < > & 특수문자 HTML 엔티티 변환")
    void getSpclStrCnvr() {
        assertEquals("&lt;br&gt;&amp;", EgovStringUtil.getSpclStrCnvr("<br>&"));
    }

    // ── getHtmlStrCnvr ─────────────────────────────────────────

    @Test
    @DisplayName("getHtmlStrCnvr: HTML 엔티티를 원래 문자로 복원")
    void getHtmlStrCnvr() {
        assertEquals("<br>&", EgovStringUtil.getHtmlStrCnvr("&lt;br&gt;&amp;"));
    }

    // ── split ──────────────────────────────────────────────────

    @Test
    @DisplayName("split: 분리자로 배열 분리")
    void split_basic() {
        String[] parts = EgovStringUtil.split("a,b,c", ",");
        assertArrayEquals(new String[]{"a", "b", "c"}, parts);
    }

    @Test
    @DisplayName("split(3인자): 지정 길이 배열로 분리")
    void split_withLength() {
        String[] parts = EgovStringUtil.split("a,b,c", ",", 2);
        assertEquals("a", parts[0]);
        assertEquals("b,c", parts[1]);
    }

    // ── stripStart / stripEnd / strip ──────────────────────────

    @Test
    @DisplayName("stripStart: 앞쪽 지정 문자 제거")
    void stripStart() {
        assertEquals("abc  ", EgovStringUtil.stripStart("yxabc  ", "xyz"));
    }

    @Test
    @DisplayName("stripEnd: 뒤쪽 지정 문자 제거")
    void stripEnd() {
        assertEquals("  abc", EgovStringUtil.stripEnd("  abcyx", "xyz"));
    }

    @Test
    @DisplayName("strip: 양쪽 지정 문자 제거")
    void strip() {
        assertEquals("  abc", EgovStringUtil.strip("  abcyx", "xyz"));
    }
}
