package com.spring.learn.resume.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.learn.resume.ResumeVO;

@Repository
public class ResumeDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	public ResumeDAO() {
		System.out.println("=========== ResumeDAOMybatis() 객체 생성");

	}
	
	void insertResume(ResumeVO vo) {
		System.out.println("insertResume()");
		mybatis.insert("resumeDAO.insertResume", vo);
	}
	
	void deleteResume(ResumeVO vo){
		System.out.println("deleteResume()");
		mybatis.delete("resumeDAO.deleteResume", vo);
		System.out.println("vo: " + vo);
	}
	
	void updateResume(ResumeVO vo) {
		System.out.println("updateResume()");
		mybatis.update("resumeDAO.updateResume", vo);
		System.out.println("vo: " + vo);
	}
	
	ResumeVO getResume(ResumeVO vo) {
		System.out.println("getResume()");
		vo =  mybatis.selectOne("resumeDAO.getResume", vo);
		System.out.println("vo: " + vo);
		
		return vo;
		
	}
	
	List<ResumeVO> getResumeList(ResumeVO vo){
		
		
		return null;
		
	}
	
	//관리자페이지 데이터 확인용
	int countFalseResume() {
		return mybatis.selectOne("resumeDAO.countFalseResume");
	}

	List<ResumeVO> getFalseResume(Map<String, String> map) {
		return mybatis.selectList("resumeDAO.getFalseResume", map);
	}

	int countTrueResume() {
		return mybatis.selectOne("resumeDAO.countTrueResume");
	}

	List<ResumeVO> getTrueResume(Map<String, String> map) {
		return mybatis.selectList("resumeDAO.getTrueResume", map);
	}

	int updateResumeStatus(ResumeVO vo) {
		return mybatis.update("resumeDAO.updateResumeStatus", vo);
	}
	
}
