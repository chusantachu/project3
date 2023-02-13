package com.spring.learn.roadmap;

import java.util.StringTokenizer;
import org.springframework.web.multipart.MultipartFile;

public class RoadmapVO {
  // lectureList: 강의번호 '/'로 구분해서 나열
  private String rboardNo, userId, rboardTitle, rboardContent, lectureList, categoryName, rboardCoverimg, userName;
  int userCount, lectureCount;
  
  private MultipartFile uploadFile;

  public String getRboardNo() {
    return rboardNo;
  }

  public void setRboardNo(String rboardNo) {
    this.rboardNo = rboardNo;
  }

  public String getUserId() {
    return userId;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  public String getRboardTitle() {
    return rboardTitle;
  }

  public void setRboardTitle(String rboardTitle) {
    this.rboardTitle = rboardTitle;
  }

  public String getRboardContent() {
    return rboardContent;
  }

  public void setRboardContent(String rboardContent) {
    this.rboardContent = rboardContent;
  }

  public String getLectureList() {
    return lectureList;
  }

  public void setLectureList(String lectureList) {
    this.lectureList = lectureList;
  }
  


  


	

	public String getCategoryName() {
	return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getRboardCoverimg() {
		return rboardCoverimg;
	}
	
	public void setRboardCoverimg(String rboardCoverimg) {
		this.rboardCoverimg = rboardCoverimg;
	}
	

	
	
	public int getUserCount() {
		return userCount;
	}

	public void setUserCount(int userCount) {
		this.userCount = userCount;
	}
	
	
	public int getLectureCount() {
		return lectureCount;
	}

	public void setLectureCount() {
		String lectures = lectureList;
		StringTokenizer str = new StringTokenizer(lectures, "/");
		lectureCount = str.countTokens();
	}

	
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public MultipartFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}

	public void setLectureCount(int lectureCount) {
		this.lectureCount = lectureCount;
	}

	@Override
	public String toString() {
		return "RoadmapVO [rboardNo=" + rboardNo + ", userId=" + userId + ", rboardTitle=" + rboardTitle
				+ ", rboardContent=" + rboardContent + ", lectureList=" + lectureList + ", categoryName=" + categoryName
				+ ", rboardCoverimg=" + rboardCoverimg + ", userName=" + userName + ", userCount=" + userCount
				+ ", lectureCount=" + lectureCount + ", uploadFile=" + uploadFile + "]";
	}


	
	

	
  
	

}
