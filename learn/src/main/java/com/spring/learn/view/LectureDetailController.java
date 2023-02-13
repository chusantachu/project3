package com.spring.learn.view;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.learn.lecture.ClassVO;
import com.spring.learn.lecture.LectureCommentVO;
import com.spring.learn.lecture.LectureDetailService;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.lecture.OfftimetableVO;
import com.spring.learn.user.UserVO;


@RequestMapping({"/Common", "/Member"})
@Controller
public class LectureDetailController {
	
	@Autowired
	private LectureDetailService lectureDetailService;
	
	//강의를 눌렀을때 자세한 정보들 가져오면서 여러가지 체크요소들 확인
	@RequestMapping("/getLecture.do") 
	public String getLectureDetail(LectureVO vo, Model model, HttpSession session) {
		LectureVO lecture = lectureDetailService.getLectureDetail(vo);
		model.addAttribute("lecture",lecture);
		
		//미리 보기로 들어갔을때 다시 돌아가려면 lectureNo정보가 필요해서 저장해둠
		session.setAttribute("lecture", lecture);
		
//		UserVO user =  (UserVO) session.getAttribute("user");
//		getMyBoardNo(vo.getLectureNo(), user.getUserId(), model);
		
		getLectureLike(vo, model); 
		checkLecturer(model, session, lecture.getUserId(), lecture.getLectureNo());
		checkLike(vo.getLectureNo() ,model, session);
		System.out.println(lectureDetailService.getLectureDetail(vo));
		
		LectureCommentVO count = new LectureCommentVO();
		count.setLectureNo(Integer.parseInt(vo.getLectureNo()));
		System.out.println(count);
		count = lectureDetailService.getCounts(count);
		System.out.println(count);
		model.addAttribute("count",count );
		System.out.println("온라인? 오프라인? : " + lecture.getLectureOnOff());
		
		//온라인 수업인 경우
		if (lecture.getLectureOnOff().equals("0")) {
			System.out.println("온라인");
			getClasses(vo.getLectureNo(), model);
		} else if (lecture.getLectureOnOff().equals("1")) {
			System.out.println("오프라인");
			getTimetables(vo.getLectureNo(), model);
		}
		
		return "/Lecture/lectureDetail.jsp";
		
	}
	
	//상세페이지에서 동영상 이동할때 max,min 구해서 저장해놓고 가기
	@RequestMapping("/previewD.do") 
	public String previewD(String classNo, Model model, int min, int max, HttpSession session) {
		ClassVO vo = lectureDetailService.getClassDetail(classNo);
		model.addAttribute("classdetail", vo);
		session.setAttribute("min", min);
		session.setAttribute("max", max);
		System.out.println("Class : " + vo);
		System.out.println("min : " + min + " max : " + max);
		return "/Lecture/videoClass.jsp";
	}
	
	//동영상 페이지에서 이전, 다음처리하여 이동할때 사용
	@RequestMapping("/preview.do") 
	public String preview(String classNo, Model model) {
		ClassVO vo = lectureDetailService.getClassDetail(classNo);
		model.addAttribute("classdetail", vo);
		System.out.println("Class : " + vo);
		
		return "/Lecture/videoClass.jsp";
	}
	
	
	//해당 강의의 좋아요수 확인
	public void getLectureLike(LectureVO vo, Model model) {
		System.out.println("getLectureLike()");
		model.addAttribute("lectureLike",lectureDetailService.getLectureLike(vo)); 
		System.out.println(lectureDetailService.getLectureLike(vo));
		
	}
	//로그인한 유저의 좋아요 여부 확인
	public void checkLike(String lectureNo, Model model, HttpSession session) {
		System.out.println("checkLike()");
		UserVO vo =(UserVO) session.getAttribute("user");
		//로그인 안된경우
		if (vo==null) {
			model.addAttribute("checkLike","2");
		} else {
			HashMap<String, String> map = new HashMap<>();
			map.put("lectureNo", lectureNo);
			map.put("userId", vo.getUserId());
			System.out.println(map);
			model.addAttribute("checkLike",lectureDetailService.checkLike(map)); 
		}
		
		
//		System.out.println("checkLike : " + lectureDetailService.checkLike(map));
		
	}
	
