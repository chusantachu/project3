package com.spring.learn.view;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.support.RequestPartServletServerHttpRequest;

import com.spring.learn.echo.AlramService;
import com.spring.learn.echo.AlramVO;
import com.spring.learn.memberboard.MemberBoardVO;
import com.spring.learn.order.OrderCartVO;
import com.spring.learn.user.ChatService;
import com.spring.learn.user.ChatVO;
import com.spring.learn.user.LikeVO;
import com.spring.learn.user.MailSendService;
import com.spring.learn.user.UserService;
import com.spring.learn.user.UserVO;

// @RequestMapping 클래스 선언부 사용시
// 모든 메소드 요청경로의 부모(root) 경로로 추가됨
@RequestMapping({"/alram", "/Alram"})
@Controller
public class AlramController {
	
	@Autowired
	private AlramService alramService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ChatService chatService;
	
	@RequestMapping("/chatGoAdmin.do") // 4.3버전 부터 사용가능
	 public String chatGoAdmin(UserVO vo, Model model){
		 System.out.println(">>> chatGoAdmin 처리임");
		 System.out.println("vo : " + vo);
		 
		 List<ChatVO> contentRoomList = chatService.getContentRoomList(); // 채팅방 조회하기
		 model.addAttribute("contentRoomList", contentRoomList);
		 
		 //실시간 상담 게시판 불러와서 리스트로 나열하기.
		 // 채팅 방 입장할때 select해서 컨텐트내용 가져와서 출력할 준비도 해야 합니다. ㅇㅋ? 잘 됬으면 좋겠네요
		 
		 return "/Admin/chatGoAdmin.jsp";
	 }
		
	// 채팅방 입장
	@RequestMapping("/chatTest2.do")
	public String view_chat(UserVO vo, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		System.out.println("채팅방 입장하니?");
		System.out.println("vo : " + vo);
		UserVO vo2 = userService.confirmUser(vo);
		ChatVO ch = chatService.CheckList(vo);
		System.out.println("vo2 : " + vo2);
		System.out.println("ch : " + ch);
		if(vo2.getGrade().equals("관리자")) {
			List<ChatVO> contentList = chatService.getContentList(ch); // 조회하고
			System.out.println(contentList);
			model.addAttribute("contentList", contentList); // 값 저장하고
			return "chatTest2.jsp";
		} else {
			if(ch == null) {
				chatService.insertChatList(vo2);
			}
			else {
				List<ChatVO> contentList = chatService.getContentList(ch); // 조회하고
				model.addAttribute("contentList", contentList);
				System.out.println(contentList);
				return "chatTest2.jsp";
			}
		}
		// 채팅방 입장할때 기존에 만들어 져있는 채팅방없으면 채팅방 하나 insert하면서 들어가기
		// 기존에 만들어져 있는 채팅방 없으면 기존에 대화 내용 불러오기 ㅇㅋ? 가능하겟니...
		return "chatTest2.jsp";
	}
	
	@RequestMapping("/updateContent.do")
	@ResponseBody
	public String updateContent(ChatVO vo, UserVO vo2) {
		System.out.println("아이디 체크 요청이 들어옴!");
		System.out.println("vo : " + vo);
		
		System.out.println("vo2 : " + vo2);
		vo.setChatNo(chatService.CheckList(vo2).getChatNo());//채팅방이 있는지 확인하고 채팅방의 번호를 가져오기
		chatService.insetChatContent(vo);
		vo2.setUserId(vo.getSendId());
		UserVO vo3 = userService.confirmUser(vo2);
		System.out.println("vo3 : " + vo3);
		if(vo3.getGrade().equals("관리자")) {
			chatService.updateChatList1(vo);
		} else {
			chatService.updateChatList0(vo);
		}
		
		return "성공";
	}
	
	//알람 리스트 불러오기
	@RequestMapping("/getAlramList.do")
	@ResponseBody
	public List<AlramVO> getAlramList(AlramVO vo) {
		System.out.println("getAlramList 요청이 들어옴!");
		System.out.println("vo : " + vo);
		List<AlramVO> alramList = new ArrayList<AlramVO>(); 
		
		alramList = alramService.getAlramList(vo);
		
		System.out.println("보내기전 alramList" + alramList);
		
		return alramList;
	}
	
	//알람 갯수 불러오기
		@RequestMapping("/alramCount.do")
		@ResponseBody
		public int alramCount (AlramVO vo) throws Exception{
			System.out.println("alramCount 요청이 들어옴!");
			System.out.println("vo : " + vo);
			int alram = alramService.alramCount(vo);
			
		return alram;
		}	
	
		
	//알람 갯수 불러오기
		@RequestMapping("/alramDelete.do")
		@ResponseBody
		public int alramClick(AlramVO vo) throws Exception{
			System.out.println("alramDelete 요청이 들어옴!");
			System.out.println("vo : " + vo);
			int alram = alramService.alramDelete(vo);
			
		return alram;
		}	
		
			
			
			
			
			
			
			
			
}
