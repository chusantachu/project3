package com.spring.learn.user.impl;

import com.spring.learn.user.PointLogVO;
import java.util.List;


import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.learn.user.LikeVO;
import com.spring.learn.user.UserVO;

@Repository
public class UserDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	public UserDAO() {
		System.out.println("=========== UserDAOMybatis() 객체 생성");
	}
	
	public UserVO getUser(UserVO vo) {
		System.out.println("===> Mybatis 사용 getUser() 실행");
		return mybatis.selectOne("userDAO.getUser", vo);
	}
	
	public int insertUser(UserVO vo) {
		System.out.println("===> Mybatis 사용 insertUser() 실행");
		return mybatis.insert("userDAO.insertUser", vo);
	}

	public int getUserId(UserVO vo) {
		System.out.println("===> Mybatis 사용 getUserId() 실행");
		int cnt = mybatis.selectOne("userDAO.getUserId", vo);
		return cnt;
	}

	public int modifyUser(UserVO vo) {
		System.out.println("===> Mybatis 사용 modifyUser() 실행");
		return mybatis.update("userDAO.modifyUser", vo);
	}
	
	
	public List<UserVO> findUserIdList(UserVO user) {
		return mybatis.selectList("userDAO.findUserIdList", user);
	}
	
	public UserVO findUserId(UserVO user) {
		return mybatis.selectOne("userDAO.findUserId", user);
	}

	public UserVO confirmUser(UserVO vo) {
		return mybatis.selectOne("userDAO.confirmUser", vo);
	}

	public void changePwd(UserVO user) {
		mybatis.update("userDAO.changePwd", user);
	}
	
	public void deleteUser(UserVO user) {
		mybatis.update("userDAO.deleteUser", user);		
	}

	public void addNaverUser(UserVO user) {
		mybatis.update("userDAO.addNaverUser", user);
	}
	
	public List<LikeVO> getLikeList(LikeVO vo) {
		return mybatis.selectList("userDAO.getLikeList", vo);
	}

	public int getReviewCnt(LikeVO vo) {
		return mybatis.selectOne("userDAO.getReviewCnt", vo);
	}

	public int getReviewRate(LikeVO vo) {
		return mybatis.selectOne("userDAO.getReviewRate", vo);
	}

	public int getOrderCh(LikeVO vo) {
		return mybatis.selectOne("userDAO.getOrderCh", vo);
	}

	public int insertLike(LikeVO vo) {
		return mybatis.insert("userDAO.insertLike", vo);
	}

	public int deleteLike(LikeVO vo) {
		return mybatis.delete("userDAO.deleteLike", vo);
	}

	public List<LikeVO> getSearchLikeList(LikeVO vo) {
		System.out.println("dao 에서 찍어본 vo : " + vo);
		return mybatis.selectList("userDAO.getSearchLikeList", vo);
	}

	public List<LikeVO> getSearchPaidLikeList(LikeVO vo) {
		return mybatis.selectList("userDAO.getSearchPaidLikeList", vo);
	}

	public List<LikeVO> getSearchFreeLikeList(LikeVO vo) {
		return mybatis.selectList("userDAO.getSearchFreeLikeList", vo);
	}

	public double getReviewAverage(LikeVO vo) {
		return mybatis.selectOne("userDAO.getReviewAverage", vo);
	}
	
	//강의자 신청 승인을 위한 기능
	public void updateUserLecture(UserVO vo) {
		mybatis.update("userDAO.updateUserLecture", vo);
	}
	
	public void updateUserIntro(UserVO vo) {
		mybatis.update("userDAO.updateUserIntro", vo);;
	}

	public int getPointLogCount(String userId) {
		return mybatis.selectOne("userDAO.getPointLogCount", userId);
	}

	public List<PointLogVO> getPointLogList(Map<String, String> map) {
		return mybatis.selectList("userDAO.getPointLogList", map);
	}
	
	public LikeVO getLectureTeacherId(LikeVO vo) {
		return mybatis.selectOne("userDAO.getLectureTeacherId", vo);
	}

	public List<UserVO> getUserList() {
		return mybatis.selectList("userDAO.getUserList");
	}
	
}