	//로그인한 유저가 해당강의의 구매자인지(해야할것) 강의자인지 확인
	public void checkLecturer(Model model, HttpSession session, String lecturerId, String lectureNo) {
		UserVO vo = (UserVO) session.getAttribute("user");
		String userId = "";
		int num = 0;
		
		if (vo !=null) {
		userId = vo.getUserId();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("lectureNo", lectureNo);
		num = lectureDetailService.checkpurchase(map);
		System.out.println("num : " + num);
		
		}
		
		
		//로그인 안된경우
		if(vo==null) {
			model.addAttribute("lecturer", "visitor");			
		} 
		//로그인한 유저아이디와 해당강의 아이디가 같은경우 
		else if (userId.equals(lecturerId)){
			model.addAttribute("lecturer", "lecturer");
		} 
			else if(num > 0) {
			model.addAttribute("lecturer", "student");			
		} 
			else{
			model.addAttribute("lecturer", "viewer");
		}

	}
	
	//온라인 강의의 경우에 클래스들 정보 가져오기
	public void getClasses(String lectureNo, Model model) {
		List<ClassVO> list = lectureDetailService.getClasses(lectureNo);
		System.out.println("getClasses() : " + list);
		model.addAttribute("classes", list);
		
	}
	
	//오프라인 강의의 경우 시간표 정보들 가져오기
	public void getTimetables(String lectureNo, Model model) {
		List<OfftimetableVO> list = lectureDetailService.getTimetables(lectureNo);
		System.out.println("getTimetables() : " + list);
		model.addAttribute("timetables", list);
		System.out.println(list);
	}
	
	//장바구니에 추가
	@RequestMapping("/insertCart.do")
	public String insertCart(String lectureNo, HttpSession session, String timetableNo) {
		System.out.println("카트에 추가~ 카트로 이동");
		UserVO user = (UserVO) session.getAttribute("user");
		
		String pathway = "";
		//유저아이디, 강의번호, 타임테이블넘버(오프라인인 경우)를 조건으로 구매한 경험이 있는지 확인 한다
		//있을 경우에는 장바구니에 넣지않고 이미 구매한 상품이라는 창이 뜨면서 막는다
		//없을경우 바로 insert처리 
		
		
		HashMap<String, String> map = new HashMap<>();
		map.put("userId", user.getUserId());
		map.put("lectureNo", lectureNo);
		map.put("timetableNo", timetableNo);
		System.out.println(map);
		
		int checkValue = lectureDetailService.checkpurchase(map);
		System.out.println(lectureDetailService.checkpurchase(map));
		System.out.println("checkValue : " + checkValue);
		
		if (checkValue != 0) {
			//오류창으로 가져서 alert으로 "이미 구매한 상품입니다" 라는 창을 띄워주고 session에 저장된 lecture의 lectureNo로 다시 
			//getLecture.do?lectureNo=lecture.lectureNo로 다시 요청처리한다
			pathway = "/Lecture/invalidPurchase.jsp";
			
		} else {
			//카트내부도 확인해서 있을경우 장바구니에 상품을 넣는 과정은 생략하고 바로 장바구니 페이지로 이동한다
			int checkCartValue = lectureDetailService.checkCart(map);
			
			if (checkCartValue ==0) {
				lectureDetailService.insertCart(map);
			} 
		
			pathway = "myCartGo.do?userId=" + user.getUserId();
			System.out.println(pathway);
		}
		
		
		
		return pathway;
	}
	
	//디테일 창 들어갈때 본인이 작성한 댓글이 어떤게있는지 조회해보려고했는데 어려움
	public int[] getMyBoardNo(String lectureNo, String userId, Model model) {
		
		HashMap<String, String> map = new HashMap<>();
		map.put("userId",userId);
		map.put("lectureNo", lectureNo);
		int[] arr = lectureDetailService.getMyBoardNo(map);
		model.addAttribute("myboardNo", arr);
		
		return arr;
	}
	
}
