package com.spring.learn.order;

import java.util.List;

import com.spring.learn.memberboard.MemberBoardVO;

public interface OrderService {
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
	
	/*
	 * void insertBoard(OrderVO vo); void updateBoard(OrderVO vo); void
	 * deleteBoard(OrderVO vo); OrderVO getBoard(OrderVO vo); // 1���� ������ ��ȸ
	 * List<OrderVO> getBoardList(OrderVO vo); // ��ü�� ��ȸ List<OrderVO>
	 * resolvedCBoardList(OrderVO vo); List<OrderVO> unResolvedCBoardList(OrderVO
	 * vo);
	 */
	
}
