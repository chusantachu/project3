package com.spring.learn.user;

import java.sql.Timestamp;

public class PointLogVO {
  private String logNum, userId;
  private int orderNo, usepointLog, earnPoint;
  private Timestamp pointDate;

  public String getLogNum() {
    return logNum;
  }

  public void setLogNum(String logNum) {
    this.logNum = logNum;
  }

  public String getUserId() {
    return userId;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  public int getOrderNo() {
    return orderNo;
  }

  public void setOrderNo(int orderNo) {
    this.orderNo = orderNo;
  }

  public int getUsepointLog() {
    return usepointLog;
  }

  public void setUsepointLog(int usepointLog) {
    this.usepointLog = usepointLog;
  }

  public int getEarnPoint() {
    return earnPoint;
  }

  public void setEarnPoint(int earnPoint) {
    this.earnPoint = earnPoint;
  }

  public Timestamp getPointDate() {
    return pointDate;
  }

  public void setPointDate(Timestamp pointDate) {
    this.pointDate = pointDate;
  }

  @Override
  public String toString() {
    return "PointLogVO{" +
        "logNum='" + logNum + '\'' +
        ", userId='" + userId + '\'' +
        ", orderNo=" + orderNo +
        ", usepointLog=" + usepointLog +
        ", earnPoint=" + earnPoint +
        ", pointDate=" + pointDate +
        '}';
  }

}
