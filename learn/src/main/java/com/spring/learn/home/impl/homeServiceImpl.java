package com.spring.learn.home.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.home.HomeService;
import com.spring.learn.home.HomeVO;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.roadmap.RoadmapVO;

// UserService
@Service("homeService")
public class homeServiceImpl implements HomeService {
	
	@Autowired
	private homeDAO homeDao;
	
	@Override
	public List<LectureVO> getStarterLectureList() {
		return homeDao.getStarterLectureList();
	}

	@Override
	public List<LectureVO> getFreeLectureList() {
		return homeDao.getFreeLectureList();
	}

	@Override
	public List<RoadmapVO> getIndexRoadMapList() {
		return homeDao.getIndexRoadMapList();
	}

	@Override
	public List<HomeVO> getIndexReviewList() {
		return homeDao.getIndexReviewList();
	}

	@Override
	public List<HomeVO> getLectureIndexList(Map<String, Object> map) {
		return homeDao.getLectureIndexList(map);
	}

	@Override
	public int countLectureIndex(HomeVO vo) {
		return homeDao.countLectureIndex(vo);
	}

	@Override
	public List<HomeVO> getLectureIndexList_on(Map<String, Object> map) {
		return homeDao.getLectureIndexList_on(map);
	}

	@Override
	public int countLectureIndex_on(HomeVO vo) {
		return homeDao.countLectureIndex_on(vo);
	}

	@Override
	public List<HomeVO> getLectureIndexList_off(Map<String, Object> map) {
		return homeDao.getLectureIndexList_off(map);
	}

	@Override
	public int countLectureIndex_off(HomeVO vo) {
		return homeDao.countLectureIndex_off(vo);
	}
	

}
