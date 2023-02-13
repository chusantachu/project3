package com.spring.learn.board.impl;

import java.util.List;
import java.util.Map;

import com.spring.learn.board.ReportResultVO;

public interface ReportResultDAO {
	void insertDelReport(ReportResultVO vo);
	List<ReportResultVO> getResultReport(Map<String, String> map); 
	int countResultReport();
	ReportResultVO getDelReportPost (ReportResultVO vo);
}





