package com.spring.learn.user.impl;

import com.spring.learn.user.PointLogVO;
import java.util.List;

import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.user.LikeVO;
import com.spring.learn.user.UserService;
import com.spring.learn.user.UserVO;

// UserService 구현
@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDAO;

	@Override
	public UserVO getUser(UserVO vo) {
		return userDAO.getUser(vo);
	}

	@Override
	public void insertUser(UserVO vo) {
		userDAO.insertUser(vo);
	}

	@Override
	public int getUserId(UserVO vo) {
		return userDAO.getUserId(vo);
	}

	@Override
	public int modifyUser(UserVO vo) {
		return userDAO.modifyUser(vo);
	}
	
	@Override
	public List<UserVO> findUserIdList(UserVO user) {
		return userDAO.findUserIdList(user);
	}


	@Override
	public UserVO findUserId(UserVO user) {
		return userDAO.findUserId(user);

	}

	@Override
	public UserVO confirmUser(UserVO vo) {
		return userDAO.confirmUser(vo);
	}

	@Override
	public void changePwd(UserVO user) {
		userDAO.changePwd(user);		
	}

	@Override
	public void deleteUser(UserVO user) {
		userDAO.deleteUser(user);
		
	}

	@Override
	public void addNaverUser(UserVO user) {
		userDAO.addNaverUser(user);
	}
	
	@Override
	public List<LikeVO> getLikeList(LikeVO vo) {
		return userDAO.getLikeList(vo);
	}

	@Override
	public int getReviewCnt(LikeVO vo) {
		return userDAO.getReviewCnt(vo);
	}

	@Override
	public int getReviewRate(LikeVO vo) {
		return userDAO.getReviewRate(vo);
	}

	@Override
	public int getOrderCh(LikeVO vo) {
		return userDAO.getOrderCh(vo);
	}

	@Override
	public int insertLike(LikeVO vo) {
		return userDAO.insertLike(vo);
	}

	@Override
	public int deleteLike(LikeVO vo) {
		return userDAO.deleteLike(vo);
	}

	@Override
	public List<LikeVO> getSearchLikeList(LikeVO vo) {
		return userDAO.getSearchLikeList(vo);
	}

	@Override
	public List<LikeVO> getSearchPaidLikeList(LikeVO vo) {
		return userDAO.getSearchPaidLikeList(vo);
	}

	@Override
	public List<LikeVO> getSearchFreeLikeList(LikeVO vo) {
		return userDAO.getSearchFreeLikeList(vo);
	}

	@Override
	public double getReviewAverage(LikeVO vo) {
		return userDAO.getReviewAverage(vo);
	}
	
	//강의자 신청 승인을 위한 기능
	@Override
	public void updateUserLecture(UserVO vo) {
		userDAO.updateUserLecture(vo);
	}

	@Override
	public void updateUserIntro(UserVO vo) {
		userDAO.updateUserIntro(vo);
	}

	@Override
	public int getPointLogCount(String userId) {
		return userDAO.getPointLogCount(userId);
	}

	@Override
	public List<PointLogVO> getPointLogList(Map<String, String> map) {
		return userDAO.getPointLogList(map);
	}
	
	@Override
	public LikeVO getLectureTeacherId(LikeVO vo) {
		return userDAO.getLectureTeacherId(vo);
	}

	@Override
	public List<UserVO> getUserList() {
		return userDAO.getUserList();
	}
	
	
}
