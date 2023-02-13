package com.spring.learn.lecture;

import java.util.HashMap;
import java.util.List;

import com.spring.learn.order.OrderCartVO;
import com.spring.learn.user.UserVO;

public interface LectureDetailService {

	LectureVO getLectureDetail(LectureVO vo);
	void insertLectureLike(HashMap<String, String> map);
	void deleteLectureLike(HashMap<String, String> map);
	int getLectureLike(LectureVO vo);
	int checkLike(HashMap<String, String> map);
	
	void insertLectureComment(LectureCommentVO vo);
	List<LectureCommentVO> getLectureReviewList(LectureCommentVO vo);
	List<LectureCommentVO> getLectureReviewListRateDesc(LectureCommentVO vo);
	List<LectureCommentVO> getLectureReviewListRateAsc(LectureCommentVO vo);

	LectureCommentVO getCounts(LectureCommentVO vo); 
	
	List<ClassVO> getClasses(String lectureNo);
	ClassVO getClassDetail(String classNo);
	List<OfftimetableVO> getTimetables(String lectureNo);
	
	void insertReply(LectureReviewCommentVO vo);
	void deleteReply(LectureReviewCommentVO vo);
	void deleteComment(LectureCommentVO vo);
	
	List<LectureReviewCommentVO> getReplyList(String lectureNo);
	
	void insertCart(HashMap<String, String> map);
	int checkpurchase(HashMap<String, String> map);
	int checkCart(HashMap<String, String> map);
	
	int[] getMyBoardNo(HashMap<String, String> map);

}
