package com.spring.learn.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.learn.common.PagingSK;
import com.spring.learn.lecture.CategoryVO;
import com.spring.learn.lecture.ClassService;
import com.spring.learn.lecture.LectureService;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.lecture.OfftimetableService;

import oracle.jdbc.proxy.annotation.Post;

@RestController				// 단 현재 위치(클래스)에서만 유효
@SessionAttributes({"lecture"}) // lecture라는 이름의 Model객체가 있으면 세션에 저장
@RequestMapping("/lecture")
public class LectureAjaxController {

	@Autowired
	private LectureService lectureService;
	
	@Autowired
	private ClassService classService;
	
	@Autowired
	private OfftimetableService offtimetableService;
	
	
	public LectureAjaxController() {
		System.out.println(">> LectureAjaxController() 생성");
	}
	
	
	//강의 필터링 검색 post방식
	@PostMapping("/getLecturesFiltering.do")
	public Map<String, Object> getLectureListFilter (@RequestBody Map<String, String> find, Model model) {
		
		System.out.println("LectureAjaxController의 getLecturesFiltering 실행");
		
		System.out.println(find.get("onoff"));
		System.out.println(find.get("searchKeyword"));
		System.out.println(find.get("orderKeyword"));
		System.out.println(find.get("categoryName"));
		System.out.println(find.get("page"));
		System.out.println(find.get("address"));
		
		PagingSK p = paging(find.get("categoryName"), find.get("searchKeyword"), find.get("page"), find.get("onoff"), find.get("address")); //off-on					
		model.addAttribute("p", p);
		
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("onoff", find.get("onoff")); //off라인은 off, on라인은 on
		map.put("searchKeyword", find.get("searchKeyword"));
		map.put("orderKeyword", find.get("orderKeyword"));
		map.put("categoryName", find.get("categoryName"));
		map.put("beginBoard", String.valueOf(p.getBegin()));
		map.put("endBoard", String.valueOf(p.getEnd()));
		map.put("address", find.get("address"));
		
		System.out.println(map);
		List<LectureVO> list = new ArrayList<LectureVO>();
		
		if (find.get("onoff").equals("on")) {
			list = lectureService.getOnLecturesFiltering(map);						
		} else {
			list = lectureService.getLecturesFiltering(map);			
		}
		
		for (LectureVO vo : list) {
			vo.setSalePrice();
			vo.setStudentCount(lectureService.countStudents(vo.getLectureNo())); // 수강생수
			vo.setLectureRate(lectureService.getAvgLecture(vo.getLectureNo())); //평점
			vo.setReviewCount(lectureService.countLectureReview(vo.getLectureNo())); //리뷰 개수
		}
		System.out.println(list.size());
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("list", list);
		jsonMap.put("p", p);
		
		
		System.out.println(list);
		System.out.println("mapper후까지는 실행됨");
		
		System.out.println(p);
		return jsonMap;
	
	}
	

	//강의 필터링 검색 post방식
	@PostMapping("/getLectureLocation.do")
	public Map<String, Object> getLectureListLocation (@RequestBody Map<String, String> find, Model model) {
		
		System.out.println("LectureAjaxController의 getLectureListLocation 실행");
		System.out.println("find: " + find);
		
		//PagingLecRoad p = paging(find.get("categoryName"), find.get("searchKeyword"), "1", "on",); 
		//model.addAttribute("p", p);
		
		
		Map<String, String> map = new HashMap<String, String>();

		

		map.put("address", find.get("address"));
		//map.put("searchKeyword", find.get("searchKeyword"));
		//map.put("orderKeyword", find.get("orderKeyword"));
		//map.put("categoryName", find.get("categoryName"));
		//map.put("beginBoard", String.valueOf(p.getBegin()));
		//map.put("endBoard", String.valueOf(p.getEnd()));
		
		System.out.println();
		List<LectureVO> list = lectureService.searchLectureLocation(map);
		
		for (LectureVO vo : list) {
			vo.setSalePrice();
			vo.setStudentCount(lectureService.countStudents(vo.getLectureNo())); // 수강생수
			vo.setLectureRate(lectureService.getAvgLecture(vo.getLectureNo())); //평점
			vo.setReviewCount(lectureService.countLectureReview(vo.getLectureNo())); //리뷰 개수
		}
		
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("list", list);
		//jsonMap.put("p", p);
		
		
		System.out.println(list);
		System.out.println("mapper후까지는 실행됨");
		
		//System.out.println(p);
		return jsonMap;
		
		
	}
	

	@PostMapping("/getLectureAll.do")
	public List<LectureVO> getLectureAll(Model model) {
		
		List<LectureVO> markList = lectureService.lectureLocationAll();
		model.addAttribute("markList", markList);
		
		return markList;	
	}

	
	public PagingSK paging (String categoryName, String searchKeyword, String page, String onoff, String address) {
		
		PagingSK p =  new PagingSK();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("onoff", onoff);
		map.put("categoryName", categoryName);
		map.put("searchKeyword", searchKeyword);
		map.put("address", address);
		
		if (onoff.equals("on")) {
			p.setTotalRecord(lectureService.getOnLectureTotalCount(map));				
		} else {
			p.setTotalRecord(lectureService.getLectureTotalCount(map));		
		}

		System.out.println("입력되는 map: " + map);
		System.out.println("계산된 totalCount 4여야 함" + p.getTotalRecord());
		p.setTotalPage();
		
		if (page != null && page != "") {
			if (Integer.valueOf(page) > p.getTotalPage()) {
				p.setNowPage(p.getTotalPage());
			} else {				
				p.setNowPage(Integer.valueOf(page));
			}
		}
		
		p.setEnd(p.getNowPage() * p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
		
		if (p.getEnd() > p.getTotalRecord()) {
			p.setEnd(p.getTotalRecord());
		}
		
		int nowPage = p.getNowPage();
		int beginPage = (nowPage - 1) / p.getNumPerBlock() * p.getNumPerBlock() + 1;
		
		p.setBeginPage(beginPage);
		p.setEndPage(beginPage + p.getNumPerBlock() - 1);
		
		if (p.getEndPage() > p.getTotalPage()) {
			p.setEndPage(p.getTotalPage());
		}
		
		return p;
		
	}
	
}
	
