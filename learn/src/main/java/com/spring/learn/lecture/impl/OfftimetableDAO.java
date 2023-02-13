package com.spring.learn.lecture.impl;

import com.spring.learn.lecture.OfftimetableVO;
import com.spring.learn.user.UserVO;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;

@Repository
public interface OfftimetableDAO {

  // 메소드명이 Mapper 파일의 id명으로 사용

  List<OfftimetableVO> getOfftimetableList(Map<String, String> map);

  int getOfftimetableCount(String lectureNo);

  List<UserVO> getStudentList(Map<String, String> map);

  int getStudentCount(String timetableNo);

  void insertTimetable(OfftimetableVO tt);
}





