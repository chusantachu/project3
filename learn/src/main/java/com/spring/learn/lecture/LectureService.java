package com.spring.learn.lecture;

import java.util.List;
import java.util.Map;

import com.spring.learn.user.UserVO;

public interface LectureService {

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
	
	//카테고리 가져오기
	List<CategoryVO> getCategories();
	
	//카테고리 이름 가져오기
	String getCategoryName(String categoryNo);
	
	//카테고리별 온라인 강의 조회
	List<LectureVO> getOnlineLectures(Map<String, String> map);

	//카테고리별 오프라인 강의 조회
	List<LectureVO> getOfflineLectures(Map<String, String> map);
	
	//필터링조건별 온오프 강의 조회
	List<LectureVO> getLecturesFiltering(Map<String, String> map);
	List<LectureVO> getOnLecturesFiltering(Map<String, String> map);
	
	//paging용 TotalCount 계산
	int getLectureTotalCount(Map<String, String> map);
	int getOnLectureTotalCount(Map<String, String> map);
	
	//강의 수강생 카운트
	int countStudents(String lectureNo);
	
	//강의 평점 카운트
	double getAvgLecture(String lectureNo);
	
	//강의 리뷰 개수 카운트
	int countLectureReview(String lectureNo);

	List<LectureVO> searchLectureLocation(Map<String, String> map);
	
	List<LectureVO> lectureLocationAll();

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
