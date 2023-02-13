package com.spring.learn.board;

public class ReportResultVO {
	private int resultNo;
	private String resultId;
	private String resultTitle;
	private String resultContent;
	private String resultRegdate;
	
	public int getResultNo() {
		return resultNo;
	}
	public void setResultNo(int resultNo) {
		this.resultNo = resultNo;
	}
	public String getResultId() {
		return resultId;
	}
	public void setResultId(String resultId) {
		this.resultId = resultId;
	}
	public String getResultTitle() {
		return resultTitle;
	}
	public void setResultTitle(String resultTitle) {
		this.resultTitle = resultTitle;
	}
	public String getResultContent() {
		return resultContent;
	}
	public void setResultContent(String resultContent) {
		this.resultContent = resultContent;
	}
	public String getResultRegdate() {
		return resultRegdate;
	}
	public void setResultRegdate(String resultRegdate) {
		this.resultRegdate = resultRegdate;
	}
	
	@Override
	public String toString() {
		return "ReportResultVO [resultNo=" + resultNo + ", resultId=" + resultId + ", resultTitle=" + resultTitle
				+ ", resultContent=" + resultContent + ", resultRegdate=" + resultRegdate + "]";
	}
	
}
