package com.spring.learn.order;

import java.sql.Date;
import java.sql.Timestamp;

import java.sql.Date;

public class OrderCartVO {
	private String userId, userName, teacher, lectureWriter, categoryName, lectureTitle, lectureLevel, lectureSection, lectureCoverimg;
	private int points, lectureNo, lectureDue, lectureSalerate, lecturePrice, lectureOnOff,timetableNo, cartNo;
	private int	lectureSalePrice = (int)(lecturePrice-(lectureSalerate/100.0)*lecturePrice);
	private int realSalePrice = (int)((lectureSalerate/100.0)*lecturePrice);
	private int realPrice;
	private Date lectureSaledue;
	
	public int getRealSalePrice() {
		return realSalePrice;
	}
	public void setRealSalePrice() {
		realSalePrice = (int)((lectureSalerate/100.0)*lecturePrice);
	}
	public int getRealPrice() {
		return realPrice;
	}
	public void setRealPrice(int realPrice) {
		this.realPrice = realPrice;
	}

	private Date lectureRegdate;
	private Timestamp timetableStart, timeTableEnd;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getTeacher() {
		return teacher;
	}
	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}
	public String getLectureWriter() {
		return lectureWriter;
	}
	public void setLectureWriter(String lectureWriter) {
		this.lectureWriter = lectureWriter;
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
	public String getLectureLevel() {
		return lectureLevel;
	}
	public void setLectureLevel(String lectureLevel) {
		this.lectureLevel = lectureLevel;
	}
	public String getLectureSection() {
		return lectureSection;
	}
	public void setLectureSection(String lectureSection) {
		this.lectureSection = lectureSection;
	}
	public int getPoints() {
		return points;
	}
	public void setPoints(int points) {
		this.points = points;
	}
	public int getLectureNo() {
		return lectureNo;
	}
	public void setLectureNo(int lectureNo) {
		this.lectureNo = lectureNo;
	}
	public int getLectureDue() {
		return lectureDue;
	}
	public void setLectureDue(int lectureDue) {
		this.lectureDue = lectureDue;
	}
	public int getLectureSalerate() {
		return lectureSalerate;
	}
	public void setLectureSalerate(int lectureSalerate) {
		this.lectureSalerate = lectureSalerate;
	}
	public Date getLectureSaledue() {
		return lectureSaledue;
	}
	public void setLectureSaledue(Date lectureSaledue) {
		this.lectureSaledue = lectureSaledue;
	}
	public int getLecturePrice() {
		return lecturePrice;
	}
	public void setLecturePrice(int lecturePrice) {
		this.lecturePrice = lecturePrice;
	}
	public int getLectureOnOff() {
		return lectureOnOff;
	}
	public void setLectureOnOff(int lectureOnOff) {
		this.lectureOnOff = lectureOnOff;
	}
	public int getTimetableNo() {
		return timetableNo;
	}
	public void setTimetableNo(int timetableNo) {
		this.timetableNo = timetableNo;
	}
	public int getCartNo() {
		return cartNo;
	}
	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}
	public Date getLectureRegdate() {
		return lectureRegdate;
	}
	public void setLectureRegdate(Date lectureRegdate) {
		this.lectureRegdate = lectureRegdate;
	}
	public Timestamp getTimetableStart() {

		return timetableStart;
	}
	public void setTimetableStart(Timestamp timetableStart) {
		this.timetableStart = timetableStart;
	}
	public Timestamp getTimeTableEnd() {
		return timeTableEnd;
	}
	public void setTimeTableEnd(Timestamp timeTableEnd) {
		this.timeTableEnd = timeTableEnd;
	}	
	
	public int getLectureSalePrice() {
		return lectureSalePrice;
	}
	public void setLectureSalePrice() {
		lectureSalePrice = (int)(lecturePrice-(lectureSalerate/100.0)*lecturePrice);
	}
	
	public String getLectureCoverimg() {
		return lectureCoverimg;
	}
	public void setLectureCoverimg(String lectureCoverimg) {
		this.lectureCoverimg = lectureCoverimg;
	}
	@Override
	public String toString() {
		return "OrderCartVO [userId=" + userId + ", userName=" + userName + ", teacher=" + teacher + ", lectureWriter="
				+ lectureWriter + ", categoryName=" + categoryName + ", lectureTitle=" + lectureTitle
				+ ", lectureLevel=" + lectureLevel + ", lectureSection=" + lectureSection + ", lectureCoverimg="
				+ lectureCoverimg + ", points=" + points + ", lectureNo=" + lectureNo + ", lectureDue=" + lectureDue
				+ ", lectureSalerate=" + lectureSalerate + ", lectureSaledue=" + lectureSaledue + ", lecturePrice="
				+ lecturePrice + ", lectureOnOff=" + lectureOnOff + ", timetableNo=" + timetableNo + ", cartNo="
				+ cartNo + ", lectureSalePrice=" + lectureSalePrice + ", realSalePrice=" + realSalePrice
				+ ", realPrice=" + realPrice + ", lectureRegdate=" + lectureRegdate + ", timetableStart="
				+ timetableStart + ", timeTableEnd=" + timeTableEnd + "]";
	}
	
	
		
}
