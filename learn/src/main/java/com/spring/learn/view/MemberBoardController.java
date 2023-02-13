package com.spring.learn.view;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.learn.common.Paging;
import com.spring.learn.memberboard.AdminQNAReplyService;
import com.spring.learn.memberboard.AdminQNAReplyVO;
import com.spring.learn.memberboard.CallcenterCommentVO;
import com.spring.learn.memberboard.MemberBoardService;
import com.spring.learn.memberboard.MemberBoardVO;
import com.spring.learn.memberboard.OrdersDetailVO;
import com.spring.learn.user.UserService;
import com.spring.learn.user.UserVO;

@Controller					// 단 현재 위치(클래스)에서만 유효
@SessionAttributes({"memberBoard", "callBvo", "cvoList", "myOrderDetailList"}) // memberBoard라는 이름의 Model객체가 있으면 세션에 저장
@RequestMapping("/memberBoard")
public class MemberBoardController {

	@Autowired
	private MemberBoardService memberBoardService;
	
	@Autowired
	private AdminQNAReplyService adminQNAReplyService;
	
	@Autowired
	private UserService userService;
	
	
	public MemberBoardController() {
		System.out.println(">> MemberBoardController() 생성");
	}
	
	// 검색과 페이지 보기, 페이징- 아작스 버전 하나 만들기
	@RequestMapping("/getMyQBoardList.do")
	public String getQnaBoardList(MemberBoardVO bvo, Model model, Paging p, HttpSession session) {
		System.out.println(">>> 보드리스트 가져오기 bvo : " + bvo);		
		UserVO uvo = (UserVO) session.getAttribute("user");
		
		bvo.setUserId(uvo.getUserId());
		bvo.setUserGrade(uvo.getGrade());
		
		System.out.println("bvo : " + bvo);
		model.addAttribute("memberBoard", bvo);
		
		if(uvo.getUserId() == null) {
			return "redirect:/Member/login.do";
		}
		
		getMyQBoardListCommon(bvo, model, p, uvo);

		return "/Member/MemberBoard/myQBoardList.jsp"; // 이동
	}
	
	
	// 검색과 페이지 보기, 페이징- 아작스 버전 하나 만들기
	@RequestMapping("/getMyQBoardListAj.do")
	public String getMyQBoardListAj(MemberBoardVO bvo, Model model, Paging p, HttpSession session) {
		
		System.out.println(">>> 보드리스트 가져오기");		
		UserVO uvo = (UserVO) session.getAttribute("user");
		bvo.setUserId(uvo.getUserId());
		
		System.out.println("vo : " + bvo);
		bvo.setUserGrade(uvo.getGrade());
		model.addAttribute("memberBoard", bvo);
		
		if(uvo.getUserId() == null) {
			return "redirect:/Member/login.do";
		}
		
		System.out.println("vo : " + bvo);
		if(bvo.getQnaAdopt().equals("미해결")) {
			bvo.setQnaAdopt("FALSE");
		} else if(bvo.getQnaAdopt().equals("해결됨")) {
			bvo.setQnaAdopt("TRUE");
		} else if(bvo.getQnaAdopt().equals("전체")) {
			bvo.setQnaAdopt(null);
		}
		
		getMyQBoardListCommon(bvo, model, p, uvo);
		
		return "/Member/MemberBoard/searchQboard/SearchQboard.jsp"; // 이동
		
	}
		// 검색과 페이지 보기, 페이징- 아작스 버전 하나 만들기
		@RequestMapping("/getMyQBoardListM.do")
		public String getQnaBoardListM(MemberBoardVO bvo, Model model, Paging p, HttpSession session) {
			System.out.println(">>> 보드리스트 가져오기");		
			UserVO uvo = (UserVO) session.getAttribute("user");
			bvo.setUserId(uvo.getUserId());
			
			System.out.println("vo : " + bvo);
			bvo.setUserGrade(uvo.getGrade());
			model.addAttribute("memberBoard", bvo);
			
			if(uvo.getUserId() == null) {
				return "redirect:/Member/login.do";
			}
			
			getMyQBoardListCommon(bvo, model, p, uvo);

			return "/Admin/adminQnA.jsp"; // 이동
		}

