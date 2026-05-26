package egovframework.let.uss.sam.ipm.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.EgovMapper;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.uss.sam.ipm.service.IndvdlInfoPolicy;

/**
 * 개인정보보호정책를 처리하는 Mapper 인터페이스
 * @author 공통서비스 장동한
 * @since 2009.07.03
 * @version 2.0
 * @see <pre>
 * &lt;&lt; 개정이력(Modification Information) &gt;&gt;
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.07.03  장동한          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *   2024.11.01  표준프레임워크센터  @EgovMapper 어노테이션 방식으로 전환
 *
 * </pre>
 */
@EgovMapper("onlineIndvdlInfoPolicyMapper")
public interface IndvdlInfoPolicyMapper {

    /**
     * 개인정보보호정책를(을) 목록을 한다.
     * @param searchVO  조회할 정보가 담긴 VO
     * @return List
     * @throws Exception
     */
    List<?> selectIndvdlInfoPolicy(ComDefaultVO searchVO) throws Exception;

    /**
     * 개인정보보호정책를(을) 목록 전체 건수를(을) 조회한다.
     * @param searchVO  조회할 정보가 담긴 VO
     * @return int
     * @throws Exception
     */
    int selectIndvdlInfoPolicyCnt(ComDefaultVO searchVO) throws Exception;

    /**
     * 개인정보보호정책를(을) 상세조회 한다.
     * @param indvdlInfoPolicy  개인정보보호정책 정보가 담김 VO
     * @return IndvdlInfoPolicy
     * @throws Exception
     */
    IndvdlInfoPolicy selectIndvdlInfoPolicyDetail(IndvdlInfoPolicy indvdlInfoPolicy) throws Exception;

    /**
     * 개인정보보호정책를(을) 등록한다.
     * @param indvdlInfoPolicy  개인정보보호정책 정보가 담김 VO
     * @throws Exception
     */
    void insertIndvdlInfoPolicy(IndvdlInfoPolicy indvdlInfoPolicy) throws Exception;

    /**
     * 개인정보보호정책를(을) 수정한다.
     * @param indvdlInfoPolicy  개인정보보호정책 정보가 담김 VO
     * @throws Exception
     */
    void updateIndvdlInfoPolicy(IndvdlInfoPolicy indvdlInfoPolicy) throws Exception;

    /**
     * 개인정보보호정책를(을) 삭제한다.
     * @param indvdlInfoPolicy  개인정보보호정책 정보가 담김 VO
     * @throws Exception
     */
    void deleteIndvdlInfoPolicy(IndvdlInfoPolicy indvdlInfoPolicy) throws Exception;

}
