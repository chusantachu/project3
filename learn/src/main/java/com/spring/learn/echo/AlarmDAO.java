package com.spring.learn.echo;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.learn.resume.ResumeVO;

@Repository
public class AlarmDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	public AlarmDAO() {
		System.out.println("=========== alarmDAO() 객체 생성");

	}

	public int selectAlarmUchkCount(String memId) {
		System.out.println("실행되니");
		return 0;
	}

	public void insertAlram(AlramVO vo) {
		mybatis.insert("alramDAO.insertAlram", vo);
		
	}

	public List<AlramVO> getAlramList(AlramVO vo) {
		return mybatis.selectList("alramDAO.getAlramList", vo);
	}

	public int alramCount(AlramVO vo) {
		return mybatis.selectOne("alramDAO.alramCount", vo);
	}

	public int alramDelete(AlramVO vo) {
		return mybatis.delete("alramDAO.alramDelete", vo);
	}
	
	
}
