package com.spring.learn.memberboard;

public class MemberBoardVO {
	private String qnaNo,userId,grade,qnaTitle,qnaContent,qnaRegdate,qnaAdopt,qnaFile,searchKeyword
	,userGrade, userName;

	public String getQnaNo() {
		return qnaNo;
	}

	public void setQnaNo(String qnaNo) {
		this.qnaNo = qnaNo;
	}

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

	public String getQnaTitle() {
		return qnaTitle;
	}

	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}

	public String getQnaContent() {
		return qnaContent;
	}

	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}

	public String getQnaRegdate() {
		return qnaRegdate;
	}

	public void setQnaRegdate(String qnaRegdate) {
		this.qnaRegdate = qnaRegdate;
	}

	public String getQnaAdopt() {
		return qnaAdopt;
	}

	public void setQnaAdopt(String qnaAdopt) {
		this.qnaAdopt = qnaAdopt;
	}

	public String getQnaFile() {
		return qnaFile;
	}

	public void setQnaFile(String qnaFile) {
		this.qnaFile = qnaFile;
	}

	

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserGrade() {
		return userGrade;
	}

	public void setUserGrade(String userGrade) {
		this.userGrade = userGrade;
	}

	@Override
	public String toString() {
		return "MemberBoardVO [qnaNo=" + qnaNo + ", userId=" + userId + ", grade=" + grade + ", qnaTitle=" + qnaTitle
				+ ", qnaContent=" + qnaContent + ", qnaRegdate=" + qnaRegdate + ", qnaAdopt=" + qnaAdopt + ", qnaFile="
				+ qnaFile + ", searchKeyword=" + searchKeyword + ", userGrade=" + userGrade + "]";
	}



	
		
}
