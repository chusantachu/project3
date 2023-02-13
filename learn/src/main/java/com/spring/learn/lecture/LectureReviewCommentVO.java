package com.spring.learn.lecture;

public class LectureReviewCommentVO {
	private String commentNo,
	boardNo,
	lectureNo,
	lectureWriter,
	commentContent,
	commentRegdate
	;

	public LectureReviewCommentVO() {
		// TODO Auto-generated constructor stub
	}
	
	public String getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(String commentNo) {
		this.commentNo = commentNo;
	}

	public String getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}

	public String getLectureNo() {
		return lectureNo;
	}

	public void setLectureNo(String lectureNo) {
		this.lectureNo = lectureNo;
	}

	public String getLectureWriter() {
		return lectureWriter;
	}

	public void setLectureWriter(String lectureWriter) {
		this.lectureWriter = lectureWriter;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public String getCommentRegdate() {
		return commentRegdate;
	}

	public void setCommentRegdate(String commentRegdate) {
		this.commentRegdate = commentRegdate;
	}

	@Override
	public String toString() {
		return "LectureReviewCommentVO [commentNo=" + commentNo + ", boardNo=" + boardNo + ", lectureNo=" + lectureNo
				+ ", lectureWriter=" + lectureWriter + ", commentContent=" + commentContent + ", commentRegdate="
				+ commentRegdate + "]";
	}
	
	
	
	
	
}
