package com.spring.learn.user;

import java.util.List;
import java.util.Map;

public interface UserService {

	UserVO getUser(UserVO vo);
	void insertUser(UserVO vo);

	int getUserId(UserVO vo);
	int modifyUser(UserVO vo);

	
	//findUserId
	List<UserVO> findUserIdList(UserVO user);
	UserVO findUserId(UserVO user);

	UserVO confirmUser(UserVO vo);
	
	//changePassWord
	void changePwd(UserVO user);
	
	//deleteUser
	void deleteUser(UserVO user);

	void addNaverUser(UserVO user);
	
	//좋아요~
		List<LikeVO> getLikeList(LikeVO vo);
		//리뷰수
		int getReviewCnt(LikeVO vo);
		int getReviewRate(LikeVO vo);
		int getOrderCh(LikeVO vo);
		int insertLike(LikeVO vo);
		int deleteLike(LikeVO vo);
		List<LikeVO> getSearchLikeList(LikeVO vo);
		List<LikeVO> getSearchPaidLikeList(LikeVO vo);
		List<LikeVO> getSearchFreeLikeList(LikeVO vo);
		double getReviewAverage(LikeVO vo);
		
	//강의자 신청 승인을 위한 기능
	void updateUserLecture(UserVO vo);

  int getPointLogCount(String userId);

	List<PointLogVO> getPointLogList(Map<String, String> map);

	void updateUserIntro(UserVO vo);

		//JM
	LikeVO getLectureTeacherId(LikeVO vo);
	List<UserVO> getUserList();


}
