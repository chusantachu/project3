package com.spring.learn.board;

import java.util.List;
import java.util.Map;

public interface BoardReportService {
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