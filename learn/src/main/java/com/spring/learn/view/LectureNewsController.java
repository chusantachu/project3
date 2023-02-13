package com.spring.learn.view;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.learn.common.Paging;
import com.spring.learn.lecture.LectureNewsService;
import com.spring.learn.lecture.LectureNewsVO;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.memberboard.MemberBoardVO;
import com.spring.learn.user.UserVO;

//@SessionAttributes : board라는 이름의 Model 있으면 session에 저장
//  단, 현재위치(클래스)에서만 유효
@Controller
@SessionAttributes("lectureNews") 
public class LectureNewsController { 
	@Autowired
	private LectureNewsService lectureNewsService;
	@Autowired
	private SqlSessionTemplate mybatis;
	
	// 검색과 페이지 보기
	@RequestMapping("/getLectureNewsList.do")
	public String getLectureNewsList(LectureNewsVO vo, Model model, Paging p) {
		System.out.println(">>> getLectureNewsList.do 접속, 전달된 vo : " + vo);

		p.setNumPerPage(10);
		p.setNumPerBlock(10); 
		
		// 전체 페이지 수 구하기
		p.setTotalRecord(lectureNewsService.countBoard(vo));
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
		
		System.out.println("계산된 paging : " + p);
		
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("lectureNo", vo.getLectureNo());
		map.put("searchKeyword", vo.getSearchKeyword());
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));
		
		System.out.println(">>>>> map : " + map);

		// 리스트 가져오기
		List<LectureNewsVO> list = lectureNewsService.getLectureNewsList(map);
		
		LectureVO lecList = mybatis.selectOne("com.spring.learn.lecture.impl.LectureDAO.getLecture", vo.getLectureNo());
		System.out.println("lectureTitle : " + lecList.getLectureTitle());
		
		// 리스트 모델에 저장
		if (list != null) {
			model.addAttribute("list", list); // 값 저장하고
			model.addAttribute("pvo", p);
			model.addAttribute("lectureNo", vo.getLectureNo());
			model.addAttribute("lectureTitle", lecList.getLectureTitle());
		} else if (list == null) {
			model.addAttribute("lectureNo", vo.getLectureNo());
			model.addAttribute("lectureTitle", lecList.getLectureTitle());
		}
		
		System.out.println("새소식 list : " + list);

		return "/Teacher/noticeManager.jsp"; // 이동
	}
	
	//게시글 상세보기
	@RequestMapping("/getLectureNews.do")
	public String getLectureNews(LectureNewsVO vo, Model model) {
		System.out.println(">> 게시글 상세 보여주기");
		
		LectureNewsVO vo2 = lectureNewsService.getLectureNews(vo);
		System.out.println("상세보기 vo2 : " + vo2);

		model.addAttribute("vo", vo2);
		
		return "Teacher/lectureNewsView.jsp";
	}
	
	//게시글 삭제
	@RequestMapping("/deleteLectureNews.do")
	public String deleteLectureNews(LectureNewsVO vo) {
		System.out.println(">> 게시글 삭제하기");
		
		lectureNewsService.deleteLectureNews(vo);
	
		return "getLectureNewsList.do";
	}
	
	//강의 넘버 넘겨주기
	@RequestMapping("/lectureNewsWrite.do")
	public String lectureNewsWrite(LectureNewsVO vo, Model model) {
		System.out.println(">> 강의 넘버 넘겨주기");

		System.out.println("강의넘버 넘겨주기 vo : " + vo);
		model.addAttribute("lectureNo", vo.getLectureNo());
		
		return "Teacher/lectureNewsWrite.jsp";
	}
	
	//게시글 추가
	@RequestMapping("/insertLectureNews.do")
	public String inserNotice(HttpServletRequest request, Model model, LectureNewsVO vo) {
		System.out.println(">> 게시글 추가하기");
		
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user");
		
		System.out.println("현재 로그인된 값 : " + user);
		
		vo.setLectureWriter(user.getUserName());
		
		System.out.println("insert vo : " + vo);
		
		lectureNewsService.insertLectureNews(vo);
		int boardNo = lectureNewsService.lastNo();
		vo.setBoardNo(boardNo);
		
		model.addAttribute("vo", vo);
		System.out.println("basic에 전달되는 vo : " + vo);
	
		return "Teacher/lectureManagerBasic.jsp";
	}
	
	//게시글 수정을 위한 정보 불러오기
	@RequestMapping("/getLectureNewsUpdateView.do")
	public String getLectureNewsUpdateView(LectureNewsVO vo, Model model) {
		System.out.println(">> 게시글 수정을 위한 정보 불러오기");
		
		LectureNewsVO vo2 = lectureNewsService.getLectureNews(vo); 
		
		model.addAttribute("vo", vo2);
		System.out.println("getLectureNewsUpdateView vo2 : " + vo2);
		
		return "Teacher/lectureNewsUpdate.jsp";
	}
	
	//게시글 수정(관리자)
	@RequestMapping("/updateLectureNews.do")
	public String updateLectureNews(Model model, LectureNewsVO vo) {
		System.out.println(">> 게시글 수정하기");
		
		System.out.println("update vo : " + vo);
		
		lectureNewsService.updateLectureNews(vo);
		
		model.addAttribute("vo", vo);
	
		return "Teacher/lectureManagerBasic.jsp";
	}
	
    @RequestMapping("/uploadLecterNewsImage.do")
    @ResponseBody
    public String uploadImage(@RequestParam("file") MultipartFile uploadFile) throws IOException {

        System.out.println("uploadFile.isEmpty() : " + uploadFile.isEmpty());
        String fileName = uploadFile.getOriginalFilename(); //원본파일명
        System.out.println("::: 원본파일명 : " + fileName);

        String savedFileName = UUID.randomUUID().toString();
        System.out.println("::: 저장파일명 : " + savedFileName);

        //물리적 파일 복사
        String url = "c:/MyStudy/temp/" + savedFileName;
        uploadFile.transferTo(new File(url));

        return savedFileName;
    }
	
}
