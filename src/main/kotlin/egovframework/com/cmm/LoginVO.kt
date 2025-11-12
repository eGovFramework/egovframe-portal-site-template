package egovframework.com.cmm

import java.io.Serializable

/**
 * @Class Name : LoginVO.kt
 * @Description : Login VO class
 * @Modification Information
 * @
 * @  수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.03.03    박지욱          최초 생성
 * @ 2024.11.11    Claude          Kotlin으로 변환
 *
 *  @author 공통서비스 개발팀 박지욱
 *  @since 2009.03.03
 *  @version 1.0
 *  @see
 *
 */
data class LoginVO(
    /** 아이디 */
    var id: String = "",

    /** 이름 */
    var name: String = "",

    /** 주민등록번호 */
    var ihidNum: String = "",

    /** 이메일주소 */
    var email: String = "",

    /** 비밀번호 */
    var password: String = "",

    /** 비밀번호 힌트 */
    var passwordHint: String = "",

    /** 비밀번호 정답 */
    var passwordCnsr: String = "",

    /** 사용자구분 */
    var userSe: String = "",

    /** 조직(부서)ID */
    var orgnztId: String = "",

    /** 조직(부서)명 */
    var orgnztNm: String = "",

    /** 고유아이디 */
    var uniqId: String = "",

    /** 로그인 후 이동할 페이지 */
    var url: String = "",

    /** 사용자 IP정보 */
    var ip: String = "",

    /** GPKI인증 DN */
    var dn: String = ""

) : Serializable {
    companion object {
        private const val serialVersionUID = -8274004534207618049L
    }
}