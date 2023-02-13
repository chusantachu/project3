package com.spring.learn.lecture.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.lecture.ClassVO;
import com.spring.learn.lecture.LectureCommentVO;
import com.spring.learn.lecture.LectureDetailService;
import com.spring.learn.lecture.LectureReviewCommentVO;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.lecture.OfftimetableVO;
import com.spring.learn.order.OrderCartVO;
import com.spring.learn.user.UserVO;

@Service("LectureDetailService")
public class LectureDetailServiceimpl implements LectureDetailService {

	@Autowired
	LectureDetailDAO lectureDetailDAO;
	
	public LectureVO getLectureDetail(LectureVO vo) {
		vo =lectureDetailDAO.getLectureDetail(vo);
		
		return vo ;
	}

	public void insertLectureLike(HashMap<String, String> map) {
		lectureDetailDAO.insertLectureLike(map);
		
	}
	public void deleteLectureLike(HashMap<String, String> map) {
		lectureDetailDAO.deleteLectureLike(map);
		
	}
	
	
	public int getLectureLike(LectureVO vo) {
		
		int lectureLike = lectureDetailDAO.getLectureLike(vo);
		
		return lectureLike;
	}

	public int checkLike(HashMap<String, String> map) {
		int check = lectureDetailDAO.checkLike(map);
		
		return check;
	}

	public void insertLectureComment(LectureCommentVO vo) {
		 lectureDetailDAO.insertLectureComment(vo);
		
	}

	public List<LectureCommentVO> getLectureReviewList(LectureCommentVO vo) {
		List<LectureCommentVO> list = lectureDetailDAO.getLectureReviewList(vo);
		return list;
	}

	public List<LectureCommentVO> getLectureReviewListRateDesc(LectureCommentVO vo) {
		List<LectureCommentVO> list = lectureDetailDAO.getLectureReviewListRateDesc(vo);
		return list;
	}

	public List<LectureCommentVO> getLectureReviewListRateAsc(LectureCommentVO vo) {
		List<LectureCommentVO> list = lectureDetailDAO.getLectureReviewListRateAsc(vo);
		return list;
	}

	public LectureCommentVO getCounts(LectureCommentVO vo) {
		LectureCommentVO count = lectureDetailDAO.getCounts(vo);
		return count;
	}

	public List<ClassVO> getClasses(String lectureNo) {
		List<ClassVO> list = lectureDetailDAO.getClasses(lectureNo);
		return list;
	}

	public List<OfftimetableVO> getTimetables(String lectureNo) {
		List<OfftimetableVO> list = lectureDetailDAO.getTimetables(lectureNo);
		return list;
	}

	public void insertReply(LectureReviewCommentVO vo) {
		 lectureDetailDAO.insertReply(vo);
		
	}

	public List<LectureReviewCommentVO> getReplyList(String lectureNo) {
		List<LectureReviewCommentVO> list = lectureDetailDAO.getReplyList(lectureNo);
		return list;
	}

	public void deleteReply(LectureReviewCommentVO vo) {
		lectureDetailDAO.deleteReply(vo);
		
	}

	public void insertCart(HashMap<String, String> map) {
		lectureDetailDAO.insertCart(map);
		
	}

	public ClassVO getClassDetail(String classNo) {
		ClassVO vo = lectureDetailDAO.getClassDetail(classNo);
		return vo;
	}

	public int checkpurchase(HashMap<String, String> map) {
		int checkValue = lectureDetailDAO.checkpurchase(map);
		return checkValue;
	}
	
	public int checkCart(HashMap<String, String> map) {
		int checkValue = lectureDetailDAO.checkCart(map);
		return checkValue;
	}

	public void deleteComment(LectureCommentVO vo) {
		lectureDetailDAO.deleteComment(vo);
		
	}

	public int[] getMyBoardNo(HashMap<String, String> map) {
		int[] arr = lectureDetailDAO.getMyBoardNo(map);
		return arr;
	}



	

	
	
	
}
