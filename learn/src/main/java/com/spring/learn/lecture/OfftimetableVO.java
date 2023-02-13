package com.spring.learn.lecture;

import java.sql.Date;
import java.sql.Timestamp;

public class OfftimetableVO {
	
	
	private String timetableNo;
	private String lectureNo;
	private String lectureAddress;
	private int maxSeat;
	private Timestamp timetableStart;
	private Timestamp timetableEnd;
	private String lectureTitle;
	private int studentCount;

	private String lecturePastAddress;

	private String ttStart;

	private String ttEnd;

	public String getTtStart() {
		return ttStart;
	}

	public void setTtStart(String ttStart) {
		this.ttStart = ttStart;
	}

	public String getTtEnd() {
		return ttEnd;
	}

	public void setTtEnd(String ttEnd) {
		this.ttEnd = ttEnd;
	}

	public String getTimetableNo() {
		return timetableNo;
	}
	public void setTimetableNo(String timetableNo) {
		this.timetableNo = timetableNo;
	}
	public String getLectureNo() {
		return lectureNo;
	}
	public void setLectureNo(String lectureNo) {
		this.lectureNo = lectureNo;
	}
	public String getLectureAddress() {
		return lectureAddress;
	}
	public void setLectureAddress(String lectureAddress) {
		this.lectureAddress = lectureAddress;
	}
	public int getMaxSeat() {
		return maxSeat;
	}
	public void setMaxSeat(int maxSeat) {
		this.maxSeat = maxSeat;
	}

	public Timestamp getTimetableStart() {
		return timetableStart;
	}
	public void setTimetableStart(Timestamp timetableStart) {
		this.timetableStart = timetableStart;
	}
	public Timestamp getTimetableEnd() {
		return timetableEnd;
	}
	public void setTimetableEnd(Timestamp timetableEnd) {
		this.timetableEnd = timetableEnd;
	}

	public String getLectureTitle() {
		return lectureTitle;
	}

	public void setLectureTitle(String lectureTitle) {
		this.lectureTitle = lectureTitle;
	}

	public int getStudentCount() {
		return studentCount;
	}

	public void setStudentCount(int studentCount) {
		this.studentCount = studentCount;
	}

	public String getLecturePastAddress() {
		return lecturePastAddress;
	}

	public void setLecturePastAddress(String lecturePastAddress) {
		this.lecturePastAddress = lecturePastAddress;
	}

	@Override
	public String toString() {
		return "OfftimetableVO [timetableNo=" + timetableNo + ", lectureNo=" + lectureNo + ", lectureAddress="
				+ lectureAddress + ", maxSeat=" + maxSeat + ", timetableStart=" + timetableStart + ", timetableEnd="
				+ timetableEnd + ", lecturePastAddress=" + lecturePastAddress + "]";
	}


	
	
}
