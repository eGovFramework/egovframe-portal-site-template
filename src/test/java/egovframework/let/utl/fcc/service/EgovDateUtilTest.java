package egovframework.let.utl.fcc.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/**
 * EgovDateUtil 단위 테스트
 *
 * @author 공통서비스 개발팀
 * @since 2024-01-01
 */
class EgovDateUtilTest {

    // -------------------------------------------------------------------------
    // addYearMonthDay
    // -------------------------------------------------------------------------

    @Test
    @DisplayName("addYearMonthDay: 일 증가 - 월 경계 넘김")
    void addYearMonthDay_dayOverMonthBoundary() {
        assertEquals("19810916", EgovDateUtil.addYearMonthDay("19810828", 0, 0, 19));
    }

    @Test
    @DisplayName("addYearMonthDay: 일 감소")
    void addYearMonthDay_dayDecrease() {
        assertEquals("20060218", EgovDateUtil.addYearMonthDay("20060228", 0, 0, -10));
    }

    @Test
    @DisplayName("addYearMonthDay: 일 증가 - 3월로 넘어감")
    void addYearMonthDay_dayIncreaseToMarch() {
        assertEquals("20060310", EgovDateUtil.addYearMonthDay("20060228", 0, 0, 10));
    }

    @Test
    @DisplayName("addYearMonthDay: 월 감소 - 2월 말일 처리")
    void addYearMonthDay_monthDecreaseFebruaryEdge() {
        assertEquals("20050228", EgovDateUtil.addYearMonthDay("20050331", 0, -1, 0));
    }

    @Test
    @DisplayName("addYearMonthDay: 연도 증가 - 윤년 2월 29일")
    void addYearMonthDay_yearIncreaseFromLeapDay() {
        // 2004-02-29에서 2년 추가 → 2006-02-28(비윤년이므로 말일로)
        assertEquals("20060228", EgovDateUtil.addYearMonthDay("20040229", 2, 0, 0));
    }

    @Test
    @DisplayName("addYearMonthDay: yyyy-MM-dd 형식 입력 허용")
    void addYearMonthDay_hyphenFormat() {
        assertEquals("20060310", EgovDateUtil.addYearMonthDay("2006-02-28", 0, 0, 10));
    }

    @Test
    @DisplayName("addYearMonthDay: null 입력 시 예외")
    void addYearMonthDay_nullInput() {
        assertThrows(IllegalArgumentException.class,
                () -> EgovDateUtil.addYearMonthDay(null, 0, 0, 1));
    }

    @Test
    @DisplayName("addYearMonthDay: 잘못된 형식 입력 시 예외")
    void addYearMonthDay_invalidFormat() {
        assertThrows(IllegalArgumentException.class,
                () -> EgovDateUtil.addYearMonthDay("2006228", 0, 0, 1));
    }

    // -------------------------------------------------------------------------
    // addYear / addMonth / addDay
    // -------------------------------------------------------------------------

    @Test
    @DisplayName("addYear: 연도 증가")
    void addYear_increase() {
        assertEquals("20620201", EgovDateUtil.addYear("20000201", 62));
    }

    @Test
    @DisplayName("addYear: 연도 감소")
    void addYear_decrease() {
        assertEquals("20000201", EgovDateUtil.addYear("20620201", -62));
    }

    @Test
    @DisplayName("addYear: 윤년 2월 29일에서 비윤년으로")
    void addYear_leapDayToNonLeap() {
        assertEquals("20060228", EgovDateUtil.addYear("20040229", 2));
    }

    @Test
    @DisplayName("addMonth: 12개월 증가 - 년 넘김")
    void addMonth_increaseAcrossYear() {
        assertEquals("20020201", EgovDateUtil.addMonth("20010201", 12));
    }

    @Test
    @DisplayName("addMonth: 월 말일 처리 - 1월 31일 + 1개월 → 2월 28일")
    void addMonth_endOfMonthFebruary() {
        assertEquals("20060228", EgovDateUtil.addMonth("20060131", 1));
    }

    @Test
    @DisplayName("addDay: 일 증가 - 년 경계 넘김")
    void addDay_increaseAcrossYear() {
        assertEquals("20000201", EgovDateUtil.addDay("19991201", 62));
    }

    @Test
    @DisplayName("addDay: 일 감소")
    void addDay_decrease() {
        assertEquals("19991201", EgovDateUtil.addDay("20000201", -62));
    }

    // -------------------------------------------------------------------------
    // getDaysDiff
    // -------------------------------------------------------------------------

    @Test
    @DisplayName("getDaysDiff: 양수 차이")
    void getDaysDiff_positive() {
        assertEquals(10, EgovDateUtil.getDaysDiff("20060228", "20060310"));
    }

    @Test
    @DisplayName("getDaysDiff: 1년 차이 - 평년")
    void getDaysDiff_oneYear() {
        assertEquals(365, EgovDateUtil.getDaysDiff("20060101", "20070101"));
    }

