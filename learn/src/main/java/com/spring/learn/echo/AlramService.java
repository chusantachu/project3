package com.spring.learn.echo;

import java.util.List;

import com.spring.learn.memberboard.MemberBoardVO;

public interface AlramService {

	void insertAlram(AlramVO vo);

	List<AlramVO> getAlramList(AlramVO vo);

	int alramCount(AlramVO vo);

	int alramDelete(AlramVO vo);
	
	
}
