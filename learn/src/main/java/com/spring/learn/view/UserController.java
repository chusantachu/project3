package com.spring.learn.view;

import com.spring.learn.common.PagingJS;
import com.spring.learn.user.PointLogVO;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.learn.board.BoardService;
import com.spring.learn.board.BoardVO;

import com.spring.learn.common.Paging;

import com.spring.learn.lecture.LectureService;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.user.LikeVO;
import com.spring.learn.user.MailSendService;
import com.spring.learn.user.UserService;
import com.spring.learn.user.UserVO;

// @RequestMapping 클래스 선언부 사용시
// 모든 메소드 요청경로의 부모(root) 경로로 추가됨
@RequestMapping({"/Member", "/member"})
@Controller
public class UserController {
	@Autowired
	private MailSendService mailService;
	@Autowired
	private UserService userService;
    @Autowired
    private LectureService lectureService;
    @Autowired
    private BoardService boardService;

	@RequestMapping("/insertUser.do")
	public String insertUser(@ModelAttribute UserVO vo) {
		System.out.println(">>> 회원가입");
		System.out.println("vo : " + vo);

		userService.insertUser(vo);

		System.out.println(">> 회원가입 성공!!!");
		
		return "/Common/index.jsp";
	}
	
	//이메일인증
	@RequestMapping("/mailCheck.do")
	@ResponseBody
	public String mailCheck(String email) {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 인증 이메일 : " + email);
		return mailService.joinEmail(email);
	}
	
	//현재 비밀번호 체크
	@RequestMapping("/pwdCheck.do")
	@ResponseBody
	public int pwdCheck(UserVO vo) {
		System.out.println("비밀번호 체크 요청이 들어옴!");
		int cnt = 0;
		UserVO vo2 = userService.getUser(vo);
		System.out.println("vo2: "+vo2);
		if(vo2 != null) {
			cnt = 1;
			return cnt;
		}else {
			cnt = 0;
			return cnt;
		}
	}
	
	//현재 Id 체크
	@RequestMapping("/insertIdCheck.do")
	@ResponseBody
	public int insertIdCheck(UserVO vo) {
		System.out.println("아이디 체크 요청이 들어옴!");
		System.out.println("vo : " + vo);
		
		int cnt = userService.getUserId(vo);
		System.out.println("cnt : " + cnt);
		
		return cnt;
	}

	//로그인 처리
@RequestMapping(value = "/login.do", method = RequestMethod.POST) // 4.3버전 부터 사용가능
public String login(HttpServletRequest request, UserVO vo, Model model){
		System.out.println(">>> 로그인 처리임");
		System.out.println("vo : " + vo);

		UserVO user = userService.getUser(vo);

		String str = "/Common/index.jsp";

		//3. 화면 네비게이션(화면전환, 화면이동)
		if (user != null) { // 로그인 성공
			System.out.println(">> 로그인 성공!!!");
			HttpSession session = request.getSession();
			UserVO vo2 = userService.getUser(vo);
			session.setAttribute("user", vo2);
			if (vo2.getGrade().equals("관리자")) {
				str = "/Admin/adminIndex.do"; //회원등급이 관리자일 경우 관리자 페이지로 전환
			} else {
				str = "/common/main.do";
			}
		} else { // 로그인 실패
			System.out.println(">> 로그인 실패~~~");
			model.addAttribute("loginError", "loginError");
		}
		return str;
	}

	 /*
	 //로그인 처리
	 @RequestMapping(value = "/login.do", method = RequestMethod.POST) // 4.3버전 부터 사용가능
	 public String login(HttpServletRequest request, UserVO vo){
		 System.out.println(">>> 로그인 처리임"); System.out.println("vo : " + vo);
	
		 UserVO user = userService.getUser(vo);
		 
		 //3. 화면 네비게이션(화면전환, 화면이동) // 로그인 성공 : 게시글 목록 보여주기 // 로그인 실패 : 로그인 화면으로 이동
		 if (user != null) {
			 System.out.println(">> 로그인 성공!!!");
			 HttpSession session = request.getSession();
			 UserVO vo2 = userService.getUser(vo);
			 session.setAttribute("user", vo2);
			 } 
		 else {
			 
			 System.out.println(">> 로그인 실패~~~");
			 
			 
			 }
		 return "/Common/index.jsp";
	 }
	 */

