package com.spring.learn.view;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.learn.common.Paging;
import com.spring.learn.home.HomeService;
import com.spring.learn.home.HomeVO;
import com.spring.learn.lecture.CategoryVO;
import com.spring.learn.lecture.LectureService;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.roadmap.RoadmapVO;

@Controller					// 단 현재 위치(클래스)에서만 유효
@RequestMapping("/common")
public class CommonController {
	
	@Autowired
	private LectureService lectureService;
	@Autowired
	private HomeService homeService; 
	
	@RequestMapping("/main.do")
	public String getHeaderInfo (HttpSession session, Model model) {
System.out.println(">>> CommonController 실행됨");
		
		//메인 정보(현지) ======================
		List<LectureVO> starterLectureList = homeService.getStarterLectureList();
		System.out.println("starterLectureList : " + starterLectureList);
		for (LectureVO vo : starterLectureList) {
			vo.setSalePrice();
			vo.setStudentCount(lectureService.countStudents(vo.getLectureNo())); // 수강생수
			vo.setLectureRate(lectureService.getAvgLecture(vo.getLectureNo())); //평점
			vo.setReviewCount(lectureService.countLectureReview(vo.getLectureNo())); //리뷰 개수
		}

		List<LectureVO> freeLectureList = homeService.getFreeLectureList();
		System.out.println("freeLectureList : " + freeLectureList);
		for (LectureVO vo : freeLectureList) {
			vo.setStudentCount(lectureService.countStudents(vo.getLectureNo())); // 수강생수
			vo.setLectureRate(lectureService.getAvgLecture(vo.getLectureNo())); //평점
			vo.setReviewCount(lectureService.countLectureReview(vo.getLectureNo())); //리뷰 개수
		}
		
		List<RoadmapVO> indexRoadMapList = homeService.getIndexRoadMapList();
		System.out.println("indexRoadMapList : " + indexRoadMapList);
		
		
		List<HomeVO> indexReviewList = homeService.getIndexReviewList();
		System.out.println("indexReviewList : " + indexReviewList);
		
		model.addAttribute("starterLectureList", starterLectureList);
		model.addAttribute("freeLectureList", freeLectureList);
		model.addAttribute("indexRoadMapList", indexRoadMapList);
		model.addAttribute("indexReviewList", indexReviewList);
		//=================================================
		
		//카테고리 가져오기
		List<CategoryVO> categories = lectureService.getCategories();
		System.out.println(categories);
		session.setAttribute("categories", categories);
		
		return "/Common/index.jsp";
		
	}
	
