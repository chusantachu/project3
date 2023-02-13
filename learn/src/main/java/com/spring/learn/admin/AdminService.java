package com.spring.learn.admin;

import java.util.List;
import java.util.Map;

import com.spring.learn.lecture.LectureVO;
import com.spring.learn.memberboard.MemberBoardVO;
import com.spring.learn.resume.ResumeVO;
import com.spring.learn.user.UserVO;

public interface AdminService {

	//직전 일개월 수익
	int getRevenueThisMonth(Map<String, String> map);
	
	//직전 일개월 가입자
	int getNewUserforThisMonth(Map<String, String> map);

	//특정기간 수익
	List<RevenueVO> getRevenueEachMonth(Map<String, String> map);
	
	//상위 5개 판매자
	List<String> getBestTeacher();
	
	//Revenue 출력할 
	List<AdminRevenueDatailVO> getRevenueDetail(Map<String, String> map);
	
	int getRevenueTotal(Map<String, String> map);
	
	List<AdminRevenueDatailVO> getRevenueTotalInfo (Map<String, String> map);
	
	List<JoinerVO> getJoinerEachMonth(Map<String, String> map);
	
	List<RevenueVO> getRevenueEachWeekly(Map<String, String> map);

	List<RevenueVO> getRevenueEachDaily(Map<String, String> map);
	
	List<LectureVO> getNewWeeklyLectures();

	List<UserVO> getUsers(Map<String, String> map);

	int getResumeTotal ();
	
	List<ResumeVO> getResumes(Map<String, String> map);

	int getCallcenterTotal ();
	
	List<MemberBoardVO> getCallcenters(Map<String, String> map);



}
