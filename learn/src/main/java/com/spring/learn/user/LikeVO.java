package com.spring.learn.user;

public class LikeVO {
	private String userId, teacher, categoryName, lectureTitle, lectureWriter, lectureLevel, lectureSummary;
	private int likeNo, lectureNo, lectureSalerate, lecturePrice;
	private int	lectureSalePrice = (int)(lecturePrice-(lectureSalerate/100.0)*lecturePrice);//세일되서 총금액
	private int realSalePrice = (int)((lectureSalerate/100.0)*lecturePrice);//세일이 얼마됬는지 
	private int orderCh;//구매 했으면 1 구매 안했으면 0
	private int reviewCnt;//리뷰 남긴 사람 수
	private int reviewRate;//리뷰별점 총수
	private double reviewAverage;//리뷰별점 평균
	private int reviewSearchAverage;//리뷰별점 평균
	private String lectureCoverimg;//렉쳐 이미지
	private String studentCount;//학생수로 검색용
	private String searchStatus;//학생수로 검색용
	private String searchOrder;//학생수로 검색용
	
	public int getOrderCh() {
		return orderCh;
	}
	public void setOrderCh(int orderCh) {
		this.orderCh = orderCh;
	}
	public int getReviewCnt() {
		return reviewCnt;
	}
	public void setReviewCnt(int reviewCnt) {
		this.reviewCnt = reviewCnt;
	}
	public int getReviewRate() {
		return reviewRate;
	}
	public void setReviewRate(int reviewRate) {
		this.reviewRate = reviewRate;
	}
	
	public double getReviewAverage() {
		return reviewAverage;
	}
	public void setReviewAverage() {
		if(reviewRate == 0) {
			this.reviewAverage = 0;
			return;
		} else {
			this.reviewAverage = ((reviewRate*10/reviewCnt)/10.0);
		}
			
	}
	
	public int getLectureSalePrice() {
		return lectureSalePrice;
	}
	public void setLectureSalePrice() {
		lectureSalePrice = (int)(lecturePrice-(lectureSalerate/100.0)*lecturePrice);
	}
	
	public int getRealSalePrice() {
		return realSalePrice;
	}
	public void setRealSalePrice() {
		realSalePrice = (int)((lectureSalerate/100.0)*lecturePrice);
	}
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTeacher() {
		return teacher;
	}
	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getLectureTitle() {
		return lectureTitle;
	}
	public void setLectureTitle(String lectureTitle) {
		this.lectureTitle = lectureTitle;
	}
	public String getLectureWriter() {
		return lectureWriter;
	}
	public void setLectureWriter(String lectureWriter) {
		this.lectureWriter = lectureWriter;
	}
	public String getLectureLevel() {
		return lectureLevel;
	}
	public void setLectureLevel(String lectureLevel) {
		this.lectureLevel = lectureLevel;
	}
	public String getLectureSummary() {
		return lectureSummary;
	}
	public void setLectureSummary(String lectureSummary) {
		this.lectureSummary = lectureSummary;
	}
	public int getLikeNo() {
		return likeNo;
	}
	public void setLikeNo(int likeNo) {
		this.likeNo = likeNo;
	}
	public int getLectureNo() {
		return lectureNo;
	}
	public void setLectureNo(int lectureNo) {
		this.lectureNo = lectureNo;
	}
	public int getLectureSalerate() {
		return lectureSalerate;
	}
	public void setLectureSalerate(int lectureSalerate) {
		this.lectureSalerate = lectureSalerate;
	}
	public int getLecturePrice() {
		return lecturePrice;
	}
	public void setLecturePrice(int lecturePrice) {
		this.lecturePrice = lecturePrice;
	}

	public String getLectureCoverimg() {
		return lectureCoverimg;
	}
	public void setLectureㅊoverimg(String lectureCoverimg) {
		this.lectureCoverimg = lectureCoverimg;
	}

	public String getStudentCount() {
		return studentCount;
	}
	public void setStudentCount(String studentCount) {
		this.studentCount = studentCount;
	}
	
	public String getSearchStatus() {
		return searchStatus;
	}
	public void setSearchStatus(String searchStatus) {
		this.searchStatus = searchStatus;
	}
	public String getSearchOrder() {
		return searchOrder;
	}
	public void setSearchOrder(String searchOrder) {
		this.searchOrder = searchOrder;
	}
	
	public int getReviewSearchAverage() {
		return reviewSearchAverage;
	}
	public void setReviewSearchAverage(int reviewSearchAverage) {
		this.reviewSearchAverage = reviewSearchAverage;
	}
	@Override
	public String toString() {
		return "LikeVO [userId=" + userId + ", teacher=" + teacher + ", categoryName=" + categoryName
				+ ", lectureTitle=" + lectureTitle + ", lectureWriter=" + lectureWriter + ", lectureLevel="
				+ lectureLevel + ", lectureSummary=" + lectureSummary + ", likeNo=" + likeNo + ", lectureNo="
				+ lectureNo + ", lectureSalerate=" + lectureSalerate + ", lecturePrice=" + lecturePrice
				+ ", lectureSalePrice=" + lectureSalePrice + ", realSalePrice=" + realSalePrice + ", orderCh=" + orderCh
				+ ", reviewCnt=" + reviewCnt + ", reviewRate=" + reviewRate + ", reviewAverage=" + reviewAverage
				+ ", reviewSearchAverage=" + reviewSearchAverage + ", lectureCoverimg=" + lectureCoverimg
				+ ", studentCount=" + studentCount + ", searchStatus=" + searchStatus + ", searchOrder=" + searchOrder
				+ "]";
	}
	
	
	
	
	

	
	
	
	

}
	