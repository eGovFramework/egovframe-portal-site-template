package egovframework.com.cmm

import org.apache.commons.lang3.builder.ToStringBuilder
import java.io.Serializable

/**
 * @Class Name : ComDefaultVO.kt
 * @Description : ComDefaultVO class
 * @Modification Information
 * @
 * @  수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.02.01    조재영         최초 생성
 * @ 2024.11.11    Claude         Kotlin으로 변환
 *
 *  @author 공통서비스 개발팀 조재영
 *  @since 2009.02.01
 *  @version 1.0
 *  @see
 *
 */
open class ComDefaultVO : Serializable {

    companion object {
        private const val serialVersionUID = -6062858939907510631L
    }

    /** 검색조건 */
    var searchCondition: String = ""

    /** 검색Keyword */
    var searchKeyword: String = ""

    /** 검색사용여부 */
    var searchUseYn: String = ""

    /** 현재페이지 */
    var pageIndex: Int = 1

    /** 페이지갯수 */
    var pageUnit: Int = 10

    /** 페이지사이즈 */
    var pageSize: Int = 10

    /** firstIndex */
    var firstIndex: Int = 1

    /** lastIndex */
    var lastIndex: Int = 1

    /** recordCountPerPage */
    var recordCountPerPage: Int = 10

    /** 검색KeywordFrom */
    var searchKeywordFrom: String = ""

    /** 검색KeywordTo */
    var searchKeywordTo: String = ""

    override fun toString(): String {
        return ToStringBuilder.reflectionToString(this)
    }
}