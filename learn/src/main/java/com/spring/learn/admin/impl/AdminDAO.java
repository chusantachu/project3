package com.spring.learn.admin.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.spring.learn.admin.AdminRevenueDatailVO;
import com.spring.learn.admin.JoinerVO;
import com.spring.learn.admin.RevenueVO;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.memberboard.MemberBoardVO;
import com.spring.learn.resume.ResumeVO;
import com.spring.learn.user.UserVO;

@Repository
public interface AdminDAO {

	int getRevenueThisMonth(Map<String, String> map);
	
	int getNewUserforThisMonth(Map<String, String> map);
	
	List<RevenueVO> getRevenueEachMonth(Map<String, String> map);
	
	List<String> getBestTeacher();
	
	List<AdminRevenueDatailVO> getRevenueDetail(Map<String, String> map);
	
	int getRevenueTotal(Map<String, String> map);
	
	List<AdminRevenueDatailVO> getRevenueTotalInfo (Map<String, String> map);
	
	List<JoinerVO> getJoinerEachMonth(Map<String, String> map);
	
	List<LectureVO> getNewWeeklyLectures();

	List<UserVO> getUsers(Map<String, String> map);
	
	int getResumeTotal ();
	
	List<ResumeVO> getResumes(Map<String, String> map);

	int getCallcenterTotal ();
	
	List<MemberBoardVO> getCallcenters(Map<String, String> map);
	
	List<RevenueVO> getRevenueEachWeekly(Map<String, String> map);

	List<RevenueVO> getRevenueEachDaily(Map<String, String> map);
	
}
