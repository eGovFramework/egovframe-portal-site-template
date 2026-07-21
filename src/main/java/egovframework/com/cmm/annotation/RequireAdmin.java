package egovframework.com.cmm.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 관리자(ROLE_ADMIN) 권한이 필요한 컨트롤러 메소드에 사용하는 애노테이션.
 * egov-com-adminaop.xml에 설정된 AOP(egov.adminAuthorizationAspect)가
 * 이 애노테이션이 붙은 메소드 실행 전에 로그인 여부와 ROLE_ADMIN 권한 여부를 검증한다.
 *
 * Spring Security의 URL 패턴 기반 접근통제(sqlRolesAndUrl 등)만으로는
 * 같은 프리픽스를 공유하는 공개 기능과 관리 기능을 구분하지 못하므로,
 * 컨트롤러 메소드 단위의 방어를 추가하기 위한 용도이다.
 *
 * @see egovframework.com.cmm.util.EgovAdminAuthorizationAspect
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface RequireAdmin {
}
