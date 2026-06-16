package egovframework.let.uss.olh.faq.service;

import org.egovframe.rte.ptl.reactive.validation.EgovNullCheck;

import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

/**
 *
 * FAQ를 처리하는 VO 클래스
 * @author 공통서비스 개발팀 박정규
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  박정규          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Getter
@Setter
public class FaqManageVO extends FaqManageDefaultVO {

    private static final long serialVersionUID = 1L;

    /** FAQ ID */
    private String faqId;

    /** 질문제목 */
    @EgovNullCheck
    @Size(max=1000)
    private String qestnSj;

    /** 질문내용 */
    @EgovNullCheck
    @Size(max=2500)
    private String qestnCn;

    /** 답변내용 */
    @EgovNullCheck
    @Size(max=2500)
    private String answerCn;

    /** 조회횟수 */
    private String inqireCo;

    /** 첨부파일ID */
    private String atchFileId;

    /** 최초등록시점 */
    private String frstRegisterPnttm;

    /** 최초등록자ID */
    private String frstRegisterId;

    /** 최종수정시점 */
    private String lastUpdusrPnttm;

    /** 최종수정자ID */
    private String lastUpdusrId;

}
