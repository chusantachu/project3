package com.spring.learn.view;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.learn.board.FaqVO;
import com.spring.learn.board.NoticeService;
import com.spring.learn.board.NoticeVO;
import com.spring.learn.common.Paging;
import com.spring.learn.memberboard.MemberBoardVO;
import com.spring.learn.user.UserVO;

//@SessionAttributes : board라는 이름의 Model 있으면 session에 저장
//  단, 현재위치(클래스)에서만 유효
@Controller
@SessionAttributes("notice") 
public class NoticeController { 
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private SqlSessionTemplate mybatis;
	
	//게시글 수정을 위한 정보 불러오기(관리자)
	@RequestMapping("/getNoticeUpdateView.do")
	public String getNoticeUpdateView(NoticeVO vo, Model model) {
		System.out.println(">> 게시글 수정을 위한 정보 불러오기");
		
		NoticeVO vo2 = noticeService.getNotice(vo); 
		
		model.addAttribute("vo", vo2);
		System.out.println("getNoticeUpdateView vo2 : " + vo2);
		
		return "Admin/adminNoticeUpdate.jsp";
	}
	
	//게시글 수정(관리자)
	@RequestMapping("/updateNotice.do")
	public String updateNotice(Model model, NoticeVO vo) {
		System.out.println(">> 게시글 수정하기");
		
		System.out.println("update vo : " + vo);
		
		noticeService.updateNotice(vo);
		
		model.addAttribute("vo", vo);
	
		return "Admin/adminBasic.jsp";
	}
	
	
	//게시글 추가(관리자)
	@RequestMapping("/insertNotice.do")
	public String inserNotice(HttpServletRequest request, Model model, NoticeVO vo) {
		System.out.println(">> 게시글 추가하기");
		
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user");
		
		System.out.println("현재 로그인된 값 : " + user);
		
		vo.setUserId(user.getUserId());
		vo.setGrade(user.getGrade());
		
		System.out.println("insert vo : " + vo);
		
		noticeService.insertNotice(vo);
		int boardNo = noticeService.lastNo();
		vo.setBoardNo(boardNo);
		
		model.addAttribute("vo", vo);
	
		//return "getNoticeAdminList.do";
		return "Admin/adminBasic.jsp";
	}

	//게시글 삭제(관리자)
	@RequestMapping("/deleteNotice.do")
	public String deleteNotice(NoticeVO vo) {
		System.out.println(">> 게시글 삭제하기");
		
		noticeService.deleteNotice(vo);
	
		return "getNoticeAdminList.do";
	}
	
	//게시글 상세보기
	@RequestMapping("/getNotice.do")
	public String getNotice(NoticeVO vo, Model model) {
		System.out.println(">> 게시글 상세 보여주기");
		System.out.println("상세보기 vo : " + vo);
		
		NoticeVO vo2 = noticeService.getNotice(vo); 

		model.addAttribute("vo", vo2);
		
		return "Member/MemberBoard/noticeView.jsp";
	}
	
	//게시글 상세보기(관리자)
	@RequestMapping("/getAdminNotice.do")
	public String getAdminNotice(NoticeVO vo, Model model) {
		System.out.println(">> 게시글 상세 보여주기");
		
		NoticeVO vo2 = noticeService.getNotice(vo); 
		
		model.addAttribute("vo", vo2);
		System.out.println("vo2 : " + vo2);
		
		return "Admin/adminNoticeView.jsp";
	}
	
