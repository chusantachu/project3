package com.spring.learn.home;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class HomeVO {
	private int boardNo, boardRate;
	private String userId, boardContent, lectureNo;
	private String boardRegdate;
	private String lectureTitle, userName;
	
	private String categoryName;
	private String lectureWriter;
	private String lectureUrl; //강의 공유 url
	private String lectureDue; //오프라인은 NULL
	private String lectureLevel; //입문, 초급, 중급이상
	private String lectureContent;
	private String lectureSummary; //Content와 동일, 출력 위치가 다름 단, 오프라인은 강의시간 포함
	private String lectureSalerate; //할인율
	private String lectureSaledue; //요일수로 받아서 처리 한달 30일, 세 달 90일
	private String lecturePrice; 
	private String lectureRegdate;
	private String lectureCoverimg;
	private String lectureSection; // 슬래시/ 로 구분 ex.스프링입문/스프링이란/스프링의이해 (배열 인덱스 사용)
	private String lectureOnOff; //0: 온라인 / 1: 오프라인
	private int isBuy; // 0: 미구매 / 1: 구매 (DB 에는 추가 X)
	
	private String lecturePastAddress; //지도 검색용 지번 주소
	
	//할인가 필드 변수 
	private int salePrice; //원가 * 할인가
	
	//수강생 수
	private int studentCount;
	
	//수강 평점
	private double lectureRate;
	
	//수강 리뷰 개수
	private int reviewCount;
	
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

	public String getLectureTitle() {
		return lectureTitle;
	}

	public void setLectureTitle(String lectureTitle) {
		this.lectureTitle = lectureTitle;
	}
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getLectureWriter() {
		return lectureWriter;
	}

	public void setLectureWriter(String lectureWriter) {
		this.lectureWriter = lectureWriter;
	}

	public String getLectureUrl() {
		return lectureUrl;
	}

	public void setLectureUrl(String lectureUrl) {
		this.lectureUrl = lectureUrl;
	}

	public String getLectureDue() {
		return lectureDue;
	}

	public void setLectureDue(String lectureDue) {
		this.lectureDue = lectureDue;
	}

	public String getLectureLevel() {
		return lectureLevel;
	}

	public void setLectureLevel(String lectureLevel) {
		this.lectureLevel = lectureLevel;
	}

	public String getLectureContent() {
		return lectureContent;
	}

	public void setLectureContent(String lectureContent) {
		this.lectureContent = lectureContent;
	}

	public String getLectureSummary() {
		return lectureSummary;
	}

	public void setLectureSummary(String lectureSummary) {
		this.lectureSummary = lectureSummary;
	}

	public String getLectureSalerate() {
		return lectureSalerate;
	}

	public void setLectureSalerate(String lectureSalerate) {
		this.lectureSalerate = lectureSalerate;
	}

	public String getLectureSaledue() {
		return lectureSaledue;
	}

	public void setLectureSaledue(String lectureSaledue) {
		this.lectureSaledue = lectureSaledue;
	}

	public String getLecturePrice() {
		return lecturePrice;
	}

	public void setLecturePrice(String lecturePrice) {
		this.lecturePrice = lecturePrice;
	}

	public String getLectureRegdate() {
		return lectureRegdate;
	}

	public void setLectureRegdate(String lectureRegdate) {
		this.lectureRegdate = lectureRegdate;
	}

	public String getLectureCoverimg() {
		return lectureCoverimg;
	}

	public void setLectureCoverimg(String lectureCoverimg) {
		this.lectureCoverimg = lectureCoverimg;
	}

	public String getLectureSection() {
		return lectureSection;
	}

	public void setLectureSection(String lectureSection) {
		this.lectureSection = lectureSection;
	}

	public String getLectureOnOff() {
		return lectureOnOff;
	}

	public void setLectureOnOff(String lectureOnOff) {
		this.lectureOnOff = lectureOnOff;
	}

	public int getIsBuy() {
		return isBuy;
	}

	public void setIsBuy(int isBuy) {
		this.isBuy = isBuy;
	}

	public String getLecturePastAddress() {
		return lecturePastAddress;
	}

	public void setLecturePastAddress(String lecturePastAddress) {
		this.lecturePastAddress = lecturePastAddress;
	}

	public int getSalePrice() {
		return salePrice;
	}
	
	public void setSalePrice() {
		this.salePrice = 
			(int)(Integer.valueOf(lecturePrice)-((Integer.valueOf(lecturePrice) * (Integer.valueOf(lectureSalerate)/100.0))));
	}

	public int getStudentCount() {
		return studentCount;
	}

	public void setStudentCount(int studentCount) {
		this.studentCount = studentCount;
	}

	public double getLectureRate() {
		return lectureRate;
	}

	public void setLectureRate(double lectureRate) {
		this.lectureRate = lectureRate;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	@Override
	public String toString() {
		return "HomeVO [boardNo=" + boardNo + ", lectureNo=" + lectureNo + ", boardRate=" + boardRate + ", userId="
				+ userId + ", boardContent=" + boardContent + ", boardRegdate=" + boardRegdate + ", lectureTitle="
				+ lectureTitle + ", userName=" + userName + ", categoryName=" + categoryName + ", lectureWriter="
				+ lectureWriter + ", lectureUrl=" + lectureUrl + ", lectureDue=" + lectureDue + ", lectureLevel="
				+ lectureLevel + ", lectureContent=" + lectureContent + ", lectureSummary=" + lectureSummary
				+ ", lectureSalerate=" + lectureSalerate + ", lectureSaledue=" + lectureSaledue + ", lecturePrice="
				+ lecturePrice + ", lectureRegdate=" + lectureRegdate + ", lectureCoverimg=" + lectureCoverimg
				+ ", lectureSection=" + lectureSection + ", lectureOnOff=" + lectureOnOff + ", isBuy=" + isBuy
				+ ", lecturePastAddress=" + lecturePastAddress + ", salePrice=" + salePrice + ", studentCount="
				+ studentCount + ", lectureRate=" + lectureRate + ", reviewCount=" + reviewCount + ", searchKeyword="
				+ searchKeyword + "]";
	}

}
