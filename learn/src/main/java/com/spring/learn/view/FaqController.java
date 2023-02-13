package com.spring.learn.view;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.learn.board.FaqService;
import com.spring.learn.board.FaqVO;

//@SessionAttributes : board라는 이름의 Model 있으면 session에 저장
//  단, 현재위치(클래스)에서만 유효
@Controller
@SessionAttributes("faq") 
public class FaqController { 
	@Autowired
	private FaqService faqService;

	@RequestMapping("/getFaqList.do")
	public String getFaqList(FaqVO vo, Model model) {

		List<FaqVO> list = faqService.getFaqList(vo);
		
		model.addAttribute("list", list);
		
		return "Member/MemberBoard/faq.jsp";
	}
	
	@RequestMapping("/getAdminFaqList.do")
	public String getAdminFaqList(FaqVO vo, Model model) {

		List<FaqVO> list = faqService.getFaqList(vo);
		
		model.addAttribute("list", list);
		
		return "Admin/adminFaq.jsp";
	}
	
	//게시글 삭제(관리자)
	@RequestMapping("/deleteFaq.do")
	public String deleteFaq(FaqVO vo) {
		System.out.println(">> 게시글 삭제하기");
		
		System.out.println("삭제 vo : " + vo);
		
		faqService.deleteFaq(vo);
	
		return "getAdminFaqList.do";
	}
	
	//게시글 수정(관리자)
	@RequestMapping("/updateFaq.do")
	public String updateNotice(Model model, FaqVO vo) {
		System.out.println(">> 게시글 수정하기");
		
		System.out.println("update vo : " + vo);
		
		faqService.updateFaq(vo);
		
		model.addAttribute("vo", vo);
	
		return "getAdminFaqList.do";
	}
	
	//게시글 추가(관리자)
	@RequestMapping("/insertFaq.do")
	public String inserNotice(Model model, FaqVO vo) {
		System.out.println(">> 게시글 추가하기");
		
		System.out.println("insert vo : " + vo);
		
		faqService.insertFaq(vo);
		
		model.addAttribute("vo", vo);
	
		return "getAdminFaqList.do";
	}
	
	
}