	@RequestMapping("/getJsonNoticeList.do")
	@ResponseBody 
	public Map<String, Object> getJasonList(NoticeVO vo, Paging p) {
		
		p.setNumPerPage(10);
		p.setNumPerBlock(10);
		
		// 전체 페이지 수 구하기
		p.setTotalRecord(noticeService.countBoard(vo));
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
		map.put("searchKeyword", vo.getSearchKeyword());
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));
		

		// 리스트 가져오기
		List<NoticeVO> list = noticeService.getBoardList(map); // 조회하고
		System.out.println("검색된 list 갯수 : " + list.size());
		
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("list", list);
		data.put("pvo", p);
		return data;
	}
	
	// 검색과 페이지 보기
	@RequestMapping("/getNoticeList.do")
	public String getQnaBoardList(NoticeVO vo, Model model, Paging p) {
		p.setNumPerPage(10);
		p.setNumPerBlock(10);
		
		// 전체 페이지 수 구하기
		p.setTotalRecord(noticeService.countBoard(vo));
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
		map.put("searchKeyword", vo.getSearchKeyword());
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));
		
		System.out.println(">>>>> map : " + map);

		// 리스트 가져오기
		List<NoticeVO> list = noticeService.getBoardList(map); // 조회하고

		// 리스트 모델에 저장
		if (list != null) {
			model.addAttribute("list", list); // 값 저장하고
			model.addAttribute("pvo", p);
		}		
		
		//System.out.println("list : " + list);

		return "/Member/MemberBoard/notice.jsp"; // 이동
	}
	
	//검색과 페이지보기(관리자)
	@RequestMapping("/getNoticeAdminList.do")
	public String getNoticeAdminList(NoticeVO vo, Model model, Paging p) {
		p.setNumPerPage(10);
		p.setNumPerBlock(10);
		
		// 전체 페이지 수 구하기
		p.setTotalRecord(noticeService.countBoard(vo));
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
		map.put("searchKeyword", vo.getSearchKeyword());
		map.put("begin", Integer.toString(p.getBegin()));
		map.put("end", Integer.toString(p.getEnd()));
		
		System.out.println(">>>>> map : " + map);

		// 리스트 가져오기
		List<NoticeVO> list = noticeService.getBoardList(map); // 조회하고

		// 리스트 모델에 저장
		if (list != null) {
			model.addAttribute("list", list); // 값 저장하고
			model.addAttribute("pvo", p);
		}		
		
		//System.out.println("list : " + list);

		return "/Admin/adminNotice.jsp"; // 이동
	}
	
    @RequestMapping("/uploadNoticeImage.do")
    @ResponseBody
    public String uploadImage(@RequestParam("file") MultipartFile uploadFile) throws IOException {

        System.out.println("uploadFile.isEmpty() : " + uploadFile.isEmpty());
        String fileName = uploadFile.getOriginalFilename(); //원본파일명
        System.out.println("::: 원본파일명 : " + fileName);

        String savedFileName = UUID.randomUUID().toString();
        System.out.println("::: 저장파일명 : " + savedFileName);

        //물리적 파일 복사
        String url = "c:/MyStudy/temp/" + savedFileName;
        uploadFile.transferTo(new File(url));

        return savedFileName;
    }
    
	//관리자페이지 - cs 메인 - 최근 게시글 제목보기
	@RequestMapping("/latestInfo.do")
	public String latestInfo(Model model) {
		System.out.println(">> 최근 게시글 제목보기");
		
		List<NoticeVO> noticeList = noticeService.latestInfo();
		List<FaqVO> faqList = mybatis.selectList("faqDAO.latestInfo");
		List<MemberBoardVO> qnaList = mybatis.selectList("com.spring.learn.memberboard.impl.MemberBoardDAO.latestFalseInfo");

		model.addAttribute("noticeList", noticeList);
		model.addAttribute("faqList", faqList);
		model.addAttribute("qnaList", qnaList);
		
		System.out.println("noticeList : " + noticeList);
		System.out.println("faqList : " + faqList);
		System.out.println("qnaList : " + qnaList);
		System.out.println("미답변 qna 갯수" + qnaList.size());

		return "/Admin/adminCSmanager.jsp";
	}
	
	//관리자페이지 - cs메인에서 qna 전체 가져오기 (ajax)
	@RequestMapping("/qnaAllList.do")
	@ResponseBody 
	public List<MemberBoardVO> qnaAllList() {
		System.out.println(">> ajax qnaAllList.do 접속");
		List<MemberBoardVO> qnaAllList = mybatis.selectList("com.spring.learn.memberboard.impl.MemberBoardDAO.latestFaqInfo");
		System.out.println("ajax qnaAllList : " + qnaAllList);
		System.out.println("전체 qna 갯수" + qnaAllList.size());
		
		return qnaAllList;
	}

}
