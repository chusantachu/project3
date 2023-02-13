package com.spring.learn.resume.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.resume.ResumeService;
import com.spring.learn.resume.ResumeVO;

@Service("resumeService")
public class ResumeServiceimpl implements ResumeService {
@Autowired
	private ResumeDAO resumeDAO;
	
	@Override
	public void insertResume(ResumeVO vo) {
		resumeDAO.insertResume(vo);
		
	}

	@Override
	public void deleteResume(ResumeVO vo) {
		resumeDAO.deleteResume(vo);
		
	}

	@Override
	public void updateResume(ResumeVO vo) {
		resumeDAO.updateResume(vo);
		
	}

	@Override
	public ResumeVO getResume(ResumeVO vo) {
		vo = resumeDAO.getResume(vo);
		return vo;
	}

	@Override
	public List<ResumeVO> getResumeList(ResumeVO vo) {
		// TODO Auto-generated method stub
		return null;
	}
	
	//관리자페이지 데이터 확인용
	@Override
	public int countFalseResume() {
		return resumeDAO.countFalseResume();
	}

	@Override
	public List<ResumeVO> getFalseResume(Map<String, String> map) {
		return resumeDAO.getFalseResume(map);
	}

	@Override
	public int countTrueResume() {
		return resumeDAO.countTrueResume();
	}

	@Override
	public List<ResumeVO> getTrueResume(Map<String, String> map) {
		return resumeDAO.getTrueResume(map);
	}

	@Override
	public int updateResumeStatus(ResumeVO vo) {
		return resumeDAO.updateResumeStatus(vo);
	}

}
