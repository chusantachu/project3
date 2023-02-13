package com.spring.learn.board;

public class BoardCommentVO {
	private String commentNo,boardNo,userId,grade,commentContent,commentRegdate,categoryName,answerAdopt,commentFile
	,qboardNo, fboardNo
	,comment2No, comment2Content, comment2Regdate
	,userName
	,section
	;

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

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getAnswerAdopt() {
		return answerAdopt;
	}

	public void setAnswerAdopt(String answerAdopt) {
		this.answerAdopt = answerAdopt;
	}

	public String getCommentFile() {
		return commentFile;
	}

	public void setCommentFile(String commentFile) {
		this.commentFile = commentFile;
	}
	
	public String getQboardNo() {
		return qboardNo;
	}

	public void setQboardNo(String qboardNo) {
		this.qboardNo = qboardNo;
	}

	public String getFboardNo() {
		return fboardNo;
	}

	public void setFboardNo(String fboardNo) {
		this.fboardNo = fboardNo;
	}
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}	

	public String getComment2No() {
		return comment2No;
	}

	public void setComment2No(String comment2No) {
		this.comment2No = comment2No;
	}

	public String getComment2Content() {
		return comment2Content;
	}

	public void setComment2Content(String comment2Content) {
		this.comment2Content = comment2Content;
	}

	public String getComment2Regdate() {
		return comment2Regdate;
	}

	public void setComment2Regdate(String comment2Regdate) {
		this.comment2Regdate = comment2Regdate;
	}
	
	public String getSection() {
		return section;
	}

	public void setSection(String section) {
		this.section = section;
	}

	@Override
	public String toString() {
		return "BoardCommentVO [commentNo=" + commentNo + ", boardNo=" + boardNo + ", userId=" + userId + ", grade="
				+ grade + ", commentContent=" + commentContent + ", commentRegdate=" + commentRegdate
				+ ", categoryName=" + categoryName + ", answerAdopt=" + answerAdopt + ", commentFile=" + commentFile
				+ ", qboardNo=" + qboardNo + ", fboardNo=" + fboardNo + ", comment2No=" + comment2No
				+ ", comment2Content=" + comment2Content + ", comment2Regdate=" + comment2Regdate + ", userName="
				+ userName + ", section=" + section + "]";
	}

}
