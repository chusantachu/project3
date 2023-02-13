package com.spring.learn.user;

import java.util.List;

public interface MemberChatService {

	MemberChatRoomListVO getChatroom(MemberChatRoomListVO mcrlvo);

	void addChatroom(MemberChatRoomListVO mcrlvo);

	String getName(String senderId);

	List<MemberChatContentsVO> getMemberChatContents(MemberChatRoomListVO mcrlvo);

	void addMemberChatContents(MemberChatContentsVO memberChatContents);

	void updateMemberChatList(MemberChatContentsVO memberChatContents);

	List<MemberChatRoomListVO> getMemberChatList(UserVO uvo);

	MemberChatContentsVO getLastMsg(MemberChatRoomListVO memberChat);

	void seeYourMsg(MemberChatContentsVO memberChatContents);
	
}
