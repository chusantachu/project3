package com.spring.learn.lecture.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.spring.learn.lecture.LectureNewsVO;

@Repository
public interface LectureNewsDAO {
	// 메소드명이 Mapper 파일의 id명으로 사용
	List<LectureNewsVO> getLectureNewsList(Map<String, String> map); // 전체글 조회 map
	int countBoard(LectureNewsVO vo);
	
	LectureNewsVO getLectureNews(LectureNewsVO vo);
	
	void deleteLectureNews(LectureNewsVO vo);
	void insertLectureNews(LectureNewsVO vo);
	void updateLectureNews(LectureNewsVO vo);
	int lastNo();
}





