package com.spring.learn.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.board.impl.BoardDAO;
import com.spring.learn.user.ChatService;
import com.spring.learn.user.ChatVO;
import com.spring.learn.user.MemberChatContentsVO;
import com.spring.learn.user.MemberChatRoomListVO;
import com.spring.learn.user.MemberChatService;
import com.spring.learn.user.UserVO;

// chatService 구현
@Service("memberChatService")
public class MemberChatServiceImpl implements MemberChatService {
	
	@Autowired
	private MemberChatDAO memberChatDAO;
	
	public MemberChatServiceImpl() {
		System.out.println(">> MemberChatServiceImpl 생성");
	}

	@Override
	public MemberChatRoomListVO getChatroom(MemberChatRoomListVO mcrlvo) {
		
		MemberChatRoomListVO mcrlvoS = new MemberChatRoomListVO();
		
		//센더에서 찾기 사용자 찾기
		mcrlvoS = memberChatDAO.getChatroomS(mcrlvo);
		if (mcrlvoS != null) {
			return mcrlvoS;
		}
		
		//위에서 못 찾은 경우 리시버에서 사용자 찾기
		mcrlvoS = memberChatDAO.getChatroomR(mcrlvo);
		return mcrlvoS;
	}

	@Override
	public void addChatroom(MemberChatRoomListVO mcrlvo) {
		memberChatDAO.addChatroom(mcrlvo);
	}

	@Override
	public String getName(String userId) {
		return memberChatDAO.getName(userId);
	}

	@Override
	public List<MemberChatContentsVO> getMemberChatContents(MemberChatRoomListVO mcrlvo) {
		return memberChatDAO.getMemberChatContents(mcrlvo);
	}

	@Override
	public void addMemberChatContents(MemberChatContentsVO memberChatContents) {
		memberChatDAO.addMemberChatContents(memberChatContents);
	}

	@Override
	public void updateMemberChatList(MemberChatContentsVO memberChatContents) {
		memberChatDAO.updateMemberChatList(memberChatContents);
	}

	@Override
	public List<MemberChatRoomListVO> getMemberChatList(UserVO uvo) {
		
		return memberChatDAO.getMemberChatList(uvo);
	}

	@Override
	public MemberChatContentsVO getLastMsg(MemberChatRoomListVO memberChat) {
		return memberChatDAO.getLastMsg(memberChat);
	}

	@Override
	public void seeYourMsg(MemberChatContentsVO memberChatContents) {
		memberChatDAO.seeYourMsg(memberChatContents);
		
	}
	
}
