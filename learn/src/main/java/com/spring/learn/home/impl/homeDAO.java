package com.spring.learn.home.impl;

import java.util.List;
import java.util.Map;

import com.spring.learn.home.HomeVO;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.roadmap.RoadmapVO;

public interface homeDAO {
	List<LectureVO> getStarterLectureList(); 
	List<LectureVO> getFreeLectureList();
	List<RoadmapVO> getIndexRoadMapList();
	List<HomeVO> getIndexReviewList();
	
	List<HomeVO> getLectureIndexList(Map<String, Object> map); 
	int countLectureIndex(HomeVO vo);
	List<HomeVO> getLectureIndexList_on(Map<String, Object> map); 
	int countLectureIndex_on(HomeVO vo);
	List<HomeVO> getLectureIndexList_off(Map<String, Object> map); 
	int countLectureIndex_off(HomeVO vo);
}





