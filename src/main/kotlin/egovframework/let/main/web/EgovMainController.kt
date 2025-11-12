package egovframework.let.main.web

import egovframework.com.cmm.ComDefaultVO
import egovframework.com.cmm.LoginVO
import egovframework.let.cop.bbs.service.BoardVO
import egovframework.let.cop.bbs.service.EgovBBSManageService
import egovframework.let.sym.mnu.mpm.service.EgovMenuManageService
import egovframework.let.sym.mnu.mpm.service.MenuManageVO
import egovframework.let.uss.olh.faq.service.EgovFaqManageService
import egovframework.let.uss.olh.faq.service.FaqManageDefaultVO
import egovframework.let.uss.olp.qri.service.EgovQustnrRespondInfoService
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo
import org.springframework.stereotype.Controller
import org.springframework.ui.ModelMap
import org.springframework.web.bind.annotation.*
import javax.annotation.Resource
import javax.servlet.http.HttpServletRequest

/**
 * 템플릿 메인 페이지 컨트롤러 클래스(Sample 소스)
 * @author 실행환경 개발팀 JJY
 * @since 2011.08.31
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *  수정일              수정자           수정내용
 *  ----------  --------   ---------------------------
 *  2011.08.31  JJY        최초 생성
 *  2021.08.12  신용호            추가 URL 생성
 *  2024.11.11  Claude      Kotlin으로 변환
 *
 * </pre>
 */
@Controller
@SessionAttributes(types = [ComDefaultVO::class])
class EgovMainController {

    /**
     * EgovBBSManageService
     */
    @Resource(name = "EgovBBSManageService")
    private lateinit var bbsMngService: EgovBBSManageService

    /** EgovMenuManageService */
    @Resource(name = "meunManageService")
    private lateinit var menuManageService: EgovMenuManageService

    /** FaqManageService */
    @Resource(name = "FaqManageService")
    private lateinit var faqManageService: EgovFaqManageService

    /** egovQustnrRespondInfoService */
    @Resource(name = "egovQustnrRespondInfoService")
    private lateinit var egovQustnrRespondInfoService: EgovQustnrRespondInfoService

    /**
     * 메인 페이지에서 각 업무 화면으로 연계하는 기능을 제공한다.
     *
     * @param request
     * @param commandMap
     * @exception Exception Exception
     */
    @RequestMapping(value = ["/cmm/forwardPage.do"])
    fun forwardPageWithMenuNo(
        request: HttpServletRequest,
        @RequestParam commandMap: Map<String, Any>
    ): String {
        return ""
    }

    /**
     * 템플릿 메인 페이지 조회
     * @return 메인페이지 정보 Map [key : 항목명]
     *
     * @param request
     * @param model
     * @exception Exception Exception
     */
    @RequestMapping(value = ["/cmm/main/mainPage.do"])
    fun getMgtMainPage(request: HttpServletRequest, model: ModelMap): String {

        // 공지사항 메인 컨텐츠 조회 시작 ---------------------------------
        val boardVO = BoardVO().apply {
            useAt = "Y"
            pageUnit = 5
            pageSize = 10
            bbsId = "BBSMSTR_AAAAAAAAAAAA"
        }

        val paginationInfo = PaginationInfo().apply {
            currentPageNo = boardVO.pageIndex
            recordCountPerPage = boardVO.pageUnit
            pageSize = boardVO.pageSize
        }

        boardVO.apply {
            firstIndex = paginationInfo.firstRecordIndex
            lastIndex = paginationInfo.lastRecordIndex
            recordCountPerPage = paginationInfo.recordCountPerPage
        }

        val map = bbsMngService.selectBoardArticles(boardVO, "BBSA02")
        model.addAttribute("notiList", map["resultList"])

        // 공지사항 메인컨텐츠 조회 끝 -----------------------------------

        // 자유게시판 메인 컨텐츠 조회 시작 ---------------------------------
        boardVO.apply {
            pageUnit = 9
            pageSize = 10
            bbsId = "BBSMSTR_BBBBBBBBBBBB"
        }

        paginationInfo.apply {
            currentPageNo = boardVO.pageIndex
            recordCountPerPage = boardVO.pageUnit
            pageSize = boardVO.pageSize
        }

        boardVO.apply {
            firstIndex = paginationInfo.firstRecordIndex
            lastIndex = paginationInfo.lastRecordIndex
            recordCountPerPage = paginationInfo.recordCountPerPage
        }

        model.addAttribute("bbsList", bbsMngService.selectBoardArticles(boardVO, "BBSA02")["resultList"])

        // 자유게시판 메인컨텐츠 조회 끝 -----------------------------------

        // FAQ 메인 컨텐츠 조회 시작 ---------------------------------
        /** EgovPropertyService.SiteList */
        val searchVO = FaqManageDefaultVO().apply {
            pageUnit = 3
            pageSize = 10
        }

        /** pageing */
        paginationInfo.apply {
            currentPageNo = searchVO.pageIndex
            recordCountPerPage = searchVO.pageUnit
            pageSize = searchVO.pageSize
        }

        searchVO.apply {
            firstIndex = paginationInfo.firstRecordIndex
            lastIndex = paginationInfo.lastRecordIndex
            recordCountPerPage = paginationInfo.recordCountPerPage
        }

        model.addAttribute("faqList", faqManageService.selectFaqList(searchVO))

        // FAQ 메인 컨텐츠 조회 끝 -----------------------------------

        // 설문참여 메인 컨텐츠 조회 시작 -----------------------------------
        val qVO = ComDefaultVO().apply {
            pageUnit = 1
            pageSize = 10
        }

        /** pageing */
        paginationInfo.apply {
            currentPageNo = qVO.pageIndex
            recordCountPerPage = qVO.pageUnit
            pageSize = qVO.pageSize
        }

        qVO.apply {
            firstIndex = paginationInfo.firstRecordIndex
            lastIndex = paginationInfo.lastRecordIndex
            recordCountPerPage = paginationInfo.recordCountPerPage
        }

        model.addAttribute("qriList", egovQustnrRespondInfoService.selectQustnrRespondInfoManageList(qVO))

        // 설문참여 메인 컨텐츠 조회 끝 -----------------------------------

        return "main/EgovMainView"
    }

