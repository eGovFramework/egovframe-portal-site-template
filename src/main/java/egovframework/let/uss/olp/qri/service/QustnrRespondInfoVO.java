package egovframework.let.uss.olp.qri.service;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.egovframe.rte.ptl.reactive.validation.EgovNullCheck;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

/**
 * 설문조사 VO Class 구현
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
public class QustnrRespondInfoVO implements Serializable {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	/** 설문응답ID */
	private String qestnrQesrspnsId = "";

	/** 설문문항ID */
	private String qestnrQesitmId = "";

	/** 설문ID */
	private String qestnrId = "";

	/** 설문템플릿ID */
	private String qestnrTmplatId = "";

	/** 설문항목ID */
	private String qustnrIemId = "";

	/** 응답자답변내용 */
	@Size(max=1000)
	private String respondAnswerCn = "";

	/** 응답자명 */
	@EgovNullCheck
	@Size(max=50)
	private String respondNm = "";

	/** 기타답변내용 */
	@Size(max=1000)
	private String etcAnswerCn = "";

	/** 최초등록시점 */
	private String frstRegisterPnttm = "";

	/** 최등등록시점ID */
	private String frstRegisterId = "";

	/** 최종수정시점 */
	private String lastUpdusrPnttm = "";

	/** 최종수정시점ID */
	private String lastUpdusrId = "";

	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
    	return ToStringBuilder.reflectionToString(this);
    }

}
