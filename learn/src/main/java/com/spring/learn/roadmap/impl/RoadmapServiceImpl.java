package com.spring.learn.roadmap.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.roadmap.MyroadmapVO;
import com.spring.learn.roadmap.RoadmapService;
import com.spring.learn.roadmap.RoadmapVO;

@Service
public class RoadmapServiceImpl implements RoadmapService {

  @Autowired
  private RoadmapDAO roadmapDAO;

  public RoadmapServiceImpl() {
    System.out.println(">> RoadmapServiceImpl 생성");
  }
  

	@Override
	public List<RoadmapVO> getRoadmaps(Map<String, String> map) {
		// TODO Auto-generated method stub
		return roadmapDAO.getRoadmaps(map);
	}


	@Override
	public int getTotalRoadmapLike(String roadmapNo) {
		return roadmapDAO.getTotalRoadmapLike(roadmapNo);
	}


	@Override
	public int getRoadmapTotalCount(Map<String, String> map) {
		return roadmapDAO.getRoadmapTotalCount(map);
	}



	@Override
	public List<RoadmapVO> getRoadmapsFiltering(Map<String, String> map) {
		return roadmapDAO.getRoadmapsFiltering(map);
	}

	  @Override
	  public RoadmapVO getRoadmapDetail(String rboardNo) {
	    return roadmapDAO.getRoadmapDetail(rboardNo);
	  }
	  
	  @Override
	  public MyroadmapVO getMyroadmap(Map map) {
	    return roadmapDAO.getMyroadmap(map);
	  }

	  @Override
	  public void addMyroadmap(Map map) {
	    roadmapDAO.addMyroadmap(map);
	  }

	  @Override
	  public void removeMyroadmap(Map map) {
	    roadmapDAO.removeMyroadmap(map);
	  }

	  @Override
	  public ArrayList<RoadmapVO> getRoadmapManager(Map<String, String> map) {
	    return roadmapDAO.getRoadmapManager(map);
	  }

	  @Override
	  public int isBuy(Map map) {
	    return roadmapDAO.isBuy(map);
	  }

	  @Override
	  public void removeRoadmap(Map map) {
	    roadmapDAO.removeRoadmap(map);
	  }

	  @Override
	  public void insertRoadmap(RoadmapVO roadmapVO) {
	    roadmapDAO.insertRoadmap(roadmapVO);
	  }

	  @Override
	  public void addUserCount(String rboardNo) {
	    roadmapDAO.addUserCount(rboardNo);
	  }

	  @Override
	  public void removeUserCount(String rboardNo) {
	    roadmapDAO.removeUserCount(rboardNo);
	  }

	  @Override
	  public void editRoadmap(RoadmapVO roadmapVO) {
	    roadmapDAO.editRoadmap(roadmapVO);
	  }

	  @Override
	  public int getRoadmapCount(String userId) {
	    return roadmapDAO.getRoadmapCount(userId);
	  }

	@Override
	public String getFileName(String rboardNo) {
		return roadmapDAO.getFileName(rboardNo);
	}
}
