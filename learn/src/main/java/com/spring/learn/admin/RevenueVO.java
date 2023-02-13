package com.spring.learn.admin;

public class RevenueVO {

	String filter;
	int onRevenue;
	int offRevenue;
	int totRevenue;
	public String getFilter() {
		return filter;
	}
	public void setFilter(String filter) {
		this.filter = filter;
	}
	public int getOnRevenue() {
		return onRevenue;
	}
	public void setOnRevenue(int onRevenue) {
		this.onRevenue = onRevenue;
	}
	public int getOffRevenue() {
		return offRevenue;
	}
	public void setOffRevenue(int offRevenue) {
		this.offRevenue = offRevenue;
	}
	public int getTotRevenue() {
		return totRevenue;
	}
	public void setTotRevenue(int totRevenue) {
		this.totRevenue = totRevenue;
	}
	@Override
	public String toString() {
		return "RevenueVO [filter=" + filter + ", onRevenue=" + onRevenue + ", offRevenue=" + offRevenue
				+ ", totRevenue=" + totRevenue + "]";
	}
	
	

	
	
}
