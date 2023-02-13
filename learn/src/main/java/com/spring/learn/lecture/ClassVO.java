package com.spring.learn.lecture;

import org.springframework.web.multipart.MultipartFile;

public class ClassVO {
	
	private String classNo;
	private String lectureNo;
	private String categoryName;
	private String sectionNo;
	private String className;
	private String classUrl;
	private String preview;
	private String filename;
	private String oriname;
	private String videoname;
	private MultipartFile uploadBook;
	private MultipartFile uploadVideo;

	public String getClassNo() {
		return classNo;
	}
	public void setClassNo(String classNo) {
		this.classNo = classNo;
	}
	public String getLectureNo() {
		return lectureNo;
	}
	public void setLectureNo(String lectureNo) {
		this.lectureNo = lectureNo;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getSectionNo() {
		return sectionNo;
	}
	public void setSectionNo(String sectionNo) {
		this.sectionNo = sectionNo;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getClassUrl() {
		return classUrl;
	}
	public void setClassUrl(String classUrl) {
		this.classUrl = classUrl;
	}
	public String getPreview() {
		return preview;
	}
	public void setPreview(String preview) {
		this.preview = preview;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getOriname() {
		return oriname;
	}
	public void setOriname(String oriname) {
		this.oriname = oriname;
	}

	public String getVideoname() {
		return videoname;
	}

	public void setVideoname(String videoname) {
		this.videoname = videoname;
	}

	public MultipartFile getUploadBook() {
		return uploadBook;
	}

	public void setUploadBook(MultipartFile uploadBook) {
		this.uploadBook = uploadBook;
	}

	public MultipartFile getUploadVideo() {
		return uploadVideo;
	}

	public void setUploadVideo(MultipartFile uploadVideo) {
		this.uploadVideo = uploadVideo;
	}

	@Override
	public String toString() {
		return "ClassVO [classNo=" + classNo + ", lectureNo=" + lectureNo + ", categoryName=" + categoryName
				+ ", sectionNo=" + sectionNo + ", className=" + className + ", classUrl=" + classUrl + ", preview="
				+ preview + ", filename=" + filename + ", oriname=" + oriname + "]";
	}

	
	
	
}
