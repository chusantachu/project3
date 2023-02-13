package com.spring.learn.board.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.board.FaqService;
import com.spring.learn.board.FaqVO;

//@Service : @Component 상속확장 어노테이션
//비즈니스 로직 처리 서비스 영역에 사용
@Service("faqService")
public class FaqServiceImpl implements FaqService {
	@Autowired //타입이 일치하는 객체(인스턴스)주입 (DI)
	private FaqDAO faqDao;
	
	public FaqServiceImpl() {
		System.out.println(">> FaqServiceImpl() 객체 생성");
	}

	@Override
	public List<FaqVO> getFaqList(FaqVO vo) {
		return faqDao.getFaqList(vo);
	}

	@Override
	public void deleteFaq(FaqVO vo) {
		faqDao.deleteFaq(vo);
	}

	@Override
	public void updateFaq(FaqVO vo) {
		faqDao.updateFaq(vo);
		
	}

	@Override
	public void insertFaq(FaqVO vo) {
		faqDao.insertFaq(vo);
	}

//	@Override
//	public List<FaqVO> latestInfo() {
//		return faqDao.latestInfo();
//	}

//	@Override
//	public FaqVO getFaq(FaqVO vo) {
//		return faqDao.getFaq(vo);
//	}

//	@Override
//	public List<FaqVO> getFaqListExcept(FaqVO vo) { 
//		return faqDao.getFaqListExcept(vo);
//	}


	
  

}
