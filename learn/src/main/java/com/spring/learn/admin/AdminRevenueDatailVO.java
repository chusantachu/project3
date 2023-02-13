package com.spring.learn.admin;

public class AdminRevenueDatailVO {
	
	String orderNo, buyer, lectureTitle, teacher, lectureOnOff, orderRegdate;
	
	int lecturePrice, commission;

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getBuyer() {
		return buyer;
	}

	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}

	public String getLectureTitle() {
		return lectureTitle;
	}

	public void setLectureTitle(String lectureTitle) {
		this.lectureTitle = lectureTitle;
	}

	public String getTeacher() {
		return teacher;
	}

	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}

	public String getLectureOnOff() {
		return lectureOnOff;
	}

	public void setLectureOnOff(String lectureOnOff) {
		this.lectureOnOff = lectureOnOff;
	}

	public String getOrderRegdate() {
		return orderRegdate;
	}

	public void setOrderRegdate(String orderRegdate) {
		this.orderRegdate = orderRegdate;
	}

	public int getLecturePrice() {
		return lecturePrice;
	}

	public void setLecturePrice(int lecturePrice) {
		this.lecturePrice = lecturePrice;
	}

	public int getCommission() {
		return commission;
	}

	public void setCommission() {
		commission = (int) (lecturePrice * 0.15);
	}

	@Override
	public String toString() {
		return "AdminRevenueDatailVO [orderNo=" + orderNo + ", buyer=" + buyer + ", lectureTitle=" + lectureTitle
				+ ", teacher=" + teacher + ", lectureOnOff=" + lectureOnOff + ", orderRegdate=" + orderRegdate
				+ ", lecturePrice=" + lecturePrice + ", commission=" + commission + "]";
	}

	
}
