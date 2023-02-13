package com.spring.learn.roadmap.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.spring.learn.roadmap.MyroadmapVO;
import com.spring.learn.roadmap.RoadmapVO;

@Repository
public interface RoadmapDAO {
	
	//카테고리별 로드맵 조회
	List<RoadmapVO> getRoadmaps(Map<String, String> map);	
	
	//로드맵별 좋아요순
	int getTotalRoadmapLike (String roadmapNo);
	
	//로드맵 총 게시글수
	int getRoadmapTotalCount(Map<String, String> map);

	List<RoadmapVO> getRoadmapsFiltering(Map<String, String> map);
	
	  RoadmapVO getRoadmapDetail(String rboardNo);

	  MyroadmapVO getMyroadmap(Map map);

	  void addMyroadmap(Map map);

	  void removeMyroadmap(Map map);

	  ArrayList<RoadmapVO> getRoadmapManager(Map<String, String> map);

	  int isBuy(Map map);

	  void removeRoadmap(Map map);

	  void insertRoadmap(RoadmapVO roadmapVO);

	  void addUserCount(String rboardNo);

	  void removeUserCount(String rboardNo);

	  void editRoadmap(RoadmapVO roadmapVO);

	  int getRoadmapCount(String userId);

		String getFileName(String rboardNo);
}
