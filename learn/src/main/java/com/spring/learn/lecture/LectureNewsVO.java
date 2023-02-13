package com.spring.learn.lecture;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class LectureNewsVO {
	
	private int boardNo;
	private String lectureNo;
	private String lectureWriter;
	private String newsContent;
	private String newsTitle;
	private String boardRegdate;
	
	@JsonIgnore
	private String searchKeyword = "";
	
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
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
	public String getNewsContent() {
		return newsContent;
	}
	public void setNewsContent(String newsContent) {
		this.newsContent = newsContent;
	}
	public String getBoardRegdate() {
		return boardRegdate;
	}
	public void setBoardRegdate(String boardRegdate) {
		this.boardRegdate = boardRegdate;
	}
	public String getNewsTitle() {
		return newsTitle;
	}
	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}
	
	@Override
	public String toString() {
		return "LectureNewsVO [boardNo=" + boardNo + ", lectureNo=" + lectureNo + ", lectureWriter=" + lectureWriter
				+ ", newsContent=" + newsContent + ", newsTitle=" + newsTitle + ", boardRegdate=" + boardRegdate
				+ ", searchKeyword=" + searchKeyword + "]";
	}


}
