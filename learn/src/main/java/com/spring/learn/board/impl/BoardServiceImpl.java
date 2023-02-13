package com.spring.learn.board.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.board.BoardService;
import com.spring.learn.board.BoardVO;
import com.spring.learn.board.QnaLikeVO;
import com.spring.learn.board.BoardCommentVO;
import com.spring.learn.board.BoardReportVO;
import com.spring.learn.memberboard.MemberBoardVO;

// UserService
@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO boardDAO;

	public BoardServiceImpl() {
		System.out.println(">> BoardServiceImple 생성");
	}

	@Override
	public void updateBoard(BoardVO vo) {
		boardDAO.updateBoard(vo);
	}

	@Override
	public void deleteBoard(BoardVO vo) {
		boardDAO.deleteBoard(vo);
	}

	@Override
	public BoardVO getBoard(BoardVO bvo) {		
		return boardDAO.getBoard(bvo);
	}

	@Override
	public List<BoardVO> getBoardList(BoardVO vo) {
		return boardDAO.getBoardList(vo);
	}

	@Override
	public void insertQnaBoard(BoardVO bvo) {
		boardDAO.insertQnaBoard(bvo);
	}

	@Override
	public void insertFreeBoard(BoardVO bvo) {
		boardDAO.insertFreeBoard(bvo);
	}

	@Override
	public int countQnaBoard(BoardVO bvo) {
		return boardDAO.countQnaBoard(bvo);
	}

	@Override
	public List<BoardVO> getQnaBoardList(Map<String, String> map) {
		return boardDAO.getQnaBoardList(map);
	}

	@Override
	public List<BoardCommentVO> getComment(BoardVO bvo) {
		return boardDAO.getComment(bvo);
	}

	@Override
	public QnaLikeVO getQnaLike(Map<String, String> map) {
		return boardDAO.getQnaLike(map);
	}

	@Override
	public void insertQnaLike(Map<String, String> map) {
		boardDAO.insertQnaLike(map);
	}

	@Override
	public void deleteQnaLike(Map<String, String> map) {
		boardDAO.deleteQnaLike(map);
	}

	@Override
	public void insertBoardReport(BoardReportVO boardReport) {
		boardDAO.insertBoardReport(boardReport);
		
	}

	@Override
	public BoardReportVO getBoardReport(Map<String, String> map) {
		return boardDAO.getBoardReport(map);
	}

	@Override
	public List<BoardVO> getTopBoard(BoardVO bvo) {
		return boardDAO.getTopBoard(bvo);
	}

	@Override
	public void addComment(BoardCommentVO cvo) {
		boardDAO.addComment(cvo);
	}

	@Override
	public void delComment(BoardCommentVO cvo) {
		boardDAO.delComment(cvo);
	}

	@Override
	public void addCocomment(BoardCommentVO cvo) {
		boardDAO.addCocomment(cvo);
	}

	@Override
	public List<BoardCommentVO> getCocoment(BoardVO bvo) {
		return boardDAO.getCocoment(bvo);
	}

	@Override
	public void delCocomment(BoardCommentVO ccvo) {
		boardDAO.delCocomment(ccvo);
	}

	@Override
	public void insertBoard(BoardVO vo) {
		boardDAO.insertBoard(vo);
	}

	@Override
	public List<BoardVO> getMyBoardList(Map<String, String> map) {
		return boardDAO.getMyBoardList(map);
	}

	@Override
	public int getMyBoardCount(Map<String, String> map) {
		return boardDAO.getMyBoardCount(map);
	}

	@Override
	public int getMyQBoardCount(Map<String, String> pmap) {
		return boardDAO.getMyQBoardCount(pmap);
	}

	@Override
	public List<BoardVO> getMyQBoardList(Map<String, String> pmap) {
		return boardDAO.getMyQBoardList(pmap);
	}


}
