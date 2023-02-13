package com.spring.learn.board.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.board.BoardReportService;
import com.spring.learn.board.BoardReportVO;

// UserService
@Service("boardReportService")
public class BoardReportServiceImpl implements BoardReportService {
	
	@Autowired
	private BoardReportDAO boardReportDao;

	public BoardReportServiceImpl() {
		System.out.println(">> BoardReportServiceImpl 생성");
	}

	@Override
	public List<BoardReportVO> getFalseReport(Map<String, String> map) {
		return boardReportDao.getFalseReport(map);
	}

	@Override
	public int countFalseReport() {
		return boardReportDao.countFalseReport();
	}

	@Override
	public List<BoardReportVO> getTrueReport(Map<String, String> map) {
		return boardReportDao.getTrueReport(map);
	}

	@Override
	public int countTrueReport() {
		return boardReportDao.countTrueReport();
	}

	@Override
	public int getCntReport(BoardReportVO vo) {
		return boardReportDao.getCntReport(vo);
	}

	@Override
	public void updateReportStatus(BoardReportVO vo) {
		boardReportDao.updateReportStatus(vo);
	}

	@Override
	public void deleteReport(BoardReportVO vo) {
		boardReportDao.deleteReport(vo);
	}

	@Override
	public int countReport(BoardReportVO vo) {
		return boardReportDao.countReport(vo);
	}

	@Override
	public void deleteReportAll(BoardReportVO vo) {
		boardReportDao.deleteReportAll(vo);
	}


}
