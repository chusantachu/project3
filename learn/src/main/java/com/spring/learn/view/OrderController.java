package com.spring.learn.view;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.learn.order.OrderCartVO;
import com.spring.learn.order.OrderCheckVO;
import com.spring.learn.order.OrderFinishVO;
import com.spring.learn.order.OrderService;
import com.spring.learn.order.OrderVO;
import com.spring.learn.user.UserService;
import com.spring.learn.user.UserVO;

// @RequestMapping 클래스 선언부 사용시
// 모든 메소드 요청경로의 부모(root) 경로로 추가됨
@Controller
@RequestMapping({"/Order", "/order", "/Member","/Common"})
public class OrderController {
	
	@Autowired
	private UserService userService;

	@Autowired
	private OrderService orderService;
	
	public OrderController() {
		System.out.println(">> OrderController() 생성");
	}
	
	@RequestMapping("/myCartGo.do")
	public String myCartGo(OrderCartVO vo, Model model, HttpSession req) {
		System.out.println(">>>myCartGo() 실행");
		System.out.println("vo : " + vo);
		
		 // 장바구니 리스트 담음
		List<OrderCartVO> cartList = orderService.getCartList(vo);
		int sum = 0;
		for(OrderCartVO cvo : cartList) {
			cvo.setLectureSalePrice();
			cvo.setRealSalePrice();
			sum += cvo.getLecturePrice();
		}
		for(OrderCartVO cvo : cartList) {
			cvo.setRealPrice(sum);
		}
		
		model.addAttribute("cartList", cartList);
		
		
		System.out.println(cartList);
		
		return "/Order/myCart.jsp";
	}
	
	@RequestMapping("/orderDetailGo.do")
	public String orderDetailGo(OrderCheckVO vo, Model model) {
		System.out.println(">>>OrderCheckVO() 실행");
		System.out.println("vo : " + vo);
		
		 // 장바구니 리스트 담음
		List<OrderCheckVO> orderList = orderService.getOrderList(vo);
		System.out.println("orderList>>>>: " + orderList);
		for(OrderCheckVO cvo : orderList) {
			cvo.setLectureSalePrice();
			cvo.setRealSalePrice();
		}
		
		model.addAttribute("orderList", orderList);
		
		
		System.out.println(orderList);
		
		return "/Order/orderDetail.jsp";
	}
	
	@RequestMapping("/cartDeleteGo.do")
	public String cartDeleteGo(OrderCartVO vo, Model model, HttpSession req, @RequestParam(value="checkBoxArr[]") List<Integer> checkBoxArr) {
		System.out.println(">>>cartDelete_go() 실행");
		System.out.println("vo : " + vo);
		System.out.println("list : " + checkBoxArr);
		for(int checkbox : checkBoxArr) {
			vo.setCartNo(checkbox);
			orderService.deleteCart(vo);
		}
		
		List<OrderCartVO> cartList2 = orderService.getCartList(vo);
		int sum = 0;
		for(OrderCartVO cvo : cartList2) {
			cvo.setLectureSalePrice();
			cvo.setRealSalePrice();
			sum += cvo.getLecturePrice();
		}
		for(OrderCartVO cvo : cartList2) {
			cvo.setRealPrice(sum);
		}
		
		model.addAttribute("cartList2", cartList2);
		
		
		System.out.println(cartList2);
		
		
		return "/Order/myCartAjaxList.jsp";
	}
	
	@RequestMapping("/pointCheck.do")
	@ResponseBody
	public int pointCheck(OrderCartVO vo) {
		System.out.println(">>>pointCheck() 실행");
		System.out.println("vo : " + vo);

		return orderService.getPoint(vo);
	}
	
	@RequestMapping("priceCheck.do")
	@ResponseBody
	public List<OrderCartVO> priceCheck(OrderCartVO vo, List<OrderCartVO> list) {
		System.out.println(">>>priceCheck() 실행");
		System.out.println("vo : " + vo);
		list = orderService.getPrice(vo);
		System.out.println(">>>>>>>>>>list"+list);
		return list;
	}
	
