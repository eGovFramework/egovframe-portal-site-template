package egovframework.let.uss.umt.service;

import jakarta.validation.constraints.Email;
import org.egovframe.rte.ptl.reactive.validation.EgovNullCheck;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

/**
 * 일반회원VO클래스로서 일반회원관리 비지니스로직 처리용 항목을 구성한다.
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.10  JJY            최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Getter
@Setter
public class MberManageVO extends UserDefaultVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	/** 이전비밀번호 - 비밀번호 변경시 사용*/
    private String oldPassword = "";

    /**
	 * 사용자고유아이디
	 */
	private String uniqId = "";

	/**
	 * 사용자 유형
	 */
	private String userTy;

	/**
	 * 주소
	 */
	@Size(max=100)
	private String adres;

	/**
	 * 상세주소
	 */
	private String detailAdres;

	/**
	 * 끝전화번호
	 */
	private String endTelno;

	/**
	 * 팩스번호
	 */
	@Size(max=15)
	private String mberFxnum;

	/**
	 * 그룹 ID
	 */
	@EgovNullCheck
	private String groupId;

	/**
	 * 주민등록번호
	 */
	private String ihidnum;

	/**
	 * 성별코드
	 */
	private String sexdstnCode;

	/**
	 * 회원 ID
	 */
	@EgovNullCheck
	@Size(max=20)
	private String mberId;

	/**
	 * 회원명
	 */
	@EgovNullCheck
	@Size(max=50)
	private String mberNm;

	/**
	 * 회원상태
	 */
	@EgovNullCheck
	private String mberSttus;

	/**
	 * 지역번호
	 */
	@Size(max=4)
	private String areaNo;

	/**
	 * 중간전화번호
	 */
	@Size(max=4)
	private String middleTelno;

	/**
	 * 핸드폰번호
	 */
	@Size(max=15)
	private String moblphonNo;

	/**
	 * 비밀번호
	 */
	private String password;

	/**
	 * 비밀번호 정답
	 */
	@EgovNullCheck
	@Size(max=100)
	private String passwordCnsr;

	/**
	 * 비밀번호 힌트
	 */
	@EgovNullCheck
	private String passwordHint;

	/**
	 * 가입 일자
	 */
	private String sbscrbDe;

	/**
	 * 우편번호
	 */
	private String zip;

	/**
	 * 이메일주소
	 */	// 26.08.20 조치 : EgovEmailCheck 는 빈 값을 형식오류로 거부한다.
	// 가입폼·수정폼 어디에도 이메일은 필수 표시가 없는데 서버만 필수처럼 동작해,
	// 이메일이 비어 있는 회원(시드의 admin·user1 포함)은 수정 자체가 불가했다.
	// jakarta 의 @Email 은 null·빈 문자열을 유효로 보므로 형식 검증은 유지하면서 선택 항목이 된다.
	// 26.08.24 조치 : 이 필드만 @Size 가 없어 51자 이상 입력 시 필드 오류가 아니라
	// DB 에서 실패했다(MBER_EMAIL_ADRES varchar(50) → Data too long / ORA-12899 → 500)
	@Email
	@Size(max=50)
	private String mberEmailAdres;

}
