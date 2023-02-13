package com.spring.learn.order;

import java.sql.Date;

//import java.sql.Date;

public class OrderCheckVO {
	private String userId, lectureTitle, orderPayment;
	private int lectureNo, lectureSalerate, lecturePrice, orderDetailNo;
	private int	lectureSalePrice = (int)(lecturePrice-(lectureSalerate/100.0)*lecturePrice);
	private int realSalePrice = (int)((lectureSalerate/100.0)*lecturePrice);
	private Date orderRegdate;
	
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
	
	public String getLectureTitle() {
		return lectureTitle;
	}
	public void setLectureTitle(String lectureTitle) {
		this.lectureTitle = lectureTitle;
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
	public int getLectureSalePrice() {
		return lectureSalePrice;
	}
	public void setLectureSalePrice() {
		lectureSalePrice = (int)(lecturePrice-(lectureSalerate/100.0)*lecturePrice);
	}
	public String getOrderPayment() {
		return orderPayment;
	}
	public void setOrderPayment(String orderPayment) {
		this.orderPayment = orderPayment;
	}
	public int getOrderDetailNo() {
		return orderDetailNo;
	}
	public void setOrderDetailNo(int orderDetailNo) {
		this.orderDetailNo = orderDetailNo;
	}
	public Date getOrderRegdate() {
		return orderRegdate;
	}
	public void setOrderRegdate(Date orderRegdate) {
		this.orderRegdate = orderRegdate;
	}
	@Override
	public String toString() {
		return "OrderCheckVO [userId=" + userId + ", lectureTitle=" + lectureTitle + ", orderPayment=" + orderPayment
				+ ", lectureNo=" + lectureNo + ", lectureSalerate=" + lectureSalerate + ", lecturePrice=" + lecturePrice
				+ ", orderDetailNo=" + orderDetailNo + ", lectureSalePrice=" + lectureSalePrice + ", realSalePrice="
				+ realSalePrice + ", orderRegdate=" + orderRegdate + "]";
	}
	
		
}
