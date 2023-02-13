package com.spring.learn.view;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.learn.board.BoardReportService;
import com.spring.learn.board.BoardReportVO;
import com.spring.learn.board.BoardService;
import com.spring.learn.board.BoardVO;
import com.spring.learn.board.ReportResultService;
import com.spring.learn.board.ReportResultVO;
import com.spring.learn.common.Paging;

@Controller					// 단 현재 위치(클래스)에서만 유효
@SessionAttributes("board") // board라는 이름의 Model객체가 있으면 세션에 저장
public class BoardReportController {

	@Autowired
	private BoardReportService boardReportService;
	@Autowired
	private ReportResultService reportResultService;
	@Autowired
	private BoardService boardService;
	
	public BoardReportController() {
		System.out.println(">> BoardReportController() 생성");
	}
	
	// 검색과 페이지 보기
	@RequestMapping("/getFalseReport.do")
	public String getFalseReport(Model model, Paging p) {
		p.setNumPerPage(10);
		p.setNumPerBlock(10);
		
		// 전체 페이지 수 구하기
		p.setTotalRecord(boardReportService.countFalseReport());
		p.setTotalPage();
		
		// 현재 페이지 구하기
		if (p.getcPage() != 0) {
			p.setNowPage(p.getcPage());
		}
		
		// 현재 페이지에 시작할 첫게시글 번호, 끝 게시글 번호
		p.setEnd(p.getNowPage()*p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() +1);
		
		// 끝번호가 더 크면 토탈번호와 맞게 하기 - 끝블록 끝페이지 때문
		if (p.getEnd() > p.getTotalRecord()) p.setEnd(p.getTotalRecord());
		
		// 블록 계산하기
		int nowPage = p.getNowPage();
		int beginPage = (nowPage -1) / p.getNumPerBlock() * p.getNumPerBlock() + 1;
		p.setBeginPage(beginPage);
		p.setEndPage(beginPage + p.getNumPerBlock() - 1);
		
		if (p.getEndPage() > p.getTotalPage()) p.setEndPage(p.getTotalPage());		
		
		System.out.println("계산된 paging : " + p);
		
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));
		
		System.out.println(">>>>> map : " + map);

		// 리스트 가져오기
		List<BoardReportVO> list = boardReportService.getFalseReport(map);
		System.out.println("list : " + list);	
		
		model.addAttribute("list", list); 
		model.addAttribute("pvo", p);
		

		return "/Admin/adminReportManager.jsp"; 
	}
	
	@RequestMapping("/getTrueReport.do")
	@ResponseBody 
	public Map<String, Object> getTrueReport(Paging p) {
		System.out.println(">>> getTrueReport 접속");
		
		p.setNumPerPage(10);
		p.setNumPerBlock(10);
		
		// 전체 페이지 수 구하기
		p.setTotalRecord(boardReportService.countTrueReport());
		p.setTotalPage();
		
		// 현재 페이지 구하기
		if (p.getcPage() != 0) {
			p.setNowPage(p.getcPage());
		}
		
		// 현재 페이지에 시작할 첫게시글 번호, 끝 게시글 번호
		p.setEnd(p.getNowPage()*p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() +1);
		
		// 끝번호가 더 크면 토탈번호와 맞게 하기 - 끝블록 끝페이지 때문
		if (p.getEnd() > p.getTotalRecord()) p.setEnd(p.getTotalRecord());
		
		// 블록 계산하기
		int nowPage = p.getNowPage();
		int beginPage = (nowPage -1) / p.getNumPerBlock() * p.getNumPerBlock() + 1;
		p.setBeginPage(beginPage);
		p.setEndPage(beginPage + p.getNumPerBlock() - 1);
		
		if (p.getEndPage() > p.getTotalPage()) p.setEndPage(p.getTotalPage());		
		
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));
		

		// 리스트 가져오기
		List<BoardReportVO> list = boardReportService.getTrueReport(map);
		System.out.println("getTrueResumeList : " + list);
		
		Map<String, Object> data = new HashMap<String, Object>();
		
		data.put("list", list);
		data.put("pvo", p);
		
		return data;
	}
	
	@RequestMapping("/getReportDetail.do") 
	public String getReportDetail(Model model, BoardReportVO vo) {
		System.out.println("getReportDetail vo : " + vo);
		
		int cnt = boardReportService.getCntReport(vo);
	
		model.addAttribute("cnt", cnt);
		model.addAttribute("vo", vo);
		
		return "/Admin/adminReportView.jsp";
	}
	
	@RequestMapping("/resultReportStatus.do")
	public String resultReportStatus(Model model, BoardReportVO vo) {
		System.out.println("resultReportStatus vo: " + vo);
		String boardNo = vo.getBoardNo();
		
		
		if (vo.getResult().equals("approve")) {
			boardReportService.updateReportStatus(vo);
			
			int cnt = boardReportService.countReport(vo);
			System.out.println("승인하고 해당 게시글 현재까지 신고 횟수 : " + cnt);
			
			if (cnt >= 3) {
				System.out.println("해당 게시글 result 테이블로 내용 옮기고 삭제하기");
				System.out.println("해당 게시글 신고내역 전체 삭제하기");
				
				if (vo.getBoardType().equals("freeBoard")) {
					BoardVO bvo = new BoardVO();
					bvo.setFboardNo(boardNo);
					BoardVO resultVo = boardService.getBoard(bvo);
					
					ReportResultVO rvo = new ReportResultVO();
					rvo.setResultTitle(resultVo.getBoardTitle());
					rvo.setResultContent(resultVo.getBoardContent());
					rvo.setResultId(resultVo.getUserId());
					rvo.setResultRegdate(resultVo.getBoardRegdate().substring(0,10));
					System.out.println("자유게시판 rvo : " + rvo);
					
					reportResultService.insertDelReport(rvo); //기존 게시글 내용 그대로 result 테이블에 저장하여 보관
					boardService.deleteBoard(resultVo);//기존 게시글은 삭제
					boardReportService.deleteReportAll(vo);//신고테이블에 해당 게시글 신고내역 전체 삭제(처리여부와 관계없이 - 이미 삭제된 글이므로)
					
				} else if (vo.getBoardType().equals("questionBoard")) {
					BoardVO bvo = new BoardVO();
					bvo.setQboardNo(boardNo);
					BoardVO resultVo = boardService.getBoard(bvo);
					
					ReportResultVO rvo = new ReportResultVO();
					rvo.setResultTitle(resultVo.getBoardTitle());
					rvo.setResultContent(resultVo.getBoardContent());
					rvo.setResultId(resultVo.getUserId());
					rvo.setResultRegdate(resultVo.getBoardRegdate().substring(0,10));
					
					System.out.println("질문게시판 rvo : " + rvo);
					
					reportResultService.insertDelReport(rvo);//기존 게시글 내용 그대로 result 테이블에 저장하여 보관
					boardService.deleteBoard(resultVo);//기존 게시글은 삭제//기본 게시글은 삭제
					boardReportService.deleteReportAll(vo);//신고테이블에 해당 게시글 신고내역 전체 삭제(처리여부와 관계없이 - 이미 삭제된 글이므로)
				}
			}
			
		} else if (vo.getResult().equals("reject")) {
			boardReportService.deleteReport(vo);
		}
		
		return "getFalseReport.do";
	}
	
	@RequestMapping("/getDeleteReport.do")
	@ResponseBody 
	public Map<String, Object> getDeleteReport(Paging p) {
		System.out.println(">>> getDeleteReport 접속");
		
		p.setNumPerPage(10);
		p.setNumPerBlock(10);
		
		// 전체 페이지 수 구하기
		p.setTotalRecord(reportResultService.countResultReport());
		p.setTotalPage();
		
		// 현재 페이지 구하기
		if (p.getcPage() != 0) {
			p.setNowPage(p.getcPage());
		}
		
		// 현재 페이지에 시작할 첫게시글 번호, 끝 게시글 번호
		p.setEnd(p.getNowPage()*p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() +1);
		
		// 끝번호가 더 크면 토탈번호와 맞게 하기 - 끝블록 끝페이지 때문
		if (p.getEnd() > p.getTotalRecord()) p.setEnd(p.getTotalRecord());
		
		// 블록 계산하기
		int nowPage = p.getNowPage();
		int beginPage = (nowPage -1) / p.getNumPerBlock() * p.getNumPerBlock() + 1;
		p.setBeginPage(beginPage);
		p.setEndPage(beginPage + p.getNumPerBlock() - 1);
		
		if (p.getEndPage() > p.getTotalPage()) p.setEndPage(p.getTotalPage());		
		
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));
		

		// 리스트 가져오기
		List<ReportResultVO> list = reportResultService.getResultReport(map);
		System.out.println("getDeleteReport List : " + list);
		System.out.println("getDeleteReport Page : " + p);
		
		Map<String, Object> data = new HashMap<String, Object>();
		
		data.put("list", list);
		data.put("pvo", p);
		
		return data;
	}
	
	@RequestMapping("/getReportPost.do") 
	public String getReportPost(Model model, BoardReportVO vo) {
		System.out.println("getReportPost vo : " + vo);
		String boardNo = vo.getBoardNo();
		String adminStatus = null;
		
		if (vo.getBoardType().equals("questionBoard")) {
			BoardVO qvo = new BoardVO();
			qvo.setQboardNo(boardNo);
			
			BoardVO resultVO = boardService.getBoard(qvo);
			System.out.println("질문게시판의 vo : " + resultVO);
			
			model.addAttribute("vo", resultVO);
			
		} else if (vo.getBoardType().equals("freeBoard") ) {
			BoardVO fvo = new BoardVO();
			fvo.setFboardNo(boardNo);
			
			BoardVO resultVO = boardService.getBoard(fvo);
			System.out.println("자유시판의 vo : " + resultVO);

			model.addAttribute("vo", resultVO);
		}
		
		adminStatus = "notDel";
		model.addAttribute("adminStatus", adminStatus);
		
		return "/Admin/adminReportPost.jsp";
	}
	
	@RequestMapping("/getDelReportPost.do") 
	public String getDelReportPost(Model model, ReportResultVO vo) {
		System.out.println("getDelReportPost vo : " + vo);
		String adminStatus = null;
		
		ReportResultVO vo2 = reportResultService.getDelReportPost(vo);
		
		model.addAttribute("vo", vo2);
		
		adminStatus = "del";
		model.addAttribute("adminStatus", adminStatus);
		
		return "/Admin/adminReportPost.jsp";
	}
	
	

}
