package com.spring.learn.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.spring.learn.lecture.LectureCommentVO;
import com.spring.learn.lecture.LectureDetailService;
import com.spring.learn.lecture.LectureReviewCommentVO;
import com.spring.learn.lecture.LectureVO;
import com.spring.learn.user.UserVO;

//@Controller
@RestController //클래스 내의 요청처리 결과가 모두 @ResponseBody 처리됨
@RequestMapping({"/Member","Common"})
public class LectureDetailAjaxController {
	
@Autowired
private LectureDetailService lectureDetailService;

public LectureDetailAjaxController() {
	System.out.println("LectureDetailAjaxController() 실행");
}

@RequestMapping("/ajaxAddLike.do")
@ResponseBody
public int ajaxAddLike(String lectureNo, HttpSession session, Model model) {
	HashMap<String, String> map = new HashMap<>();
	UserVO vo =(UserVO) session.getAttribute("user");
	System.out.println("ajax 처리");
	System.out.println("useId : " + vo.getUserId());	
	System.out.println("받은데이터 lectureNo : " + lectureNo);
	//추가작업
	
	map.put("lectureNo", lectureNo );
	map.put("userId",vo.getUserId());
	
	lectureDetailService.insertLectureLike(map);
	
	LectureVO ve = new LectureVO();
	ve.setLectureNo(lectureNo);
	//강의의 좋아요수 반환
	
	model.addAttribute("checkLike", 1);
	
	return lectureDetailService.getLectureLike(ve);
	
}

@RequestMapping("/ajaxDeleteLike.do")
@ResponseBody
public int ajaxDeleteLike(String lectureNo, HttpSession session, Model model) {
	HashMap<String, String> map = new HashMap<>();
	UserVO vo =(UserVO) session.getAttribute("user");
	System.out.println("ajax 처리");
	System.out.println("useId : " + vo.getUserId());	
	System.out.println("받은데이터 lectureNo : " + lectureNo);
	//추가작업
	
	map.put("lectureNo", lectureNo );
	map.put("userId",vo.getUserId());
	
	lectureDetailService.deleteLectureLike(map);
	
	LectureVO ve = new LectureVO();
	ve.setLectureNo(lectureNo);
	
	model.addAttribute("checkLike", 0);
	
	//강의의 좋아요수 반환
	return lectureDetailService.getLectureLike(ve);
	
}

@RequestMapping(value = "/ajaxInsertLectureComment.do")
@ResponseBody
public List<LectureCommentVO> ajaxInsertLectureComment(int lectureNo, int boardRate, String boardContent, HttpSession session ) {
	System.out.println("ajaxInsertLectureComment() 실행~~");
	System.out.println("lectureNo : " + lectureNo + " boardRate : " + boardRate + " boardContent :" + boardContent);
	LectureCommentVO vo = new LectureCommentVO();
	vo.setLectureNo(lectureNo);
	vo.setBoardRate(boardRate);
	vo.setBoardContent(boardContent);
	UserVO user =(UserVO) session.getAttribute("user");
	System.out.println(user.getUserId());
	vo.setUserId(user.getUserId());
	
	lectureDetailService.insertLectureComment(vo);
	List<LectureCommentVO> list = new ArrayList<LectureCommentVO>();
	list = lectureDetailService.getLectureReviewList(vo);
	System.out.println(list);
	return list;

}

@RequestMapping(value = "/ajaxGetLectureComment.do")
@ResponseBody
public List<LectureCommentVO> ajaxGetLectureComment(int lectureNo) {

	LectureCommentVO vo = new LectureCommentVO();
	vo.setLectureNo(lectureNo);
	
	List<LectureCommentVO> list = new ArrayList<LectureCommentVO>();
	list = lectureDetailService.getLectureReviewList(vo);
	System.out.println(list);
	return list;

}
//좋아요 높은순
@RequestMapping(value = "ajaxGetLectureCommentRateDesc.do")
@ResponseBody
public List<LectureCommentVO> ajaxGetLectureCommentRateDesc(int lectureNo) {

	LectureCommentVO vo = new LectureCommentVO();
	vo.setLectureNo(lectureNo);
	
	List<LectureCommentVO> list = new ArrayList<LectureCommentVO>();
	list = lectureDetailService.getLectureReviewListRateDesc(vo);
	System.out.println(list);
	return list;

}
//좋아요 낮은순
@RequestMapping(value = "ajaxGetLectureCommentRateAsc.do")
@ResponseBody
public List<LectureCommentVO> ajaxGetLectureCommentRateAsc(int lectureNo) {

	LectureCommentVO vo = new LectureCommentVO();
	vo.setLectureNo(lectureNo);
	
	List<LectureCommentVO> list = new ArrayList<LectureCommentVO>();
	list = lectureDetailService.getLectureReviewListRateAsc(vo);
	System.out.println(list);
	return list;

}

//답글달기
@RequestMapping(value = "ajaxInsertCommentReply.do")
@ResponseBody
public List<LectureReviewCommentVO> ajaxInsertCommentReply(String boardNo, String lectureNo, String replyContent, HttpSession session) {
	UserVO vo =(UserVO) session.getAttribute("user");
	String userId = vo.getUserId();
	System.out.println("boardNo : " + boardNo + " lectureNo : " + lectureNo + " replyContent : " + replyContent + " userId : " + userId);
	
	LectureReviewCommentVO reply = new LectureReviewCommentVO();
	reply.setBoardNo(boardNo);
	reply.setLectureNo(lectureNo);
	reply.setCommentContent(replyContent);
	reply.setLectureWriter(userId);
	System.out.println("표시선------------");
	
	lectureDetailService.insertReply(reply);
	List<LectureReviewCommentVO> list =  lectureDetailService.getReplyList(lectureNo);
	System.out.println(list);
	
	return list;

}

//답변 삭제하기
@RequestMapping(value = "ajaxDeleteCommentReply.do")
@ResponseBody
public int ajaxDeleteCommentReply(String boardNo, String lectureNo) {
	
	System.out.println("boardNo : " + boardNo);
	
	LectureReviewCommentVO reply = new LectureReviewCommentVO();
	reply.setBoardNo(boardNo);
	
	lectureDetailService.deleteReply(reply);

	
	return 0;

}

//수강후기 삭제하기
@RequestMapping(value = "ajaxDeleteComment.do")
@ResponseBody
public int ajaxDeleteComment(String boardNo, String lectureNo) {
	
	System.out.println("boardNo : " + boardNo);
	
	LectureCommentVO comment = new LectureCommentVO();
	comment.setBoardNo(Integer.parseInt(boardNo));
	comment.setLectureNo(Integer.parseInt(lectureNo));
	
	lectureDetailService.deleteComment(comment);
	
	return 0;

}
//답변 리스트 불러오기
@RequestMapping(value = "ajaxGetCommentReply.do")
@ResponseBody
public List<LectureReviewCommentVO> ajaxGetCommentReply(String lectureNo) {
	
	List<LectureReviewCommentVO> list =  lectureDetailService.getReplyList(lectureNo);
	System.out.println(list);
	
	return list;

}



//	@Autowired
	
//	private BoardService boardService;
//	
//	@RequestMapping("/getJsonBoardList.do")
//	//@ResponseBody //response 응답객체의 몸체(body)에 데이터 전달
//	public List<BoardVO> getJsonBoardList(BoardVO vo) {
//		System.out.println("========= BoardAjaxController getJsonBoardList() 실행");
//		List<BoardVO> boardList = boardService.getBoardList(vo);
//		System.out.println("boardList : " + boardList);
//		
//		return boardList;
//	}
//	
//	//JSON 데이터를 받아 게시글 찾아서 JSON 데이터로 리턴(응답)
//	@PostMapping("/getJsonBoard.do")
//	public BoardVO getJsonBoard(@RequestBody BoardVO vo) { //@RequestBody post방식 전달데이터 처리
//		System.out.println("========== BoardAjaxController getJsonBoard(vo) 실행");
//		System.out.println("getJsonBoard() vo : " + vo);
//		
//		BoardVO board = boardService.getBoard(vo);
//		System.out.println("getJsonBoard() board : " + board);
//		
//		return board;
//	}
	
}