	 /*
	  * @RequestMapping(value = "/login.do", method = RequestMethod.GET) // 4.3버전 부터 사용가능 
	 public String loginView(@ModelAttribute("user") UserVO vo, Model model) {
		 System.out.println(">>> 로그인 화면 이동 - loginView()");

		 return "/Member/login.jsp";
	 }
	  * */

	  @RequestMapping("/logout.do") public String logout(HttpSession session) {
		  System.out.println(">> 로그아웃 처리");
			session.removeAttribute("user");
		  return "redirect:/common/main.do";
	  }
	  
	//현재 Id 체크
	@RequestMapping("modifyUser.do")
	public String modifyUser(HttpServletRequest request, UserVO vo) {
		System.out.println("아이디 수정 요청이 들어옴!");
		System.out.println("vo : " + vo);
		
		int c = userService.modifyUser(vo);
		System.out.println(c);
		 HttpSession session = request.getSession();
		 UserVO vo2 = userService.getUser(vo);
		 session.setAttribute("user", vo2);
		
		return "myPage.jsp";
	}
	
	
	@RequestMapping("/changePasswordPage.do")
	public String moveToChangePage (HttpSession session) {
		System.out.println("==== skController moveToChangePage() 실행 ====");
		String userId = ((UserVO)session.getAttribute("vo")).getUserId();
		System.out.println("userId: " + userId);		
		return "/Member/changePassword.jsp";
	}
	
	
	@RequestMapping("/changePassword.do")
	public String changePassword (@ModelAttribute UserVO user, HttpSession session) {
		System.out.println("==== skController changePassword() 실행 ====");
		//System.out.println("userId: " + ((UserVO)session.getAttribute("user")).getUserId());		
		String userId = ((UserVO)session.getAttribute("vo")).getUserId();
		//user.setUserId(userId);
		user.setUserId(userId);
		System.out.println("세션 데이터 삭제 전 " + session.getAttribute("vo"));
		
		userService.changePwd(user);
		
		System.out.println("userPassword: " + user.getUserPwd());		
		
		session.removeAttribute("vo");
		System.out.println(session.getAttribute("vo"));
		return "/Member/changePasswordOK.jsp";
	}
	
	
	@RequestMapping("/deleteUser.do")
	public String deleteUser (HttpSession session) {
		UserVO user = (UserVO) session.getAttribute("user");
		System.out.println("삭제 전 user: " + user);
		userService.deleteUser(user);
		return "/Common/index.jsp";
	}

	@RequestMapping("/googleLogin.do")
	@ResponseBody
	public String googleLogin(@ModelAttribute UserVO userVO, HttpServletRequest request) {

		HttpSession session = request.getSession();

		UserVO user = userService.confirmUser(userVO);

		if (user != null) {
			System.out.println(">> 구글 로그인 성공!!!");
		} else {
			System.out.println(">> 구글 회원가입!!!");
			userService.insertUser(userVO);
		}

		user = userService.confirmUser(userVO);
		session.setAttribute("user", user);
		System.out.println(session.getAttribute("user"));

		return "main.do";
	}

	@RequestMapping("/checkSignUp.do")
	@ResponseBody
	public int checkSignUp(@ModelAttribute UserVO userVO) {

		UserVO user = userService.confirmUser(userVO);

		if (user == null) {
			System.out.println(">> 가입한 적 없음");
			return 0;
		}

		return 1;
	}

	// 공통: 페이징 처리
	private PagingJS makePaging(String cPage, int totalRecord) {

		PagingJS p = new PagingJS();

		// 1. 전체 게시물 수량 구하기
		p.setTotalRecord(totalRecord);
		p.setTotalPage();

		// 2. 현재 페이지 구하기
		if(cPage != null) {
			p.setNowPage(Integer.parseInt(cPage));
		}

		// 3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end) 구하기
		p.setEnd(p.getNowPage() * p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() + 1);

		// 3-1.(선택적) 끝번호(end)가 건수보다 많으면 데이터 건수와 동일하게 처리
		if (p.getEnd() > p.getTotalRecord()) {
			p.setEnd(p.getTotalRecord());
		}

		// 4. 블록 시작페이지, 끝페이지 구하기(현재페이지 번호 사용)
		int nowPage = p.getNowPage();
		int beginPage = (nowPage - 1) / p.getNumPerBlock() * p.getNumPerBlock() + 1;
		p.setBeginPage(beginPage);
		p.setEndPage(beginPage + p.getNumPerBlock() - 1);

		// 끝페이지(endPage)가 전체 페이지 수(totalPage) 보다 크면
		// 끝페이지를 전체페이지 수로 변경 처리
		if (p.getEndPage() > p.getTotalPage()) {
			p.setEndPage(p.getTotalPage());
		}

		return p;
	}


