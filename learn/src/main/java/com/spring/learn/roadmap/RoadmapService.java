package com.spring.learn.roadmap;

import com.spring.learn.roadmap.MyroadmapVO;
import com.spring.learn.roadmap.RoadmapVO;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface RoadmapService {
	
	//카테고리별 로드맵 강의 조회
	List<RoadmapVO> getRoadmaps(Map<String, String> map);	
	
	int getTotalRoadmapLike (String roadmapNo);

	int getRoadmapTotalCount(Map<String, String> map);
	
	List<RoadmapVO> getRoadmapsFiltering(Map<String, String> map);
	
	  RoadmapVO getRoadmapDetail(String rboardNo);

	  MyroadmapVO getMyroadmap(Map<String, String> map);

	  void addMyroadmap(Map<String, String> map);

	  void removeMyroadmap(Map<String, String> map);

	  ArrayList<RoadmapVO> getRoadmapManager(Map<String, String> map);

	  int isBuy(Map<String, String> map);

	  void removeRoadmap(Map<String, String> map);

	  void insertRoadmap(RoadmapVO roadmapVO);

	  void addUserCount(String rboardNo);

	  void removeUserCount(String rboardNo);

	  void editRoadmap(RoadmapVO roadmapVO);

	  int getRoadmapCount(String userId);

  String getFileName(String rboardNo);
}
