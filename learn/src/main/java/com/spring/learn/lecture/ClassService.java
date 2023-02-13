package com.spring.learn.lecture;

import java.util.List;

public interface ClassService {

  void addClass(ClassVO classVO);

  List<ClassVO> getClassList(String lectureNo);
}
