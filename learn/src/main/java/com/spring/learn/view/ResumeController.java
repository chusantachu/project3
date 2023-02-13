package com.spring.learn.view;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.learn.common.Paging;
import com.spring.learn.resume.ResumeService;
import com.spring.learn.resume.ResumeVO;
import com.spring.learn.user.UserService;
import com.spring.learn.user.UserVO;

@SessionAttributes("resume")
@RequestMapping({"/Member", "/memberBoard", "/Admin"})
@Controller
public class ResumeController {
	
	@Autowired
	private ResumeService resumeService;

	@Autowired
	private UserService userService;
	
	/*
	 * @RequestMapping : 요청과 처리(Controller) 연결(HandlerMapping 역할 대체)
	 * Command 객체 사용 : 파라미터로 전달되는 값을 Command 객체에 설정
	 * 1. UserVO 타입 객체 생성
	 * 2. UserVO 타입 객체에 전달받은 파라미터 값을 설정(이름 일치하는 경우)
	 * 3. UserVO 타입 객체를 메소드의 파라미터 값으로 전달
	 */
	//@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	@RequestMapping("/Belecture/insertResume.do") 
	public String insertResume(ResumeVO vo) {
		System.out.println("받은 데이터 vo : " + vo);
		
		resumeService.insertResume(vo);
	
		return "/Member/myPage.jsp";
	}
	
	@RequestMapping("/updateResume.do") 
	public String updateResume(ResumeVO vo) {
		System.out.println("받은 데이터 vo : " + vo);
		
		resumeService.updateResume(vo);
	
		return "getResume.do";
	}
	
	@RequestMapping("/deleteResume.do") 
	public String deleteResume(ResumeVO vo) {
		System.out.println("받은 데이터 vo : " + vo);
		
		resumeService.deleteResume(vo);
	
		return "myPage.jsp";
	}
	
	@RequestMapping("/getResume.do")
	public String getResume(ResumeVO vo, Model model ) {
		System.out.println("받은 데이터 vo :" + vo);
		
		vo = resumeService.getResume(vo);
		
		if (vo == null) {
			vo = new ResumeVO();
		}
		model.addAttribute("resume", vo);
		
		return "/Member/Belecture/viewLectureApply.jsp";
		
	}
	
	//관리자페이지 데이터 확인용 =============================
	@RequestMapping("/getFalseResume.do")
	public String getFalseResume(ResumeVO vo, Paging p, Model model) {
		System.out.println(">>> getFalseResume 접속");

		p.setNumPerPage(10);
		p.setNumPerBlock(10);
		
		// 전체 페이지 수 구하기
		p.setTotalRecord(resumeService.countFalseResume());
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
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));
		
		System.out.println(">>>>> map : " + map);

		// 리스트 가져오기
		List<ResumeVO> list = resumeService.getFalseResume(map);
		System.out.println("getFalseResumeList : " + list);

		// 리스트 모델에 저장
		if (list != null) {
			model.addAttribute("resumeFalseList", list); // 값 저장하고
			model.addAttribute("pvo", p);
		}		
		
		return "/Admin/adminResumeManager.jsp";
		
	}

	@RequestMapping("/getTrueResume.do")
	@ResponseBody 
	public Map<String, Object> getTrueResume(ResumeVO vo, Paging p) {
		System.out.println(">>> getTrueResume 접속");
		
		p.setNumPerPage(10);
		p.setNumPerBlock(10);
		
		// 전체 페이지 수 구하기
		p.setTotalRecord(resumeService.countTrueResume());
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
		
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));
		

		// 리스트 가져오기
		List<ResumeVO> list = resumeService.getTrueResume(map);
		System.out.println("getTrueResumeList : " + list);
		
		Map<String, Object> data = new HashMap<String, Object>();
		
		data.put("list", list);
		data.put("pvo", p);
		
		return data;
	}

	@RequestMapping("/getResumeDetail.do")
	public String getResumeDetail(ResumeVO vo, Model model ) {
		
		ResumeVO resume = resumeService.getResume(vo);
		System.out.println("받은 getResumeDetail resume :" + resume);
		
		model.addAttribute("resume", resume);
		
		return "/Admin/adminResumeView.jsp";
		
	}

	@RequestMapping("/resumeApprove.do") 
	public String resumeApprove(ResumeVO vo, UserVO vo2, Model model) {
		System.out.println("resumeApprove vo : " + vo);
		
		String approve = "approve";
		resumeService.updateResumeStatus(vo); //resume 테이블 업데이트
		userService.updateUserLecture(vo2); //users 테이블 grade 업데이트
		
		model.addAttribute("userId", vo.getUserId());
		model.addAttribute("result", approve);

		return "getFalseResume.do";
	}

	@RequestMapping("/resumeReject.do") 
	public String resumeReject(ResumeVO vo, Model model) {
		System.out.println("resumeApprove vo : " + vo);
		
		String reject = "reject";
		resumeService.deleteResume(vo);
		
		model.addAttribute("userId", vo.getUserId());
		model.addAttribute("result", reject);

		return "getFalseResume.do";
	}

	//===================================
	
	
	
	
}
