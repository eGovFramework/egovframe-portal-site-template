package egovframework.let.sym.cal.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.sym.cal.service.EgovCalRestdeManageService;
import egovframework.let.sym.cal.service.Restde;
import egovframework.let.sym.cal.service.RestdeVO;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;

import org.apache.commons.collections.map.ListOrderedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;


/**
 * 
 * 공휴일에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한 Controller를 정의한다
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성 
 *
 * </pre>
 */
@Controller
public class EgovCalRestdeManageController {

	/** RestdeManageService */
	@Resource(name = "RestdeManageService")
    private EgovCalRestdeManageService restdeManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** EgovCmmUseService */
	@Resource(name="EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** beanValidator */
	@Autowired
	private DefaultBeanValidator beanValidator;

	/**
	 * 달력 메인창을 호출한다.
	 * @param model
	 * @return "/cmm/sym/cal/EgovNormalCalPopup"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/cmm/callCalPopup.do")
 	public String callCalendar (ModelMap model
 			) throws Exception {
		return "/cmm/sym/cal/EgovCalPopup";
	}    
	
	/**
	 * 달력을 호출한다.
	 * @param model
	 * @return "/cmm/sym/cal/EgovNormalCalPopup"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/cmm/callCal.do")
 	public String callCal (Restde restde
 			, ModelMap model
 			) throws Exception {

		Calendar cal = Calendar.getInstance();

		if(restde.getYear()==null || restde.getYear().equals("")){
			restde.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		}
		if(restde.getMonth()==null || restde.getMonth().equals("")){
			restde.setMonth(Integer.toString(cal.get(Calendar.MONTH)+1));
		}
		int iYear  = Integer.parseInt(restde.getYear());
		int iMonth = Integer.parseInt(restde.getMonth());

		if (iMonth<1){
			iYear--;
			iMonth = 12;
		}
		if (iMonth>12){
			iYear++;
			iMonth = 1;
		}
		if (iYear<1){
			iYear = 1;
			iMonth = 1;
		}
		if (iYear>9999){
			iYear = 9999;
			iMonth = 12;
		}
		
		cal.set(iYear,iMonth-1,1);
		
		int firstWeek = cal.get(Calendar.DAY_OF_WEEK);
		int lastDay   = cal.getActualMaximum(Calendar.DATE);
		int week      = cal.get(Calendar.DAY_OF_WEEK);
		
		String year   = Integer.toString(iYear);
		String month  = Integer.toString(iMonth);
		//String day    = Integer.toString(cal.get(Calendar.DAY_OF_MONTH));
		
		restde.setStartWeekMonth(firstWeek);
		restde.setLastDayMonth(lastDay);
		restde.setYear(year);
		restde.setMonth(month);
		
		List<ListOrderedMap> CalInfoList = new ArrayList<ListOrderedMap>();
		String tmpDay = "";
		
		/**
		 * 계산... START
		 */
		for(int i=0; i<42;i++) {
			ListOrderedMap  map   = new ListOrderedMap();
			int cc = i + 1;
			int dd = cc-firstWeek+1;

			if (dd > 0 && dd <= lastDay) {
				tmpDay = Integer.toString(dd);
			} else {
				tmpDay = "";
			}
			
			map.put("year",		year);
	        map.put("month",	month);
	        map.put("day",		tmpDay);
	        map.put("cellNum",	cc);
	        map.put("weeks",	(cc - 1) / 7 + 1);
	        map.put("week",		(week-1) % 7 + 1);
	        map.put("restAt",	((week-1) % 7 + 1==1) ? "Y" : "N");

	    	if (dd > 0 && dd <= lastDay) {
				week ++;
			}    	
	    	CalInfoList.add(map);

		}
		/**
		 * 계산... END		
		 */
		
        model.addAttribute("resultList", CalInfoList);
		
		return "/cmm/sym/cal/EgovCalendar";
	}    
	
	/**
	 * 일반달력 팝업 메인창을 호출한다.
	 * @param model
	 * @return "/cmm/sym/cal/EgovNormalCalPopup"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/cmm/EgovNormalCalPopup.do")
 	public String callNormalCalPopup (ModelMap model
 			) throws Exception {
		return "/sym/cal/EgovNormalCalPopup";
	}    

	/**
	 * 일반달력 팝업 정보를 조회한다.
	 * @param restde
	 * @param model
	 * @return "/cmm/sym/cal/EgovNormalCalendar"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/cmm/EgovselectNormalCalendar.do")
 	public String selectNormalRestdePopup (Restde restde
 			, ModelMap model
 			) throws Exception {

		Calendar cal = Calendar.getInstance();

		if(restde.getYear()==null || restde.getYear().equals("")){
			restde.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		}
		if(restde.getMonth()==null || restde.getMonth().equals("")){
			restde.setMonth(Integer.toString(cal.get(Calendar.MONTH)+1));
		}
		int iYear  = Integer.parseInt(restde.getYear());
		int iMonth = Integer.parseInt(restde.getMonth());

		if (iMonth<1){
			iYear--;
			iMonth = 12;
		}
		if (iMonth>12){
			iYear++;
			iMonth = 1;
		}
		if (iYear<1){
			iYear = 1;
			iMonth = 1;
		}
		if (iYear>9999){
			iYear = 9999;
			iMonth = 12;
		}
		
		/* DB를 사용할 경우 처리
		restde.setYear(Integer.toString(iYear));
		restde.setMonth(Integer.toString(iMonth));
		
		cal.set(iYear,iMonth-1,1);
		
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));

        List CalInfoList = restdeManageService.selectNormalRestdePopup(restde);
        */
		
