package com.spring.learn.memberboard.impl;

import java.util.List;
import java.util.Map;

import com.spring.learn.memberboard.CallcenterCommentVO;
import com.spring.learn.memberboard.MemberBoardVO;
import com.spring.learn.memberboard.OrdersDetailVO;

public interface MemberBoardDAO {
	
	void insertBoard(MemberBoardVO vo);
	void updateBoard(MemberBoardVO vo);
	void deleteBoard(MemberBoardVO vo);
	MemberBoardVO getBoard(MemberBoardVO vo);

	List<MemberBoardVO> getBoardListMap(Map<String, String> map); // 전체데이터 조회 map
	List<MemberBoardVO> getBoardList(MemberBoardVO vo); // 전체데이터 조회 vo
	
	int countBoard(MemberBoardVO vo);
	void addCallcenterComment(CallcenterCommentVO cvo);
	List<CallcenterCommentVO> getCallcenterComment(MemberBoardVO bvo);
	void delCallcenterComment(CallcenterCommentVO cvo);	

	List<MemberBoardVO> resolvedCBoardList(MemberBoardVO vo);
	List<MemberBoardVO> unResolvedCBoardList(MemberBoardVO vo);
	List<OrdersDetailVO> goMyLectureList(OrdersDetailVO oov);

}





