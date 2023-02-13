package com.spring.learn.memberboard.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.memberboard.AdminQNAReplyService;
import com.spring.learn.memberboard.AdminQNAReplyVO;

@Service("AdminQNAReplyService")
public class AdminQNAReplyServiceImpl implements AdminQNAReplyService {

	@Autowired
	private AdminQNAReplyDAO adminQNAReplyDAO;
	
	
	@Override
	public AdminQNAReplyVO getReply(String qnaNo) {
		return adminQNAReplyDAO.getReply(qnaNo);
	}

}
