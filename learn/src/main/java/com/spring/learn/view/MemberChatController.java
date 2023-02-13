package com.spring.learn.view;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.learn.user.MemberChatContentsVO;
import com.spring.learn.user.MemberChatRoomListVO;
import com.spring.learn.user.MemberChatService;
import com.spring.learn.user.UserVO;

@Controller					// 단 현재 위치(클래스)에서만 유효
@RequestMapping({"/memberChat", "/MemberChat"})
@SessionAttributes({"memberChatRoomList", "memberChatContents"}) // 같은 이름의 Model객체가 있으면 세션에 저장
public class MemberChatController {

	@Autowired
	private MemberChatService memberChatService;
	
	public MemberChatController() {
		System.out.println(">> MemberChatController() 생성");
	}
	
	// 채팅방 입장 - 아이디 클릭햇을 때
	@RequestMapping("/memberChatRoom.do")
	public String view_chat(MemberChatRoomListVO mcrlvo, Model model) {
		
		System.out.println("채팅방 입장하니?");
		System.out.println("mcrlvo : " + mcrlvo);
		
		MemberChatRoomListVO mcrlvoIm = new MemberChatRoomListVO();
		
		mcrlvoIm = memberChatService.getChatroom(mcrlvo);
		
		// 찾은 결과가 비어있지 않다면, 그거 가져오기 - 번호랑 다 챙겨올 수 있음
		if (mcrlvoIm != null) {
			mcrlvo = mcrlvoIm;
		} else {
			// 찾은 결과가 비어 있다면, 채팅룸을 추가하기
			String senderName = memberChatService.getName(mcrlvo.getSenderId());
			String receiverName = memberChatService.getName(mcrlvo.getReceiverId());
			
			// 이름 추가 하기
			mcrlvo.setSenderName(senderName);
			mcrlvo.setReceiverName(receiverName);
			
			System.out.println(">> DB 집어 넣기 전 new mcrlvo : " + mcrlvo);
			// 룸 DB에 집어 넣고 다시 가져오기
			memberChatService.addChatroom(mcrlvo);
			mcrlvo = memberChatService.getChatroom(mcrlvo);
		}
		
		System.out.println("mcrlvo : " + mcrlvo);
		
		// 새로 만든 것이거나 그게 아니더라도 채팅방이 없을 수도 있다
		List<MemberChatContentsVO> memberChatContents = memberChatService.getMemberChatContents(mcrlvo);
		
		System.out.println("memberChatContents : " + memberChatContents);
		
		model.addAttribute("memberChatRoomList", mcrlvo);
		model.addAttribute("memberChatContents", memberChatContents);
		
		return "/Member/Detail/memberChatRoom.jsp";
		
	}
	

	
	
	// 채팅 입력시 ajax로 인서트와 업데이트 동시 진행
	@PostMapping("/sendMessage.do")
	@ResponseBody
	public String sendMessage(MemberChatContentsVO memberChatContents, Model model) {
		
		// 에이젝스로 들어온 
		System.out.println("sendMessage() 로 들어옴 : " + memberChatContents);
		
		// MEMBER_CHAT_ROOM_LIST 에 입력
		memberChatService.addMemberChatContents(memberChatContents);
		
		
		// MEMBER_CHAT_CONTENTS 에 업데이트
		memberChatService.updateMemberChatList(memberChatContents);
		
		return "성공";
	}	
	
	// 채팅방 리스트 - 아이디 클릭햇을 때
	@RequestMapping("/memberChatListGo.do")
	public String memberChatListGo(UserVO uvo, Model model) {
		
		//리스트 불러오기
		List<MemberChatRoomListVO> memberChatList = memberChatService.getMemberChatList(uvo); 
		
		for (MemberChatRoomListVO memberChat : memberChatList) {
			
			// 라스트 채터가 상대방인 경우
			
			if (memberChat.getLastChater() != null) {
				
				if (!memberChat.getLastChater().equals(uvo.getUserId())){
					
					// 내가 미응답한 경우 - 미응답 했다는 내용을 vo에 추가하기
					String chatStatus =  memberChatService.getLastMsg(memberChat).getChatStatus();
					memberChat.setChatStatus(chatStatus);
					
					System.out.println(">>>>>  memberChat : " + memberChat);
				}
				
			}
		}
		model.addAttribute("memberChatList", memberChatList);
		return "/Member/Detail/memberChatList.jsp";
	}
	
	
	// 채팅을 봤다
	@RequestMapping("/seeYourMsg.do")
	@ResponseBody
	public void seeYourMsg(MemberChatContentsVO memberChatContents, Model model) {	
		
		System.out.println("]]]]] seeYourMsg 도착 memberChatContents: " + memberChatContents);
	
		memberChatService.seeYourMsg(memberChatContents);
	
	}
	
	
}	
	
	
	
	
	
	

	
	