	// 포인트 조회
	@RequestMapping("/viewPoints.do")
	public String viewPoints(@RequestParam(value = "cPage", required = false) String cPage,
			Model model, HttpSession session) {
		UserVO user = (UserVO) session.getAttribute("user");
		String userId = user.getUserId();

		PagingJS p = makePaging(cPage, userService.getPointLogCount(userId));

		Map<String, String> map = new HashMap<>();
		map.put("userId", userId);
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));

		List<PointLogVO> list = userService.getPointLogList(map);
		model.addAttribute("list", list);
		model.addAttribute("pvo", p);

		return "/Member/viewPoints.jsp";
	}

	// 포인트 조회 페이징
	@RequestMapping("/getPointPaging.do")
	@ResponseBody
	public Map<Object, Object> viewPointsPaging(@RequestParam String cPage, HttpSession session) {

		Map<Object, Object> map = new HashMap<>();

		UserVO user = (UserVO) session.getAttribute("user");
		String userId = user.getUserId();

		PagingJS p = makePaging(cPage, userService.getPointLogCount(userId));

		Map<String, String> pmap = new HashMap<>();
		pmap.put("userId", userId);
		pmap.put("begin", Integer.toString(p.getBegin()));
		pmap.put("end", Integer.toString(p.getEnd()));

		map.put("pmap", userService.getPointLogList(pmap));
		map.put("pvo", p);

		return map;
	}

	
	@RequestMapping("/likeGo.do")
	public String likeGo (LikeVO vo, Model model) {
		System.out.println(">>>likeGo() 실행");
		System.out.println("LikeVO vo : " + vo);
		List<LikeVO> likeList = userService.getLikeList(vo);
		System.out.println("likeList : >>>" + likeList);
		for(LikeVO cvo : likeList) {
			int a = 0;//별점 사람 수 용
			int b = 0;//별점 평균 용
			int c = 0;//주문한 상품인지 아닌지 체크 용
			a = userService.getReviewCnt(cvo);
			b = userService.getReviewRate(cvo);
			c = userService.getOrderCh(cvo);
			if (c == 0) {
				cvo.setOrderCh(c);				
			} else {
				cvo.setOrderCh(1);
			}
			cvo.setReviewCnt(a);//리뷰에 참가한 사람 수
			cvo.setReviewRate(b);// 리뷰에 별점 평균
			cvo.setReviewAverage();
			cvo.setLectureSalePrice();//세일되서 총금액
			cvo.setRealSalePrice();//세일 되는 금액
			System.out.println("cvo : "+cvo);
		}
		
		model.addAttribute("likeList", likeList);
		System.out.println(likeList);
		
		return "/Member/myLike.jsp";
	}
	//좋아요 추가
		@RequestMapping("/insertLike.do")
		@ResponseBody
		public LikeVO insertLike(LikeVO vo) {
			System.out.println("insertLike 좋아요 추가!");
			System.out.println("vo : " + vo);
			LikeVO Lvo = userService.getLectureTeacherId(vo);
			userService.insertLike(vo);
			
			return Lvo;
		}
	//좋아요 삭제
	@RequestMapping("/deleteLike.do")
	@ResponseBody
	public LikeVO deleteLike(LikeVO vo) {
		System.out.println("deleteLike 좋아요 삭제!");
		System.out.println("vo : " + vo);
		LikeVO Lvo = userService.getLectureTeacherId(vo);
		userService.deleteLike(vo);
		
		return Lvo;
	}
	//카테고리 정렬
	@RequestMapping("/searchLike.do")
	public String searchLike2(LikeVO vo, Model model) {
		System.out.println("searchLike 검색요청이 들어왔어요~!");
		System.out.println("vo : " + vo);
		//System.out.println("list : " + list);
		String searchStatus = vo.getSearchStatus();//유료 무료 전체 체크
		String searchOrder = vo.getSearchOrder();//정렬 기준 선택
		List<LikeVO> list = new ArrayList<LikeVO>();
		/////
		List<LikeVO> likeList = userService.getLikeList(vo);
		for(LikeVO cvo : likeList) {
			int a = 0;//별점 사람 수 용
			int b = 0;//별점 평균 용
			int c = 0;//주문한 상품인지 아닌지 체크 용
			a = userService.getReviewCnt(cvo);
			b = userService.getReviewRate(cvo);
			c = userService.getOrderCh(cvo);
			if (c == 0) {
				cvo.setOrderCh(c);				
			} else {
				cvo.setOrderCh(1);
			}
			cvo.setReviewCnt(a);//리뷰에 참가한 사람 수
			cvo.setReviewRate(b);// 리뷰에 별점 평균
			cvo.setReviewAverage();
			cvo.setLectureSalePrice();//세일되서 총금액
			cvo.setRealSalePrice();//세일 되는 금액
		}
		/////list = list.stream().sorted(Comparator.comparing(Student::getMath)).collect(Collectors.toList());
		if (searchOrder.equalsIgnoreCase("reviewAverage")) {
			System.out.println(">>>likeList : "+likeList);
			for(LikeVO cvo : likeList) {
				double v = userService.getReviewAverage(cvo);
				int test = (int)(v*10);
				cvo.setReviewSearchAverage(test);
				System.out.println(cvo.getReviewSearchAverage());
			}
			System.out.println("여기까지는 오는거지?");
			likeList = likeList.stream().sorted(Comparator.comparing(LikeVO::getReviewSearchAverage).reversed()).collect(Collectors.toList());
			System.out.println(">>>이게 진짜 된다고? likeList!!!!"+likeList);
			if(searchStatus.equals("전체")) {
				System.out.println("전체 검색");
				model.addAttribute("likeList2",  likeList);
				return "/Member/myLikeAjaxList.jsp";
			} else if(searchStatus.equals("유료")) {
				for (int i = 0; i < likeList.size(); i++) {
					if(likeList.get(i).getLecturePrice() > 0) {
						list.add(likeList.get(i));
					}
				}
				model.addAttribute("likeList2",  list);
				return "/Member/myLikeAjaxList.jsp";
			} else if(searchStatus.equals("무료")) {
				for (int i = 0; i < likeList.size(); i++) {
					if(likeList.get(i).getLecturePrice() == 0) {
						list.add(likeList.get(i));
					}
				}
				model.addAttribute("likeList2",  list);
				return "/Member/myLikeAjaxList.jsp";
			}
			
		}else {
			if(searchStatus.equals("전체")) {
				System.out.println("전체 검색");
				System.out.println("이값을 보내줍니다 vo : " + vo);
				list = userService.getSearchLikeList(vo);					
			} else if(searchStatus.equals("유료")) {
				System.out.println("유료 검색");
				list = userService.getSearchPaidLikeList(vo);
			} else if(searchStatus.equals("무료")) {
				list = userService.getSearchFreeLikeList(vo);
			}
			
			for(LikeVO cvo : list) {
				int a = 0;//별점 사람 수 용
				int b = 0;//별점 평균 용
				int c = 0;//주문한 상품인지 아닌지 체크 용
				a = userService.getReviewCnt(cvo);
				b = userService.getReviewRate(cvo);
				c = userService.getOrderCh(cvo);
				if (c == 0) {
					cvo.setOrderCh(c);				
				} else {
					cvo.setOrderCh(1);
				}
				cvo.setReviewCnt(a);//리뷰에 참가한 사람 수
				cvo.setReviewRate(b);// 리뷰에 별점 평균
				cvo.setReviewAverage();
				cvo.setLectureSalePrice();//세일되서 총금액
				cvo.setRealSalePrice();//세일 되는 금액
			}
		}
		
		System.out.println("리턴 전 list : " + list);
		
		model.addAttribute("likeList2",  list);
		return "/Member/myLikeAjaxList.jsp";
	}
	//==============================================================================
	
	//관리자페이지를 위한 추가 기능=========================
	@RequestMapping("/rejectResumeMail.do")
	@ResponseBody
	public String rejectResumeMail(String email) {
		System.out.println("수신 이메일 주소 : " + email);
		return mailService.rejectResumeMail(email);
	}

	@RequestMapping("/approveResumeMail.do")
	@ResponseBody
	public String approveResumeMail(String email) {
		System.out.println("수신 이메일 주소 : " + email);
		return mailService.approveResumeMail(email);
	}
	//==============================
	
	
	@RequestMapping("/goToPersonalPage.do")
	public String PersonalPage(UserVO vo, Model model) {
		
		//사용자 페이지를 위한
		UserVO person = userService.findUserId(vo); //아이디로 유저 정보 가져오기
		model.addAttribute("person", person);
		
		System.out.println(person.getGrade());

		// 게시글 가져오기(지수)
		Map<String, String> map = new HashMap<>();
		map.put("userId", vo.getUserId());
		map.put("order", "1");
		map.put("begin", "1");
		map.put("end", "5");

		List<BoardVO> boardList = boardService.getMyBoardList(map);
		model.addAttribute("boardList",  boardList);
		
		// 게시글 가져오기(지수)
		
		if (person.getGrade().equals("강의자")) {
	        // 총 수강생 수
			Integer studentCnt = lectureService.getStudentCount(person.getUserId());
			model.addAttribute("studentCnt", studentCnt);

			// 평균 평점
			String lectureRate = String.format("%.2f", lectureService.getLectureAvgRate(person.getUserId()));
			model.addAttribute("lectureRate", lectureRate);
	        
	        //!!!!!!!!!!!!강의자 프로필 조회 기능(현지)====================
	        List<LectureVO> lectures = lectureService.getLectureProfile(person);
			for (int i = 0; i < lectures.size(); i++) {
				lectures.get(i).setSalePrice();
				lectures.get(i).setStudentCount(lectureService.countStudents(lectures.get(i).getLectureNo())); // 수강생수
				lectures.get(i).setLectureRate(lectureService.getAvgLecture(lectures.get(i).getLectureNo())); //평점
				lectures.get(i).setReviewCount(lectureService.countLectureReview(lectures.get(i).getLectureNo())); //리뷰 개수
			}			
			
			List<LectureVO> all = lectureService.getLectureProfileAll(person);
			
			if (all.size() != 0) {
				model.addAttribute("lecturesSize", all.size());
			}
	        System.out.println("lectures : " + lectures);
	        System.out.println("lectures.size() : " + lectures.size());
	        
	        model.addAttribute("lectures", lectures);
	        //=======================================
	        
			return "/Member/userPage.jsp";		
			
		} else {
			return "/Member/userGeneralPage.jsp";
		}
	}
	
	@ResponseBody
	@RequestMapping("/editUserIntro.do")
	public Map<String, String> UserIntro(UserVO vo, HttpSession session) {
		Map<String, String> map = new HashMap<>();
		System.out.println(vo);
		userService.updateUserIntro(vo);
		session.setAttribute("user", userService.getUser((UserVO)session.getAttribute("user")));
		System.out.println((UserVO)session.getAttribute("user"));
		map.put("intro", ((UserVO)session.getAttribute("user")).getUserIntro());
		return map;
	}
	
	//사용자조회 - 강의목록(현지)
	@RequestMapping("/goToPersonalPage_Lecture.do")
	public String goToPersonalPage_Lecture(UserVO vo, Paging p, Model model) {
		
		UserVO person = userService.findUserId(vo); 
		System.out.println("person : " + person);
		model.addAttribute("person", person);
		
        Integer studentCnt = lectureService.getStudentCount(person.getUserId());
        model.addAttribute("studentCnt", studentCnt);
        
        String lectureRate = String.format("%.2f", lectureService.getLectureAvgRate(person.getUserId()));
        model.addAttribute("lectureRate", lectureRate);
        
        //==================================================
        p.setNumPerPage(6);
		p.setNumPerBlock(10);
		
		// 전체 페이지 수 구하기
		p.setTotalRecord(lectureService.countLectureProfilePage(person));
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
		
		System.out.println("계산된 lectures paging : " + p);
		
		Map<String, Object> map = new HashMap<>();
		map.put("userId", person.getUserId());
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));
		
		List<LectureVO> all = lectureService.getLectureProfileAll(person);
		if (all.size() != 0) {
			model.addAttribute("lecturesSize", all.size());
		}

		// 리스트 가져오기
		List<LectureVO> list = lectureService.getLectureProfilePage(map);
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setSalePrice();
			list.get(i).setStudentCount(lectureService.countStudents(list.get(i).getLectureNo())); // 수강생수
			list.get(i).setLectureRate(lectureService.getAvgLecture(list.get(i).getLectureNo())); //평점
			list.get(i).setReviewCount(lectureService.countLectureReview(list.get(i).getLectureNo())); //리뷰 개수
		}	
				
		// 리스트 모델에 저장
		if (list != null) {
			model.addAttribute("lectures", list);
			model.addAttribute("pvo", p);
		}		
		
		System.out.println("list : " + list);
		
		String listUp = "new";
		model.addAttribute("listUp", listUp);
        
		return "/Member/userPageLecture.jsp";		
			
	}
	
	//사용자조회 - 강의목록(현지) - 오래된순
	@RequestMapping("/goToPersonalPage_Lecture_old.do")
	public String goToPersonalPage_Lecture_old(UserVO vo, Paging p, Model model) {
		
		UserVO person = userService.findUserId(vo); 
		System.out.println("person : " + person);
		model.addAttribute("person", person);
		
        Integer studentCnt = lectureService.getStudentCount(person.getUserId());
        model.addAttribute("studentCnt", studentCnt);
        
        String lectureRate = String.format("%.2f", lectureService.getLectureAvgRate(person.getUserId()));
        model.addAttribute("lectureRate", lectureRate);
        
        //==================================================
        p.setNumPerPage(6);
		p.setNumPerBlock(10);
		
		// 전체 페이지 수 구하기
		p.setTotalRecord(lectureService.countLectureProfilePage(person));
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
		
		System.out.println("계산된 lectures paging : " + p);
		
		Map<String, Object> map = new HashMap<>();
		map.put("userId", person.getUserId());
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));
		
		List<LectureVO> all = lectureService.getLectureProfileAll(person);
		if (all.size() != 0) {
			model.addAttribute("lecturesSize", all.size());
		}

		// 리스트 가져오기
		List<LectureVO> list = lectureService.getLectureProfilePage_old(map);
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setSalePrice();
			list.get(i).setStudentCount(lectureService.countStudents(list.get(i).getLectureNo())); // 수강생수
			list.get(i).setLectureRate(lectureService.getAvgLecture(list.get(i).getLectureNo())); //평점
			list.get(i).setReviewCount(lectureService.countLectureReview(list.get(i).getLectureNo())); //리뷰 개수
		}	
				
		// 리스트 모델에 저장
		if (list != null) {
			model.addAttribute("lectures", list);
			model.addAttribute("pvo", p);
		}		
		
		System.out.println("list : " + list);
		
		String listUp = "old";
		model.addAttribute("listUp", listUp);
        
		return "/Member/userPageLecture.jsp";		
			
	}

	@RequestMapping("/userBoardPageAjax.do")
	@ResponseBody
	public Map<Object, Object> userBoardPageAjax(@RequestParam String userId,
			@RequestParam String order,
			@RequestParam String type,
			@RequestParam String cPage) {

		Map<String, String> pmap = new HashMap<>();
		pmap.put("userId", userId);
		pmap.put("order", order);
		pmap.put("type", type);

		System.out.println("개수: " + boardService.getMyBoardCount(pmap));
		PagingJS p = makePaging(cPage, boardService.getMyBoardCount(pmap));

		pmap.put("begin", Integer.toString(p.getBegin()));
		pmap.put("end", Integer.toString(p.getEnd()));

		Map<Object, Object> map = new HashMap<>();
		map.put("pmap", boardService.getMyBoardList(pmap));
		map.put("pvo", p);

		return map;

	}

	@RequestMapping("/userBoardPage.do")
	public String userBoardPage(UserVO vo, Model model, @RequestParam(value = "order", required = false) String order,
			@RequestParam(value = "type", required = false) String type,
			@RequestParam(value = "cPage", required = false) String cPage) {

		//사용자 페이지를 위한
		UserVO person = userService.findUserId(vo); //아이디로 유저 정보 가져오기
		model.addAttribute("person", person);

		Map<String, String> map = new HashMap<>();
		map.put("userId", vo.getUserId());
		map.put("order", (order == null ? "1" : order));
		if(type != null && !type.equals("0")) {
			map.put("type", type);
		}

		PagingJS p = makePaging(cPage, boardService.getMyBoardCount(map));

		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));

		List<BoardVO> boardList = boardService.getMyBoardList(map);
		model.addAttribute("boardList",  boardList);
		model.addAttribute("pvo", p);

		// 페이징 처리
		return "/Member/userBoardPage.jsp";
	}

	// 마이페이지: 작성한 게시글(질문)
	@RequestMapping("/myQuestion.do")
	public String myQuestion(HttpSession session, Model model,
			@RequestParam(value = "order", required = false) String order,
			@RequestParam(value = "cPage", required = false) String cPage) {

		UserVO user = (UserVO) session.getAttribute("user");

		Map<String, String> pmap = new HashMap<>();
		pmap.put("userId", user.getUserId());
		pmap.put("order", order);
		pmap.put("type", "1");

		PagingJS p = makePaging(cPage, boardService.getMyBoardCount(pmap));

		pmap.put("begin", Integer.toString(p.getBegin()));
		pmap.put("end", Integer.toString(p.getEnd()));

		model.addAttribute("list", boardService.getMyBoardList(pmap));
		model.addAttribute("pvo", p);

			return "/Member/myQuestion.jsp";
	}

	// 마이페이지: 작성한 게시글(자유주제)
	@RequestMapping("/myFree.do")
	public String myFree(HttpSession session, Model model,
			@RequestParam(value = "order", required = false) String order,
			@RequestParam(value = "cPage", required = false) String cPage) {
			UserVO user = (UserVO) session.getAttribute("user");

			Map<String, String> pmap = new HashMap<>();
			pmap.put("userId", user.getUserId());
			pmap.put("order", order);
			pmap.put("type", "2");

			PagingJS p = makePaging(cPage, boardService.getMyBoardCount(pmap));

			pmap.put("begin", Integer.toString(p.getBegin()));
			pmap.put("end", Integer.toString(p.getEnd()));

			model.addAttribute("list", boardService.getMyBoardList(pmap));
			model.addAttribute("pvo", p);

			return "/Member/myFree.jsp";
	}

	@RequestMapping("/myFreeAjax.do")
	public String userFreeAjax(@RequestParam String order, HttpSession session,
			@RequestParam String cPage, Model model) {

		UserVO user = (UserVO) session.getAttribute("user");

		Map<String, String> pmap = new HashMap<>();
		pmap.put("userId", user.getUserId());
		pmap.put("order", order);
		pmap.put("type", "2");

		PagingJS p = makePaging(cPage, boardService.getMyBoardCount(pmap));

		pmap.put("begin", Integer.toString(p.getBegin()));
		pmap.put("end", Integer.toString(p.getEnd()));

		model.addAttribute("list2", boardService.getMyBoardList(pmap));
		model.addAttribute("pvo", p);

		return "/Member/myFreeAjax.jsp";

	}

	@RequestMapping("/myQuestionAjax.do")
	public String userQuestionAjax(@RequestParam String order, HttpSession session,
			@RequestParam String cPage, @RequestParam String status, Model model) {

		UserVO user = (UserVO) session.getAttribute("user");

		Map<String, String> pmap = new HashMap<>();
		pmap.put("userId", user.getUserId());
		pmap.put("order", order);
		pmap.put("type", "1");
		pmap.put("status", status);

		PagingJS p = makePaging(cPage, boardService.getMyQBoardCount(pmap));

		pmap.put("begin", Integer.toString(p.getBegin()));
		pmap.put("end", Integer.toString(p.getEnd()));

		model.addAttribute("list2", boardService.getMyQBoardList(pmap));
		model.addAttribute("pvo", p);

		return "/Member/myQuestionAjax.jsp";

	}

}
