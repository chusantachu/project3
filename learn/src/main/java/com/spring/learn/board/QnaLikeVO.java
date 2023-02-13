package com.spring.learn.board;

public class QnaLikeVO {
	private String userId,boardNo,grade;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	@Override
	public String toString() {
		return "QnaLikeVO [userId=" + userId + ", boardNo=" + boardNo + ", grade=" + grade + "]";
	}
	
}
