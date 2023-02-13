package com.spring.learn.board;

import java.util.List;

public interface FaqService {
	List<FaqVO> getFaqList(FaqVO vo); //전체 데이터 조회
	void deleteFaq(FaqVO vo);
	void updateFaq(FaqVO vo);
	void insertFaq(FaqVO vo);
	
//	List<FaqVO> latestInfo();
//	FaqVO getFaq(FaqVO vo);
//	List<FaqVO> getFaqListExcept(FaqVO vo);
}
