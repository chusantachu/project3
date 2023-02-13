package com.spring.learn.board;

import java.util.List;
import java.util.Map;

import com.spring.learn.memberboard.MemberBoardVO;

public interface BoardService {
	void insertBoard(BoardVO vo);
	void updateBoard(BoardVO vo);
	void deleteBoard(BoardVO vo);

	BoardVO getBoard(BoardVO vo); // 1개의 데이터 조회
	List<BoardVO> getBoardList(BoardVO vo); // 전체글 조회
	
	
	void insertQnaBoard(BoardVO bvo); // qna보드 입력
	void insertFreeBoard(BoardVO bvo); // free보드 입력
	
	int countQnaBoard(BoardVO bvo); // qna 보드 수량 검색	
	List<BoardVO> getQnaBoardList(Map<String, String> map); // qna 보드 가져오기
	List<BoardCommentVO> getComment(BoardVO bvo);
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