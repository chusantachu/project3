package com.spring.learn.lecture;

public class LectureCommentVO {

	private int boardNo, lectureNo, boardRate;
	private String userId, boardContent;
	String boardRegdate;
	
	private int rate5, rate4, rate3, rate2, rate1, totalComment;
	
	public LectureCommentVO() {
		
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public int getLectureNo() {
		return lectureNo;
	}

	public void setLectureNo(int lectureNo) {
		this.lectureNo = lectureNo;
	}

	public int getBoardRate() {
		return boardRate;
	}

	public void setBoardRate(int boardRate) {
		this.boardRate = boardRate;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public String getBoardRegdate() {
		return boardRegdate;
	}

	public void setBoardRegdate(String boardRegdate) {
		this.boardRegdate = boardRegdate;
	}
	
	public int getRate5() {
		return rate5;
	}

	public void setRate5(int rate5) {
		this.rate5 = rate5;
	}

	public int getRate4() {
		return rate4;
	}

	public void setRate4(int rate4) {
		this.rate4 = rate4;
	}

	public int getRate3() {
		return rate3;
	}

	public void setRate3(int rate3) {
		this.rate3 = rate3;
	}

	public int getRate2() {
		return rate2;
	}

	public void setRate2(int rate2) {
		this.rate2 = rate2;
	}

	public int getRate1() {
		return rate1;
	}

	public void setRate1(int rate1) {
		this.rate1 = rate1;
	}

	public int getTotalComment() {
		return totalComment;
	}

	public void setTotalComment(int totalComment) {
		this.totalComment = totalComment;
	}

	@Override
	public String toString() {
		return "LectureCommentVO [boardNo=" + boardNo + ", lectureNo=" + lectureNo + ", boardRate=" + boardRate
				+ ", userId=" + userId + ", boardContent=" + boardContent + ", boardRegdate=" + boardRegdate
				+ ", rate5=" + rate5 + ", rate4=" + rate4 + ", rate3=" + rate3 + ", rate2=" + rate2 + ", rate1=" + rate1
				+ ", totalComment=" + totalComment + "]";
	}


	
	
	
}
