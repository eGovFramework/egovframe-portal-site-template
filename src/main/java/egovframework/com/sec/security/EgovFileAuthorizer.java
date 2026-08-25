package egovframework.com.sec.security;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.springframework.stereotype.Component;

import egovframework.com.cmm.LoginVO;
import egovframework.let.cop.bbs.service.impl.BBSManageDAO;
import egovframework.let.uss.olh.faq.service.impl.FaqManageDAO;
import jakarta.annotation.Resource;

/**
 * 첨부파일 업무 객체 접근 권한 검증
 */
@Component("egovFileAuth")
public class EgovFileAuthorizer {

	@Resource(name = "BBSManageDAO")
	private BBSManageDAO bbsManageDAO;

	@Resource(name = "FaqManageDAO")
	private FaqManageDAO faqManageDAO;

	public boolean isAdmin() {
		return EgovUserDetailsHelper.getAuthorities() != null
				&& EgovUserDetailsHelper.getAuthorities().contains("ROLE_ADMIN");
	}

	public boolean isAuthenticated() {
		return EgovUserDetailsHelper.isAuthenticated();
	}

	public boolean canAccess(String atchFileId) throws Exception {
		if (!isAuthenticated()) {
			return false;
		}
		if (isAdmin()) {
			return true;
		}
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if (user == null || user.getUniqId() == null) {
			return false;
		}
		int bbsOwnerCount = bbsManageDAO.countArticleByAtchFileIdAndOwner(atchFileId, user.getUniqId());
		if (bbsOwnerCount > 0) {
			return true;
		}
		int faqLinkedCount = faqManageDAO.countFaqByAtchFileId(atchFileId);
		if (faqLinkedCount > 0) {
			return false;
		}
		int bbsLinkedCount = bbsManageDAO.countArticleByAtchFileId(atchFileId);
		return bbsLinkedCount == 0;
	}
}
