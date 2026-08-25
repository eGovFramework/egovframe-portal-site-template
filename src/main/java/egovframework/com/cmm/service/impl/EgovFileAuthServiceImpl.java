package egovframework.com.cmm.service.impl;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import egovframework.com.sec.security.EgovFileAuthorizer;
import javax.annotation.Resource;

/**
 * 첨부파일 업무 객체 접근 권한 검증
 */
@Service("EgovFileAuthService")
public class EgovFileAuthServiceImpl {

	@Resource(name = "egovFileAuth")
	private EgovFileAuthorizer fileAuthorizer;

	public void assertFileAccess(String atchFileId) throws Exception {
		if (!fileAuthorizer.canAccess(atchFileId)) {
			throw new AccessDeniedException("파일 접근 권한이 없습니다.");
		}
	}
}