	@RequestMapping("/getIndexSearch.do")
	public String getIndexSearch (Paging p, HomeVO hvo, Model model) {
		System.out.println(">>> getIndexSearch 실행됨");
		
		p.setNumPerPage(10);
		p.setNumPerBlock(10);
		
		// 전체 페이지 수 구하기
		p.setTotalRecord(homeService.countLectureIndex(hvo));
		p.setTotalPage();
		
		// 현재 페이지 구하기
		if (p.getcPage() != 0) {
			p.setNowPage(p.getcPage());
		}
		
		// 현재 페이지에 시작할 첫게시글 번호, 끝 게시글 번호
		p.setEnd(p.getNowPage()*p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() +1);
		
		// 끝번호가 더 크면 토탈번호와 맞게 하기 - 끝블록 끝페이지 때문
		if (p.getEnd() > p.getTotalRecord()) p.setEnd(p.getTotalRecord());
		
		// 블록 계산하기
		int nowPage = p.getNowPage();
		int beginPage = (nowPage -1) / p.getNumPerBlock() * p.getNumPerBlock() + 1;
		p.setBeginPage(beginPage);
		p.setEndPage(beginPage + p.getNumPerBlock() - 1);
		
		if (p.getEndPage() > p.getTotalPage()) p.setEndPage(p.getTotalPage());		
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchKeyword", hvo.getSearchKeyword());
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));
		
		// 리스트 가져오기
		List<HomeVO> list = homeService.getLectureIndexList(map);
		System.out.println("메인에서 검색된 list 갯수 : " + list.size());
		System.out.println("list : " + list);
		System.out.println("::: searchKeyword : " + hvo.getSearchKeyword());
		
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setSalePrice();
			list.get(i).setStudentCount(lectureService.countStudents(list.get(i).getLectureNo())); // 수강생수
			list.get(i).setLectureRate(lectureService.getAvgLecture(list.get(i).getLectureNo())); //평점
			list.get(i).setReviewCount(lectureService.countLectureReview(list.get(i).getLectureNo())); //리뷰 개수
		}
		
		String result = "all";
		
		model.addAttribute("result", result);
		model.addAttribute("list", list);
		model.addAttribute("p", p);
		model.addAttribute("searchKeyword", hvo.getSearchKeyword());
		
		return "/Common/indexSearch.jsp";
	}
	
	@RequestMapping("/getIndexSearch_on.do")
	public String getIndexSearch_on (Paging p, HomeVO hvo, Model model) {
		System.out.println(">>> getIndexSearch_on 실행됨");
		
		p.setNumPerPage(10);
		p.setNumPerBlock(10);
		
		// 전체 페이지 수 구하기
		p.setTotalRecord(homeService.countLectureIndex_on(hvo));
		p.setTotalPage();
		
		// 현재 페이지 구하기
		if (p.getcPage() != 0) {
			p.setNowPage(p.getcPage());
		}
		
		// 현재 페이지에 시작할 첫게시글 번호, 끝 게시글 번호
		p.setEnd(p.getNowPage()*p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() +1);
		
		// 끝번호가 더 크면 토탈번호와 맞게 하기 - 끝블록 끝페이지 때문
		if (p.getEnd() > p.getTotalRecord()) p.setEnd(p.getTotalRecord());
		
		// 블록 계산하기
		int nowPage = p.getNowPage();
		int beginPage = (nowPage -1) / p.getNumPerBlock() * p.getNumPerBlock() + 1;
		p.setBeginPage(beginPage);
		p.setEndPage(beginPage + p.getNumPerBlock() - 1);
		
		if (p.getEndPage() > p.getTotalPage()) p.setEndPage(p.getTotalPage());		
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchKeyword", hvo.getSearchKeyword());
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));
		
		// 리스트 가져오기
		List<HomeVO> list = homeService.getLectureIndexList_on(map);
		System.out.println("메인에서 검색된 list 갯수 : " + list.size());
		System.out.println("list : " + list);
		System.out.println("::: searchKeyword : " + hvo.getSearchKeyword());
		
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setSalePrice();
			list.get(i).setStudentCount(lectureService.countStudents(list.get(i).getLectureNo())); // 수강생수
			list.get(i).setLectureRate(lectureService.getAvgLecture(list.get(i).getLectureNo())); //평점
			list.get(i).setReviewCount(lectureService.countLectureReview(list.get(i).getLectureNo())); //리뷰 개수
		}
		
		String result = "on";
		
		model.addAttribute("result", result);
		model.addAttribute("list", list);
		model.addAttribute("p", p);
		model.addAttribute("searchKeyword", hvo.getSearchKeyword());
		
		return "/Common/indexSearch.jsp";
	}
	
	@RequestMapping("/getIndexSearch_off.do")
	public String getIndexSearch_off (Paging p, HomeVO hvo, Model model) {
		System.out.println(">>> getIndexSearch_off 실행됨");
		
		p.setNumPerPage(10);
		p.setNumPerBlock(10);
		
		// 전체 페이지 수 구하기
		p.setTotalRecord(homeService.countLectureIndex_off(hvo));
		p.setTotalPage();
		
		// 현재 페이지 구하기
		if (p.getcPage() != 0) {
			p.setNowPage(p.getcPage());
		}
		
		// 현재 페이지에 시작할 첫게시글 번호, 끝 게시글 번호
		p.setEnd(p.getNowPage()*p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() +1);
		
		// 끝번호가 더 크면 토탈번호와 맞게 하기 - 끝블록 끝페이지 때문
		if (p.getEnd() > p.getTotalRecord()) p.setEnd(p.getTotalRecord());
		
		// 블록 계산하기
		int nowPage = p.getNowPage();
		int beginPage = (nowPage -1) / p.getNumPerBlock() * p.getNumPerBlock() + 1;
		p.setBeginPage(beginPage);
		p.setEndPage(beginPage + p.getNumPerBlock() - 1);
		
		if (p.getEndPage() > p.getTotalPage()) p.setEndPage(p.getTotalPage());		
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchKeyword", hvo.getSearchKeyword());
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));
		
		// 리스트 가져오기
		List<HomeVO> list = homeService.getLectureIndexList_off(map);
		System.out.println("메인에서 검색된 list 갯수 : " + list.size());
		System.out.println("list : " + list);
		System.out.println("::: searchKeyword : " + hvo.getSearchKeyword());
		
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setSalePrice();
			list.get(i).setStudentCount(lectureService.countStudents(list.get(i).getLectureNo())); // 수강생수
			list.get(i).setLectureRate(lectureService.getAvgLecture(list.get(i).getLectureNo())); //평점
			list.get(i).setReviewCount(lectureService.countLectureReview(list.get(i).getLectureNo())); //리뷰 개수
		}
		
		String result = "off";
		
		model.addAttribute("result", result);
		model.addAttribute("list", list);
		model.addAttribute("p", p);
		model.addAttribute("searchKeyword", hvo.getSearchKeyword());
		
		return "/Common/indexSearch.jsp";
	}
	
	@RequestMapping("imgUpload.do")
	@ResponseBody
	public String uploadMailImageFile(@RequestParam("file") MultipartFile file) throws IOException {
        
		System.out.println("uploadFile.isEmpty() : " + file.isEmpty());
        String fileName = file.getOriginalFilename(); //원본파일명
        System.out.println("::: 원본파일명 : " + fileName);

        String savedFileName = UUID.randomUUID().toString();
        System.out.println("::: 저장파일명 : " + savedFileName);

        //물리적 파일 복사
        String url = "\\\\192.168.18.11\\temp\\" + savedFileName;
        file.transferTo(new File(url));

        return savedFileName;
	}

}
