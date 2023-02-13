package com.spring.learn.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.learn.common.PagingSK;
import com.spring.learn.lecture.CategoryVO;
import com.spring.learn.lecture.LectureService;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.roadmap.MyroadmapVO;
import com.spring.learn.roadmap.RoadmapService;
import com.spring.learn.roadmap.RoadmapVO;
import com.spring.learn.user.UserVO;

@Controller					// 단 현재 위치(클래스)에서만 유효
@SessionAttributes({"lecture"}) // lecture라는 이름의 Model객체가 있으면 세션에 저장
@RequestMapping({"/roadmap", "/Lecture"})
public class RoadmapController {

	@Autowired
	private LectureService lectureService;
	
	@Autowired
	private RoadmapService roadmapService;
	
	public RoadmapController() {
		System.out.println(">> RoadmapController() 생성");
	}

	
	//로드맵은 온라인만
	@RequestMapping("/getRoadmapList.do")
	public String getRoadmaps (String categoryNo, String page, Model model) {
				
		//카테고리 가져오기
		//System.out.println("categoryNo:-" + categoryNo + "-");
		List<CategoryVO> categories = lectureService.getCategories();
		//System.out.println(categories);
		model.addAttribute("categories", categories);
		
		//카테고리 이름 찾기
		String categoryName = lectureService.getCategoryName(categoryNo);
		model.addAttribute("categoryName", categoryName);
		//System.out.println(categoryName);
		
		
		//페이징 
		PagingSK p = paging(categoryName, null, null, page);
		model.addAttribute("p", p);
		
		//카테고리별 로드맵 가져오기
		Map<String, String> map = new HashMap<String, String>();
		map.put("categoryName", categoryName);
		map.put("begin", String.valueOf(p.getBegin()));
		map.put("end", String.valueOf(p.getEnd()));
		
		List<RoadmapVO> roadmaps = roadmapService.getRoadmaps(map);
		for (RoadmapVO vo : roadmaps) {
			vo.setUserCount(roadmapService.getTotalRoadmapLike(vo.getRboardNo())); //수강자수
			vo.setLectureCount();
		}
		System.out.println("roadmaps: " + roadmaps);
		model.addAttribute("roadmaps", roadmaps);
		
		return "/Lecture/roadmapList.jsp";
		
	};
	
	
	//로드맵 필터링 검색 post방식
	@PostMapping("/getRoadmapsFiltering.do")
	@ResponseBody
	public Map<String, Object> getLectureListFilter (@RequestBody Map<String, String> find, Model model) {
		
		System.out.println(find.get("searchKeyword"));
		System.out.println(find.get("searchFilter"));
		System.out.println(find.get("orderKeyword"));
		System.out.println(find.get("categoryName"));
		System.out.println(find.get("page"));
		
		
		PagingSK p = paging(find.get("categoryName"), find.get("searchFilter"), find.get("searchKeyword"), find.get("page"));
		model.addAttribute("p", p);
		
		Map<String, String> map = new HashMap<String, String>();

		map.put("searchKeyword", find.get("searchKeyword"));
		map.put("searchFilter", find.get("searchFilter"));
		map.put("orderKeyword", find.get("orderKeyword"));
		map.put("categoryName", find.get("categoryName"));
		map.put("begin", String.valueOf(p.getBegin()));
		map.put("end", String.valueOf(p.getEnd()));
		
		System.out.println(map);
		
		List<RoadmapVO> list = roadmapService.getRoadmapsFiltering(map);
		
		for (RoadmapVO vo : list) {
			vo.setUserCount(roadmapService.getTotalRoadmapLike(vo.getRboardNo())); //수강자수
			vo.setLectureCount();
		}
		
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("list", list);
		jsonMap.put("p", p);
		
		
		//System.out.println(list);
		//System.out.println("mapper후까지는 실행됨");
		
		System.out.println(p);
		return jsonMap;
		
		
	}
	
	
	public PagingSK paging (String categoryName, String searchFilter, String searchKeyword, String page) {

		PagingSK p =  new PagingSK();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("categoryName", categoryName);
		map.put("searchFilter", searchFilter);
		map.put("searchKeyword", searchKeyword);
		
		p.setTotalRecord(roadmapService.getRoadmapTotalCount(map));
		p.setTotalPage();
		//System.out.println("p.setTotalRecord: " + p.getTotalRecord());
		//System.out.println("p.setTotalPage(): " + p.getTotalPage());
		
		if (page != null && page != "") {
			if (Integer.valueOf(page) > p.getTotalPage()) {
				p.setNowPage(p.getTotalPage());
			} else {
				p.setNowPage(Integer.valueOf(page));				
			}
		}
		
		p.setEnd(p.getNowPage()*p.getNumPerPage());
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
	

	// 로드맵 상세 조회
	@RequestMapping("/roadmapDetail.do")
	public String getRoadmapDetail (@RequestParam String rboardNo, Model model, HttpSession session) {

		RoadmapVO roadmapVO = roadmapService.getRoadmapDetail(rboardNo);
		roadmapVO.setUserCount(roadmapService.getTotalRoadmapLike(rboardNo)); // 사용자수 가져오기

		// 사용자가 해당 로드맵 학습하고 있는지 아닌지 확인
		UserVO userVO = (UserVO) session.getAttribute("user");

		// lectureList 자르고 각각 강의정보 가져오기
		String lecNoStr = roadmapVO.getLectureList();
		String[] lecNoArr = lecNoStr.split("/");

		ArrayList<LectureVO> lectureList = new ArrayList<>();
		for(String lecNo : lecNoArr) {
			lectureList.add(lectureService.getLecture(lecNo));
		}

		if(userVO != null) {
			String userId = userVO.getUserId();

			Map<String, String> map = new HashMap<>();
			map.put("rboardNo", rboardNo);
			map.put("userId", userId);
			MyroadmapVO myroadmapVO = roadmapService.getMyroadmap(map);

		int roadmapRate = 0;
		// lecture가 사용자가 구매한 강의인지 확인
		for(LectureVO lecture : lectureList) {
			map = new HashMap<>();
			map.put("lectureNo", lecture.getLectureNo());
			map.put("userId", userId);
			int isBuy = roadmapService.isBuy(map);
			if(isBuy == 0) {
				lecture.setIsBuy(0);
			} else {
				lecture.setIsBuy(1);
				roadmapRate++;
			}
		}
		// 진도율 수정
		if(myroadmapVO != null) {
			myroadmapVO.setRoadmapRate(roadmapRate);
		}

			model.addAttribute("myroadmap", myroadmapVO);
		}

		model.addAttribute("roadmap", roadmapVO);
		model.addAttribute("lectureList", lectureList);

		return "/Lecture/roadmapDetail.jsp";
	}

	// 나의 로드맵 추가
	@RequestMapping("/addMyroadmap.do")
	public String addMyroadmap(@RequestParam String rboardNo, HttpSession session) {

		UserVO userVO = (UserVO) session.getAttribute("user");

		Map<String, String> map = new HashMap<>();
		map.put("rboardNo", rboardNo);
		map.put("userId", userVO.getUserId());

		roadmapService.addMyroadmap(map);
		roadmapService.addUserCount(rboardNo);

		return "redirect:/Lecture/roadmapDetail.do?rboardNo=" + rboardNo;
	}

	// 나의 로드맵 삭제
	@RequestMapping("/removeMyroadmap.do")
	public String removeMyroadmap(@RequestParam String rboardNo, HttpSession session) {

		UserVO userVO = (UserVO) session.getAttribute("user");

		Map<String, String> map = new HashMap<>();
		map.put("rboardNo", rboardNo);
		map.put("userId", userVO.getUserId());

		roadmapService.removeMyroadmap(map);
		roadmapService.removeUserCount(rboardNo);

		return "redirect:/Lecture/roadmapDetail.do?rboardNo=" + rboardNo;
	}
	
}
