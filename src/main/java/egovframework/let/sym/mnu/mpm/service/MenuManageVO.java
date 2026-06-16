package egovframework.let.sym.mnu.mpm.service;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.egovframe.rte.ptl.reactive.validation.EgovNullCheck;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

/**
 * 메뉴목록관리 처리를 위한 VO 클래스르를 정의한다
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Getter
@Setter
public class MenuManageVO{

   /** 메뉴정보 */
   /** 메뉴번호 */
   @NotNull
   private   int      menuNo;
   /** 메뉴순서 */
   @NotNull
   private   int      menuOrdr;
   /** 메뉴명 */
   @EgovNullCheck
   @Size(max=50)
   private   String   menuNm;
   /** 상위메뉴번호 */
   @NotNull
   private   int      upperMenuId;
   /** 메뉴설명 */
   @Size(max=100)
   private   String   menuDc;
   /** 관련이미지경로 */
   @Size(max=100)
   private   String   relateImagePath;
   /** 관련이미지명 */
   @Size(max=50)
   private   String   relateImageNm;
   /** 프로그램파일명 */
   @EgovNullCheck
   @Size(max=50)
   private   String   progrmFileNm;

   /** 사이트맵 */
   /** 생성자ID **/
   private   String   creatPersonId;

   /** 권한정보설정 */
   /** 권한코드 */
   private   String   authorCode;

   /** 기타VO변수 */
   private   String   tempValue;
   private   int      tempInt;


   /** Login 메뉴관련 VO변수 */
   /** tmp_Id */
   private   String   tmp_Id;
   /** tmp_Password */
   private   String   tmp_Password;
   /** tmp_Name */
   private   String   tmp_Name;
   /** tmp_UserSe */
   private   String   tmp_UserSe;
   /** tmp_Email */
   private   String   tmp_Email;
   /** tmp_OrgnztId */
   private   String   tmp_OrgnztId;
   /** tmp_UniqId */
   private   String   tmp_UniqId;
   /** tmp_Cmd */
   private   String   tmp_Cmd;

	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
    	return ToStringBuilder.reflectionToString(this);
    }
}
