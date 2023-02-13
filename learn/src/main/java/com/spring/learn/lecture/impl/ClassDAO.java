package com.spring.learn.lecture.impl;

import com.spring.learn.lecture.ClassVO;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public interface ClassDAO {

  void addClass(ClassVO classVO);

  List<ClassVO> getClassList(String lectureNo);
  // 메소드명이 Mapper 파일의 id명으로 사용
	  
	
	  
	
}





