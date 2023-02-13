package com.spring.learn.lecture;

import com.spring.learn.user.UserVO;
import java.util.List;
import java.util.Map;

public interface OfftimetableService {

  List<OfftimetableVO> getOfftimetableList(Map<String, String> map);

  int getOfftimetableCount(String lectureNo);

  List<UserVO> getStudentList(Map<String, String> map);

  int getStudentCount(String timetableNo);

  void insertTimetable(OfftimetableVO tt);
}
