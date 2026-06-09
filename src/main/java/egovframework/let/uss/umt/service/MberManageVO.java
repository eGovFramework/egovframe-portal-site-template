package egovframework.let.uss.umt.service;

import org.egovframe.rte.ptl.reactive.validation.EgovNullCheck;
import org.egovframe.rte.ptl.reactive.validation.EgovEmailCheck;
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
	 */
	@EgovEmailCheck
	private String mberEmailAdres;

}
