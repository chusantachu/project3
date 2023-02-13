package com.spring.learn.view;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.learn.common.PagingSK;
import com.spring.learn.lecture.CategoryVO;
import com.spring.learn.lecture.ClassService;
import com.spring.learn.lecture.LectureService;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.lecture.OfftimetableService;

@Controller	// 단 현재 위치(클래스)에서만 유효
@SessionAttributes({"lecture"}) // lecture라는 이름의 Model객체가 있으면 세션에 저장
@RequestMapping("/lecture")
public class LectureController {

	@Autowired
	private LectureService lectureService;
	
	@Autowired
	private ClassService classService;
	
	@Autowired
	private OfftimetableService offtimetableService;
	
	
	public LectureController() {
		System.out.println(">> LectureController() 생성");
	}

	
	//online일 때
	@RequestMapping("/getOnlineLectureList.do")
	public String getOnlineLectureList (String categoryNo, String page, Model model) {
		
		//카테고리 가져오기
		System.out.println("categoryNo:-" + categoryNo + "-");
		List<CategoryVO> categories = lectureService.getCategories();
		//System.out.println(categories);
		model.addAttribute("categories", categories);
		
		//카테고리 이름 찾기
		String categoryName = lectureService.getCategoryName(categoryNo);
		//System.out.println(categoryName);

		model.addAttribute("categoryName", categoryName);						
		
		PagingSK p = paging(categoryName, page, "on"); //off라인은 off
		model.addAttribute("p", p);
		
		Map<String, String> search = new HashMap();
		search.put("categoryName", categoryName);
		search.put("beginBoard", String.valueOf(p.getBegin()));
		search.put("endBoard", String.valueOf(p.getEnd()));
		//System.out.println("비긴 보드: " +p.getBegin() + ", 엔드보드: " + p.getEnd());
		//카테고리별 온라인 강의 가져오기
		List<LectureVO> lectures = lectureService.getOnlineLectures(search);
		System.out.println("lectures: " + lectures);
		model.addAttribute("lectures", lectures);
		
		for (LectureVO vo : lectures) {
			vo.setSalePrice();
			vo.setStudentCount(lectureService.countStudents(vo.getLectureNo())); // 수강생수
			vo.setLectureRate(lectureService.getAvgLecture(vo.getLectureNo())); //평점
			vo.setReviewCount(lectureService.countLectureReview(vo.getLectureNo())); //리뷰 개수
		}
		System.out.println("lectures: " + lectures);
		
		return "/Lecture/onlineLectureList.jsp";
		
	};
	
	//offline일 때
	@RequestMapping("/getOfflineLectureList.do")
	public String getOfflineLectureList (String categoryNo, String page, Model model) {
		
		//카테고리 가져오기
		System.out.println("categoryNo:-" + categoryNo + "-");
		List<CategoryVO> categories = lectureService.getCategories();
		//System.out.println(categories);
		model.addAttribute("categories", categories);
		
		//카테고리 이름 찾기
		String categoryName = lectureService.getCategoryName(categoryNo);
		//System.out.println(categoryName);

		model.addAttribute("categoryName", categoryName);						
		
		PagingSK p = paging(categoryName, page, "off"); //off라인은 off
		model.addAttribute("p", p);
		
		Map<String, String> search = new HashMap();
		search.put("categoryName", categoryName);
		search.put("beginBoard", String.valueOf(p.getBegin()));
		search.put("endBoard", String.valueOf(p.getEnd()));
		//System.out.println("비긴 보드: " +p.getBegin() + ", 엔드보드: " + p.getEnd());
		//카테고리별 온라인 강의 가져오기
		List<LectureVO> lectures = lectureService.getOfflineLectures(search);
		System.out.println("lectures: " + lectures);
		model.addAttribute("lectures", lectures);
		
		for (LectureVO vo : lectures) {
			vo.setSalePrice();
			vo.setStudentCount(lectureService.countStudents(vo.getLectureNo())); // 수강생수
			vo.setLectureRate(lectureService.getAvgLecture(vo.getLectureNo())); //평점
			vo.setReviewCount(lectureService.countLectureReview(vo.getLectureNo())); //리뷰 개수
		}
		System.out.println("lectures: " + lectures);
		
		return "/Lecture/offlineLectureList.jsp";
		
		
	};
	
	
	
	
	
	public PagingSK paging (String categoryName, String page, String onoff) {
		
		PagingSK p =  new PagingSK();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("onoff", onoff);
		map.put("categoryName", categoryName);
				
		if (onoff.equals("on")) {
			p.setTotalRecord(lectureService.getOnLectureTotalCount(map));				
		} else {
			p.setTotalRecord(lectureService.getLectureTotalCount(map));		
		}
		
		
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

	// 실시간 질문: 학생
	@RequestMapping("/realtimeQuestion.do")
	public String realtimeQuestion(@RequestParam String lectureNo, Model model) {
	LectureVO lecture = lectureService.getLecture(lectureNo);
	model.addAttribute("lecture", lecture);
	return "/Lecture/realtimeQuestion.jsp";
	}

	
}
