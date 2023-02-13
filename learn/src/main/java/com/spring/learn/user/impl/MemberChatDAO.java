package com.spring.learn.user.impl;

import java.util.List;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.learn.user.ChatVO;
import com.spring.learn.user.LikeVO;
import com.spring.learn.user.MemberChatContentsVO;
import com.spring.learn.user.MemberChatRoomListVO;
import com.spring.learn.user.UserVO;

public interface MemberChatDAO {

	MemberChatRoomListVO getChatroomS(MemberChatRoomListVO mcrlvo);

	MemberChatRoomListVO getChatroomR(MemberChatRoomListVO mcrlvo);

	void addChatroom(MemberChatRoomListVO mcrlvo);

	String getName(String userId);

	List<MemberChatContentsVO> getMemberChatContents(MemberChatRoomListVO mcrlvo);

	void addMemberChatContents(MemberChatContentsVO memberChatContents);

	void updateMemberChatList(MemberChatContentsVO memberChatContents);

	List<MemberChatRoomListVO> getMemberChatList(UserVO uvo);

	MemberChatContentsVO getLastMsg(MemberChatRoomListVO memberChat);

	void seeYourMsg(MemberChatContentsVO memberChatContents);

}





