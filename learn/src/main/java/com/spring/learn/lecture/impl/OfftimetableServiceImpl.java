package com.spring.learn.lecture.impl;

import com.spring.learn.lecture.OfftimetableService;
import com.spring.learn.lecture.OfftimetableVO;
import com.spring.learn.user.UserVO;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("offtimetableService")
public class OfftimetableServiceImpl implements OfftimetableService {

	@Autowired //타입이 일치하는 객체(인스턴스)주입 (DI)
	private OfftimetableDAO OfftimetableDAO;

	public OfftimetableServiceImpl() {
		System.out.println(">> OfftimetableServiceImpl() 객체 생성");
	}


	@Override
	public List<OfftimetableVO> getOfftimetableList(Map<String, String> map) {
		return OfftimetableDAO.getOfftimetableList(map);
	}

	@Override
	public int getOfftimetableCount(String lectureNo) {
		return OfftimetableDAO.getOfftimetableCount(lectureNo);
	}

	@Override
	public List<UserVO> getStudentList(Map<String, String> map) {
		return OfftimetableDAO.getStudentList(map);
	}

	@Override
	public int getStudentCount(String timetableNo) {
		return OfftimetableDAO.getStudentCount(timetableNo);
	}

	@Override
	public void insertTimetable(OfftimetableVO tt) {
		OfftimetableDAO.insertTimetable(tt);
	}
}
