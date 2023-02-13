package com.spring.learn.order;

import java.sql.Date;

public class OrderFinishVO {
	private String userId, grade, userName, orderPayment, orderStatus, logNum;
	
	private int point, lectureNo, studentCount, orderNo, orderPrice, orderDetailNo, timetableNo, lectureRate, usepointLog, earnPoint;
	
	private Date orderRegdate, pointDate;

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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getOrderPayment() {
		return orderPayment;
	}

	public void setOrderPayment(String orderPayment) {
		this.orderPayment = orderPayment;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getLogNum() {
		return logNum;
	}

	public void setLogNum(String logNum) {
		this.logNum = logNum;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getLectureNo() {
		return lectureNo;
	}

	public void setLectureNo(int lectureNo) {
		this.lectureNo = lectureNo;
	}

	public int getStudentCount() {
		return studentCount;
	}

	public void setStudentCount(int studentCount) {
		this.studentCount = studentCount;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public int getOrderPrice() {
		return orderPrice;
	}

	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}

	public int getOrderDetailNo() {
		return orderDetailNo;
	}

	public void setOrderDetailNo(int orderDetailNo) {
		this.orderDetailNo = orderDetailNo;
	}

	public int getTimetableNo() {
		return timetableNo;
	}

	public void setTimetableNo(int timetableNo) {
		this.timetableNo = timetableNo;
	}

	public int getLectureRate() {
		return lectureRate;
	}

	public void setLectureRate(int lectureRate) {
		this.lectureRate = lectureRate;
	}

	public int getUsepointLog() {
		return usepointLog;
	}

	public void setUsepointLog(int usepointLog) {
		this.usepointLog = usepointLog;
	}

	public Date getOrderRegdate() {
		return orderRegdate;
	}

	public void setOrderRegdate(Date orderRegdate) {
		this.orderRegdate = orderRegdate;
	}

	public Date getPointDate() {
		return pointDate;
	}

	public void setPointDate(Date pointDate) {
		this.pointDate = pointDate;
	}

	public int getEarnPoint() {
		return earnPoint;
	}

	public void setEarnPoint(int earnPoint) {
		this.earnPoint = earnPoint;
	}

	@Override
	public String toString() {
		return "OrderFinishVO [userId=" + userId + ", grade=" + grade + ", userName=" + userName + ", orderPayment="
				+ orderPayment + ", orderStatus=" + orderStatus + ", logNum=" + logNum + ", point=" + point
				+ ", lectureNo=" + lectureNo + ", studentCount=" + studentCount + ", orderNo=" + orderNo
				+ ", orderPrice=" + orderPrice + ", orderDetailNo=" + orderDetailNo + ", timetableNo=" + timetableNo
				+ ", lectureRate=" + lectureRate + ", usepointLog=" + usepointLog + ", earnPoint=" + earnPoint
				+ ", orderRegdate=" + orderRegdate + ", pointDate=" + pointDate + "]";
	}
	
	

	
		
}
