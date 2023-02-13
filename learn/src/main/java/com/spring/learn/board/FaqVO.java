package com.spring.learn.board;

public class FaqVO {
	private String faqQuestion, faqAnswer;
	private int faqNo;
	
	public FaqVO() {
		System.out.println(">> FaqVO() 객체 생성");
	}

	public String getFaqQuestion() {
		return faqQuestion;
	}

	public void setFaqQuestion(String faqQuestion) {
		this.faqQuestion = faqQuestion;
	}

	public String getFaqAnswer() {
		return faqAnswer;
	}

	public void setFaqAnswer(String faqAnswer) {
		this.faqAnswer = faqAnswer;
	}

	public int getFaqNo() {
		return faqNo;
	}

	public void setFaqNo(int faqNo) {
		this.faqNo = faqNo;
	}

	@Override
	public String toString() {
		return "FaqVO [faqQuestion=" + faqQuestion + ", faqAnswer=" + faqAnswer + ", faqNo=" + faqNo + "]";
	}
	

  
}
