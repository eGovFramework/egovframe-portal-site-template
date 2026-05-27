package egovframework.let.sec.ram.service;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

/**
 * 권한관리에 대한 Vo 클래스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이문준          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성 
 *
 * </pre>
 */

@Getter
@Setter
public class AuthorManageVO extends AuthorManage {

	private static final long serialVersionUID = 1L;

	/** 권한관리 목록 */
	private List<AuthorManageVO> authorManageList;

}