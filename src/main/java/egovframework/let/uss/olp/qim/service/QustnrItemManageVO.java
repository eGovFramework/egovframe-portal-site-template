package egovframework.let.uss.olp.qim.service;

import java.io.Serializable;

import org.egovframe.rte.ptl.reactive.validation.EgovNullCheck;

import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

/**
 * 설문항목관리 VO Class 구현
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
public class QustnrItemManageVO implements Serializable {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	/** 설문문항 아이디 */
	private String qestnrQesitmId = "";

	/** 설문지 아이디 */
	private String qestnrId = "";

	/** 항목순번 */
	@EgovNullCheck
	@Size(max=5)
	@Pattern(regexp = "^[0-9]*$", message = "{validation.integer.check}")
	private String iemSn = "";

	/** 항목내용 */
	private String qustnrIemId = "";

	/** 설문항목아이디 */
	@EgovNullCheck
	@Size(max=1000)
	private String iemCn = "";

	/** 키타답변여부 */
	private String etcAnswerAt = "";

	/** 설문항목(을)를 아이디 */
	private String qestnrTmplatId = "";

	/** 최초등록시점  */
	private String frstRegisterPnttm = "";

	/** 최초등록아이디 */
	private String frstRegisterId = "";

	/** 최종수정일 */
	private String lastUpdusrPnttm = "";

	/** 최종수정자 아이디 */
	private String lastUpdusrId = "";

	/** 컨트롤 명령어 */
	private String cmd = "";

}
