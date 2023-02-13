
package com.spring.learn.echo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.spring.learn.user.UserService;
import com.spring.learn.user.UserVO;

public class AlarmHandler extends TextWebSocketHandler {
	
	@Autowired
	private AlramService alramService;
	
	@Autowired
	private UserService userService;
	
	//로그인 한 인원 전체
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1:1로 할 경우
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {//클라이언트와 서버가 연결
		// TODO Auto-generated method stub
		System.out.println("Socket 연결");
		System.out.println(session);
		sessions.add(session);
		System.out.println("이건 랜덤 유저 아이디 새션 이름 값 "+currentUserName(session));
		String senderId = currentUserName(session);
		userSessionsMap.put(senderId, session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {// 메시지
		// TODO Auto-generated method stub
		System.out.println("ssesion"+currentUserName(session));
		String msg = message.getPayload();//자바스크립트에서 넘어온 Msg
		System.out.println("msg="+msg);
		
		if (!StringUtils.isEmpty(msg)) {
			System.out.println("if문 들어옴?");
			String[] strs = msg.split(",");
			if(strs != null && strs.length == 6) {
				
				String cmd = strs[0];
				String replyWriter = strs[1];
				String boardWriter = strs[2];
				System.out.println("boardWriter"+boardWriter);
				String bno = strs[3];
				String title = strs[4];
				String bgno = strs[5];
				System.out.println("length 성공?"+cmd);
				
				WebSocketSession replyWriterSession = userSessionsMap.get(replyWriter);
				WebSocketSession boardWriterSession = userSessionsMap.get(boardWriter);
				System.out.println("boardWriterSession="+userSessionsMap.get(boardWriter));
				System.out.println("boardWirterSession="+boardWriterSession);
				
				//댓글
				if ("reply".equals(cmd) && boardWriterSession != null) {
					System.out.println("onmessage되나?");
					TextMessage tmpMsg = new TextMessage(replyWriter + "님이 "
							+ "<a href='/board/readView?bno="+ bno +"&bgno="+bgno+"'  style=\"color: black\">"
							+ title+" 에 댓글을 달았습니다!</a>");
					boardWriterSession.sendMessage(tmpMsg);
				}
				
				//새로운 공지가 작성되면
				else if("Notice".equals(cmd) && boardWriterSession != null) {
					//replyWriter = 스크랩누른사람 , boardWriter = 게시글작성자
					System.out.println("새로운 공지글 이 실행 됩니다!!");
					AlramVO vo = new AlramVO();
					List<UserVO> vo2 = userService.getUserList();
					vo.setbNo((Integer.parseInt(bno)));
					vo.setCategori(cmd);
					vo.setFromId(replyWriter);
					vo.setTitle("New 공지");
					for(UserVO vo3 : vo2) {
						vo.setToId(vo3.getUserId());
						alramService.insertAlram(vo);
					}
					for(WebSocketSession sess : sessions){
			        	sess.sendMessage(new TextMessage("새로운 공지글이 작성됬습니다. 확인 부탁드립니다~"));
			        }
					
				}
				
				//좋아요 등록
				else if("lectureLike".equals(cmd) && boardWriterSession != null) {// && boardWriterSession != null
					//replyWriter = 좋아요누른사람 , boardWriter = 게시글작성자
					System.out.println("너 실행되니?");
					TextMessage tmpMsg = new TextMessage(replyWriter + "님이 "
							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
							+ title+"</strong> 에 작성한 글을 좋아요했습니다!</a>");
					System.out.println("너는 실행되니?");
					AlramVO vo = new AlramVO();
					vo.setbNo((Integer.parseInt(bno)));
					vo.setCategori(cmd);
					vo.setFromId(replyWriter);
					vo.setToId(boardWriter);
					vo.setTitle("좋아요 Plus");
					alramService.insertAlram(vo);
					boardWriterSession.sendMessage(tmpMsg);
					System.out.println("너는??????????? 실행되니?");
				}
				
				//좋아요 취소
				else if("lectureLikeCancle".equals(cmd) && boardWriterSession != null) {// && boardWriterSession != null
					//replyWriter = 좋아요누른사람 , boardWriter = 게시글작성자
					System.out.println("너 실행되니?");
					TextMessage tmpMsg = new TextMessage(replyWriter + "님이 "
							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
							+ title+"</strong> 에 작성한 글을 좋아요를 취소했습니다!</a>");
					System.out.println("너는 실행되니?");
					AlramVO vo = new AlramVO();
					vo.setbNo((Integer.parseInt(bno)));
					vo.setCategori(cmd);
					vo.setFromId(replyWriter);
					vo.setToId(boardWriter);
					vo.setTitle("좋아요가 취소됬습니다.");
					alramService.insertAlram(vo);
					boardWriterSession.sendMessage(tmpMsg);
					System.out.println("너는??????????? 실행되니?");
				}
				
				//DEV
				else if("Dev".equals(cmd) && boardWriterSession != null) {
					//replyWriter = 좋아요누른사람 , boardWriter = 게시글작성자
					TextMessage tmpMsg = new TextMessage(replyWriter + "님이 "
							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
							+ title+"</strong> 에 작성한 글을 DEV했습니다!</a>");

					boardWriterSession.sendMessage(tmpMsg);
					
				}
				
				//댓글채택
				else if("questionCheck".equals(cmd) && replyWriterSession != null) {
					//replyWriter = 댓글작성자 , boardWriter = 글작성자
					TextMessage tmpMsg = new TextMessage(boardWriter + "님이 "
							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
							+ title+"</strong> 에 작성한 댓글을 채택했습니다!</a>");

					replyWriterSession.sendMessage(tmpMsg);
					
				}
				
				//댓글좋아요
				else if("commentLike".equals(cmd) && replyWriterSession != null) {
					//logger.info("좋아요onmessage되나?");
					//logger.info("result=board="+boardWriter+"//"+replyWriter+"//"+bno+"//"+bgno+"//"+title);
					//replyWriter=댓글작성자 , boardWriter=좋아요누른사람 
					TextMessage tmpMsg = new TextMessage(boardWriter + "님이 "
							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
							+ title+"</strong> 에 작성한 댓글을 추천했습니다!</a>");

					replyWriterSession.sendMessage(tmpMsg);
				}
				
				
				//댓글DEV
				else if("commentDev".equals(cmd) && replyWriterSession != null) {
					//logger.info("좋아요onmessage되나?");
					//logger.info("result=board="+boardWriter+"//"+replyWriter+"//"+bno+"//"+bgno+"//"+title);
					//replyWriter=댓글작성자 , boardWriter=좋아요누른사람 
					TextMessage tmpMsg = new TextMessage(boardWriter + "님이 "
							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
							+ title+"</strong> 에 작성한 댓글을 DEV했습니다!</a>");

					replyWriterSession.sendMessage(tmpMsg);
				}
				
				
					
				
			}
			
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {//연결 해제
		// TODO Auto-generated method stub
		//logger.info("Socket 끊음");
		sessions.remove(session);
		userSessionsMap.remove(currentUserName(session),session);
	}

	
	private String currentUserName(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		System.out.println("httpSession 넌머니? : " + httpSession);
		UserVO loginUser = (UserVO)httpSession.get("user");
		System.out.println("이게 먼가요??===" + loginUser);
		if(loginUser == null) {
			String mid = session.getId();
			System.out.println("mid = " + mid);
			return mid;
		}
		System.out.println("session.getId() = " + session.getId());
		String mid = loginUser.getUserId();
		return mid;
		
	}
}