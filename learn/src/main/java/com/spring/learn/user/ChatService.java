package com.spring.learn.user;

import java.util.List;

public interface ChatService {

	ChatVO CheckList(UserVO vo2);

	void insertChatList(UserVO vo2);

	List<ChatVO> getContentList(ChatVO ch);

	void insetChatContent(ChatVO vo);

	void updateChatList1(ChatVO vo);
	
	void updateChatList0(ChatVO vo);

	List<ChatVO> getContentRoomList();
	
	List<ChatVO> getRegRoomList();

	List<ChatVO> getReversRoomList();

	List<ChatVO> getReversRegRoomList();
	
	
	
}