    @Test
    @DisplayName("getDaysDiff: 음수 차이 - 과거 날짜")
    void getDaysDiff_negative() {
        assertEquals(-28, EgovDateUtil.getDaysDiff("19990228", "19990131"));
    }

    @Test
    @DisplayName("getDaysDiff: 동일 날짜 → 0")
    void getDaysDiff_sameDate() {
        assertEquals(0, EgovDateUtil.getDaysDiff("20060801", "20060801"));
    }

    @Test
    @DisplayName("getDaysDiff: 1일 차이")
    void getDaysDiff_oneDay() {
        assertEquals(1, EgovDateUtil.getDaysDiff("20060801", "20060802"));
    }

    // -------------------------------------------------------------------------
    // checkDate
    // -------------------------------------------------------------------------

    @Test
    @DisplayName("checkDate: 유효한 날짜 - yyyyMMdd")
    void checkDate_validCompact() {
        assertTrue(EgovDateUtil.checkDate("20060228"));
    }

    @Test
    @DisplayName("checkDate: 유효한 날짜 - yyyy-MM-dd")
    void checkDate_validHyphen() {
        assertTrue(EgovDateUtil.checkDate("2006-02-28"));
    }

    @Test
    @DisplayName("checkDate: 존재하지 않는 날 - 11월 31일")
    void checkDate_invalidDay() {
        assertFalse(EgovDateUtil.checkDate("2006-11-31"));
    }

    @Test
    @DisplayName("checkDate: 존재하지 않는 월 - 13월")
    void checkDate_invalidMonth() {
        assertFalse(EgovDateUtil.checkDate("2000-13-31"));
    }

    @Test
    @DisplayName("checkDate: 윤년이 아닌 해의 2월 29일")
    void checkDate_feb29NonLeapYear() {
        assertFalse(EgovDateUtil.checkDate("2006-02-29"));
    }

    @Test
    @DisplayName("checkDate: 윤년의 2월 29일")
    void checkDate_feb29LeapYear() {
        assertTrue(EgovDateUtil.checkDate("20040229"));
    }

    // -------------------------------------------------------------------------
    // isLeapYear (주의: 메서드 반환값이 반전됨 - 윤년이면 false)
    // -------------------------------------------------------------------------

    @Test
    @DisplayName("isLeapYear: 4의 배수이고 100의 배수가 아닌 해 - 윤년(false 반환)")
    void isLeapYear_divisibleBy4NotBy100() {
        // 구현상 윤년이면 false를 반환하는 로직
        assertFalse(EgovDateUtil.isLeapYear(2004));
    }

    @Test
    @DisplayName("isLeapYear: 400의 배수인 해 - 윤년(false 반환)")
    void isLeapYear_divisibleBy400() {
        assertFalse(EgovDateUtil.isLeapYear(2000));
    }

    @Test
    @DisplayName("isLeapYear: 100의 배수이지만 400의 배수가 아닌 해 - 평년(true 반환)")
    void isLeapYear_divisibleBy100NotBy400() {
        assertTrue(EgovDateUtil.isLeapYear(1900));
    }

    @Test
    @DisplayName("isLeapYear: 4의 배수가 아닌 해 - 평년(true 반환)")
    void isLeapYear_notDivisibleBy4() {
        assertTrue(EgovDateUtil.isLeapYear(2005));
    }

    // -------------------------------------------------------------------------
    // formatDate
    // -------------------------------------------------------------------------

    @Test
    @DisplayName("formatDate: yyyyMMdd를 구분자 dot으로 변환")
    void formatDate_dot() {
        assertEquals("2003.04.05", EgovDateUtil.formatDate("20030405", "."));
    }

    @Test
    @DisplayName("formatDate: yyyyMMdd를 구분자 slash로 변환")
    void formatDate_slash() {
        assertEquals("2004/01/01", EgovDateUtil.formatDate("20040101", "/"));
    }

    @Test
    @DisplayName("formatDate: 월 부분이 00인 경우 연도만 반환")
    void formatDate_monthZero() {
        assertEquals("2003", EgovDateUtil.formatDate("20030000", "."));
    }

    @Test
    @DisplayName("formatDate: 일 부분이 00인 경우 연월만 반환")
    void formatDate_dayZero() {
        assertEquals("2003.04", EgovDateUtil.formatDate("20030400", "."));
    }

    // -------------------------------------------------------------------------
    // convertWeek
    // -------------------------------------------------------------------------

    @Test
    @DisplayName("convertWeek: MON → 월요일")
    void convertWeek_monday() {
        assertEquals("월요일", EgovDateUtil.convertWeek("MON"));
    }

    @Test
    @DisplayName("convertWeek: SUN → 일요일")
    void convertWeek_sunday() {
        assertEquals("일요일", EgovDateUtil.convertWeek("SUN"));
    }

    @Test
    @DisplayName("convertWeek: SAT → 토요일")
    void convertWeek_saturday() {
        assertEquals("토요일", EgovDateUtil.convertWeek("SAT"));
    }

}