    /**
     * Header Page를 조회한다.
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "EgovIncHeader"
     * @exception Exception
     */
    @RequestMapping(value = ["/sym/mms/EgovHeader.do"])
    fun selectHeader(
        @ModelAttribute("menuManageVO") menuManageVO: MenuManageVO,
        @RequestParam(value = "flag", required = false) flag: String?,
        model: ModelMap
    ): String {

        val user: LoginVO? = if (EgovUserDetailsHelper.isAuthenticated())
            EgovUserDetailsHelper.getAuthenticatedUser() as? LoginVO else null

        if (EgovUserDetailsHelper.isAuthenticated() && user != null) {
            menuManageVO.apply {
                tmp_Id = user.id
                tmp_Password = user.password
                tmp_UserSe = user.userSe
                tmp_Name = user.name
                tmp_Email = user.email
                tmp_OrgnztId = user.orgnztId
                tmp_UniqId = user.uniqId
            }
            model.addAttribute("list_headmenu", menuManageService.selectMainMenuHead(menuManageVO))
            model.addAttribute("list_menulist", menuManageService.selectMainMenuLeft(menuManageVO))
        } else {
            menuManageVO.authorCode = "ROLE_ANONYMOUS"
            model.addAttribute("list_headmenu", menuManageService.selectMainMenuHeadByAuthor(menuManageVO))
            model.addAttribute("list_menulist", menuManageService.selectMainMenuLeftByAuthor(menuManageVO))
        }

        return "main/inc/EgovIncHeader" // 업무화면의 상단메뉴 화면
    }

    /**
     * Footer Page를 조회한다.
     * @param
     * @return 출력페이지정보 "EgovIncFooter"
     * @exception Exception
     */
    @RequestMapping(value = ["/sym/mms/EgovFooter.do"])
    fun selectFooter(model: ModelMap): String {
        return "main/inc/EgovIncFooter"
    }

    /**
     * 좌측메뉴를 조회한다.
     * @param
     * @return 출력페이지정보 "EgovIncLeftmenu"
     * @exception Exception
     */
    @RequestMapping(value = ["/sym/mms/EgovMenuLeft.do"])
    fun selectMenuLeft(model: ModelMap): String {

        if (EgovUserDetailsHelper.isAuthenticated()) {
            //인증된 경우 처리할 사항 추가 ...
            model.addAttribute("lastLogoutDateTime", "로그아웃 타임: 2021-08-12 11:30")
            //최근 로그아웃 시간 등에 대한 확보 후 메인 컨텐츠로 활용
        }

        return "main/inc/EgovIncLeftmenu"
    }

    /**
     * Head메뉴를 조회한다.
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "main_headG", "main_head"
     * @exception Exception
     */
    @RequestMapping(value = ["/sym/mms/EgovMainMenuHead.do"])
    fun selectMainMenuHead(
        @ModelAttribute("menuManageVO") menuManageVO: MenuManageVO,
        @RequestParam(value = "flag", required = false) flag: String?,
        model: ModelMap
    ): String {

        val user: LoginVO? = if (EgovUserDetailsHelper.isAuthenticated())
            EgovUserDetailsHelper.getAuthenticatedUser() as? LoginVO else null

        if (EgovUserDetailsHelper.isAuthenticated() && user != null) {
            menuManageVO.apply {
                tmp_Id = user.id
                tmp_Password = user.password
                tmp_UserSe = user.userSe
                tmp_Name = user.name
                tmp_Email = user.email
                tmp_OrgnztId = user.orgnztId
                tmp_UniqId = user.uniqId
            }
            model.addAttribute("list_headmenu", menuManageService.selectMainMenuHead(menuManageVO))
            model.addAttribute("list_menulist", menuManageService.selectMainMenuLeft(menuManageVO))
        } else {
            menuManageVO.authorCode = "ROLE_ANONYMOUS"
            model.addAttribute("list_headmenu", menuManageService.selectMainMenuHeadByAuthor(menuManageVO))
            model.addAttribute("list_menulist", menuManageService.selectMainMenuLeftByAuthor(menuManageVO))
        }

        return when (flag) {
            null -> "main/inc/EgovIncSubHeaderOld" // 업무화면의 상단메뉴 화면
            "MAIN" -> "main/inc/EgovIncHeaderOld" // 메인화면의 상단메뉴 화면
            else -> "main/inc/EgovIncSubHeaderOld" // 업무화면의 상단메뉴 화면
        }
    }

    /**
     * 좌측메뉴를 조회한다.
     * @param menuManageVO MenuManageVO
     * @param vStartP      String
     * @return 출력페이지정보 "main_left"
     * @exception Exception
     */
    @RequestMapping(value = ["/sym/mms/EgovMainMenuLeft.do"])
    fun selectMainMenuLeft(model: ModelMap): String {

        if (EgovUserDetailsHelper.isAuthenticated()) {
            //인증된 경우 처리할 사항 추가 ...
            model.addAttribute("lastLogoutDateTime", "로그아웃 타임: 2011-11-10 11:30")
            //최근 로그아웃 시간 등에 대한 확보 후 메인 컨텐츠로 활용
        }

        return "main/inc/EgovIncLeftmenuOld"
    }
}