package com.spring.learn.memberboard;

public class AdminQNAReplyVO {
	
	private String commentNo,qnaNo,userId,grade,commentContent,commentRegdate,commentFile;

	public String getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(String commentNo) {
		this.commentNo = commentNo;
	}

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

	public String getCommentFile() {
		return commentFile;
	}

	public void setCommentFile(String commentFile) {
		this.commentFile = commentFile;
	}
	

	@Override
	public String toString() {
		return "AdminQNAReplyVO [commentNo=" + commentNo + ", qnaNo=" + qnaNo + ", userId=" + userId + ", grade="
				+ grade + ", commentContent=" + commentContent + ", commentRegdate=" + commentRegdate + ", commentFile="
				+ commentFile + "]";
	}

	
	
}
