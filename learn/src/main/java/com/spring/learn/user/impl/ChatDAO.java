package com.spring.learn.user.impl;

import java.util.List;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.learn.user.ChatVO;
import com.spring.learn.user.LikeVO;
import com.spring.learn.user.UserVO;

@Repository
public class ChatDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	public ChatDAO() {
		System.out.println("=========== ChatDAO() 객체 생성");
	}

	public ChatVO CheckList(UserVO vo2) {
		System.out.println("===> Mybatis 사용 CheckList() 실행");
		return mybatis.selectOne("chatDAO.CheckList", vo2);
	}

	public void insertChatList(UserVO vo2) {
		mybatis.insert("chatDAO.insertChatList", vo2);
	}

	public List<ChatVO> getContentList(ChatVO ch) {
		return mybatis.selectList("chatDAO.getContentList", ch);
	}

	public void insetChatContent(ChatVO vo) {
		mybatis.insert("chatDAO.insetChatContent", vo);
	}

	public void updateChatList1(ChatVO vo) {
		mybatis.update("chatDAO.updateChatList1", vo);
	}
	
	public void updateChatList0(ChatVO vo) {
		mybatis.update("chatDAO.updateChatList0", vo);
	}

	public List<ChatVO> getContentRoomList() {
		return mybatis.selectList("chatDAO.getContentRoomList");
	}

	public List<ChatVO> getRegRoomList() {
		return mybatis.selectList("chatDAO.getRegRoomList");
	}

	public List<ChatVO> getReversRoomList() {
		return mybatis.selectList("chatDAO.getReversRoomList");
	}

	public List<ChatVO> getReversRegRoomList() {
		return mybatis.selectList("chatDAO.getReversRegRoomList");
	}
	
	
	
}