	@RequestMapping("getRealPrice.do")
	@ResponseBody
	public OrderCartVO getRealPrice(OrderCartVO vo) {
		System.out.println(">>>getRealPrice() 실행");
		System.out.println("vo : " + vo);

		OrderCartVO vo2 = orderService.getRealPrice(vo);
		System.out.println("vo2:::" + vo2);
		if(vo2.getLectureSalerate() > 0) {
			vo2.setRealSalePrice();
		}
		System.out.println("진짜 vo2:::" + vo2);
		return vo2;
	}
	
	@RequestMapping("orderFinish.do")
	@ResponseBody
	public int orderFinish(OrderCartVO vo, OrderFinishVO odvo, Model model, HttpSession req, @RequestParam(value="checkBoxArr[]") List<Integer> checkBoxArr) {
		System.out.println(">>>orderFinish() 실행");
		System.out.println("vo : " + vo);
		System.out.println("odvo : " + odvo);
		System.out.println("checkBoxArr : " + checkBoxArr);
		int usePoints = vo.getPoints();
		int sum = 0;
		int earnPoint = 0;
		System.out.println("첫번째 통과요~");
		for(int checkbox : checkBoxArr) {
			System.out.println("2번째 통과요~");
			vo.setCartNo(checkbox);
			if(orderService.getLecture(vo).getLectureSalerate() > 0) {
				vo = orderService.getLecture(vo);
				vo.setLectureSalePrice();
				sum += vo.getLectureSalePrice();
				System.out.println(sum+"0000000000");
			}else {
				sum += orderService.getLecture(vo).getLecturePrice();
				System.out.println(sum+"0000000000");
			}
			System.out.println("3번째 통과요~");
		}
		earnPoint = sum/10;
		if(usePoints > 0) {
			sum -= odvo.getPoint();
		}
		System.out.println("4번째 통과요~");
		System.out.println(sum+"0000000000");
		odvo.setOrderPrice(sum);
		orderService.insertOrder(odvo);
		System.out.println("5번째 통과요~");
		usePoints -= earnPoint;
		System.out.println("6번째 통과요~");
		odvo.setOrderNo(orderService.getOrderNo());
		System.out.println(vo.getPoints());
		vo.setPoints(usePoints);
		orderService.updateUserPoint(vo);
		System.out.println("7번째 통과요~");
		odvo.setEarnPoint(earnPoint);
		orderService.insertPointLog(odvo);
		System.out.println("7-2번째 통과요~");
		for(int checkbox : checkBoxArr) {
			System.out.println("8번째 통과요~");
			vo.setCartNo(checkbox);
			vo = orderService.getLecture(vo);
			int a = orderService.getOrderNo();
			System.out.println("a>>>>>>>>>>a>>>>>>>"+a);
			odvo.setLectureNo(vo.getLectureNo());
			odvo.setTimetableNo(vo.getTimetableNo());
			odvo.setOrderNo(a);
			System.out.println(odvo);
			orderService.insertOrderDetail(odvo);
			System.out.println("9번째 통과요~");
		}
		System.out.println("10번째 통과요~");
		for(int checkbox : checkBoxArr) {
			vo.setCartNo(checkbox);
			System.out.println("11번째 통과요~");
			vo = orderService.getLecture(vo);
			System.out.println(">>>>>>>.vo::::::" + vo);
			orderService.updateLectureStudentCnt(vo);
			orderService.deleteCart(vo);
		}
		
		
		System.out.println("12번째 통과요~");
		return 1;
	}
	
	
	
	
	@RequestMapping("/payment.do")
	@ResponseBody
	public String payment(Long amount) {
		System.out.println("amount : " + amount);
		


		System.out.println(">> 결제 성공!!!결재 금액 : " + amount);
		return "성공";
		//PointService.chargePoint(new PointChargeDto(amount), id);
		
	}
	
	/*
	 * public Point chargePoint(PointChargeDto dto, int id) { UserVO user =
	 * userRepository.findUserById(id); dto.setUser(user); return
	 * pointRepository.save(mapper.map(dto, point.class)); }
	 */
	
}
