package egovframework.com.cmm.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.EgovWebUtil;

/**
 * 공통유틸리티성 작업을 위한 Controller 클래스
 * @author 공통 서비스 개발팀 JJY
 * @since 2009.03.02
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *  수정일               수정자            수정내용
 *  ----------   --------   ---------------------------
 *  2009.03.02   JJY        최초 생성
 *  2011.08.31   JJY        경량환경 템플릿 커스터마이징버전 생성
 *  2021.02.23   신용호       moveToPage() 화이트리스트 처리
 *  2023.05.30   박형준       moveToPage() 추가 보완 조치
 *  </pre>
 */
@Controller
public class EgovComUtlController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovComUtlController.class);
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "egovPageLinkWhitelist")
    protected List<String> egovWhitelist;
	
	/**
	 * JSP 호출작업만 처리하는 공통 함수
	 */
	@RequestMapping(value="/EgovPageLink.do")
	public String moveToPage(@RequestParam(value="linkIndex",required=true,defaultValue="0") Integer linkIndex, 
			HttpSession session, @RequestParam(value = "menuNo", required = false) String menuNo){
		
		String link = "";
		
		// 화이트 리스트가 비었는지 확인
		if (egovWhitelist == null || egovWhitelist.isEmpty() || egovWhitelist.size() <= linkIndex) {
			
			LOGGER.debug("Page Link WhiteList Error! Please check whitelist!");
			
			link="cmm/error/egovError";
			
			return link;
		}
		
		link = egovWhitelist.get(linkIndex);
		
		link = link.replace(";", "");
		link = link.replace("%", "");
		link = link.replace(".", "");
		
		if(link.indexOf(",")>-1){
		    link=link.substring(0,link.indexOf(","));
		}
		
		// 선택된 메뉴정보를 세션으로 등록한다.
		if (menuNo != null && !menuNo.equals("")) {
			session.setAttribute("menuNo", menuNo);
		}
		
		// 안전한 경로 문자열로 조치
		link = EgovWebUtil.filePathBlackList(link);
		
		return link;
	}

	/**
	 * validation rule dynamic java script
	 */
	@RequestMapping("/validator.do")
	public String validate() {
		return "cmm/validator";
	}

}