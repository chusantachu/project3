package com.spring.learn.user;

import java.sql.Date;

public class UserVO {
	private String userId, grade, userName, userPwd, userBirth, socialType, userIntro;
	private int points;
	private Date userRegdate;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserBirth() {
		return userBirth;
	}
	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}
	public int getPoints() {
		return points;
	}
	public void setPoints(int points) {
		this.points = points;
	}
	public Date getUserRegdate() {
		return userRegdate;
	}
	public void setUserRegdate(Date userRegdate) {
		this.userRegdate = userRegdate;
	}
	public String getSocialType() {
		return socialType;
	}

	public void setSocialType(String socialType) {
		this.socialType = socialType;
	}
	
	
	public String getUserIntro() {
		return userIntro;
	}
	public void setUserIntro(String userIntro) {
		this.userIntro = userIntro;
	}
	
	@Override
	public String toString() {
		return "UserVO [userId=" + userId + ", grade=" + grade + ", userName=" + userName + ", userPwd=" + userPwd
				+ ", userBirth=" + userBirth + ", socialType=" + socialType + ", userIntro=" + userIntro + ", points="
				+ points + ", userRegdate=" + userRegdate + "]";
	}
	

	

}
	