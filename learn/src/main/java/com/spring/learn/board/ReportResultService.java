package com.spring.learn.board;

import java.util.List;
import java.util.Map;

public interface ReportResultService {
	void insertDelReport(ReportResultVO vo);
	List<ReportResultVO> getResultReport(Map<String, String> map); 
	int countResultReport();
	ReportResultVO getDelReportPost (ReportResultVO vo);
}