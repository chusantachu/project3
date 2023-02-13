package com.spring.learn.lecture.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.lecture.LectureNewsService;
import com.spring.learn.lecture.LectureNewsVO;

@Service("lectureNewsService")
public class LectureNewsServiceImpl implements LectureNewsService {
	
	@Autowired //타입이 일치하는 객체(인스턴스)주입 (DI)
	private  LectureNewsDAO lectureNewsDAO;

	public LectureNewsServiceImpl() {
		System.out.println(">> LectureNewsServiceImpl() 객체 생성");
	}

	@Override
	public List<LectureNewsVO> getLectureNewsList(Map<String, String> map) {
		return lectureNewsDAO.getLectureNewsList(map);
	}

	@Override
	public int countBoard(LectureNewsVO vo) {
		return lectureNewsDAO.countBoard(vo);
	}

	@Override
	public LectureNewsVO getLectureNews(LectureNewsVO vo) {
		return lectureNewsDAO.getLectureNews(vo);
	}

	@Override
	public void deleteLectureNews(LectureNewsVO vo) {
		lectureNewsDAO.deleteLectureNews(vo);
		
	}

	@Override
	public void insertLectureNews(LectureNewsVO vo) {
		lectureNewsDAO.insertLectureNews(vo);
	}

	@Override
	public int lastNo() {
		return lectureNewsDAO.lastNo();
	}

	@Override
	public void updateLectureNews(LectureNewsVO vo) {
		lectureNewsDAO.updateLectureNews(vo);
		
	}
	
	
}
