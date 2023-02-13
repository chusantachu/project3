package com.spring.learn.board.impl;

import java.util.List;
import java.util.Map;

import com.spring.learn.board.BoardReportVO;

public interface BoardReportDAO {
	List<BoardReportVO> getFalseReport(Map<String, String> map); //신고 미처리데이터 가져오기
	int countFalseReport();
	List<BoardReportVO> getTrueReport(Map<String, String> map); //신고처리데이터 가져오기
	int countTrueReport();
	
	int getCntReport(BoardReportVO vo);
	void updateReportStatus(BoardReportVO vo);
	void deleteReport(BoardReportVO vo);
	int countReport(BoardReportVO vo);
	
	void deleteReportAll(BoardReportVO vo);
}





