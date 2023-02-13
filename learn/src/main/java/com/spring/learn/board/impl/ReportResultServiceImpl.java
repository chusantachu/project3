package com.spring.learn.board.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.board.ReportResultService;
import com.spring.learn.board.ReportResultVO;

// UserService
@Service("reportResultService")
public class ReportResultServiceImpl implements ReportResultService {
	
	@Autowired
	private ReportResultDAO reportResultDAO;

	@Override
	public void insertDelReport(ReportResultVO vo) {
		reportResultDAO.insertDelReport(vo);
	}

	@Override
	public List<ReportResultVO> getResultReport(Map<String, String> map) {
		return reportResultDAO.getResultReport(map);
	}

	@Override
	public int countResultReport() {
		return reportResultDAO.countResultReport();
	}

	@Override
	public ReportResultVO getDelReportPost(ReportResultVO vo) {
		return reportResultDAO.getDelReportPost(vo);
	}
}
