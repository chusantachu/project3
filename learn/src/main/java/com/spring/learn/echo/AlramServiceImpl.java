package com.spring.learn.echo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.learn.memberboard.MemberBoardVO;
import com.spring.learn.order.OrderCartVO;
import com.spring.learn.order.OrderCheckVO;
import com.spring.learn.order.OrderFinishVO;
import com.spring.learn.order.OrderService;
import com.spring.learn.order.OrderVO;

// orderService
@Service("alramService")
public class AlramServiceImpl implements AlramService {
	
	@Autowired
	private AlarmDAO alramDAO;

	public AlramServiceImpl() {
		System.out.println(">> AlramServiceImpl 실행");
	}

	@Override
	public void insertAlram(AlramVO vo) {
		alramDAO.insertAlram(vo);
		
	}

	@Override
	public List<AlramVO> getAlramList(AlramVO vo) {
		return alramDAO.getAlramList(vo);
	}

	@Override
	public int alramCount(AlramVO vo) {
		return alramDAO.alramCount(vo);
	}

	@Override
	public int alramDelete(AlramVO vo) {
		return alramDAO.alramDelete(vo);
	}

	



	


  
}
