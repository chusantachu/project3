package com.spring.learn.echo;

public class AlramVO {
	private String toId, fromId, title, categori;
	private int aNo, bNo;
	public String getToId() {
		return toId;
	}
	public void setToId(String toId) {
		this.toId = toId;
	}
	public String getFromId() {
		return fromId;
	}
	public void setFromId(String fromId) {
		this.fromId = fromId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCategori() {
		return categori;
	}
	public void setCategori(String categori) {
		this.categori = categori;
	}
	public int getaNo() {
		return aNo;
	}
	public void setaNo(int aNo) {
		this.aNo = aNo;
	}
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	@Override
	public String toString() {
		return "AlramVO [toId=" + toId + ", fromId=" + fromId + ", title=" + title + ", categori=" + categori + ", aNo="
				+ aNo + ", bNo=" + bNo + "]";
	}

	

	
		
}
