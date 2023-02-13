package com.spring.learn.board.impl;

import java.util.List;
import java.util.Map;

import com.spring.learn.board.BoardVO;
import com.spring.learn.board.QnaLikeVO;
import com.spring.learn.board.BoardCommentVO;
import com.spring.learn.board.BoardReportVO;
import com.spring.learn.memberboard.MemberBoardVO;

public interface BoardDAO {
	// 메소드명이 Mapper 파일의 id명으로 사용
	void insertBoard(BoardVO vo);
	void updateBoard(BoardVO vo);
	void deleteBoard(BoardVO vo);
	BoardVO getBoard(BoardVO vo);
	List<BoardVO> getBoardList(BoardVO vo);
	
	void insertQnaBoard(BoardVO bvo); // qna보드 입력
	void insertFreeBoard(BoardVO bvo); // free보드 입력
	int countQnaBoard(BoardVO bvo); // qna보드 전체 수 검색
	List<BoardVO> getQnaBoardList(Map<String, String> map); // qna보드 검색 가져오기
	List<BoardCommentVO> getComment(BoardVO bvo); // 코멘트 가져오기 , 안에서 분기처리 할 것
	QnaLikeVO getQnaLike(Map<String, String> map);
	void insertQnaLike(Map<String, String> map);
	void deleteQnaLike(Map<String, String> map);
	void insertBoardReport(BoardReportVO boardReport);
	BoardReportVO getBoardReport(Map<String, String> map);
	List<BoardVO> getTopBoard(BoardVO bvo);
	void addComment(BoardCommentVO cvo);
	void delComment(BoardCommentVO cvo);
	void addCocomment(BoardCommentVO cvo);
	List<BoardCommentVO> getCocoment(BoardVO bvo);
	void delCocomment(BoardCommentVO ccvo);
	List<BoardVO> getMyBoardList(Map<String, String> map);
	int getMyBoardCount(Map<String, String> map);

  int getMyQBoardCount(Map<String, String> pmap);

	List<BoardVO> getMyQBoardList(Map<String, String> pmap);
}





