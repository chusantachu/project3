package com.spring.learn.resume;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

public interface ResumeService {
		void insertResume(ResumeVO vo);
		void deleteResume(ResumeVO vo);
		void updateResume(ResumeVO vo);
		ResumeVO getResume(ResumeVO vo);
		List<ResumeVO> getResumeList(ResumeVO vo);
		
		//관리자페이지 데이터 확인용
		int countFalseResume();
		List<ResumeVO> getFalseResume(Map<String, String> map);
		int countTrueResume();
		List<ResumeVO> getTrueResume(Map<String, String> map);
		int updateResumeStatus(ResumeVO vo);
		
}
