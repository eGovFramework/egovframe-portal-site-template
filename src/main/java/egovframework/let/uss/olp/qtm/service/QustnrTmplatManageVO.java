package egovframework.let.uss.olp.qtm.service;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.egovframe.rte.ptl.reactive.validation.EgovNullCheck;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

/**
 * 설문템플릿 VO Class 구현
 * @author 공통서비스 장동한
 * @since 2009.03.20
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  장동한          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Getter
@Setter
public class QustnrTmplatManageVO implements Serializable {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	/** 설문템플릿 아이디 */
	private String qestnrTmplatId = "";

	/** 설문템플릿 유형 */
	@EgovNullCheck
	@Size(max=100)
	private String qestnrTmplatTy = "";

	/** 설문템플 이미지경로 */
	private byte[] qestnrTmplatImagepathnm;

	/** 설문템플릿  설명 */
	@EgovNullCheck
	@Size(max=1000)
	private String qestnrTmplatCn = "";

	/** 서물템플릿경로명 */
	@EgovNullCheck
	@Size(max=100)
	private String qestnrTmplatCours;

	/** 최초등록시점 */
	private String frstRegisterPnttm = "";

	/** 최초등록자아이디 */
	private String frstRegisterId = "";

	/** 최종수정자 시점 */
	private String lastUpdusrPnttm = "";

	/** 최종수정자아이디 */
	private String lastUpdusrId = "";

	/** 화면 명령 처리 */
	private String cmd = "";

	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
    	return ToStringBuilder.reflectionToString(this);
    }

}
