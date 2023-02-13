package com.spring.learn.order.impl;

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
@Service("orderService")
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderDAO orderDAO;

	public OrderServiceImpl() {
		System.out.println(">> OrderServiceImple ����");
	}

	@Override
	public List<OrderCartVO> getCartList(OrderCartVO vo) {
		return orderDAO.getCartList(vo);
	}

	@Override
	public int deleteCart(OrderCartVO vo) {
		return orderDAO.deleteCart(vo);
	}

	@Override
	public int getPoint(OrderCartVO vo) {
		return orderDAO.getPoint(vo);
	}

	@Override
	public List<OrderCartVO> getPrice(OrderCartVO vo) {
		return orderDAO.getPrice(vo);
	}

	@Override
	public OrderCartVO getRealPrice(OrderCartVO vo) {
		return orderDAO.getRealPrice(vo);
	}

	@Override
	public OrderCartVO getLecture(OrderCartVO vo) {
		
		return orderDAO.getLecture(vo);
		
	}

	@Override
	public void updateLecture(OrderCartVO vo) {
		orderDAO.updateLecture(vo);
		
	}

	@Override
	public void updateUserPoint(OrderCartVO vo) {
		orderDAO.updateUserPoint(vo);
		
	}

	@Override
	public void insertOrder(OrderFinishVO odvo) {
		orderDAO.insertOrder(odvo);
		
	}

	@Override
	public int getOrderNo() {
		int a = orderDAO.getOrderNo();
		return a;
	}

	@Override
	public void insertPointLog(OrderFinishVO odvo) {
		orderDAO.insertPointLog(odvo);
		
	}

	@Override
	public void insertOrderDetail(OrderFinishVO odvo) {
		orderDAO.insertOrderDetail(odvo);
		
	}

	@Override
	public void updateLectureStudentCnt(OrderCartVO vo) {
		orderDAO.updateLectureStudentCnt(vo);
		
	}

	@Override
	public List<OrderCheckVO> getOrderList(OrderCheckVO vo) {
		return orderDAO.getOrderList(vo);
	}



	


  
}
