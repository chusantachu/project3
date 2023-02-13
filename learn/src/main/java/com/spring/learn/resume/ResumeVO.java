package com.spring.learn.resume;

public class ResumeVO {
	private String userId,
	categoryName,
	userName,
	userTel,
	userIntroduce,
	userLink,
	regdate
	;
	private String resumeStatus = "false";
	
	public ResumeVO() {
		// TODO Auto-generated constructor stub
	}
	
	public ResumeVO(String userId, String categoryName, String userName, String userTel, String userIntroduce,
			String userLink) {
		super();
		this.userId = userId;
		this.categoryName = categoryName;
		this.userName = userName;
		this.userTel = userTel;
		this.userIntroduce = userIntroduce;
		this.userLink = userLink;
	}

	
	public ResumeVO(String userId, String categoryName, String userName, String userTel, String userIntroduce,
			String userLink, String resumeStatus) {
		super();
		this.userId = userId;
		this.categoryName = categoryName;
		this.userName = userName;
		this.userTel = userTel;
		this.userIntroduce = userIntroduce;
		this.userLink = userLink;
		this.resumeStatus = resumeStatus;
	}
	
	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserTel() {
		return userTel;
	}

	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}

	public String getUserIntroduce() {
		return userIntroduce;
	}

	public void setUserIntroduce(String userIntroduce) {
		this.userIntroduce = userIntroduce;
	}

	public String getUserLink() {
		return userLink;
	}

	public void setUserLink(String userLink) {
		this.userLink = userLink;
	}

	
	
	public String getResumeStatus() {
		return resumeStatus;
	}

	public void setResumeStatus(String resumeStatus) {
		this.resumeStatus = resumeStatus;
	}

	@Override
	public String toString() {
		return "ResumeVO [userId=" + userId + ", categoryName=" + categoryName + ", userName=" + userName + ", userTel="
				+ userTel + ", userIntroduce=" + userIntroduce + ", userLink=" + userLink + ", regdate=" + regdate
				+ ", resumeStatus=" + resumeStatus + "]";
	}


	
	
	
	
}
