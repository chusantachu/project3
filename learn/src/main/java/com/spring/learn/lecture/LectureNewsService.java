package com.spring.learn.lecture;

import java.util.List;
import java.util.Map;

public interface LectureNewsService {
	//게시글 리스트가져오기
	List<LectureNewsVO> getLectureNewsList(Map<String, String> map);
	int countBoard(LectureNewsVO vo);

	LectureNewsVO getLectureNews(LectureNewsVO vo); 
	void deleteLectureNews(LectureNewsVO vo);
	void insertLectureNews(LectureNewsVO vo);
	void updateLectureNews(LectureNewsVO vo);
	int lastNo();
}
