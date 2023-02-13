package com.spring.learn.memberboard;

import java.util.List;
import java.util.Map;

public interface MemberBoardService {
	void insertBoard(MemberBoardVO vo);
	void updateBoard(MemberBoardVO vo);
	void deleteBoard(MemberBoardVO vo);
	int countBoard(MemberBoardVO vo);
	MemberBoardVO getBoard(MemberBoardVO vo); // 1개의 데이터 조회
	List<MemberBoardVO> getBoardList(Map<String, String> map); // 전체글 조회 map
	List<MemberBoardVO> getBoardList(MemberBoardVO bvo); // 전체글 조회 vo
	void addCallcenterComment(CallcenterCommentVO cvo);
	List<CallcenterCommentVO> getCallcenterComment(MemberBoardVO bvo);
	void delCallcenterComment(CallcenterCommentVO cvo);
	List<MemberBoardVO> resolvedCBoardList(MemberBoardVO vo);
	List<MemberBoardVO> unResolvedCBoardList(MemberBoardVO vo);
	List<OrdersDetailVO> goMyLectureList(OrdersDetailVO oov);
}