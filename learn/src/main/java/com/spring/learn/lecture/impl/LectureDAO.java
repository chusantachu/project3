package com.spring.learn.lecture.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.spring.learn.lecture.CategoryVO;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.user.UserVO;

@Repository
public interface LectureDAO {
	// 메소드명이 Mapper 파일의 id명으로 사용

	List<CategoryVO> getCategories();

	String getCategoryName(String categoryNo);
	
	List<LectureVO> getOnlineLectures(Map<String, String> map);
	
	List<LectureVO> getOfflineLectures(Map<String, String> map);
	  
	List<LectureVO> getLecturesFiltering(Map<String, String> map);
	
	List<LectureVO> getOnLecturesFiltering(Map<String, String> map);
	
	int getLectureTotalCount(Map<String, String> map);

	int getOnLectureTotalCount(Map<String, String> map);
	
	int countStudents(String lectureNo);
	
	double getAvgLecture(String lectureNo);
	
	int countLectureReview(String lectureNo);

	List<LectureVO> searchLectureLocation(Map<String, String> map);
	
	List<LectureVO> lectureLocationAll();

	  LectureVO getLecture(String lecNo);
	  
	  List<LectureVO> getOnlineLecturebyUserId(String userId);

	  Integer getTeacherLectureCount(String userId);

	  List<LectureVO> getTeacherLectureList(Map<String, String> map);

	  Double getLectureAvgRate(String userId);

	  Integer getLectureSales(String userName);

	  Integer getStudentCount(String userId);

	  List<LectureVO> getRealtimeSales(Map<String, String> map);

	  List<LectureVO> salesByMonth(String userName);

	  List<LectureVO> salesByLecture(String userName);

	  List<LectureVO> salesByLine(String userName);

	  List<LectureVO> getSalesByLecture(Map<String, String> map);

	  int getSalesSumByLecture(String lectureNo);

	  int getSalesLectureViewCount(String lectureNo);

	  int getOrderLectureCount(String userId);

	  void addLecture(LectureVO lecture);

	  int getLectureNo();
	  
	  //프로필 조회용
	  List<LectureVO> getLectureProfile(UserVO vo); 
	  List<LectureVO> getLectureProfileAll(UserVO vo); 
	  List<LectureVO> getLectureProfilePage(Map<String, Object> map); 
	  int countLectureProfilePage(UserVO vo);
	  List<LectureVO> getLectureProfilePage_old(Map<String, Object> map); 
	  

	List<UserVO> getLectureStudentList(Map<String, String> map);

	void addLectureCoverimg(LectureVO lecture);

	void editLecture(LectureVO lecture);
}





