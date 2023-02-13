package com.spring.learn.board;

public class BoardReportVO {
	private String reportReason,reportDate,reportStatus,boardType,boardNo,reporter,repperson;

	//상태변경을 위해 추가
	private String result;
	
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	//==================================
	
	public String getReportReason() {
		return reportReason;
	}

	public void setReportReason(String reportReason) {
		this.reportReason = reportReason;
	}

	public String getReportDate() {
		return reportDate;
	}

	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}

	public String getReportStatus() {
		return reportStatus;
	}

	public void setReportStatus(String reportStatus) {
		this.reportStatus = reportStatus;
	}

	public String getBoardType() {
		return boardType;
	}

	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}

	public String getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}

	public String getReporter() {
		return reporter;
	}

	public void setReporter(String reporter) {
		this.reporter = reporter;
	}

	public String getRepperson() {
		return repperson;
	}

	public void setRepperson(String repperson) {
		this.repperson = repperson;
	}

	@Override
	public String toString() {
		return "BoardReportVO [reportReason=" + reportReason + ", reportDate=" + reportDate + ", reportStatus="
				+ reportStatus + ", boardType=" + boardType + ", boardNo=" + boardNo + ", reporter=" + reporter
				+ ", repperson=" + repperson + ", result=" + result + "]";
	}

	
	
	
	
}
