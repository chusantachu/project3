package com.spring.learn.order.impl;

import java.util.List;

import com.spring.learn.memberboard.MemberBoardVO;
import com.spring.learn.order.OrderCartVO;
import com.spring.learn.order.OrderCheckVO;
import com.spring.learn.order.OrderFinishVO;
import com.spring.learn.order.OrderVO;

public interface OrderDAO {
	
	List<OrderCartVO> getCartList(OrderCartVO vo);

	int deleteCart(OrderCartVO vo);

	int getPoint(OrderCartVO vo);

	List<OrderCartVO> getPrice(OrderCartVO vo);

	OrderCartVO getRealPrice(OrderCartVO vo);

	OrderCartVO getLecture(OrderCartVO vo);

	void updateLecture(OrderCartVO vo);

	void updateUserPoint(OrderCartVO vo);

	void insertOrder(OrderFinishVO odvo);

	int getOrderNo();

	void insertPointLog(OrderFinishVO odvo);

	void insertOrderDetail(OrderFinishVO odvo);

	void updateLectureStudentCnt(OrderCartVO vo);

	List<OrderCheckVO> getOrderList(OrderCheckVO vo);
	
	// �޼ҵ���� Mapper ������ id������ ���
	/*
	 * void insertBoard(OrderVO vo); void updateBoard(OrderVO vo); void
	 * deleteBoard(OrderVO vo); OrderVO getBoard(OrderVO vo); List<OrderVO>
	 * getBoardList(OrderVO vo); List<OrderVO> resolvedCBoardList(OrderVO vo);
	 * List<OrderVO> unResolvedCBoardList(OrderVO vo);
	 */
	
}





