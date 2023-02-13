package com.spring.learn.board.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.learn.board.FaqVO;

@Repository
public class FaqDAO {
  @Autowired
  private SqlSessionTemplate mybatis;

  public FaqDAO() {
	  System.out.println("=========== FaqDAOMybatis() 객체 생성");
  }
  
  //글 리스트 조회
  public List<FaqVO> getFaqList(FaqVO vo) {
	  System.out.println("===> Mybatis 사용 getFaqList() 실행");
	  return mybatis.selectList("faqDAO.getFaqList");
  }
  
  public void deleteFaq(FaqVO vo) {
	  mybatis.delete("faqDAO.deleteFaq", vo);
  }
  
  public void updateFaq(FaqVO vo) {
	  mybatis.update("faqDAO.updateFaq", vo);
  }
  
  public void insertFaq(FaqVO vo) {
	  mybatis.insert("faqDAO.insertFaq", vo);
  }
  
  
//  public List<FaqVO> latestInfo() {
//	  return mybatis.selectList("faqDAO.latestInfo");
//  }
  
//  public FaqVO getFaq(FaqVO vo) {
//	  System.out.println("===> Mybatis 사용 getFaq() 실행");
//	  return mybatis.selectOne("faqDAO.getFaq", vo);
//  }
  
//  public List<FaqVO> getFaqListExcept(FaqVO vo) {
//	  System.out.println("===> Mybatis 사용 getFaqListExcept() 실행");
//	  return mybatis.selectList("getFaqListExcept", vo);
//  }

}