	private void getMyQBoardListCommon(MemberBoardVO bvo, Model model, Paging p, UserVO uvo) {
		bvo.setUserId(uvo.getUserId());
		bvo.setUserGrade(uvo.getGrade());
		
		model.addAttribute("memberBoard", bvo);
		
		
		// 전체 페이지 수 구하기 - 이게 유저 아이디로 찾아야함 - > 일반 게시판에서는 조건으로 바꿔야함 , 검색 키워드와 유저아이디로
		
		System.out.println(">>>>> 토탈페이지 들어가기 전 bvo : " + bvo);
		p.setTotalRecord(memberBoardService.countBoard(bvo));
		
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
		map.put("searchKeyword", bvo.getSearchKeyword());
		map.put("userId", uvo.getUserId());
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));
		map.put("qnaAdopt", bvo.getQnaAdopt());
		map.put("grade", uvo.getGrade());
		
		System.out.println(">>>>> map : " + map);
		
		// 리스트 가져오기
		List<MemberBoardVO> memberBoardList = memberBoardService.getBoardList(map); // 조회하고
		
		for(MemberBoardVO board : memberBoardList) {
			
			String getId = board.getUserId();
			
			UserVO vo = new UserVO();
			vo.setUserId(getId);
			
			vo = userService.confirmUser(vo);
			String setName = vo.getUserName();
			board.setUserName(setName);
		}		
		
		// 리스트 모델에 저장
		if (memberBoardList != null) {
			model.addAttribute("memberBoardList", memberBoardList); // 값 저장하고
			model.addAttribute("pvo", p);
		}		
		
		System.out.println("memberBoardList : " + memberBoardList);
	}
	
	
	
	
	// 입력폼으로 이동
	@GetMapping("/qnaWriteForm.do")
	public String toQnaWriteForm(MemberBoardVO bvo) {
		System.out.println(">>> qna작성폼 이동");						
				
		return "/Member/MemberBoard/myQWriteForm.jsp"; // 이동
	}
	
	// 입력
	@PostMapping("/qnaWriteForm.do")
	public String QnaWrite(MemberBoardVO mvo, HttpSession session) {
		
		UserVO uvo = (UserVO) session.getAttribute("user");
		
		if(uvo == null) {
			return "/Member/login.do";
		}
		
		mvo.setUserId(uvo.getUserId());
		mvo.setGrade(uvo.getGrade());
		
		System.out.println(">> QnaWrite 입력 도착, uvo : " + uvo);
		System.out.println(">> QnaWrite 입력 도착, mvo : " + mvo);		
		
		memberBoardService.insertBoard(mvo);						
		
		return "/memberBoard/getMyQBoardList.do"; // 이동
	}
	
	// 수정폼으로 이동
	@GetMapping("/qnaModifyForm.do")
	public String toModifyForm(MemberBoardVO bvo, Model model) {
		System.out.println(">>> qna 수정폼 이동");	
		
		// vo 받아서 한개 가져오고 세션에 등록
		bvo = memberBoardService.getBoard(bvo);
		model.addAttribute("callBvo", bvo);
		
		System.out.println(">> 검색후 callBvo : "+ bvo);		
		
		return "/Member/MemberBoard/myQModifyForm.jsp"; // 이동
	}
	
	// 수정
	@PostMapping("/qnaModifyForm.do")
	public String QnaModify(MemberBoardVO mvo, HttpSession session) {
		
		UserVO uvo = (UserVO) session.getAttribute("user");
		
		if(uvo == null) {
			return "/Member/login.do";
		}
		
		mvo.setUserId(uvo.getUserId());
		mvo.setGrade(uvo.getGrade());
		
		System.out.println(">> Qna수정 입력 도착, uvo : " + uvo);
		System.out.println(">> Qna수정 입력 도착, mvo : " + mvo);		
		
		memberBoardService.updateBoard(mvo);
		
		return "/memberBoard/getMyQBoardList.do"; // 이동
	}
	
	
	@GetMapping("/viewPage.do")
	public String viewPage(MemberBoardVO bvo, Model model) {
		System.out.println(">>> 보드 상세페이지로 이동 : " + bvo);
		
		// vo 받아서 한개 가져오고 세션에 등록
		bvo = memberBoardService.getBoard(bvo);
		
		// 이름 입력 - 보드 상세에
		String getName = bvo.getUserId();
		UserVO vo = new UserVO();
		vo.setUserId(getName);
		vo = userService.confirmUser(vo);
		String setName = vo.getUserName();
		bvo.setUserName(setName);
		
		model.addAttribute("callBvo", bvo);
		
		System.out.println(">> 검색후 callBvo : "+ bvo);
		
		// 커멘트 가져오기
		List<CallcenterCommentVO> cvoList = memberBoardService.getCallcenterComment(bvo);
		
		if(cvoList.size() > 0) {
			getName = cvoList.get(0).getUserId();
			vo.setUserId(getName);
			vo = userService.confirmUser(vo);
			String setsName = vo.getUserName();
			cvoList.get(0).setUserName(setsName);
		}
		
		model.addAttribute("cvoList", cvoList);
		model.addAttribute("cvoCnt", cvoList.size());
		
		System.out.println(">>>>> cvoList : " + cvoList);
				
		return "/Member/MemberBoard/myQBoard.jsp"; // 이동
	}
	
	
	// 삭제하기
	@RequestMapping("/deleteBoard.do")
	public String deleteBoard(MemberBoardVO bvo) {
		System.out.println(">>> 삭제하기 : " + bvo);
		
		memberBoardService.deleteBoard(bvo);
		
		return "/memberBoard/getMyQBoardList.do"; // 이동
	}
	
	
	
	//  CallcenterComment 부분 -> 댓글 부분
	
	// 여기 리스폰스바디로 해서 에이젝스 처리 할 예정
	// 코멘트 입력하기
	@PostMapping("/addCallcenterComment.do")
	public String addCallcenterComment(CallcenterCommentVO cvo, HttpSession session, Model model, MemberBoardVO bvo) {
		
		UserVO uvo = (UserVO) session.getAttribute("user");
		
		if(uvo == null) {
			return "/Member/login.do";
		}
		
		cvo.setUserId(uvo.getUserId());
		cvo.setGrade(uvo.getGrade());
		
		System.out.println(">> QnaWrite 입력 도착, uvo : " + uvo);
		System.out.println(">> QnaWrite 입력 도착, cvo : " + cvo);
		
		
		memberBoardService.addCallcenterComment(cvo);
		
		// 커멘트 가져오기
		bvo = (MemberBoardVO) session.getAttribute("callBvo");
		List<CallcenterCommentVO> cvoList = memberBoardService.getCallcenterComment(bvo);
		
		model.addAttribute("cvoList", cvoList);
		
		model.addAttribute("cvoCnt", cvoList.size());
		
		return "/Member/MemberBoard/myQBoard.jsp"; // 이동
	}
	
	
	// 코멘트 삭제하기
	@RequestMapping("/delCallcenterComment.do")
	public String delCallcenterComment(CallcenterCommentVO cvo, Model model, MemberBoardVO bvo, HttpSession session) {
		System.out.println(">>> 삭제하기 : " + cvo);
		
		memberBoardService.delCallcenterComment(cvo);
		
		// 커멘트 가져오기
		bvo = (MemberBoardVO) session.getAttribute("callBvo");
		List<CallcenterCommentVO> cvoList = memberBoardService.getCallcenterComment(bvo);
		
		model.addAttribute("cvoList", cvoList);
		
		model.addAttribute("cvoCnt", cvoList.size());
		
		
		System.out.println(">>>>> cvoList : " + cvoList);
		
		return "/Member/MemberBoard/myQBoard.jsp"; // 이동
	}
	
	
	
	
	
	
	@RequestMapping("/inquiryDetail.do")
	public String getInquiryDetail(@ModelAttribute MemberBoardVO vo, Model model) {

		System.out.println(">>> MemberBoardController.getInquiryDetail 실행");		
		System.out.println("vo : " + vo);
				
		MemberBoardVO memberBoard = memberBoardService.getBoard(vo); // 조회하고
		AdminQNAReplyVO adminQNAReply = adminQNAReplyService.getReply(vo.getQnaNo());
		System.out.println(memberBoard);
		System.out.println(adminQNAReply);
		model.addAttribute("memberBoard", memberBoard);
		model.addAttribute("adminQNAReply", adminQNAReply);
		
		return "/Member/inquiryDetail.jsp"; // 이동
		
	}

	
	//여기서는 이정문꺼
	@RequestMapping("/cBoardList.do")
	@ResponseBody
	public List<MemberBoardVO> cBoardList(MemberBoardVO vo) {
		System.out.println(">>> 보드리스트 가져오기");		
		System.out.println("vo : " + vo);
				
		List<MemberBoardVO> cBoardList = memberBoardService.getBoardList(vo); // 조회하고
		System.out.println(cBoardList);

		return cBoardList; // 이동
	}
	
	@RequestMapping("/resolvedCBoardList.do")
	@ResponseBody
	public List<MemberBoardVO> resolvedCBoardList(MemberBoardVO vo) {
		System.out.println(">>> 해결 보드리스트 가져오기");		
				
		List<MemberBoardVO> resolvedCBoardList = memberBoardService.resolvedCBoardList(vo); // 조회하고
		

		return resolvedCBoardList; // 이동
	}
	
	@RequestMapping("/unResolvedCBoardList.do")
	@ResponseBody
	public List<MemberBoardVO> unResolvedCBoardList(MemberBoardVO vo) {
		System.out.println(">>> 미해결 보드리스트 가져오기");		
				
		List<MemberBoardVO> unResolvedCBoardList = memberBoardService.unResolvedCBoardList(vo); // 조회하고
		

		return unResolvedCBoardList; // 이동
	}
	
	@RequestMapping("/callCenterBoardList.do")
	public String callCenterBoardList(MemberBoardVO vo, Model model) {
		System.out.println(">>> 콜센터보드 첫 페이징 하기");		
				
		List<MemberBoardVO> BoardList = memberBoardService.getBoardList(vo); // 조회하고
		model.addAttribute("BoardList", BoardList); // 값 저장하고
		System.out.println(BoardList);
		return "/Member/inquiry.jsp"; // 이동
	}
	
	
	// 내학습 부분
	// 내 학습 리스트 보기 - 일반검색
	@GetMapping("/goMyLectureList.do")
	public String goMyLectureList(UserVO uvo, HttpSession session, Model model, OrdersDetailVO oov) {
		System.out.println(">>> 내 학습 리스트 보기로 이동");	
		uvo = (UserVO) session.getAttribute("user");
		
		if (uvo.getUserId() == null) {
			return "/member/login.do";
		}
		
		oov.setUserId(uvo.getUserId());
		
		List<OrdersDetailVO> myOrderDetailList = memberBoardService.goMyLectureList(oov);
		
		model.addAttribute("myOrderDetailList", myOrderDetailList);
		
		System.out.println("oov : " + oov);
		System.out.println("myOrderDetailList : " + myOrderDetailList);
		
				
		return "/Member/MemberBoard/MyLectureList.jsp"; // 이동
	}
	
	
	// 내학습 부분 - ajax 검색
	// 내 학습 리스트 보기
	@GetMapping("/goMyLectureListAj.do")
	@ResponseBody
	public List<OrdersDetailVO> goMyLectureListAj(UserVO uvo, HttpSession session, Model model, OrdersDetailVO oov) {
		System.out.println(">>> 내 학습 리스트 보기로 이동");	
		uvo = (UserVO) session.getAttribute("user");
				
		oov.setUserId(uvo.getUserId());
		
		List<OrdersDetailVO> myOrderDetailList = memberBoardService.goMyLectureList(oov);
		
		model.addAttribute("myOrderDetailList", myOrderDetailList);
		
		System.out.println("oov : " + oov);
		System.out.println("myOrderDetailList : " + myOrderDetailList);
		
				
		return myOrderDetailList;
	}
	
	
	
	
	
	
	
	
	
	
	
}
