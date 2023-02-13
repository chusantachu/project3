package com.spring.learn.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.user.ChatService;
import com.spring.learn.user.ChatVO;
import com.spring.learn.user.UserVO;

// chatService 구현
@Service("chatService")
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDAO chatDAO;

	@Override
	public ChatVO CheckList(UserVO vo2) {
		return chatDAO.CheckList(vo2);
	}

	@Override
	public void insertChatList(UserVO vo2) {
		chatDAO.insertChatList(vo2);
	}

	@Override
	public List<ChatVO> getContentList(ChatVO ch) {
		return chatDAO.getContentList(ch);
	}

	@Override
	public void insetChatContent(ChatVO vo) {
		chatDAO.insetChatContent(vo);
	}

	@Override
	public void updateChatList1(ChatVO vo) {
		chatDAO.updateChatList1(vo);
	}

	@Override
	public void updateChatList0(ChatVO vo) {
		chatDAO.updateChatList0(vo);
	}

	@Override
	public List<ChatVO> getContentRoomList() {
		return chatDAO.getContentRoomList();
	}

	@Override
	public List<ChatVO> getRegRoomList() {
		return chatDAO.getRegRoomList();
	}

	@Override
	public List<ChatVO> getReversRoomList() {
		return chatDAO.getReversRoomList();
	}

	@Override
	public List<ChatVO> getReversRegRoomList() {
		return chatDAO.getReversRegRoomList();
	}

	
	
	
}
