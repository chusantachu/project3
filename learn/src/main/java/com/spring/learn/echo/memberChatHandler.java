package com.spring.learn.echo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.learn.user.MemberChatContentsVO;
import com.spring.learn.user.MemberChatService;
import com.spring.learn.user.impl.MemberChatDAO;

@Component
public class memberChatHandler extends TextWebSocketHandler {

	// (<"bang_id", 방ID>, <"session", 세션>) - (<"bang_id", 방ID>, <"session", 세션>) - (<"bang_id", 방ID>, <"session", 세션>) 형태 
	private List<Map<String, Object>> sessionList = new ArrayList<Map<String, Object>>();
	
	@Autowired
	private MemberChatService memberChatService;
	
	// 클라이언트가 서버로 메세지 전송 처리
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		super.handleTextMessage(session, message);
        
		// JSON --> Map으로 변환
		ObjectMapper objectMapper = new ObjectMapper();
		Map<String, String> mapReceive = objectMapper.readValue(message.getPayload(), Map.class);
		
		switch (mapReceive.get("cmd")) {
		
		// CLIENT 입장
		case "CMD_ENTER":
			// 세션 리스트에 저장
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("bang_id", mapReceive.get("bang_id"));
			map.put("userName", mapReceive.get("userName"));
			map.put("session", session);
			sessionList.add(map);
			
			System.out.println("map CMD_ENTER 전송 전에 : " + map);
			
			// 같은 채팅방에 입장 메세지 전송
			for (int i = 0; i < sessionList.size(); i++) {
				Map<String, Object> mapSessionList = sessionList.get(i);
				String bang_id = (String) mapSessionList.get("bang_id");
//				String userName = (String) mapSessionList.get("userName");
				
				WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");
				
				if(bang_id.equals(mapReceive.get("bang_id"))) {
					Map<String, String> mapToSend = new HashMap<String, String>();
					mapToSend.put("bang_id", bang_id);
					mapToSend.put("cmd", "CMD_ENTER");
					mapToSend.put("msg", mapReceive.get("userName") +  "님이 입장 했습니다.");
					
					String jsonStr = objectMapper.writeValueAsString(mapToSend);
					sess.sendMessage(new TextMessage(jsonStr));
				}
			}
			break;
			
		// CLIENT 메세지
		case "CMD_MSG_SEND":
			// 같은 채팅방에 메세지 전송
			
			// 2명 이상 읽었는지 확인하기 위한 변수
			
			int seeCnt = 0;
			
			for (int i = 0; i < sessionList.size(); i++) {
				Map<String, Object> mapSessionList = sessionList.get(i);
				String bang_id = (String) mapSessionList.get("bang_id");
				
				WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");
				

				if (bang_id.equals(mapReceive.get("bang_id"))) {
					
					if (seeCnt == 1) {
						MemberChatContentsVO memberChatContents = new MemberChatContentsVO();
						memberChatContents.setChatroomNo(mapReceive.get("bang_id"));
						memberChatService.seeYourMsg(memberChatContents);
					}
					
					Map<String, String> mapToSend = new HashMap<String, String>();
					mapToSend.put("bang_id", bang_id);
					mapToSend.put("cmd", "CMD_MSG_SEND");
					mapToSend.put("msg", mapReceive.get("msg"));// session.getId() + " : " + 누가보냇는지 확인하려면 추가
					mapToSend.put("userName", mapReceive.get("userName"));// session.getId() + " : " + 누가보냇는지 확인하려면 추가
					mapToSend.put("time", mapReceive.get("time"));// session.getId() + " : " + 누가보냇는지 확인하려면 추가
					

					String jsonStr = objectMapper.writeValueAsString(mapToSend);
					sess.sendMessage(new TextMessage(jsonStr));
					
					
					seeCnt++;
				}
			}
			break;
		}
	}

	// 클라이언트가 연결을 끊음 처리
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		super.afterConnectionClosed(session, status);
        
		ObjectMapper objectMapper = new ObjectMapper();
		String now_bang_id = "";
		
		// 사용자 세션을 리스트에서 제거
		for (int i = 0; i < sessionList.size(); i++) {
			Map<String, Object> map = sessionList.get(i);
			String bang_id = (String) map.get("bang_id");
			WebSocketSession sess = (WebSocketSession) map.get("session");
			
			if(session.equals(sess)) {
				now_bang_id = bang_id;
				sessionList.remove(map);
				break;
			}	
		}
		
		// 같은 채팅방에 퇴장 메세지 전송 
		for (int i = 0; i < sessionList.size(); i++) {
			Map<String, Object> mapSessionList = sessionList.get(i);
			String bang_id = (String) mapSessionList.get("bang_id");
//			String userName = (String) mapSessionList.get("userName");
			
			WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");

			if (bang_id.equals(now_bang_id)) {
				Map<String, String> mapToSend = new HashMap<String, String>();
				mapToSend.put("bang_id", bang_id);
				mapToSend.put("cmd", "CMD_EXIT");

				
//				mapToSend.put("msg", userName + "님이 퇴장 했습니다.");
				

				String jsonStr = objectMapper.writeValueAsString(mapToSend);
				sess.sendMessage(new TextMessage(jsonStr));
			}
		}
	}
}
