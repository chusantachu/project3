package com.spring.learn.lecture;

public class CategoryVO {
	
	String categoryName;
	String categoryNo;
	
	
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(String categoryNo) {
		this.categoryNo = categoryNo;
	}

	@Override
	public String toString() {
		return "CategoryVO [categoryName=" + categoryName + ", categoryNo=" + categoryNo + "]";
	}
	
	
	
	
}
