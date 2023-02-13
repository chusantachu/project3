package com.spring.learn.roadmap;

import java.sql.Date;

public class MyroadmapVO {
  private String rboardNo, userId;
  private Date roadmapStart;
  private int roadmapRate;

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

  public Date getRoadmapStart() {
    return roadmapStart;
  }

  public void setRoadmapStart(Date roadmapStart) {
    this.roadmapStart = roadmapStart;
  }

  public int getRoadmapRate() {
    return roadmapRate;
  }

  public void setRoadmapRate(int roadmapRate) {
    this.roadmapRate = roadmapRate;
  }

  @Override
  public String toString() {
    return "MyroadmapVO{" +
        "rboardNo='" + rboardNo + '\'' +
        ", userId='" + userId + '\'' +
        ", roadmapStart=" + roadmapStart +
        ", roadmapRate=" + roadmapRate +
        '}';
  }

}
