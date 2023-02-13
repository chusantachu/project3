package com.spring.learn.admin;

public class JoinerVO {

	String month;
	int general;
	int naver;
	int google;
	int total;
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getGeneral() {
		return general;
	}
	public void setGeneral(int general) {
		this.general = general;
	}
	public int getNaver() {
		return naver;
	}
	public void setNaver(int naver) {
		this.naver = naver;
	}
	public int getGoogle() {
		return google;
	}
	public void setGoogle(int google) {
		this.google = google;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	@Override
	public String toString() {
		return "JoinerVO [month=" + month + ", general=" + general + ", naver=" + naver + ", google=" + google
				+ ", total=" + total + "]";
	}
	
	
	
	
	
}