		cal.set(iYear,iMonth-1,1);
		 
        int firstWeek = cal.get(Calendar.DAY_OF_WEEK);
        int lastDay   = cal.getActualMaximum(Calendar.DATE);
        int week      = cal.get(Calendar.DAY_OF_WEEK);
 
        String year   = Integer.toString(iYear);
        String month  = Integer.toString(iMonth);
        //String day    = Integer.toString(cal.get(Calendar.DAY_OF_MONTH));
 
        restde.setStartWeekMonth(firstWeek);
        restde.setLastDayMonth(lastDay);
        restde.setYear(year);
        restde.setMonth(month);
 
        List<ListOrderedMap> CalInfoList = new ArrayList<ListOrderedMap>();
        String tmpDay = "";
 
        /**
         * 계산... START
         */
        for(int i=0; i<42;i++) {
            ListOrderedMap  map   = new ListOrderedMap();
            int cc = i + 1;
            int dd = cc-firstWeek+1;
 
            if (dd > 0 && dd <= lastDay) {
                tmpDay = Integer.toString(dd);
            } else {
                tmpDay = "";
            }
 
            map.put("year",     year);
            map.put("month",    month);
            map.put("day",      tmpDay);
            map.put("cellNum",  cc);
            map.put("weeks",    (cc - 1) / 7 + 1);
            map.put("week",     (week-1) % 7 + 1);
            map.put("restAt",   ((week-1) % 7 + 1==1) ? "Y" : "N");
 
            if (dd > 0 && dd <= lastDay) {
                week ++;
            }
            CalInfoList.add(map);
 
        }
        /**
         * 계산... END
         */
		
		
        model.addAttribute("resultList", CalInfoList);
		return "/sym/cal/EgovNormalCalendar";
	}
	
	
	/**
	 * 행정달력 팝업 메인창을 호출한다.
	 * @param model
	 * @return "/cmm/sym/cal/EgovAdministCalPopup"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/cmm/EgovAdministCalPopup.do")
 	public String callAdministCalPopup (ModelMap model
 			) throws Exception {
		return "/cmm/sym/cal/EgovAdministCalPopup";
	}    
	
	/**
	 * 행정달력 팝업 정보를 조회한다.
	 * @param restde
	 * @param model
	 * @return "/cmm/sym/cal/EgovAdministCalendar"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/cmm/EgovselectAdministCalendar.do")
 	public String selectAdministRestdePopup (Restde restde
 			, ModelMap model
 			) throws Exception {

		Calendar cal = Calendar.getInstance();

		if(restde.getYear()==null || restde.getYear().equals("")){
			restde.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		}
		if(restde.getMonth()==null || restde.getMonth().equals("")){
			restde.setMonth(Integer.toString(cal.get(Calendar.MONTH)+1));
		}
		int iYear  = Integer.parseInt(restde.getYear());
		int iMonth = Integer.parseInt(restde.getMonth());

		if (iMonth<1){
			iYear--;
			iMonth = 12;
		}
		if (iMonth>12){
			iYear++;
			iMonth = 1;
		}
		if (iYear<1){
			iYear = 1;
			iMonth = 1;
		}
		if (iYear>9999){
			iYear = 9999;
			iMonth = 12;
		}
		restde.setYear(Integer.toString(iYear));
		restde.setMonth(Integer.toString(iMonth));
		
		cal.set(iYear,iMonth-1,1);
		
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));

        model.addAttribute("resultList", restdeManageService.selectAdministRestdePopup(restde));
		
		return "/cmm/sym/cal/EgovAdministCalendar";
	}

	/**
	 * 일반달력 일간
	 * @param restde
	 * @param model
	 * @return "/cmm/sym/cal/EgovNormalDayCalendar"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/cal/EgovNormalDayCalendar.do")
 	public String selectNormalDayCalendar (Restde restde
 			, ModelMap model
 			) throws Exception {

		Calendar cal = Calendar.getInstance();


		if(restde.getYear()==null || restde.getYear().equals("")){
			restde.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		}
		if(restde.getMonth()==null || restde.getMonth().equals("")){
			restde.setMonth(Integer.toString(cal.get(Calendar.MONTH)+1));
		}
		if(restde.getDay()==null || restde.getDay().equals("")){
			restde.setDay(Integer.toString(cal.get(Calendar.DATE)));
		}

		int iYear  = Integer.parseInt(restde.getYear());
		int iMonth = Integer.parseInt(restde.getMonth());
		int iDay   = Integer.parseInt(restde.getDay());
		
		if (iMonth<1){
			iYear--;
			iMonth = 12;
		}
		if (iMonth>12){
			iYear++;
			iMonth = 1;
		}
		if (iYear<1){
			iYear = 1;
			iMonth = 1;
		}
		if (iYear>9999){
			iYear = 9999;
			iMonth = 12;
		}
		restde.setYear(Integer.toString(iYear));
		restde.setMonth(Integer.toString(iMonth));
		
		cal.set(iYear,iMonth-1,iDay);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));

		cal.set(iYear,iMonth-1,Integer.parseInt(restde.getDay()));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DAY_OF_MONTH));

		restde.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		restde.setMonth(Integer.toString(cal.get(Calendar.MONTH)+1));
		restde.setDay(Integer.toString(cal.get(Calendar.DAY_OF_MONTH)));
		restde.setWeek(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
		
		//List CalInfoList          = restdeManageService.selectNormalDayCal(restde);
        //List NormalWeekRestdeList = restdeManageService.selectNormalDayRestde(restde);

        model.addAttribute("resultList", restdeManageService.selectNormalDayCal(restde));
        model.addAttribute("RestdeList", restdeManageService.selectNormalDayRestde(restde));
        
		return "/cmm/sym/cal/EgovNormalDayCalendar";
	}
	
	/**
	 * 일반달력 주간
	 * @param restde
	 * @param model
	 * @return "/cmm/sym/cal/EgovNormalWeekCalendar"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/cal/EgovNormalWeekCalendar.do")
 	public String selectNormalWeekCalendar (Restde restde
 			, ModelMap model
 			) throws Exception {

		Calendar cal = Calendar.getInstance();

		if(restde.getYear()==null || restde.getYear().equals("")){
			restde.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		}
		if(restde.getMonth()==null || restde.getMonth().equals("")){
			restde.setMonth(Integer.toString(cal.get(Calendar.MONTH)+1));
		}
		if(restde.getDay()==null || restde.getDay().equals("")){
			restde.setDay(Integer.toString(cal.get(Calendar.DATE)));
		}

		int iYear  = Integer.parseInt(restde.getYear());
		int iMonth = Integer.parseInt(restde.getMonth());
		
		if (iMonth<1){
			iYear--;
			iMonth = 12;
		}
		if (iMonth>12){
			iYear++;
			iMonth = 1;
		}
		if (iYear<1){
			iYear = 1;
			iMonth = 1;
		}
		if (iYear>9999){
			iYear = 9999;
			iMonth = 12;
		}
		restde.setYear(Integer.toString(iYear));
		restde.setMonth(Integer.toString(iMonth));
		
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));

		cal.set(iYear,iMonth-1,Integer.parseInt(restde.getDay()));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DAY_OF_MONTH));

		int iStartWeek = restde.getStartWeekMonth(); 
		int iLastDate  = restde.getLastDayMonth();
		int iDayWeek  = cal.get(Calendar.DAY_OF_WEEK);
		
		int iMaxWeeks = (int)Math.floor(iLastDate/7);
		iMaxWeeks = iMaxWeeks + (int)Math.ceil(((iLastDate - iMaxWeeks * 7) + iStartWeek - 1) / 7.0);
		restde.setMaxWeeks(iMaxWeeks);
		
		if (iMaxWeeks < restde.getWeeks()) {
			restde.setWeeks(iMaxWeeks);
		}
		
		Restde vo = new Restde();
		Calendar weekCal = Calendar.getInstance();
		weekCal.setTime(cal.getTime());
		
		if(restde.getWeeks()!=0){
			weekCal.set(Calendar.DATE, (restde.getWeeks() - 1) * 7 + 1);
			if(restde.getWeeks()>1){
				iDayWeek  = weekCal.get(Calendar.DAY_OF_WEEK);
				weekCal.add(Calendar.DATE, (-1)*(iDayWeek-1));
			}
			restde.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)+1));
		}

		iDayWeek  = weekCal.get(Calendar.DAY_OF_WEEK);

		// 일요일
		weekCal.add(Calendar.DATE, (-1)*(iDayWeek-1));
		vo.setYear(Integer.toString(weekCal.get(Calendar.YEAR)));
		vo.setMonth(Integer.toString(weekCal.get(Calendar.MONTH)+1));
		vo.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)));
		vo.setWeek(weekCal.get(Calendar.DAY_OF_WEEK));
		model.addAttribute("resultList_1", restdeManageService.selectNormalDayCal(vo));
        model.addAttribute("RestdeList_1", restdeManageService.selectNormalDayRestde(vo));
        
		// 월요일
		weekCal.add(Calendar.DATE, 1);
		vo.setYear(Integer.toString(weekCal.get(Calendar.YEAR)));
		vo.setMonth(Integer.toString(weekCal.get(Calendar.MONTH)+1));
		vo.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)));
		vo.setWeek(weekCal.get(Calendar.DAY_OF_WEEK));
        model.addAttribute("resultList_2", restdeManageService.selectNormalDayCal(vo));
        model.addAttribute("RestdeList_2", restdeManageService.selectNormalDayRestde(vo));

        // 화요일
		weekCal.add(Calendar.DATE, 1);
		vo.setYear(Integer.toString(weekCal.get(Calendar.YEAR)));
		vo.setMonth(Integer.toString(weekCal.get(Calendar.MONTH)+1));
		vo.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)));
		vo.setWeek(weekCal.get(Calendar.DAY_OF_WEEK));
        model.addAttribute("resultList_3", restdeManageService.selectNormalDayCal(vo));
        model.addAttribute("RestdeList_3", restdeManageService.selectNormalDayRestde(vo));

        // 수요일
		weekCal.add(Calendar.DATE, 1);
		vo.setYear(Integer.toString(weekCal.get(Calendar.YEAR)));
		vo.setMonth(Integer.toString(weekCal.get(Calendar.MONTH)+1));
		vo.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)));
		vo.setWeek(weekCal.get(Calendar.DAY_OF_WEEK));
		//List CalInfoList_4          = restdeManageService.selectNormalDayCal(vo);
        //List NormalWeekRestdeList_4 = restdeManageService.selectNormalDayRestde(vo);
        model.addAttribute("resultList_4", restdeManageService.selectNormalDayCal(vo));
        model.addAttribute("RestdeList_4", restdeManageService.selectNormalDayRestde(vo));

        // 목요일
		weekCal.add(Calendar.DATE, 1);
		vo.setYear(Integer.toString(weekCal.get(Calendar.YEAR)));
		vo.setMonth(Integer.toString(weekCal.get(Calendar.MONTH)+1));
		vo.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)));
		vo.setWeek(weekCal.get(Calendar.DAY_OF_WEEK));
        model.addAttribute("resultList_5", restdeManageService.selectNormalDayCal(vo));
        model.addAttribute("RestdeList_5", restdeManageService.selectNormalDayRestde(vo));

        // 금요일
		weekCal.add(Calendar.DATE, 1);
		vo.setYear(Integer.toString(weekCal.get(Calendar.YEAR)));
		vo.setMonth(Integer.toString(weekCal.get(Calendar.MONTH)+1));
		vo.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)));
		vo.setWeek(weekCal.get(Calendar.DAY_OF_WEEK));
        model.addAttribute("resultList_6", restdeManageService.selectNormalDayCal(vo));
        model.addAttribute("RestdeList_6", restdeManageService.selectNormalDayRestde(vo));
		
        // 토요일
		weekCal.add(Calendar.DATE, 1);
		vo.setYear(Integer.toString(weekCal.get(Calendar.YEAR)));
		vo.setMonth(Integer.toString(weekCal.get(Calendar.MONTH)+1));
		vo.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)));
		vo.setWeek(weekCal.get(Calendar.DAY_OF_WEEK));
        model.addAttribute("resultList_7", restdeManageService.selectNormalDayCal(vo));
        model.addAttribute("RestdeList_7", restdeManageService.selectNormalDayRestde(vo));

        model.addAttribute("resultList", restdeManageService.selectNormalDayCal(restde));
        
        return "/cmm/sym/cal/EgovNormalWeekCalendar";
	}	

	/**
	 * 일반달력 월간
	 * @param restde
	 * @param model
	 * @return "/cmm/sym/cal/EgovNormalMonthCalendar"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/cal/EgovNormalMonthCalendar.do")
 	public String selectNormalMonthCalendar (Restde restde
 			, ModelMap model
 			) throws Exception {

		Calendar cal = Calendar.getInstance();

		if(restde.getYear()==null || restde.getYear().equals("")){
			restde.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		}
		if(restde.getMonth()==null || restde.getMonth().equals("")){
			restde.setMonth(Integer.toString(cal.get(Calendar.MONTH)+1));
		}
		int iYear  = Integer.parseInt(restde.getYear());
		int iMonth = Integer.parseInt(restde.getMonth());

		if (iMonth<1){
			iYear--;
			iMonth = 12;
		}
		if (iMonth>12){
			iYear++;
			iMonth = 1;
		}
		if (iYear<1){
			iYear = 1;
			iMonth = 1;
		}
		if (iYear>9999){
			iYear = 9999;
			iMonth = 12;
		}
		restde.setYear(Integer.toString(iYear));
		restde.setMonth(Integer.toString(iMonth));
		
		cal.set(iYear,iMonth-1,1);
		
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));

        model.addAttribute("resultList", restdeManageService.selectNormalRestdePopup(restde));
        model.addAttribute("RestdeList", restdeManageService.selectNormalMonthRestde(restde));

        return "/cmm/sym/cal/EgovNormalMonthCalendar";
	}	
	
	/**
	 * 일반달력 연간
	 * @param restde
	 * @param model
	 * @return "/cmm/sym/cal/EgovNormalYearCalendar"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/cal/EgovNormalYearCalendar.do")
 	public String selectNormalYearCalendar (Restde restde
 			, ModelMap model
 			) throws Exception {

		Calendar cal = Calendar.getInstance();

		if(restde.getYear()==null || restde.getYear().equals("")){
			restde.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		}
		if(restde.getMonth()==null || restde.getMonth().equals("")){
			restde.setMonth(Integer.toString(cal.get(Calendar.MONTH)+1));
		}
		int iYear  = Integer.parseInt(restde.getYear());
		int iMonth = Integer.parseInt(restde.getMonth());

		if (iMonth<1){
			iYear--;
			iMonth = 12;
		}
		if (iMonth>12){
			iYear++;
			iMonth = 1;
		}
		if (iYear<1){
			iYear = 1;
			iMonth = 1;
		}
		if (iYear>9999){
			iYear = 9999;
			iMonth = 12;
		}
		restde.setYear(Integer.toString(iYear));
		
		/* 월별확인 */

		/* 1월 */
		iMonth = 1;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_1" , restdeManageService.selectNormalRestdePopup(restde) );
        model.addAttribute("RestdeList_1" , restdeManageService.selectNormalMonthRestde(restde) );

		/* 2월 */
		iMonth = 2;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_2" , restdeManageService.selectNormalRestdePopup(restde) );
        model.addAttribute("RestdeList_2" , restdeManageService.selectNormalMonthRestde(restde) );

		/* 3월 */
		iMonth = 3;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_3" , restdeManageService.selectNormalRestdePopup(restde) );
        model.addAttribute("RestdeList_3" , restdeManageService.selectNormalMonthRestde(restde) );

		/* 4월 */
		iMonth = 4;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_4" , restdeManageService.selectNormalRestdePopup(restde) );
        model.addAttribute("RestdeList_4" , restdeManageService.selectNormalMonthRestde(restde) );

		/* 5월 */
		iMonth = 5;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_5" , restdeManageService.selectNormalRestdePopup(restde) );
        model.addAttribute("RestdeList_5" , restdeManageService.selectNormalMonthRestde(restde) );

		/* 6월 */
		iMonth = 6;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_6" , restdeManageService.selectNormalRestdePopup(restde) );
        model.addAttribute("RestdeList_6" , restdeManageService.selectNormalMonthRestde(restde) );

		/* 7월 */
		iMonth = 7;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_7" , restdeManageService.selectNormalRestdePopup(restde) );
        model.addAttribute("RestdeList_7" , restdeManageService.selectNormalMonthRestde(restde) );

		/* 8월 */
		iMonth = 8;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_8" , restdeManageService.selectNormalRestdePopup(restde) );
        model.addAttribute("RestdeList_8" , restdeManageService.selectNormalMonthRestde(restde) );

		/* 9월 */
		iMonth = 9;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_9" , restdeManageService.selectNormalRestdePopup(restde) );
        model.addAttribute("RestdeList_9" , restdeManageService.selectNormalMonthRestde(restde) );

		/* 10월 */
		iMonth = 10;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_10", restdeManageService.selectNormalRestdePopup(restde));
        model.addAttribute("RestdeList_10", restdeManageService.selectNormalMonthRestde(restde));

		/* 11월 */
		iMonth = 11;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_11", restdeManageService.selectNormalRestdePopup(restde));
        model.addAttribute("RestdeList_11", restdeManageService.selectNormalMonthRestde(restde));

		/* 12월 */
		iMonth = 12;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_12", restdeManageService.selectNormalRestdePopup(restde));
        model.addAttribute("RestdeList_12", restdeManageService.selectNormalMonthRestde(restde));

        return "/cmm/sym/cal/EgovNormalYearCalendar";
	}	
	

	/**
	 * 행정달력 일간
	 * @param restde
	 * @param model
	 * @return "/cmm/sym/cal/EgovAdministDayCalendar"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/cal/EgovAdministDayCalendar.do")
 	public String selectAdministDayCalendar (Restde restde
 			, ModelMap model
 			) throws Exception {

		Calendar cal = Calendar.getInstance();


		if(restde.getYear()==null || restde.getYear().equals("")){
			restde.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		}
		if(restde.getMonth()==null || restde.getMonth().equals("")){
			restde.setMonth(Integer.toString(cal.get(Calendar.MONTH)+1));
		}
		if(restde.getDay()==null || restde.getDay().equals("")){
			restde.setDay(Integer.toString(cal.get(Calendar.DATE)));
		}

		int iYear  = Integer.parseInt(restde.getYear());
		int iMonth = Integer.parseInt(restde.getMonth());
		int iDay   = Integer.parseInt(restde.getDay());
		
		if (iMonth<1){
			iYear--;
			iMonth = 12;
		}
		if (iMonth>12){
			iYear++;
			iMonth = 1;
		}
		if (iYear<1){
			iYear = 1;
			iMonth = 1;
		}
		if (iYear>9999){
			iYear = 9999;
			iMonth = 12;
		}
		restde.setYear(Integer.toString(iYear));
		restde.setMonth(Integer.toString(iMonth));
		
		cal.set(iYear,iMonth-1,iDay);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));

		cal.set(iYear,iMonth-1,Integer.parseInt(restde.getDay()));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DAY_OF_MONTH));

		restde.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		restde.setMonth(Integer.toString(cal.get(Calendar.MONTH)+1));
		restde.setDay(Integer.toString(cal.get(Calendar.DAY_OF_MONTH)));
		restde.setWeek(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
		
        model.addAttribute("resultList", restdeManageService.selectAdministDayCal(restde));
        model.addAttribute("RestdeList", restdeManageService.selectAdministDayRestde(restde));
        
		return "/cmm/sym/cal/EgovAdministDayCalendar";
	}
	

	/**
	 * 행정달력 주간
	 * @param restde
	 * @param model
	 * @return "/cmm/sym/cal/EgovAdministWeekCalendar"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/cal/EgovAdministWeekCalendar.do")
 	public String selectAdministWeekCalendar (Restde restde
 			, ModelMap model
 			) throws Exception {

		Calendar cal = Calendar.getInstance();

		if(restde.getYear()==null || restde.getYear().equals("")){
			restde.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		}
		if(restde.getMonth()==null || restde.getMonth().equals("")){
			restde.setMonth(Integer.toString(cal.get(Calendar.MONTH)+1));
		}
		if(restde.getDay()==null || restde.getDay().equals("")){
			restde.setDay(Integer.toString(cal.get(Calendar.DATE)));
		}

		int iYear  = Integer.parseInt(restde.getYear());
		int iMonth = Integer.parseInt(restde.getMonth());
		
		if (iMonth<1){
			iYear--;
			iMonth = 12;
		}
		if (iMonth>12){
			iYear++;
			iMonth = 1;
		}
		if (iYear<1){
			iYear = 1;
			iMonth = 1;
		}
		if (iYear>9999){
			iYear = 9999;
			iMonth = 12;
		}
		restde.setYear(Integer.toString(iYear));
		restde.setMonth(Integer.toString(iMonth));
		
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));

		cal.set(iYear,iMonth-1,Integer.parseInt(restde.getDay()));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DAY_OF_MONTH));

		int iStartWeek = restde.getStartWeekMonth(); 
		int iLastDate  = restde.getLastDayMonth();
		int iDayWeek  = cal.get(Calendar.DAY_OF_WEEK);
		
		int iMaxWeeks = (int)Math.floor(iLastDate/7);
		iMaxWeeks = iMaxWeeks + (int)Math.ceil(((iLastDate - iMaxWeeks * 7) + iStartWeek - 1) / 7.0);
		restde.setMaxWeeks(iMaxWeeks);
		
		if (iMaxWeeks < restde.getWeeks()) {
			restde.setWeeks(iMaxWeeks);
		}

		Restde vo = new Restde();
		Calendar weekCal = Calendar.getInstance();
		weekCal.setTime(cal.getTime());
		
		if(restde.getWeeks()!=0){
			weekCal.set(Calendar.DATE, (restde.getWeeks() - 1) * 7 + 1);
			if(restde.getWeeks()>1){
				iDayWeek  = weekCal.get(Calendar.DAY_OF_WEEK);
				weekCal.add(Calendar.DATE, (-1)*(iDayWeek-1));
			}
			restde.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)+1));
		}
		//List CalInfoList = restdeManageService.selectAdministDayCal(restde);
		model.addAttribute("resultList", restdeManageService.selectAdministDayCal(restde));
		
		iDayWeek  = weekCal.get(Calendar.DAY_OF_WEEK);

		// 일요일
		weekCal.add(Calendar.DATE, (-1)*(iDayWeek-1));
		vo.setYear(Integer.toString(weekCal.get(Calendar.YEAR)));
		vo.setMonth(Integer.toString(weekCal.get(Calendar.MONTH)+1));
		vo.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)));
		vo.setWeek(weekCal.get(Calendar.DAY_OF_WEEK));
		//List CalInfoList_1          = restdeManageService.selectAdministDayCal(vo);
        //List AdministWeekRestdeList_1 = restdeManageService.selectAdministDayRestde(vo);
        model.addAttribute("resultList_1", restdeManageService.selectAdministDayCal(vo));
        model.addAttribute("RestdeList_1", restdeManageService.selectAdministDayRestde(vo));
        
		// 월요일
		weekCal.add(Calendar.DATE, 1);
		vo.setYear(Integer.toString(weekCal.get(Calendar.YEAR)));
		vo.setMonth(Integer.toString(weekCal.get(Calendar.MONTH)+1));
		vo.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)));
		vo.setWeek(weekCal.get(Calendar.DAY_OF_WEEK));
        model.addAttribute("resultList_2", restdeManageService.selectAdministDayCal(vo));
        model.addAttribute("RestdeList_2", restdeManageService.selectAdministDayRestde(vo));

		// 화요일
		weekCal.add(Calendar.DATE, 1);
		vo.setYear(Integer.toString(weekCal.get(Calendar.YEAR)));
		vo.setMonth(Integer.toString(weekCal.get(Calendar.MONTH)+1));
		vo.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)));
		vo.setWeek(weekCal.get(Calendar.DAY_OF_WEEK));
        model.addAttribute("resultList_3", restdeManageService.selectAdministDayCal(vo));
        model.addAttribute("RestdeList_3", restdeManageService.selectAdministDayRestde(vo));

		// 수요일
		weekCal.add(Calendar.DATE, 1);
		vo.setYear(Integer.toString(weekCal.get(Calendar.YEAR)));
		vo.setMonth(Integer.toString(weekCal.get(Calendar.MONTH)+1));
		vo.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)));
		vo.setWeek(weekCal.get(Calendar.DAY_OF_WEEK));
        model.addAttribute("resultList_4", restdeManageService.selectAdministDayCal(vo));
        model.addAttribute("RestdeList_4", restdeManageService.selectAdministDayRestde(vo));

		// 목요일
		weekCal.add(Calendar.DATE, 1);
		vo.setYear(Integer.toString(weekCal.get(Calendar.YEAR)));
		vo.setMonth(Integer.toString(weekCal.get(Calendar.MONTH)+1));
		vo.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)));
		vo.setWeek(weekCal.get(Calendar.DAY_OF_WEEK));
        model.addAttribute("resultList_5", restdeManageService.selectAdministDayCal(vo));
        model.addAttribute("RestdeList_5", restdeManageService.selectAdministDayRestde(vo));

		// 금요일
		weekCal.add(Calendar.DATE, 1);
		vo.setYear(Integer.toString(weekCal.get(Calendar.YEAR)));
		vo.setMonth(Integer.toString(weekCal.get(Calendar.MONTH)+1));
		vo.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)));
		vo.setWeek(weekCal.get(Calendar.DAY_OF_WEEK));
        model.addAttribute("resultList_6", restdeManageService.selectAdministDayCal(vo));
        model.addAttribute("RestdeList_6", restdeManageService.selectAdministDayRestde(vo));

		// 토요일
		weekCal.add(Calendar.DATE, 1);
		vo.setYear(Integer.toString(weekCal.get(Calendar.YEAR)));
		vo.setMonth(Integer.toString(weekCal.get(Calendar.MONTH)+1));
		vo.setDay(Integer.toString(weekCal.get(Calendar.DAY_OF_MONTH)));
		vo.setWeek(weekCal.get(Calendar.DAY_OF_WEEK));

        model.addAttribute("resultList_7", restdeManageService.selectAdministDayCal(vo));
        model.addAttribute("RestdeList_7", restdeManageService.selectAdministDayRestde(vo));

		return "/cmm/sym/cal/EgovAdministWeekCalendar";
	}
	
	/**
	 * 행정달력 월간
	 * @param restde
	 * @param model
	 * @return "/cmm/sym/cal/EgovAdministMonthCalendar"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/cal/EgovAdministMonthCalendar.do")
 	public String selectAdministMonthCalendar (Restde restde
 			, ModelMap model
 			) throws Exception {

		Calendar cal = Calendar.getInstance();

		if(restde.getYear()==null || restde.getYear().equals("")){
			restde.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		}
		if(restde.getMonth()==null || restde.getMonth().equals("")){
			restde.setMonth(Integer.toString(cal.get(Calendar.MONTH)+1));
		}
		int iYear  = Integer.parseInt(restde.getYear());
		int iMonth = Integer.parseInt(restde.getMonth());

		if (iMonth<1){
			iYear--;
			iMonth = 12;
		}
		if (iMonth>12){
			iYear++;
			iMonth = 1;
		}
		if (iYear<1){
			iYear = 1;
			iMonth = 1;
		}
		if (iYear>9999){
			iYear = 9999;
			iMonth = 12;
		}
		restde.setYear(Integer.toString(iYear));
		restde.setMonth(Integer.toString(iMonth));
		
		cal.set(iYear,iMonth-1,1);
		
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));

        model.addAttribute("resultList", restdeManageService.selectAdministRestdePopup(restde));
        model.addAttribute("RestdeList", restdeManageService.selectAdministMonthRestde(restde));

        return "/cmm/sym/cal/EgovAdministMonthCalendar";
	}	


	/**
	 * 행정달력 연간
	 * @param restde
	 * @param model
	 * @return "/cmm/sym/cal/EgovAdministYearCalendar"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/cal/EgovAdministYearCalendar.do")
 	public String selectAdministYearCalendar (Restde restde
 			, ModelMap model
 			) throws Exception {

		Calendar cal = Calendar.getInstance();

		if(restde.getYear()==null || restde.getYear().equals("")){
			restde.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		}
		if(restde.getMonth()==null || restde.getMonth().equals("")){
			restde.setMonth(Integer.toString(cal.get(Calendar.MONTH)+1));
		}
		int iYear  = Integer.parseInt(restde.getYear());
		int iMonth = Integer.parseInt(restde.getMonth());

		if (iMonth<1){
			iYear--;
			iMonth = 12;
		}
		if (iMonth>12){
			iYear++;
			iMonth = 1;
		}
		if (iYear<1){
			iYear = 1;
			iMonth = 1;
		}
		if (iYear>9999){
			iYear = 9999;
			iMonth = 12;
		}
		restde.setYear(Integer.toString(iYear));
		
		/* 월별확인 */

		/* 1월 */
		iMonth = 1;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_1" , restdeManageService.selectAdministRestdePopup(restde) );
        model.addAttribute("RestdeList_1" , restdeManageService.selectAdministMonthRestde(restde) );
        
		/* 2월 */
		iMonth = 2;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_2" , restdeManageService.selectAdministRestdePopup(restde) );
        model.addAttribute("RestdeList_2" , restdeManageService.selectAdministMonthRestde(restde) );
        
		/* 3월 */
		iMonth = 3;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_3" , restdeManageService.selectAdministRestdePopup(restde) );
        model.addAttribute("RestdeList_3" , restdeManageService.selectAdministMonthRestde(restde) );
        
		/* 4월 */
		iMonth = 4;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_4" , restdeManageService.selectAdministRestdePopup(restde) );
        model.addAttribute("RestdeList_4" , restdeManageService.selectAdministMonthRestde(restde) );
        
		/* 5월 */
		iMonth = 5;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_5" , restdeManageService.selectAdministRestdePopup(restde) );
        model.addAttribute("RestdeList_5" , restdeManageService.selectAdministMonthRestde(restde) );
        
		/* 6월 */
		iMonth = 6;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_6" , restdeManageService.selectAdministRestdePopup(restde) );
        model.addAttribute("RestdeList_6" , restdeManageService.selectAdministMonthRestde(restde) );
        
		/* 7월 */
		iMonth = 7;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_7" , restdeManageService.selectAdministRestdePopup(restde) );
        model.addAttribute("RestdeList_7" , restdeManageService.selectAdministMonthRestde(restde) );
        
		/* 8월 */
		iMonth = 8;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_8" , restdeManageService.selectAdministRestdePopup(restde) );
        model.addAttribute("RestdeList_8" , restdeManageService.selectAdministMonthRestde(restde) );
        
		/* 9월 */
		iMonth = 9;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_9" , restdeManageService.selectAdministRestdePopup(restde) );
        model.addAttribute("RestdeList_9" , restdeManageService.selectAdministMonthRestde(restde) );
        
		/* 10월 */
		iMonth = 10;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_10", restdeManageService.selectAdministRestdePopup(restde));
        model.addAttribute("RestdeList_10", restdeManageService.selectAdministMonthRestde(restde));
        
		/* 11월 */
		iMonth = 11;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        model.addAttribute("resultList_11", restdeManageService.selectAdministRestdePopup(restde));
        model.addAttribute("RestdeList_11", restdeManageService.selectAdministMonthRestde(restde));
        
		/* 12월 */
		iMonth = 12;
		restde.setMonth(Integer.toString(iMonth));
		cal.set(iYear,iMonth-1,1);
		restde.setStartWeekMonth(cal.get(Calendar.DAY_OF_WEEK));
		restde.setLastDayMonth(cal.getActualMaximum(Calendar.DATE));
        
        model.addAttribute("resultList_12", restdeManageService.selectAdministRestdePopup(restde));
        model.addAttribute("RestdeList_12", restdeManageService.selectAdministMonthRestde(restde));

        return "/cmm/sym/cal/EgovAdministYearCalendar";
	}	
	

	/**
	 * 휴일을 삭제한다.
	 * @param loginVO
	 * @param restde
	 * @param model
	 * @return "forward:/sym/cal/EgovRestdeList.do"
	 * @throws Exception
	 */
    @RequestMapping(value="/sym/cal/EgovRestdeRemove.do")
	public String deleteRestde (@ModelAttribute("loginVO") LoginVO loginVO
			, Restde restde
			, ModelMap model
			) throws Exception {
    	restdeManageService.deleteRestde(restde);
        return "forward:/sym/cal/EgovRestdeList.do";
	}



    /**
     * 휴일 세부내역을 조회한다.
     * @param loginVO
     * @param restde
     * @param model
     * @return "/cmm/sym/cal/EgovRestdeDetail"
     * @throws Exception
     */
	@RequestMapping(value="/sym/cal/EgovRestdeDetail.do")
 	public String selectRestdeDetail (@ModelAttribute("loginVO") LoginVO loginVO
 			, Restde restde
 			, ModelMap model
 			) throws Exception {
		Restde vo = restdeManageService.selectRestdeDetail(restde);
		model.addAttribute("result", vo);
		
		return "/cmm/sym/cal/EgovRestdeDetail";
	}

    /**
	 * 휴일 리스트를 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/cmm/sym/cal/EgovRestdeList"
     * @throws Exception
     */
    @RequestMapping(value="/sym/cal/EgovRestdeList.do")
	public String selectRestdeList (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") RestdeVO searchVO
			, ModelMap model
			) throws Exception {
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        model.addAttribute("resultList", restdeManageService.selectRestdeList(searchVO));
        
        int totCnt = restdeManageService.selectRestdeListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/cmm/sym/cal/EgovRestdeList";
	}

    /**
	 * 휴일을 수정한다.
     * @param loginVO
     * @param restde
     * @param bindingResult
     * @param commandMap
     * @param model
     * @return "/cmm/sym/cal/EgovRestdeModify"
     * @throws Exception
     */
    @RequestMapping(value="/sym/cal/EgovRestdeModify.do")
	public String updateRestde (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("restde") Restde restde
			, BindingResult bindingResult
			, @RequestParam Map <String, Object> commandMap
			, ModelMap model
			) throws Exception {
		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
    	if (sCmd.equals("")) {
    		Restde vo = restdeManageService.selectRestdeDetail(restde);
    		model.addAttribute("restde", vo);

    		ComDefaultCodeVO CodeVO = new ComDefaultCodeVO();
    		CodeVO.setCodeId("COM017");
            model.addAttribute("restdeCode", cmmUseService.selectCmmCodeDetail(CodeVO));

            return "/cmm/sym/cal/EgovRestdeModify";
    	} else if (sCmd.equals("Modify")) {
            beanValidator.validate(restde, bindingResult);
    		if (bindingResult.hasErrors()){
        		ComDefaultCodeVO CodeVO = new ComDefaultCodeVO();
        		CodeVO.setCodeId("COM017");
                model.addAttribute("restdeCode", cmmUseService.selectCmmCodeDetail(CodeVO));

                return "/cmm/sym/cal/EgovRestdeModify";
    		}

    		restde.setLastUpdusrId(loginVO.getUniqId());
    		restdeManageService.updateRestde(restde);
	        return "forward:/sym/cal/EgovRestdeList.do";
    	} else {
    		return "forward:/sym/cal/EgovRestdeList.do";
    	}
    }

	
}