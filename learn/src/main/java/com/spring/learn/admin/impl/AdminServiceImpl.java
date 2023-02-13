package com.spring.learn.admin.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.admin.AdminRevenueDatailVO;
import com.spring.learn.admin.AdminService;
import com.spring.learn.admin.JoinerVO;
import com.spring.learn.admin.RevenueVO;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.memberboard.MemberBoardVO;
import com.spring.learn.resume.ResumeVO;
import com.spring.learn.user.UserVO;

@Service("adminService")
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminDAO adminDAO;

	@Override
	public int getRevenueThisMonth(Map<String, String> map) {
		return adminDAO.getRevenueThisMonth(map);
	}

	@Override
	public int getNewUserforThisMonth(Map<String, String> map) {
		return adminDAO.getNewUserforThisMonth(map);
	}

	@Override
	public List<RevenueVO> getRevenueEachMonth(Map<String, String> map) {
		return adminDAO.getRevenueEachMonth(map);
	}

	
	@Override
	public List<String> getBestTeacher() {
		return adminDAO.getBestTeacher();
	}

	@Override
	public List<AdminRevenueDatailVO> getRevenueDetail(Map<String, String> map) {
		return adminDAO.getRevenueDetail(map);
	}

	@Override
	public int getRevenueTotal(Map<String, String> map) {
		return adminDAO.getRevenueTotal(map);
	}

	@Override
	public List<AdminRevenueDatailVO> getRevenueTotalInfo(Map<String, String> map) {
		return adminDAO.getRevenueTotalInfo(map);
	}

	@Override
	public List<JoinerVO> getJoinerEachMonth(Map<String, String> map) {
		return adminDAO.getJoinerEachMonth(map);
	}

	@Override
	public List<RevenueVO> getRevenueEachWeekly(Map<String, String> map) {
		return adminDAO.getRevenueEachWeekly(map);
	}

	@Override
	public List<RevenueVO> getRevenueEachDaily(Map<String, String> map) {
		return adminDAO.getRevenueEachDaily(map);
	}
	
	@Override
	public List<LectureVO> getNewWeeklyLectures() {
		return adminDAO.getNewWeeklyLectures();
	}

	@Override
	public List<UserVO> getUsers(Map<String, String> map) {
		return adminDAO.getUsers(map);
	}

	@Override
	public int getResumeTotal() {
		return adminDAO.getResumeTotal();
	}

	@Override
	public List<ResumeVO> getResumes(Map<String, String> map) {
		return adminDAO.getResumes(map);
	}
	
	public List<MemberBoardVO> getCallcenters(Map<String, String> map) {
		return adminDAO.getCallcenters(map);		
	}

	@Override
	public int getCallcenterTotal() {
		return adminDAO.getCallcenterTotal();
	}






}
